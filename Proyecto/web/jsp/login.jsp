<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de login</title>
        <link rel="stylesheet" type="text/css" href="../css/login.css">
    </head>
    <body>
        <fieldset>
            <legend> <h1>INICIO DE SESIÓN</h1> </legend>
            <form method="POST" action="${pageContext.request.contextPath}/NewServletAuth">
                <!-- Campo oculto para indicar la acción de login -->
                <input type="hidden" name="action" value="login" />
                
                <p><label>CURP: </label><input type="text" name="curp" id="curp" required /></p>
                <p><label>Contraseña: </label><input type="password" name="password" id="password" required /></p>
                <button type="submit"> Entrar </button>
            </form>
        </fieldset>
    </body>
</html>