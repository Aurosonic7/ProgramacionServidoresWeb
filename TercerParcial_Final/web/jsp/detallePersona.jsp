<%@page import="src.bean.PersonasBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    PersonasBean persona = (PersonasBean) request.getAttribute("persona");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Detalle de Persona</title>
</head>
<body>
    <h1>Detalle de Persona</h1>
    <p>ID: <%= persona.getPersonaId() %></p>
    <p>Nombre: <%= persona.getNombre() %></p>
    <p>Edad: <%= persona.getEdad() %></p>
    <p>Altura: <%= persona.getAltura() %></p>
    <p>CURP: <%= persona.getCurp() %></p>
    <a href="./jsp/dashboard.jsp">Volver al Dashboard</a>
</body>
</html>