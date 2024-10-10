<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar Sesión</title>
    </head>
    <body>
        <h1>Iniciar sesión</h1>
        <form method="POST" action="${pageContext.request.contextPath}/LoginServlet" >
            <label for="username">Nombre de usuario: </label>
            <input type="text" id="matricula" name="matricula" required /> 
            <br />
            <label for="password">Contraseña: </label>
            <input type="text" id="password" name="password" required />
            
            <button type="submit">Iniciar Sesión</button>
        </form>
            
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p style="color: red;"><%= error %></p>
        <% } %>
    </body>
</html>
