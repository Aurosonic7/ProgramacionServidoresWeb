<%@page import="src.bean.PersonasBean"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Personas Registradas</h1>
    <a href="formulario.jsp">Registrar Nueva Persona</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Edad</th>
            <th>Altura</th>
            <th>CURP</th>
            <th>Acciones</th>
        </tr>
        <%
            List<PersonasBean> personas = PersonasBean.obtenerPersonas();
            for (PersonasBean persona : personas) {
        %>
        <tr>
            <td><%= persona.getPersonaId() %></td>
            <td><%= persona.getNombre() %></td>
            <td><%= persona.getEdad() %></td>
            <td><%= persona.getAltura() %></td>
            <td><%= persona.getCurp() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/DetallePersonaServlet?id=<%= persona.getPersonaId() %>">Ver Detalle</a>
                <a href="<%= request.getContextPath() %>/XmlPersonaServlet?id=<%= persona.getPersonaId() %>">Ver en XML</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>