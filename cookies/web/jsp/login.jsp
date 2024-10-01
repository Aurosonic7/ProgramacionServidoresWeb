<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/login_servlet" method="POST">
            <p><label>Matricula: </label><input type="text" name="matricula" id="matricula" required /></p>
            <p><label>Password: </label><input type="text" name="password" id="password" required /></p>
            <p><input type="checkbox" name="recordar" id="recordar"> Recordar mis datos </input></p>
            <p><input type="submit" value="Iniciar Sesión"></p>
        </form>
    </body>
</html>
