<%@page import="java.util.List"%>
<%@page import="model.Animal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mostrar animales</title>
        <link rel="stylesheet" type="text/css" href="../css/mostrar_animales.css">
    </head>
    <body>
        <a href="registro_animales.jsp">Registro animal</a>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Color</th>
                    <th>Especie</th>
                    <th>Tipo Animal</th>
                    <th>Tipo Alimento</th>
                    <th>Peso (kg)</th>
                    <th>Habitad</th>
                    <th>Altura (m)</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <h1>Lista de animales</h1>
                <%
                    List<Animal> animales = (List) request.getSession().getAttribute("animales");
                    if(animales != null && !animales.isEmpty()) {
                        for (Animal animal : animales) {
                %>
                        <tr>
                            <td><%= animal.getId()%></td>
                            <td><%= animal.getColor()%></td>
                            <td><%= animal.getEspecie()%></td>
                            <td><%= animal.getTipo_animal()%></td>
                            <td><%= animal.getTipo_alimento()%></td>
                            <td><%= animal.getPeso()%></td>
                            <td><%= animal.getHabitad()%></td>
                            <td><%= animal.getAltura()%></td>
                            <td><button class="btn-eliminar" onclick="eliminarAnimal(<%= animal.getId() %>)">Eliminar</button>
                            <form action="${pageContext.request.contextPath}/views/actualizar_animales.jsp" method="GET"> 
                                <input type="hidden" name="id" value="<%= animal.getId() %>"> 
                                <input class="btn-actualizar" type="submit" value="Actualizar"> 
                            </form>
                            </td>
                        </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="7">No hay animales registrados.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
            <script type="text/javascript">
                var contextPath = '${pageContext.request.contextPath}';
            </script>
            <script type="text/javascript" src="../js/animalEliminar.js"></script>
    </body>
</html>
