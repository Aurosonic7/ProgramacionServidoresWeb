<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="bean.AnimalesBean"%>

<%
    String nombreAnimal = "Firulais";
    String colorAnimal = "Marrón";
    String razaAnimal = "Labrador";
    Integer edadAnimal = 3;
    Double alturaAnimal = 0.75;
%>

<jsp:useBean id="animal_bean" class="bean.AnimalesBean"/>
<jsp:setProperty name="animal_bean" property="nombreAnimal" value="<%=nombreAnimal%>"/>
<jsp:setProperty name="animal_bean" property="colorAnimal" value="<%=colorAnimal%>"/>
<jsp:setProperty name="animal_bean" property="razaAnimal" value="<%=razaAnimal%>"/>
<jsp:setProperty name="animal_bean" property="edadAnimal" value="<%=edadAnimal%>"/>
<jsp:setProperty name="animal_bean" property="altura" value="<%=alturaAnimal%>"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <br>
            <div class="row">
                <div class="col-6">
                    <div class="card" style="background-color: #ccccff">
                        <div class="card-body">
                            <h3 class="card-title">Datos del Animal</h3>
                            <%
                                out.println("<h4>Nombre: " + animal_bean.getNombreAnimal() + "</h4>");
                                out.println("<h4>Color: " + animal_bean.getColorAnimal() + "</h4>");
                                out.println("<h4>Raza: " + animal_bean.getRazaAnimal() + "</h4>");
                                out.println("<h4>Edad: " + animal_bean.getEdadAnimal() + " años</h4>");
                                out.println("<h4>Altura: " + animal_bean.getAltura() + " metros</h4>");
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>