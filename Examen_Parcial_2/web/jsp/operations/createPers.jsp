<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro Animales</title>
        <link rel="stylesheet" type="text/css" href="../../css/createPers.css">
    </head>
    <body>
        <div class="form-container">
            <h1>Registro de Personas</h1>
            <form action="${pageContext.request.contextPath}/NewServletPersona" method="POST">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" name="nombre" id="nombre" pattern="[a-zA-Z\s]+" title="El nombre solo debe contener letras y espacios" required>
                </div>
                
                <div class="form-group">
                    <label for="genero">Género:</label>
                    <input type="text" name="genero" id="genero" required>
                </div>

                <div class="form-group">
                    <label for="altura">Altura:</label>
                    <input type="number" name="altura" id="altura" step="0.01" min="0" required>
                </div>

                <div class="form-group">
                    <label for="createdAt">Fecha de creación:</label>
                    <input type="date" name="createdAt" id="createdAt" required>
                </div>

                <button type="submit">Enviar</button>
            </form>
        </div>
    </body>
</html>