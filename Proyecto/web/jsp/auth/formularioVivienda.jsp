<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Formulario de Vivienda</title>
    <link rel="stylesheet" type="text/css" href="../../css/vivienda.css">
</head>
<body>
    <fieldset>
        <legend><h1>Formulario de Vivienda</h1></legend>

        <%
            String curpSession = (String) session.getAttribute("curp");
            
            if (curpSession == null) {
                response.sendRedirect(request.getContextPath() + "/jsp/auth/login.jsp");
            } else {
        %>

        <form action="<%= request.getContextPath() %>/NewServletVivienda" method="POST">
            <input type="hidden" name="curp" value="<%= curpSession %>">
            
            <label for="calle">Calle:</label>
            <input type="text" id="calle" name="calle" required><br><br>
            
            <label for="colonia">Colonia:</label>
            <input type="text" id="colonia" name="colonia" required><br><br>
            
            <label for="municipio">Municipio:</label>
            <input type="text" id="municipio" name="municipio" required><br><br>
            
            <label for="cp">Código Postal:</label>
            <input type="text" id="cp" name="cp" required><br><br>

            <button type="submit">Guardar Vivienda</button>
        </form>
        <% } %>
    </fieldset>
</body>
</html>