package src.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;
import com.google.gson.JsonSyntaxException;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import src.config.mysql.Mysql;
import src.model.Persona;


@WebServlet(name = "NewServletPersona", urlPatterns = {"/NewServletPersona"})
public class NewServletPersona extends HttpServlet {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    Mysql conexion = new Mysql();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Persona> personas = new ArrayList<>();
        try {
            conn = conexion.getConnection();
        
            String sql = "SELECT * FROM persona";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Persona persona = new Persona(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getDouble("altura"),
                    rs.getBoolean("genero"),
                    rs.getDate("createdAt")
                );
                personas.add(persona);
            }
            // for (Persona persona : personas) System.out.println(persona);
            HttpSession misesion = request.getSession();
            misesion.setAttribute("personas", personas);

            response.sendRedirect("Persona.jsp");
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
        String nombre = request.getParameter("nombre");
        double altura = Double.valueOf(request.getParameter("altura"));
        boolean genero = Boolean.parseBoolean(request.getParameter("genero"));
        Date fecha = Date.valueOf(request.getParameter("createdAt"));
        
        Persona persona = new Persona();
        persona.setNombre(nombre);
        persona.setAltura(altura);
        persona.setGenero(genero);
        persona.setCreatedAt(fecha);
        
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = new Mysql().getConnection();
            String sql = "INSERT INTO persona VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, null);
            ps.setString(2, persona.getNombre());
            ps.setBoolean(3, persona.isGenero());
            ps.setDate(4, persona.getCreatedAt());
            ps.setDouble(5, persona.getAltura());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("¡La persona fue insertado exitosamente en la base de datos!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al insertar la persona en la base de datos", e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("jsp/Persona.jsp");
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("id");

        if (idString == null || idString.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No se proporcionó el ID de la persona.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            int id = Integer.parseInt(idString); 

            conn = conexion.getConnection();

            String sql = "DELETE FROM persona WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Persona eliminado con éxito.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); 
                response.getWriter().write("No se encontró el persona con el ID especificado.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            response.getWriter().write("ID inválido.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al eliminar el persona. (Java)");
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

        Persona persona = null;
        try {
            Gson gson = new GsonBuilder()
                .registerTypeAdapter(java.sql.Date.class, new TypeAdapter<java.sql.Date>() {
                    private final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

                    @Override
                    public void write(JsonWriter out, java.sql.Date value) throws IOException {
                        out.value(value.toString());
                    }

                    @Override
                    public java.sql.Date read(JsonReader in) throws IOException {
                        try {
                            String dateStr = in.nextString();
                            java.util.Date utilDate = format.parse(dateStr);
                            return new java.sql.Date(utilDate.getTime());
                        } catch (ParseException e) {
                            throw new JsonParseException("Error al parsear la fecha", e);
                        }
                    }
                })
                .create();

                persona = gson.fromJson(sb.toString(), Persona.class);

            } catch (JsonSyntaxException e) {
                System.err.println(e);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Error al procesar el JSON.");
                return;
            }

            if (persona == null || persona.getId() <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("ID es requerido para la actualización.");
                return;
            }

            PreparedStatement ps = null;

            try {
                conn = new Mysql().getConnection();
                String sql = "UPDATE persona SET nombre = ?, altura = ?, genero = ?, createdAt = ? WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, persona.getNombre());
                ps.setDouble(2, persona.getAltura());
                ps.setBoolean(3, persona.isGenero());

                // Usa el campo 'createdAt' que ya está en formato java.sql.Date gracias al TypeAdapter
                ps.setDate(4, persona.getCreatedAt());

                ps.setInt(5, persona.getId());

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Persona actualizada con éxito.");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("No se encontró la persona con el ID especificado.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error al actualizar la persona.");
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
}
