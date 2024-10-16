<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro productos</title>
        <link rel="stylesheet" type="text/css" href="../css/test.css">
    </head>
    <body>
        <h1> Datos productos </h1>
        <form action="${pageContext.request.contextPath}/NewServletProducto" method="POST">
            <p><label>Nombre: </label> <input type="text" name="nombre" id="nombre" pattern="[a-zA-Z\s]+" title="El nombre solo debe contener letras y espacios" required /> </p>
            <p><label>Precio: </label> <input type="number" name="precio" id="precio" required /> </p>
            <p><label>Estado: </label> <input type="text" name="estado" id="estado" required /> </p>
            <p><label>Cantidad: </label> <input type="number" name="cantidad" id="cantidad" required /> </p>
            <p><label>createdAt: </label> <input type="date" name="createdAt" id="createdAt" required /> </p>
            <button type="submit">Enviar</button>
        </form>
    </body>
</html>
