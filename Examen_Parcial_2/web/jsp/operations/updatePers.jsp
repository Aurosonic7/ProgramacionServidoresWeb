<%@page import="src.config.mysql.Mysql"%>
<%@page import="java.sql.Date"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Actualizar Persona</title>
        <link rel="stylesheet" type="text/css" href="../../css/updatePers.css">
    </head>
    <body>
        <div class="form-container">
            <h1>Actualizar Persona</h1>

            <%
                String id = request.getParameter("id");
                String nombre = "";
                boolean genero = false;
                Date createdAt = null;
                double altura = 0.0;
                
                Mysql conexion = new Mysql();
                Connection connection = conexion.getConnection();
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                
                try {
                    String sql = "SELECT nombre, genero, altura, createdAt FROM persona WHERE id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, id);
                    resultSet = statement.executeQuery();
                    
                    if (resultSet.next()) {
                        nombre = resultSet.getString("nombre");
                        genero = resultSet.getBoolean("genero");
                        createdAt = resultSet.getDate("createdAt");
                        altura = resultSet.getDouble("altura");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            <form id="formActualizarPersona">
                <div class="form-group">
                    <label>ID: </label>
                    <input type="text" id="id" name="id" value="<%= id %>" readonly>
                </div>

                <div class="form-group">
                    <label>Nombre: </label>
                    <input type="text" name="nombre" id="nombre" value="<%= nombre %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required>
                </div>

                <div class="form-group">
                    <label>Género: </label>
                    <input type="text" name="genero" id="genero" value="<%= genero %>" required>
                </div>

                <div class="form-group">
                    <label>Altura: </label>
                    <input type="number" name="altura" id="altura" step="0.01" min="0" value="<%= altura %>" required>
                </div>

                <div class="form-group">
                    <label>Fecha de creación: </label>
                    <input type="date" name="createdAt" id="createdAt" value="<%= createdAt %>" required>
                </div>

                <input type="button" value="Actualizar" onclick="actualizarPersona()">
            </form>
            <div id="resultado"></div>
        </div>
        <script type="text/javascript">var contextPath = '<%= request.getContextPath() %>';</script>
        <script type="text/javascript" src="../../js/personaActualizar.js"></script>
    </body>
</html>