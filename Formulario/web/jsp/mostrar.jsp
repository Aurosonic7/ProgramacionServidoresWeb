<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@page import="src.conexion.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de muestra de datos</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            th {
                background-color: #f2f2f2;
            }

            /* Estilo para el botón */
            #clearCacheButton {
                margin: 20px 0;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            #clearCacheButton:hover {
                background-color: #0056b3;
            }
        </style>
        <script>
            // Función para limpiar todas las cookies
            function clearCache() {
                // Obtener todas las cookies
                document.cookie.split(";").forEach(function(cookie) {
                    var eqPos = cookie.indexOf("=");
                    var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
                    // Limpiar la cookie
                    document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/";
                });

                // Recargar la página
                location.reload();
            }
        </script>
    </head>
    <body>
        <h1>Los datos son:</h1>

        <!-- Botón para limpiar el caché -->
        <a href="${pageContext.request.contextPath}/NewServletComputadora3">Limpiar</a>
        <button onclick="window.location.href='<%= request.getContextPath() %>/NewServletComputadora3'">Limpiar Cookies</button>

        <table>
            <tr>
                <th>Matrícula</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Fecha de creación</th>
                <th>Hora de puesta</th>
            </tr>
            <%
                // Instancia de la clase de conexión
                Conexion conexion = new Conexion();
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                
                try {
                    // Obtener la conexión
                    connection = conexion.getConnection();
                    
                    // Consulta SQL para obtener los datos
                    String sql = "SELECT * FROM computadoras";
                    statement = connection.prepareStatement(sql);
                    
                    // Ejecutar la consulta
                    resultSet = statement.executeQuery();
                    
                    // Recorrer los resultados y mostrarlos en la tabla
                    while (resultSet.next()) {
                        String matricula = resultSet.getString("id");
                        String nombre = resultSet.getString("nombre");
                        String precio = resultSet.getString("precio");
                        String fechaCreacion = resultSet.getString("createdAt");
                        String horaPuesta = resultSet.getString("hora_puesta");
            %>
            <tr>
                <td><%= matricula %></td>
                <td><%= nombre %></td>
                <td><%= precio %></td>
                <td><%= fechaCreacion %></td>
                <td><%= horaPuesta %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='5'>Error al obtener los datos: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Cerrar recursos
                    if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                    if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                    conexion.closeConnection(connection);
                }
            %>
        </table>
    </body>
</html>