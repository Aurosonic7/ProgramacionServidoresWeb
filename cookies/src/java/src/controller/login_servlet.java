package src.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import src.configuration.Conexion;

@WebServlet(name = "login_servlet", urlPatterns = {"/login_servlet"})
public class login_servlet extends HttpServlet {
    Connection conn;
    PreparedStatement ps;
    Statement st;
    ResultSet rs;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null)
            session.invalidate();
        Cookie [] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie: cookies) {
                if("matricula".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        response.sendRedirect("/cookies/jsp/login.jsp");
            
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        
        try {
            Conexion conexion = new Conexion();
            conn = conexion.getConnection();
            String sql = "SELECT password FROM autenticacion WHERE matricula = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, matricula);
            
            rs = ps.executeQuery();
            
            if(rs.next()){
                String hashPassword = rs.getString("password");
                if(BCrypt.checkpw(password, hashPassword)){
                    Cookie cookie = new Cookie("matricula",matricula);
                    if(request.getParameter("recordar") != null && request.getParameter("recordar").equals("on")) {
                        cookie.setMaxAge(60*60*24); // 5 minutos
                    } else {
                        cookie.setMaxAge(60*5);
                    }
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    request.getRequestDispatcher("/jsp/usuario.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
                }
            } else {
                 request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("Error "+e);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
