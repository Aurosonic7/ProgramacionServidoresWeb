<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="src.model.Producto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.config.mysql.Mysql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de producto</title>
    </head>
    <body>
        <a href="operations/createProd.jsp">Registrar producto</a>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Estado</th>
                    <th>Cantidad</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <h1>Lista de Personas</h1>
                <%
                    Mysql conexion = new Mysql();
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    Producto producto = new Producto();
                    
                    try {
                        conn = conexion.getConnection();
                        String sql = "SELECT * FROM Producto";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        
                        while (rs.next()) { 
                            int id = rs.getInt("id");
                            String nombre = rs.getString("nombre");
                            double precio = rs.getInt("precio");  
                            Boolean estado = rs.getBoolean("estado");
                            int cantidad = rs.getInt("cantidad");
                            Date createdAt = rs.getDate("createdAt");

                            producto.setId(id);
                            producto.setNombre(nombre);
                            producto.setPrecio(precio);
                            producto.setEstado(estado);
                            producto.setCantidad(cantidad);
                            producto.setCreatedAt(createdAt);

                %>
                        <tr>
                            <td><%= producto.getId() %></td>
                            <td><%= producto.getNombre() %></td>
                            <td><%= producto.getPrecio() %></td>
                            <td><%= producto.isEstado() ? "Disponible" : "No disponible" %></td>
                            <td><%= producto.getCantidad() %></td>
                            <td><%= producto.getCreatedAt() %></td>
                            <td>
                                <button class="btn-eliminar" onclick="eliminarProducto(<%= producto.getId() %>)">Eliminar</button>
                                <form action="${pageContext.request.contextPath}/jsp/operations/updateProd.jsp" method="GET"> 
                                    <input type="hidden" name="id" value="<%= producto.getId() %>"> 
                                    <input class="btn-actualizar" type="submit" value="Actualizar"> 
                                </form>
                            </td>
                        </tr>
                <%
                        }
                    } catch (SQLException e){
                        out.println("Error al obtener datos: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
            <script type="text/javascript">
                var contextPath = '${pageContext.request.contextPath}';
            </script>
            <script type="text/javascript" src="../js/productoEliminar.js"></script>
    </body>
</html>
