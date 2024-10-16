<%@page import="java.sql.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.config.db.Mysql"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página de inicio</title>
        <link rel="stylesheet" type="text/css" href="../../css/inicio.css">
        <script src="../../js/inicioSessionManager.js" type="text/javascript" > </script>
    </head>
    </head>
    <body>
        <fieldset>
            <legend><h1>Inicio</h1></legend>
            <h1>Datos de la persona: </h1>
            <%
                String curpSession = (String) session.getAttribute("curp");

                if (curpSession != null) {
                    Mysql conexion = new Mysql();
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        conn = conexion.getConnection();

                        String sql = "SELECT * FROM Becario WHERE curp = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, curpSession);  
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            String curp = rs.getString("curp");
                            String apellido_p = rs.getString("apellido_p");
                            String apellido_m = rs.getString("apellido_m");
                            String nombre = rs.getString("nombre");
                            String genero = rs.getString("genero");
                            Date fecha_nac = rs.getDate("fecha_nac");
                            String foto = rs.getString("foto");
            %>
            <div class="container">
                <div class="photo">
                    <h3>Foto:</h3>
                    <img src="<%= request.getContextPath() + "/" + foto %>" alt="Foto del usuario" width="300"/>
                </div>
                <form class="uploadPhoto" method="POST" action="${pageContext.request.contextPath}/NewServletBecario" enctype="multipart/form-data">
                    <label for="image">Selecciona una imagen: </label>
                    <input type="hidden" name="curp" value="<%= curpSession %>"/>
                    <input type="file" name="image" id="image" required />
                    <br /> <br />
                    <button type="submit">Subir imagen</button>
                </form>
                <div class="textContainer">
                    <p>Bienvenido <%=nombre + " " + apellido_p + " " + apellido_m%></p>
                    <p>Tu CURP es: <%=curp.toUpperCase()%></p>
                    <p>Tu género es: <%=genero%></p>
                    <p>Tu fecha de nacimiento es: <%=fecha_nac%></p>
                    <form class="boton" method="GET" action="${pageContext.request.contextPath}/NewServletVerMas">
                        <input type="submit" value="Ver más" />
                    </form>
                    <form class="boton" action="/Proyecto/jsp/auth/formularioVivienda.jsp">
                        <input type="submit" value="Registrar Vivienda" />
                    </form>
                </div>
            </div>
            <%
                        } else {
                            out.println("<p>No se encontraron datos para el CURP proporcionado.</p>");
                        }
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='5'>Error al obtener los datos: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                        conexion.closeConnection(conn);
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
                }
            %>
        </fieldset>
    </body>
</html>