<%@page import="java.util.ArrayList"%>
<%@ page import="src.model.Persona" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<%
    // Inicializar la lista en la sesión si es la primera vez
    ArrayList<Persona> listaPersonas = (ArrayList<Persona>) session.getAttribute("personas");

    if (listaPersonas == null) {
        listaPersonas = new ArrayList<>();
        session.setAttribute("personas", listaPersonas);
    }

    // Verificar si se ha enviado un nuevo elemento desde el formulario
    String nuevoNombre = request.getParameter("nombre");
    String nuevoCorreo = request.getParameter("correo");
    String nuevaAltura = request.getParameter("altura");
    String nuevoGenero = request.getParameter("genero");

    // Validaciones en el servidor
    String nombreRegex = "^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$";
    String correoRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    boolean validacionExitosa = true;

    // Validar nombre
    if (!nuevoNombre.matches(nombreRegex)) {
        out.println("<p>Error: El nombre solo puede contener letras y acentos.</p>");
        validacionExitosa = false;
    }

    // Validar correo
    if (!nuevoCorreo.matches(correoRegex)) {
        out.println("<p>Error: El correo electrónico no es válido.</p>");
        validacionExitosa = false;
    }

    // Validar altura (solo números de hasta 3 dígitos)
    double altura = 0.0;
    try {
        altura = Double.parseDouble(nuevaAltura);
        if (altura < 0 || altura > 9999) {  // Se permite hasta 9999
            out.println("<p>Error: La altura debe ser un número de hasta 4 dígitos.</p>");
            validacionExitosa = false;
        }
    } catch (NumberFormatException e) {
        out.println("<p>Error: La altura debe ser un número válido.</p>");
        validacionExitosa = false;
    }

    // Si las validaciones son exitosas, crear y agregar el objeto Persona
    if (validacionExitosa) {
        boolean genero = Boolean.parseBoolean(nuevoGenero);

        // Crear un nuevo objeto Persona y agregarlo a la lista
        Persona nuevaPersona = new Persona(nuevoNombre, nuevoCorreo, altura, genero);
        listaPersonas.add(nuevaPersona);
        session.setAttribute("personas", listaPersonas);

        // Redireccionar a la tabla para ver la lista
        response.sendRedirect("tablaPersona.jsp");
    } else {
        // Mostrar enlace para intentar nuevamente si hay errores
        out.println("<br><a href='formulario.jsp'>Regresar al formulario</a>");
    }
%>