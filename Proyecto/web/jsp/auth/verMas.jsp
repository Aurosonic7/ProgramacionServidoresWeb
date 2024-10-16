<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles de Persona y Vivienda</title>
        <link rel="stylesheet" type="text/css" href="../../css/inicio.css">
    </head>
    <body>
        <fieldset>
            <legend><h1>Detalles de la Persona y Vivienda</h1></legend>
            <div class="container">
                <div class="photo">
                    <h3>Foto:</h3>
                    <img src="<%= request.getContextPath() + "/" + (String)request.getAttribute("foto") %>" alt="Foto del usuario" width="300"/>
                </div>
                <div class="textContainer">
                    <p><b>Bienvenido:</b> 
                        <%= (request.getAttribute("nombre") != null ? (String)request.getAttribute("nombre") : "") %>
                        <%= (request.getAttribute("apellido_p") != null ? (String)request.getAttribute("apellido_p") : "") %>
                        <%= (request.getAttribute("apellido_m") != null ? (String)request.getAttribute("apellido_m") : "") %>
                    </p>
                    <p><b>CURP:</b> 
                        <%= (request.getAttribute("curp") != null ? ((String)request.getAttribute("curp")).toUpperCase() : "CURP no disponible") %>
                    </p>
                    <p><b>Género:</b> 
                        <%= (request.getAttribute("genero") != null ? (String)request.getAttribute("genero") : "No especificado") %>
                    </p>
                    <p><b>Fecha de Nacimiento:</b> 
                        <%= (request.getAttribute("fecha_nac") != null ? request.getAttribute("fecha_nac").toString() : "Fecha no disponible") %>
                    </p>
                </div>
            </div>

            <div class="container">
                <h3>Datos de la Vivienda</h3>
                <p><b>Calle:</b> <%= (request.getAttribute("calle") != null ? (String)request.getAttribute("calle") : "No disponible") %></p>
                <p><b>Colonia:</b> <%= (request.getAttribute("colonia") != null ? (String)request.getAttribute("colonia") : "No disponible") %></p>
                <p><b>Municipio:</b> <%= (request.getAttribute("municipio") != null ? (String)request.getAttribute("municipio") : "No disponible") %></p>
                <p><b>Código Postal:</b> <%= (request.getAttribute("cp") != null ? (String)request.getAttribute("cp") : "No disponible") %></p>
            </div>
        </fieldset>
    </body>
</html>