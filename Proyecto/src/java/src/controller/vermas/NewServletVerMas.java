package src.controller.vermas;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import src.config.db.Mysql;
@WebServlet(name = "NewServletVerMas", urlPatterns = {"/NewServletVerMas"})
public class NewServletVerMas extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String curpSession = (String) session.getAttribute("curp");

        if (curpSession == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        Mysql conexion = new Mysql();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conexion.getConnection();
            System.out.println("Antes de la consulta...");
            String sql = "SELECT b.curp, b.apellido_p, b.apellido_m, b.nombre, b.genero, b.fecha_nac, b.foto, " +
                         "v.calle, v.colonia, v.municipio, v.cp " +
                         "FROM Becario b " +
                         "LEFT JOIN Vivienda v ON b.curp = v.curp " +
                         "WHERE b.curp = ?";
            System.out.println("Realize la consulta...");
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

                String calle = rs.getString("calle");
                String colonia = rs.getString("colonia");
                String municipio = rs.getString("municipio");
                String cp = rs.getString("cp");

                request.setAttribute("curp", curp);
                request.setAttribute("apellido_p", apellido_p);
                request.setAttribute("apellido_m", apellido_m);
                request.setAttribute("nombre", nombre);
                request.setAttribute("genero", genero);
                request.setAttribute("fecha_nac", fecha_nac);
                request.setAttribute("foto", foto);

                request.setAttribute("calle", calle);
                request.setAttribute("colonia", colonia);
                request.setAttribute("municipio", municipio);
                request.setAttribute("cp", cp);
            }
            
            
            request.getRequestDispatcher("/jsp/auth/verMas.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/auth/inicio.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ignore) {
                ignore.printStackTrace();
            }
        }
    }
}
