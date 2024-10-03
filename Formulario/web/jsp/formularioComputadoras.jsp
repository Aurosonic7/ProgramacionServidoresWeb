<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de computadoras</title>
        <link rel="stylesheet" type="text/css" href="../css/formularioComputadoras.css">
    </head>
    <body>
        <h1>Formulario de computadoras</h1>
        <form action="${pageContext.request.contextPath}/NewServletComputadora" method="POST"">
            <p><label>Matricula: </label><input type="number" name="matricula" id="matricula" required /></p>
            <p><label>Nombre: </label><input type="text" name="nombre" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /></p>
            <p><label>Precio: </label><input type="number" name="precio" min="0" step="0.01" required /></p>
            <p><label>Fecha de creación:</label><input type="date" name="fecha_creacion" required /></p>
            <p><label>Hora de puesta: </label><input type="time" name="hora_puesta" required /></p>
            <p><input type="submit" value="Confirmar"></p>
        </form>
    </body>
</html>