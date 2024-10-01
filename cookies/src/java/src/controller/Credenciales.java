package src.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import src.configuration.Conexion;

@WebServlet(name = "credenciales", urlPatterns = {"/credenciales"})
public class Credenciales extends HttpServlet {
    Connection conn;
    PreparedStatement ps;
    Statement st;
    ResultSet rs;
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matricula = request.getParameter("matricula");
        String password = request.getParameter("password");
        
        try {
            String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            Conexion conexion = new Conexion();
            
            String sql = "INSERT INTO autenticacion(matricula, password)"+
                    "VALUES (?,?)";
            conn = conexion.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, matricula);
            ps.setString(2, hashPassword);
            
            int filasInsertadas = ps.executeUpdate();
            if(filasInsertadas > 0){
                request.setAttribute("mensaje", "Usuario registrado correctamente!");
                request.getRequestDispatcher("/jsp/mensaje.jsp").forward(request, response);
            } else {
                request.setAttribute("mensaje", "Error al registrar usuario");
                request.getRequestDispatcher("/jsp/mensaje.jsp").forward(request, response);
            }
            
            ps.close();
            conn.close();
            
        } catch (Exception e) {
            request.setAttribute("error ", e);
            request.getRequestDispatcher("/jsp/mensaje.jsp").forward(request, response);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
