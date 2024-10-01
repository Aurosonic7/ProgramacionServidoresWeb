<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de sesión</title>
        <%
            String valor = "";
            int flag = 0;
            do{
                
            
            Cookie [] cookies = request.getCookies();
            
            for (Cookie c: cookies) {
            c.toString();
                if (c.getName().equals("matricula")){
                    valor = c.getValue();
                    break;
                }
            }
            flag++;
            }while(flag < 1);

        %>
    </head>
    <body>
        <h1>Bienvenido <%= valor%>, ha iniciado sesión de manera correcta.</h1>
        <a href="${pageContext.request.contextPath}/login_servlet">Cerrar Sesión</a>
    </body>
</html>
