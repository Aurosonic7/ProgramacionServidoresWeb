<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession session_web = request.getSession(false);
    String matricula = null;
    if(session_web != null) {
        matricula = (String) session_web.getAttribute("matricula");
    }
    int timeRemaining = (session_web != null) ? session_web.getMaxInactiveInterval() : -1;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuario</title>
        <script type="text/javascript">
            function formatTime(seconds) {
                var hours = Math.floor(seconds / 3600);
                var minutes = Math.floor((seconds % 3600) / 60);
                var seconds = seconds % 60;
                return [hours, minutes, seconds].map(unit => unit < 10 ? "0" + unit : unit).join(":");
            }

            var timeLeft = <%= timeRemaining %>;
            
            function startCountdown() {
                var countdownElem = document.getElementById("timeRemaining");
                var interval = setInterval(function() {
                    if (timeLeft > 0) {
                        countdownElem.innerHTML = formatTime(timeLeft);
                        timeLeft--;
                    } else {
                        countdownElem.innerHTML = "La sesión ha expirado.";
                        clearInterval(interval); 
                        window.location.href = "<%= request.getContextPath() %>/LoginServlet";
                    }
                }, 1000);
            }
        </script>
    </head>
    <body onload="startCountdown()">
        <h2>Bienvenido, <%= (matricula != null) ? matricula : "Invitado" %></h2>
        <% if (matricula != null) { %>
            <p>Has iniciado sesión correctamente.</p>
            <a href="<%= request.getContextPath() %>/LoginServlet">Cerrar sesión</a>
            <p>Tiempo restante hasta la expiración de la sesión: <span id="timeRemaining"><%= timeRemaining %></span></p>
        <% } else { %>
            <p>No has iniciado sesión. <a href="login.jsp">Iniciar sesión</a></p>
        <% } %>
    </body>
</html>