<!DOCTYPEhtml>
<html>
    <head>
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
                <div class="panel-heading">Uso de JavaBean</div>
                <div class="panel-body">
                    <h1>Página de prueba del uso de beans</h1>
                    <p>Se envía el formulario al servicio cuyo fichero es <mark>beans.jsp</mark></p>
                </div>
            </div>
            <div class="row col-md-12" >
                <form role="form" action="${pageContext.request.contextPath}/jsp/beans_idioma.jsp" method="POST">
                    <div class="col-md-10">
                        <div class="form-group">
                            <label for="nombre">Por favor, introduce tu nombre:</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" name="nombre" id="nombre"
                                           placeholder="Ingresa tu nombre">
                                    <span class="input-group-addon"></span>
                                </div>
                        </div>
                        <div class="form-group">
                            <label for="lenguaje">¿Cuál es tu lenguaje favorito? </label>
                                <div class="input-group">
                                    <select name="idioma" class="form-control">
                                        <option value="Ingles">Inglés
                                        <option value="Francés">Francés
                                        <option value="Ruso">Ruso
                                    </select>
                                    <span class="input-group-addon"></span>
                                </div>
                        </div>
                        <input type="submit" class="btn btn-info" value="Enviar">
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>