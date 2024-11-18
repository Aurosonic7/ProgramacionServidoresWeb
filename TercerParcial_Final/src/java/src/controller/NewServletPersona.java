package src.controller;

import src.config.Mysql;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "NewServletPersona", urlPatterns = {"/NewServletPersona"})
public class NewServletPersona extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        int edad = Integer.parseInt(request.getParameter("edad"));
        double altura = Double.parseDouble(request.getParameter("altura"));
        String curp = request.getParameter("curp");

        Mysql conexion = new Mysql();
        try (Connection connection = conexion.getConnection()) {
            String query = "INSERT INTO personas (nombre, edad, altura, curp) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, nombre);
            preparedStatement.setInt(2, edad);
            preparedStatement.setDouble(3, altura);
            preparedStatement.setString(4, curp);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("jsp/dashboard.jsp");
    }
}