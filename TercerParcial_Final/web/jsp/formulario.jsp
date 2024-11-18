<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Formulario de Alta</title>
    <script>
        function validarFormulario(event) {
            const nombre = document.getElementById("nombre").value.trim();
            const edad = parseInt(document.getElementById("edad").value);
            const altura = parseFloat(document.getElementById("altura").value);
            const curp = document.getElementById("curp").value.trim();

            // Validar que el nombre no contenga caracteres inválidos
            const regexNombre = /^[a-zA-Z\s]+$/;
            if (!regexNombre.test(nombre)) {
                alert("El nombre solo debe contener letras y espacios.");
                event.preventDefault();
                return false;
            }

            // Validar edad dentro de un rango razonable
            if (isNaN(edad) || edad < 1 || edad > 120) {
                alert("La edad debe ser un número entre 1 y 120.");
                event.preventDefault();
                return false;
            }

            // Validar altura dentro de un rango lógico
            if (isNaN(altura) || altura < 0.5 || altura > 2.5) {
                alert("La altura debe ser un número entre 0.5 y 2.5 metros.");
                event.preventDefault();
                return false;
            }

            // Validar formato de CURP
            const regexCurp = /^[A-Z]{4}\d{6}[A-Z]{6}\d{2}$/;
            if (!regexCurp.test(curp)) {
                alert("La CURP debe ser válida (ejemplo: ABCD910203HDFABC01).");
                event.preventDefault();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <h1>Registrar Persona</h1>
    <form action="../NewServletPersona" method="post" onsubmit="return validarFormulario(event)">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required 
               pattern="[a-zA-Z\s]+" 
               title="El nombre solo puede contener letras y espacios."><br>
        <label for="edad">Edad:</label>
        <input type="number" id="edad" name="edad" required 
               min="1" max="120" 
               title="La edad debe estar entre 1 y 120 años."><br>
        <label for="altura">Altura:</label>
        <input type="number" step="0.01" id="altura" name="altura" required 
               min="0.5" max="2.5" 
               title="La altura debe estar entre 0.5 y 2.5 metros."><br>
        <label for="curp">CURP:</label>
        <input type="text" id="curp" name="curp" required 
               pattern="[A-Z]{4}\d{6}[A-Z]{6}\d{2}" 
               title="Formato CURP válido, ejemplo: ABCD910203HDFABC01."><br>
        <button type="submit">Registrar</button>
    </form>
</body>
</html>