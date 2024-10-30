<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<%
    // Limpiar los datos de la sesión
    session.removeAttribute("personas");

    // Redireccionar de vuelta a la tabla
    response.sendRedirect("tablaPersona.jsp");
%>