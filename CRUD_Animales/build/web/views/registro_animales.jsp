<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro animales</title>
        <link rel="stylesheet" type="text/css" href="../css/registro_animales.css">
    </head>
    <body>
        <h1> Datos animales </h1>
        <form action="${pageContext.request.contextPath}/NewServletAnimal" method="POST">
            <p><label>Color: </label> <input type="text" name="color" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> </p>
            <p><label>Especie: </label> <input type="text" name="especie" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> </p>
            <p><label>Tipo Animal: </label> <input type="text" name="tipo_animal" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> </p>
            <p><label>Tipo Alimento: </label> <input type="text" name="tipo_alimento" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> </p>
            <p><label>Peso: </label> <input type="number" name="peso" min="0" step="0.01" required /> </p>
            <p><label>Habitad: </label> <input type="text" name="habitad" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> </p>
            <p><label>Altura: </label> <input type="number" name="altura" min="0" step="0.01" required /> </p>
            <button type="submit">Enviar</button>
        </form>
    </body>
</html>
