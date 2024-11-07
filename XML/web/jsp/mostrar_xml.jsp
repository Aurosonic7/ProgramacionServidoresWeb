<%@ page import="java.nio.file.Files, java.nio.file.Paths" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<html>
<head>
    <title>Mostrar XML</title>
</head>
<body>
    <h2>Contenido del XML</h2>
    <c:set var="fileName" value="${param.fileName}" />
    <c:choose>
        <c:when test="${not empty fileName}">
            <%
                String filePath = "/Users/christianvicente/Desktop/users/" + (String) request.getParameter("fileName");
                String userInfo = "";
                try {
                    userInfo = new String(Files.readAllBytes(Paths.get(filePath)), "UTF-8");
                    out.println("<p>Ruta del archivo: " + filePath + "</p>");
                    out.println("<p>Contenido del archivo:</p><pre>" + userInfo + "</pre>");
                } catch (Exception e) {
                    out.println("<p>Error al leer el archivo XML: " + e.getMessage() + "</p>");
                }
            %>
            <c:choose>
                <c:when test="${not empty userInfo}">
                    <x:parse xml="${userInfo}" var="output" />
                    <table border="1">
                        <tr><th>Campo</th><th>Valor</th></tr>
                        <tr><td>Nombre</td><td><x:out select="$output/Usuario/Nombre" /></td></tr>
                        <tr><td>Apellido Paterno</td><td><x:out select="$output/Usuario/ApellidoPaterno" /></td></tr>
                        <tr><td>Email</td><td><x:out select="$output/Usuario/Email" /></td></tr>
                    </table>
                </c:when>
                <c:otherwise><p>Error: El archivo XML está vacío o no se pudo cargar.</p></c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise><p>Error: No se especificó un archivo XML.</p></c:otherwise>
    </c:choose>
    <a href="mostrar_datos.jsp">Volver a la lista de usuarios</a>
</body>
</html>