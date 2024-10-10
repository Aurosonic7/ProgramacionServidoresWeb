<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.config.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession session_web = request.getSession(false);
    String matricula = null;
    if (session_web != null) {
        matricula = (String) session_web.getAttribute("matricula");
    }
%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de bienvenida</title>
    </head>
    <body>
        <h1>Bienvenido, <%= (matricula != null) ? matricula : "Invitado" %> </h1>
        <% if (matricula != null) { %>
            <p>Haz iniciado sessión</p>
            <a href="${pageContext.request.contextPath}/LoginServlet">Cerrar sesion</a>
        <% } else { %>
            <p>No has iniciado sesión</p>
        <% } %>
    </body>
</html>
