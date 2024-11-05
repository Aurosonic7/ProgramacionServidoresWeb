<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.HashMap, java.util.Map" %>

<%
    String nombre = request.getParameter("nombre");

    Integer visitas = (Integer) session.getAttribute("visitas");
    if (visitas == null) visitas = 1;
    else visitas += 1;
    session.setAttribute("visitas", visitas);

    Integer contadorGlobal = (Integer) application.getAttribute("contadorGlobal");
    if (contadorGlobal == null) contadorGlobal = 1;
    else contadorGlobal += 1;
    application.setAttribute("contadorGlobal", contadorGlobal);

    // Crear la matriz de asientos 16x2 en el contexto de la aplicación si no existe
    boolean[][] asientos = (boolean[][]) application.getAttribute("asientos");
    if (asientos == null || asientos.length != 16 || asientos[0].length != 2) {
        asientos = new boolean[16][2];
        application.setAttribute("asientos", asientos);
    }

    // Crear la lista de reservas si no existe en el contexto de la aplicación
    List<Map<String, String>> reservas = (List<Map<String, String>>) application.getAttribute("reservas");
    if (reservas == null) {
        reservas = new ArrayList<>();
        application.setAttribute("reservas", reservas);
    }

    // Obtener el asiento seleccionado por el usuario
    String asientoSeleccionado = request.getParameter("asiento");
    if (nombre != null && !nombre.isEmpty() && asientoSeleccionado != null) {
        String[] partes = asientoSeleccionado.split("_");
        int fila = Integer.parseInt(partes[0]);
        int columna = Integer.parseInt(partes[1]);
        
        // Marcar el asiento como ocupado si está dentro de los límites de la matriz
        if (fila >= 0 && fila < 16 && columna >= 0 && columna < 2) {
            asientos[fila][columna] = true;
            
            // Agregar la reserva a la lista
            Map<String, String> reserva = new HashMap<>();
            reserva.put("nombre", nombre);
            reserva.put("asiento", asientoSeleccionado);
            reservas.add(reserva);
        }
    }

    response.setContentType("text/html;charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ejemplo de Objetos Implícitos en JSP</title>
    <style>
        .asientos-container {
            display: grid;
            grid-template-columns: repeat(2, 50px);
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }
        .asiento {
            width: 50px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 2px solid #333;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
        }
        .asiento.disponible {
            background-color: #4CAF50;
            color: white;
        }
        .asiento.ocupado {
            background-color: #FF6347;
            color: white;
            cursor: not-allowed;
        }
        .asiento:hover.disponible {
            background-color: #45a049;
        }
    </style>
    <script>
        function validarFormulario() {
            const nombre = document.getElementById("nombre").value;
            if (!nombre) {
                alert("Por favor, ingrese su nombre.");
                return false;
            }
            
            const asientos = document.getElementsByName("asiento");
            let asientoSeleccionado = false;
            for (let i = 0; i < asientos.length; i++) {
                if (asientos[i].checked) {
                    asientoSeleccionado = true;
                    break;
                }
            }
            
            if (!asientoSeleccionado) {
                alert("Por favor, seleccione un asiento.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h2>Ejemplo de Objetos Implícitos en JSP</h2>

    <!-- Formulario para recibir el nombre del usuario y el asiento -->
    <form method="POST" onsubmit="return validarFormulario()">
        <label for="nombre">Ingrese su nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <br />

        <!-- Selección de Asiento -->
        <h3>Seleccione su Asiento</h3>
        <div class="asientos-container">
            <%
                for (int i = 0; i < 16; i++) {
                    for (int j = 0; j < 2; j++) {
                        boolean ocupado = asientos[i][j];
                        String estadoClase = ocupado ? "ocupado" : "disponible";
                        String idAsiento = i + "_" + j;
            %>
                        <label>
                            <input type="radio" name="asiento" value="<%= idAsiento %>" style="display: none;" <%= ocupado ? "disabled" : "" %>>
                            <div class="asiento <%= estadoClase %>"><%= idAsiento %></div>
                        </label>
            <%
                    }
                }
            %>
        </div>
        <br />
        <input type="submit" value="Reservar Asiento">
    </form>
        
    <%
        // Mostrar un mensaje de bienvenida al usuario según el nombre ingresado
        if (nombre != null && !nombre.isEmpty()) {
            out.println("<p>Bienvenido, " + nombre + "!</p>");
        } else {
            out.println("<p>Bienvenido, visitante anónimo!</p>");
        }
    %>

    <h3>Lista de Reservas</h3>
    <table border="1">
        <tr>
            <th>Nombre</th>
            <th>Asiento</th>
        </tr>
        <%
            for (Map<String, String> reserva : reservas) {
                String nombreReserva = reserva.get("nombre");
                String asientoReserva = reserva.get("asiento");
        %>
        <tr>
            <td><%= nombreReserva %></td>
            <td><%= asientoReserva %></td>
        </tr>
        <%
            }
        %>
    </table>

    <h3>Información de la Sesión</h3>
    <p>Número de visitas en esta sesión: <%= visitas %></p>

    <h3>Información de la Aplicación</h3>
    <p>Contador global de visitas a la página: <%= contadorGlobal %></p>

    <h3>Uso de `request` para obtener detalles de la solicitud:</h3>
    <p>Dirección IP del cliente: <%= request.getRemoteAddr() %></p>
    <p>Método de la solicitud: <%= request.getMethod() %></p>

    <h3>Información de la página</h3>
    <p>Clase de la página JSP actual: <%= page.getClass().getName() %></p>

    <!-- Usar JSTL para mostrar datos almacenados en la sesión -->
    <h3>Uso de JSTL para mostrar los datos</h3>
    <c:if test="${not empty sessionScope.visitas}">
        <p>Número de visitas usando JSTL: ${sessionScope.visitas}</p>
    </c:if>
</body>
</html>