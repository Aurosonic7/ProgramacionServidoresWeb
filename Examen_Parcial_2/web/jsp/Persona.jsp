<%@page import="java.util.ArrayList"%>
<%@page import="src.model.Persona"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="src.config.mysql.Mysql"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de persona</title>
        <link rel="stylesheet" href="../css/persona.css">
    </head>
    <body>
        <div class="container">
            <h1>Lista de Personas</h1>
            <a href="operations/createPers.jsp" class="btn-registrar">Registrar persona</a>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Altura</th>
                        <th>Genero</th>
                        <th>Created at:</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Mysql conexion = new Mysql();
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        Persona persona = new Persona();

                        try {
                            conn = conexion.getConnection();
                            String sql = "SELECT * FROM Persona";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next()) { 
                                int id = rs.getInt("id");
                                String nombre = rs.getString("nombre");
                                Boolean genero = rs.getBoolean("genero");
                                Date createdAt = rs.getDate("createdAt");
                                double altura = rs.getDouble("altura");

                                persona.setId(id);
                                persona.setNombre(nombre);
                                persona.setGenero(genero);
                                persona.setCreatedAt(createdAt);
                                persona.setAltura(altura);
                    %>
                            <tr>
                                <td><%= persona.getId() %></td>
                                <td><%= persona.getNombre() %></td>
                                <!-- Formato para mostrar altura con dos decimales -->
                                <td><%= String.format("%.2f", persona.getAltura()) %></td>
                                <td><%= persona.isGenero() ? "Masculino" : "Femenino" %></td>
                                <td><%= persona.getCreatedAt() %></td>
                                <td>
                                    <button class="btn-eliminar" onclick="eliminarPersona(<%= persona.getId() %>)">Eliminar</button>
                                    <form action="${pageContext.request.contextPath}/jsp/operations/updatePers.jsp" method="GET"> 
                                        <input type="hidden" name="id" value="<%= persona.getId() %>"> 
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
        </div>
        <script type="text/javascript">
            var contextPath = '${pageContext.request.contextPath}';
        </script>
        <script type="text/javascript" src="../js/personaEliminar.js"></script>
    </body>
</html>