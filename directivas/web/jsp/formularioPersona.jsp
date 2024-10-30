<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulario de Ingreso</title>
</head>
<body>
    <h2>Ingresar un nuevo elemento</h2>

    <form method="POST" action="procesarPersona.jsp">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <label for="correo">Correo:</label>
        <input type="text" id="correo" name="correo" required>
        <label for="altura">Altura:</label>
        <input type="text" id="altura" name="altura" required maxlength="4">
        <label for="genero">Género:</label>
        <select id="genero" name="genero" required>
            <option value="true">Masculino</option>
            <option value="false">Femenino</option>
        </select>
        <input type="submit" value="Agregar">
    </form>

    <br>
    <a href="tablaPersona.jsp">Ver lista de elementos</a>
</body>
</html>