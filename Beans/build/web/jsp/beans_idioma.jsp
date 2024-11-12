<jsp:useBean id="idiomaBean" scope="page" class="bean.IdiomaBean"/>
<jsp:setProperty name="idiomaBean" property="*"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPEhtml>
<html>
    <head>
        <title>Resultado de prueba del uso de beans</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
        <script 
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous">
        </script>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <br><br>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">Resultado</div>
                <div class="panel-body">
                    <p>Hola: <mark><jsp:getProperty name="idiomaBean" property="nombre"/></mark>.</p>
                    <p>Tu lenguaje favorito es: 
                        <mark><jsp:getProperty name="idiomaBean" property="idioma"/></mark></p>
                    <p>Mis comentarios acerca del lenguaje son: </p>
                    <p class="bg-info"><jsp:getProperty name="idiomaBean" property="opinion"/></p>
                </div>
            </div>
        </div>
    </body>
</html>