package src.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.NetworkInterface;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collections;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import src.configuration.Conexion;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Integer counter = 0;
    
    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
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
            ps.setString(1,matricula);
            
            rs = ps.executeQuery();
            
            if(rs.next()) {
                String hashPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("matricula",matricula);
                    session.setMaxInactiveInterval(10*1);
                    response.sendRedirect(request.getContextPath() + "/jsp/usuario.jsp");
                } else {
                    request.setAttribute("error", "Credenciales incorrectas...");
                    request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                }
            }else {
                request.setAttribute("error","Usuario no encontrado...");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            request.setAttribute("error","Error de servidor...");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            System.out.println("Error: "+e);
        }
        
    }
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
