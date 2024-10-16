
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import src.config.mysql.Mysql;
import src.model.Persona;
import src.model.Producto;

@WebServlet(name = "NewServletProducto", urlPatterns = {"/NewServletProducto"})
public class NewServletProducto extends HttpServlet {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    Mysql conexion = new Mysql();

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        double precio = Double.valueOf(request.getParameter("precio"));
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        Date fecha = Date.valueOf(request.getParameter("createdAt"));
        
        Producto producto = new Producto();
        producto.setId(0);
        producto.setNombre(nombre);
        producto.setPrecio(precio);
        producto.setEstado(estado);
        producto.setCantidad(cantidad);
        producto.setCreatedAt(fecha);
        
        
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = new Mysql().getConnection();
            // insert into producto values (null, 'Producto 1', 1, true, now(), 10);
            String sql = "INSERT INTO producto VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, null);
            ps.setString(2, producto.getNombre());
            ps.setDouble(3, producto.getPrecio());
            ps.setBoolean(4, producto.isEstado());
            ps.setDate(5, producto.getCreatedAt());
            ps.setInt(6, producto.getCantidad());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("¡El producto fue insertado exitosamente en la base de datos!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al insertar el producto en la base de datos", e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("jsp/Producto.jsp");
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("id");

        if (idString == null || idString.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("No se proporcionó el ID del producto.");
            return;
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            int id = Integer.parseInt(idString); 

            conn = conexion.getConnection();

            String sql = "DELETE FROM producto WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Producto eliminado con éxito.");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); 
                response.getWriter().write("No se encontró el producto con el ID especificado.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            response.getWriter().write("ID inválido.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al eliminar el producto. (Java)");
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

        Producto producto = null;
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

                producto = gson.fromJson(sb.toString(), Producto.class);

            } catch (JsonSyntaxException e) {
                System.err.println(e);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Error al procesar el JSON.");
                return;
            }

            if (producto == null || producto.getId() <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("ID es requerido para la actualización.");
                return;
            }

            PreparedStatement ps = null;

            try {
                conn = new Mysql().getConnection();
                String sql = "UPDATE producto SET nombre = ?, precio = ?, estado = ?, cantidad = ?, createdAt = ? WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, producto.getNombre());
                ps.setDouble(2, producto.getPrecio());
                ps.setBoolean(3, producto.isEstado());
                ps.setInt(4, producto.getCantidad());
                ps.setDate(5, producto.getCreatedAt());
                ps.setInt(6, producto.getId());

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Producto actualizada con éxito.");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("No se encontró la producto con el ID especificado.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error al actualizar la producto.");
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
