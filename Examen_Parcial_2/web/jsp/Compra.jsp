<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="src.config.mysql.Mysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de Compra y Movimientos</title>
    </head>
    <body>
        <h1>Realizar Compra</h1>
        
        <form action="${pageContext.request.contextPath}/NewServletCompra" method="POST">
            <label for="persona">Seleccionar Persona:</label>
            <select name="idPers" id="persona" required>
                <option value="">Seleccionar Persona</option>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    
                    try {
                        conn = new Mysql().getConnection(); // Asumimos que Mysql es tu clase de conexión
                        String sql = "SELECT id, nombre FROM Persona";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        while (rs.next()) { 
                            int idPers = rs.getInt("id");
                            String nombrePers = rs.getString("nombre");
                %>
                <option value="<%= idPers %>"><%= nombrePers %></option>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("Error al obtener personas: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
            </select>
            <br><br>
            
            <label for="producto">Seleccionar Producto:</label>
            <select name="idProd" id="producto" required>
                <option value="">Seleccionar Producto</option>
                <%
                    conn = null;
                    ps = null;
                    rs = null;
                    
                    try {
                        conn = new Mysql().getConnection();
                        String sql = "SELECT id, nombre FROM Producto";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        while (rs.next()) { 
                            int idProd = rs.getInt("id");
                            String nombreProd = rs.getString("nombre");
                %>
                <option value="<%= idProd %>"><%= nombreProd %></option>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("Error al obtener productos: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
            </select>
            <br><br>

            <label for="cantidad">Cantidad:</label>
            <input type="number" name="cantidad" id="cantidad" min="1" required>
            <br><br>
            
            <label for="descuento">Descuento (%):</label>
            <input type="number" name="descuento" id="descuento" step="0.01" value="0.00">
            <br><br>

            <input type="submit" value="Realizar Compra">
        </form>

        <h2>Movimientos de Compra</h2>
        <table>
            <thead>
                <tr>
                    <th>ID Persona</th>
                    <th>Nombre Persona</th>
                    <th>ID Producto</th>
                    <th>Nombre Producto</th>
                    <th>Cantidad</th>
                    <th>Descuento (%)</th>
                    <th>Total</th>
                    <th>Confirmada</th>
                    <th>Fecha Compra</th>
                </tr>
            </thead>
            <tbody>
                <%
                    conn = null;
                    ps = null;
                    rs = null;
                    
                    try {
                        conn = new Mysql().getConnection();
                        String sql = "SELECT c.idPers, p.nombre as personaNombre, c.idProd, pr.nombre as productoNombre, " +
                                     "c.cantidad, c.descuento, c.total, c.confirmada, c.fechaCompra " +
                                     "FROM Compra c " +
                                     "JOIN Persona p ON c.idPers = p.id " +
                                     "JOIN Producto pr ON c.idProd = pr.id";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        while (rs.next()) {
                            int idPers = rs.getInt("idPers");
                            String personaNombre = rs.getString("personaNombre");
                            int idProd = rs.getInt("idProd");
                            String productoNombre = rs.getString("productoNombre");
                            int cantidad = rs.getInt("cantidad");
                            double descuento = rs.getDouble("descuento");
                            double total = rs.getDouble("total");
                            boolean confirmada = rs.getBoolean("confirmada");
                            String fechaCompra = rs.getString("fechaCompra");
                %>
                <tr>
                    <td><%= idPers %></td>
                    <td><%= personaNombre %></td>
                    <td><%= idProd %></td>
                    <td><%= productoNombre %></td>
                    <td><%= cantidad %></td>
                    <td><%= descuento %></td>
                    <td><%= total %></td>
                    <td><%= confirmada ? "Sí" : "No" %></td>
                    <td><%= fechaCompra %></td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("Error al obtener movimientos: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </body>
</html>