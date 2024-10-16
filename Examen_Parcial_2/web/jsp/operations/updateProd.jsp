<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.config.mysql.Mysql"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto actualizar</title>
    </head>
    <body>
        <h1>Actualizar Producto</h1>
        <script type="text/javascript">var contextPath = '<%= request.getContextPath() %>';</script>
        <%
            String id = request.getParameter("id");
            String nombre = "";
            boolean estado = false;
            double precio = 0.0;
            int cantidad = 0;
            Date createdAt = null;
            
            Mysql conexion = new Mysql();
            Connection connection = conexion.getConnection();
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            
            try {
                String sql = "SELECT nombre, precio, estado, cantidad, createdAt FROM producto WHERE id = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, id);
                resultSet = statement.executeQuery();
                
                if (resultSet.next()) {
                    nombre = resultSet.getString("nombre");
                    estado = resultSet.getBoolean("estado");
                    precio = resultSet.getDouble("precio");
                    cantidad = resultSet.getInt("cantidad");
                    createdAt = resultSet.getDate("createdAt");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <form id="formActualizarProducto">
            <p> <label>ID: </label> <input type="text" id="id" name="id" value="<%= id %>" readonly><br> </p>
            <p> <label>Nombre: </label>
                <input type="text" name="nombre" id="nombre" value="<%= nombre %>" pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo caracteres permitidos" required /> 
            </p>
            <p> <label>Estado: </label> <input type="text" name="estado" id="estado" value="<%= estado %>" required /> </p>
            <p> <label>Precio: </label>
                <input type="number" name="precio" id="precio"  value="<%= precio %>" required />
            </p>
            <p> <label>Cantidad: </label>
                <input type="number" name="cantidad" id="cantidad"  value="<%= cantidad %>" required />
            </p>
            <p> <label>createdAt: </label>  <input type="date" name="createdAt" id="createdAt" value="<%= createdAt %>" required />  </p>
            <input type="button" value="Actualizar" onclick="actualizarProducto()"> 
        </form>
        <div id="resultado"></div>
        <script type="text/javascript" src="../../js/productoActualizar.js"></script>
        </body>
</html>
