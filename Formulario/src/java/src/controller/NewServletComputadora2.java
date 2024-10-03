/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package src.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import src.conexion.Conexion;

/**
 *
 * @author christianvicente
 */
@WebServlet(name = "NewServletComputadora2", urlPatterns = {"/NewServletComputadora2"})
public class NewServletComputadora2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String matriculaString = request.getParameter("matricula");
        int matricula = Integer.valueOf(matriculaString);
        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");
        String fechaCreacion = request.getParameter("fecha_creacion");
        String horaPuesta = request.getParameter("hora_puesta");

        Conexion conexion = new Conexion();
        Connection connection = null;

        try {
            connection = conexion.getConnection();
            
            String sql = "INSERT INTO computadoras (id, nombre, precio, createdAt, hora_puesta) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, matricula);
            statement.setString(2, nombre);
            statement.setString(3, precio);
            statement.setString(4, fechaCreacion);
            statement.setString(5, horaPuesta);

            int rowsInserted = statement.executeUpdate();
            
            if (rowsInserted > 0) response.getWriter().println("¡Registro exitoso!");
            
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al registrar los datos: " + e.getMessage());
        } finally {
            conexion.closeConnection(connection);
        }
        response.sendRedirect(request.getContextPath() +"/jsp/mostrar.jsp");
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
