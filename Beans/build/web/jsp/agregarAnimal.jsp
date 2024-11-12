<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.AnimalesBean, bean.ZooBean" %>

<jsp:useBean id="zoo" class="bean.ZooBean" scope="session" />
<jsp:useBean id="animal" class="bean.AnimalesBean" scope="page" />
<jsp:setProperty name="animal" property="*" />

<%
    // Verificar si se ha enviado el formulario
    String nombre = request.getParameter("nombreAnimal");
    if (nombre != null && !nombre.isEmpty()) {
        // Agregar el animal a la lista en ZooBean
        zoo.agregarAnimal(animal);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Agregar Animal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h2>Agregar Nuevo Animal</h2>
        <form action="agregarAnimal.jsp" method="post">
            Nombre: <input type="text" name="nombreAnimal" class="form-control" required><br>
            Color: <input type="text" name="colorAnimal" class="form-control" required><br>
            Raza: <input type="text" name="razaAnimal" class="form-control" required><br>
            Edad: <input type="number" name="edadAnimal" class="form-control" required><br>
            Altura: <input type="text" name="altura" class="form-control" required><br>
            <input type="submit" class="btn btn-primary" value="Agregar Animal">
        </form>
        <br>
        <a href="verAnimales.jsp" class="btn btn-info">Ver Lista de Animales</a>
    </div>
</body>
</html>