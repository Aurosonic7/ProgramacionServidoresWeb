<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Elementos</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 8px;
        }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h2>Lista de elementos</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Altura</th>
            <th>Género</th>
        </tr>

        <c:forEach var="persona" items="${sessionScope.personas}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td> <!-- Índice del elemento -->
                <td>${persona.nombre}</td>
                <td>${persona.correo}</td>
                <td>${persona.altura}</td>
                <td>
                    <c:choose>
                        <c:when test="${persona.genero}">
                            Masculino
                        </c:when>
                        <c:otherwise>
                            Femenino
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
            
        <c:if test="${empty sessionScope.personas}">
            <tr>
                <td colspan="5">No se han agregado elementos todavía.</td>
            </tr>
        </c:if>
    </table>

    <br>

    <!-- Formulario para limpiar la sesión -->
    <form method="post" action="limpiarSesion.jsp">
        <input type="submit" value="Limpiar datos">
    </form>

    <br>
    <a href="formularioPersona.jsp">Agregar un nuevo elemento</a>
</body>
</html>