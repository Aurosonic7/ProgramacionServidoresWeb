package servlet;

import config.Conexion;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import model.Animal;

@WebServlet(name = "NewServletAnimal", urlPatterns = {"/NewServletAnimal"})
public class NewServletAnimal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Animal> animales = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Conexion conexion = new Conexion();
        try {
            conn = conexion.getConnection();
        
            String sql = "SELECT * FROM animales";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Animal animal = new Animal(
                    rs.getInt("id"),
                    rs.getString("color"),
                    rs.getString("especie"),
                    rs.getString("tipo_animal"),
                    rs.getString("tipo_alimento"),
                    rs.getDouble("peso"),
                    rs.getString("habitad"),
                    rs.getDouble("altura")
                );
                animales.add(animal);
            }
            // for (Animal animal : animales) System.out.println(animal);
            HttpSession misesion = request.getSession();
            misesion.setAttribute("animales", animales);

            response.sendRedirect("views/mostrar_animales.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al conectar a la base de datos", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String color = request.getParameter("color");
        String especie = request.getParameter("especie");
        String tipo_animal = request.getParameter("tipo_animal");
        String tipo_alimento = request.getParameter("tipo_alimento");
        String pesoString = request.getParameter("peso");
        double peso = Double.parseDouble(pesoString);
        String habitad = request.getParameter("habitad");
        String alturaString = request.getParameter("altura");
        double altura = Double.parseDouble(alturaString);

        Animal animal = new Animal();
        animal.setColor(color);
        animal.setEspecie(especie);
        animal.setTipo_animal(tipo_animal);
        animal.setTipo_alimento(tipo_alimento);
        animal.setPeso(peso);
        animal.setHabitad(habitad);
        animal.setAltura(altura);

        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = new Conexion().getConnection();
            String sql = "INSERT INTO animales (color, especie, tipo_animal, tipo_alimento, peso, habitad, altura) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, animal.getColor());
            stmt.setString(2, animal.getEspecie());
            stmt.setString(3, animal.getTipo_animal());
            stmt.setString(4, animal.getTipo_alimento());
            stmt.setDouble(5, animal.getPeso());
            stmt.setString(6, animal.getHabitad());
            stmt.setDouble(7, animal.getAltura());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("¡El nuevo animal fue insertado exitosamente en la base de datos!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al insertar el animal en la base de datos", e);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("index.html");
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("id");
        Conexion conexion = new Conexion(); 

        if (idString == null || idString.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No se proporcionó el ID del animal.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            int id = Integer.parseInt(idString); 

            conn = conexion.getConnection();

            String sql = "DELETE FROM animales WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Animal eliminado con éxito.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); 
                response.getWriter().write("No se encontró el animal con el ID especificado.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            response.getWriter().write("ID inválido.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al eliminar el animal. (Java)");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) sb.append(line);
        }
        
        Animal animal = null;
        try {
            Gson gson = new Gson();
            animal = gson.fromJson(sb.toString(), Animal.class);
        } catch (JsonSyntaxException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error al procesar el JSON.");
            return;
        }

        if (animal == null || animal.getId() <= 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ID es requerido para la actualización.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new Conexion().getConnection();
            String sql = "UPDATE animales SET color = ?, especie = ?, tipo_animal = ?, tipo_alimento = ?, peso = ?, habitad = ?, altura = ? WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, animal.getColor());
            ps.setString(2, animal.getEspecie());
            ps.setString(3, animal.getTipo_animal());
            ps.setString(4, animal.getTipo_alimento());
            ps.setDouble(5, animal.getPeso());
            ps.setString(6, animal.getHabitad());
            ps.setDouble(7, animal.getAltura());
            ps.setInt(8, animal.getId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Animal actualizado con éxito.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("No se encontró el animal con el ID especificado.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al actualizar el animal.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
