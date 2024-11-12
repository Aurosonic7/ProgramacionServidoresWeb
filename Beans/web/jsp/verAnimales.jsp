<%@page import="bean.AnimalesBean"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.ZooBean" %>

<jsp:useBean id="zoo" class="bean.ZooBean" scope="session" />

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Animales</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h2>Lista de Animales</h2>
        <a href="agregarAnimal.jsp" class="btn btn-primary">Agregar Nuevo Animal</a>
        <br><br>

        <%
            if (zoo.getListaAnimales() != null && !zoo.getListaAnimales().isEmpty()) {
        %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Color</th>
                        <th>Raza</th>
                        <th>Edad</th>
                        <th>Altura (metros)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (AnimalesBean animal : zoo.getListaAnimales()) {
                    %>
                        <tr>
                            <td><%= animal.getNombreAnimal() %></td>
                            <td><%= animal.getColorAnimal() %></td>
                            <td><%= animal.getRazaAnimal() %></td>
                            <td><%= animal.getEdadAnimal() %></td>
                            <td><%= animal.getAltura() %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p>No hay animales agregados.</p>
        <%
            }
        %>
    </div>
</body>
</html>