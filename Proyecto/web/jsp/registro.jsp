<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de registro</title>
        <link rel="stylesheet" type="text/css" href="../css/registro.css">
    </head>
    <body>
        <fieldset>
            <legend> <h1>ALTA BECARIO</h1> </legend>
            <form method="POST" action="${pageContext.request.contextPath}/NewServletAuth" accept-charset="UTF-8">
                <!-- Campo oculto para indicar la acción de registro -->
                <input type="hidden" name="action" value="register" />

                <p><label>CURP: </label>
                    <input type="text" name="curp" id="curp" required />
                </p>
                <p><label>Apellido Paterno: </label><input type="text" name="ap_pat" id="ap_pat" required /></p>
                <p><label>Apellido Materno: </label><input type="text" name="ap_mat" id="ap_mat" required /></p>
                <p><label>Nombre: </label><input type="text" name="nombre" id="nombre" required /></p>
                <p><label>Contraseña: </label><input type="password" name="password" id="password" required /></p>
                <p>
                    <label>Selecciona tu género:</label>
                    <br />
                    <label for="masculino">Masculino </label>
                    <input type="radio" name="genero" id="genero" value="masculino" required />
                    <label for="femenino">Femenino </label>
                    <input type="radio" name="genero" id="genero" value="femenino" required />
                </p>
                <button type="submit"> Registrarse </button>
            </form>
        </fieldset>
    </body>
</html>