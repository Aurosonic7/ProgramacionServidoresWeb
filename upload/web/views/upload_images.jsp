<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subir una imagen</title>
    </head>
    <body>
        <h2>Subir una imagen</h2>
        <form method="POST" action="${pageContext.request.contextPath}/Upload" enctype="multipart/form-data">
            <label for="image">Selecciona una imagen: </label>
            <input type="file" name="image" id="image" required />
            <br /> <br />
            <button type="submit">Subir imagen</button>
        </form>
    </body>
</html>
