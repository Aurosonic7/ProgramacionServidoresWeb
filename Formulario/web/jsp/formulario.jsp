<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de computadoras</title>
        <link rel="stylesheet" type="text/css" href="../css/formularioComputadoras.css">
        <script>
            // JavaScript para obtener datos de una cookie y cargarlo en los campos
            window.onload = function() {
                // Obtener cookies
                const cookies = document.cookie.split('; ').reduce((acc, cookie) => {
                    const [name, value] = cookie.split('=');
                    acc[name] = value;
                    return acc;
                }, {});

                // Cargar los valores en los campos
                document.getElementById('matricula').value = cookies['matricula'] || '';
                document.getElementById('nombre').value = cookies['nombre'] || '';
                document.getElementById('precio').value = cookies['precio'] || '';
                document.getElementById('fecha_creacion').value = cookies['fecha_creacion'] || '';
                document.getElementById('hora_puesta').value = cookies['hora_puesta'] || '';
            };
        </script>
    </head>
    <body>
        <h1>Formulario de computadoras</h1>
        <form method="POST" action="${pageContext.request.contextPath}/NewServletComputadora2">
            <p><label>Matricula: </label><input type="number" name="matricula" id="matricula" readonly /></p>
            <p><label>Nombre: </label><input type="text" name="nombre" id="nombre" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" readonly /></p>
            <p><label>Precio: </label><input type="number" name="precio" id="precio" min="0" step="0.01" readonly /></p>
            <p><label>Fecha de creación: </label><input type="date" name="fecha_creacion" id="fecha_creacion" readonly /></p>
            <p><label>Hora de puesta: </label><input type="time" name="hora_puesta" id="hora_puesta" readonly /></p>
            <p><input type="submit" value="Registrar"></p>
        </form>
    </body>
</html>