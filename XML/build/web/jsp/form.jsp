<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/NewServletPersona" method="post">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="apellido_p">Apellido Paterno:</label>
        <input type="text" id="apellido_p" name="apellido_p" required><br><br>

        <label for="email">Email:</label>
        <input type="text" id="email" name="email" required><br><br>

        <input type="submit" value="Enviar">
    </form>
</body>
</html>