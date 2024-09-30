<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %> 
<%@page import="config.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar animales</title>
        <link rel="stylesheet" type="text/css" href="../css/actualizar_animales.css">
    </head>
    <body>
        <h1>Actualizar Animal</h1>
        <script type="text/javascript">var contextPath = '<%= request.getContextPath() %>';</script>

        <%
            String id = request.getParameter("id");
            String color = "";
            String especie = "";
            String tipo_animal = "";
            String tipo_alimento = "";
            double peso = 0;
            String habitad = "";
            double altura = 0;
            Conexion conexion = new Conexion();
            Connection connection = conexion.getConnection();
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            try {
                String sql = "SELECT color, especie, tipo_animal, tipo_alimento, peso, habitad, altura FROM animales WHERE id = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, id);
                resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    color = resultSet.getString("color");
                    especie = resultSet.getString("especie");
                    tipo_animal = resultSet.getString("tipo_animal");
                    tipo_alimento = resultSet.getString("tipo_alimento");
                    peso = resultSet.getDouble("peso");
                    habitad = resultSet.getString("habitad");
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
        <form id="formActualizarAnimal">
        <p>
            <label>ID: </label>
            <input type="text" id="txt_id" name="id" value="<%= id %>" readonly><br>
        </p>
        <p>
            <label>Color: </label>
            <input type="text" name="color" id="txt_color" value="<%= color %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> 
        </p>
        <p>
            <label>Especie: </label> 
            <input type="text" name="especie" id="txt_especie" value="<%= especie %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> 
        </p>
        <p>
            <label>Tipo Animal: </label>
            <input type="text" name="tipo_animal" id="txt_tipo_animal" value="<%= tipo_animal %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required />
        </p>
        <p>
            <label>Tipo Alimento: </label> 
            <input type="text" name="tipo_alimento" id="txt_tipo_alimento" value="<%= tipo_alimento %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> 
        </p>
        <p>
            <label>Peso: </label>
            <input type="number" id="txt_peso" name="peso" value="<%= peso %>" min="0" step="0.01" required />
        </p>
        <p>
            <label>Habitad: </label>
            <input type="text" id="txt_habitad" name="habitad" value="<%= habitad %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> 
        </p>
        <p>
            <label>Altura: </label>
            <input type="number" id="txt_altura" name="altura" value="<%= altura %>" min="0" step="0.01" required />
        </p>
        <input type="button" value="Actualizar" onclick="actualizarAnimal()"> 
    </form>
    <div id="resultado"></div>
    <script type="text/javascript" src="../js/animalActualizar.js"></script>
    </body>
</html>