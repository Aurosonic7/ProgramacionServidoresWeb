<%@page import="src.bean.PersonasBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String xmlData = (String) request.getAttribute("xmlData");
    PersonasBean persona = (PersonasBean) request.getAttribute("persona");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Ver XML</title>
</head>
<body>
    <h1>Datos en XML</h1>
    <pre>
        <%= xmlData %>
    </pre>
    <form action="<%= request.getContextPath() %>/DescargarXmlServlet" method="post">
        <textarea name="xmlData" style="display:none;"><%= xmlData %></textarea>
        <input type="hidden" name="fileName" value="persona_<%= persona.getPersonaId() %>.xml">
        <button type="submit">Descargar XML</button>
    </form>
    <a href="<%= request.getContextPath() %>/jsp/dashboard.jsp">Volver al Dashboard</a>
</body>
</html>