<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="bean.PersonaBean"%>

<% 
    String curpPersona = "VIJC02AD";
    String apellidoPersona = "Vicente";
    String nombrePersona = "Christian";
    boolean generoPersona = true;
%>
<jsp:useBean id="persona_bean" class="bean.PersonaBean"/>
<jsp:setProperty name="persona_bean" property="curpPersona" value="<%=curpPersona%>"/>
<jsp:setProperty name="persona_bean" property="apellidoPersona" value="<%=apellidoPersona%>"/>
<jsp:setProperty name="persona_bean" property="nombrePersona" value="<%=nombrePersona%>"/>
<jsp:setProperty name="persona_bean" property="generoPersona" value="<%=generoPersona%>"/>


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
                            <h3 class="card-title">Datos personales</h3>
                            <%
                                out.println("<h4>Curp: "+persona_bean.getCurpPersona()+"<h4>");
                                out.println("<h4>Apellido: "+persona_bean.getApellidoPersona()+"<h4>");
                                out.println("<h4>Nombre: "+persona_bean.getNombrePersona()+"<h4>");
                                out.println("<h4>Genero: "+persona_bean.isGeneroPersona()+"<h4>");
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
