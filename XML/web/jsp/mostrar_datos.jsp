<%@page import="java.util.ArrayList"%>
<%@ page import="controller.NewServletPersona, model.Persona" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Usuarios</title>
</head>
<body>
    <h2>Usuarios Registrados</h2>

    <table border="1">
        <tr>
            <th>Nombre</th>
            <th>Apellido Paterno</th>
            <th>Email</th>
            <th>Acciones</th>
        </tr>
        <%
            ArrayList<Persona> personas = NewServletPersona.getPersonas();
            for (Persona persona : personas) {
        %>
            <tr>
                <td><%= persona.getNombre() %></td>
                <td><%= persona.getApellido_p() %></td>
                <td><%= persona.getEmail() %></td>
                <td>
                    <!-- Botón para mostrar el XML -->
                    <form action="mostrar_xml.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="fileName" value="<%= persona.getNombre() + "_" + persona.getApellido_p() + ".xml" %>">
                        <input type="submit" value="Mostrar XML">
                    </form>

                    <!-- Botón para crear el XML -->
                    <form action="crear_xml.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="nombre" value="<%= persona.getNombre() %>">
                        <input type="hidden" name="apellido_p" value="<%= persona.getApellido_p() %>">
                        <input type="hidden" name="email" value="<%= persona.getEmail() %>">
                        <input type="submit" value="Crear XML">
                    </form>
                </td>
            </tr>
        <%
            }
        %>
    </table>
    
    <!-- Botón para ir al formulario y agregar un nuevo usuario -->
    <form action="form.jsp" method="get" style="margin-top:20px;">
        <input type="submit" value="Crear Nuevo Usuario">
    </form>
</body>
</html>