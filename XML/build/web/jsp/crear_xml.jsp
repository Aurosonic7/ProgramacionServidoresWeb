<%@ page import="controller.NewServletPersona, model.Persona" %>
<%
    String nombre = request.getParameter("nombre");
    String apellidoP = request.getParameter("apellido_p");
    String email = request.getParameter("email");

    Persona persona = new Persona(nombre, apellidoP, email);
    try {
        NewServletPersona.crearXML(persona);
        out.println("<p>Archivo XML creado con éxito para " + nombre + " " + apellidoP + ".</p>");
    } catch (Exception e) {
        out.println("<p>Error al crear el archivo XML: " + e.getMessage() + "</p>");
    }
%>
<a href="mostrar_datos.jsp">Volver a la lista de usuarios</a>