package src.controller.vivienda;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import src.config.db.Mysql;
import src.model.Vivienda;

@WebServlet(name = "NewServletVivienda", urlPatterns = {"/NewServletVivienda"})
public class NewServletVivienda extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String curp = request.getParameter("curp");
        String calle = request.getParameter("calle");
        String colonia = request.getParameter("colonia");
        String municipio = request.getParameter("municipio");
        String cp = request.getParameter("cp");
        
        Vivienda vivienda = new Vivienda();
        vivienda.setId(0);
        vivienda.setCurp(curp);
        vivienda.setCalle(calle);
        vivienda.setColonia(colonia);
        vivienda.setMunicipio(municipio);
        vivienda.setCp(cp);
        
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new Mysql().getConnection();
            
            String sql = "INSERT INTO Vivienda(id, calle, colonia, municipio, cp, curp) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, vivienda.getId());
            ps.setString(2, vivienda.getCalle());
            ps.setString(3, vivienda.getColonia());
            ps.setString(4, vivienda.getMunicipio());
            ps.setString(5, vivienda.getCp());
            ps.setString(6, vivienda.getCurp());

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("¡La vivienda fue insertada exitosamente en la base de datos!");
                response.sendRedirect(request.getContextPath() + "/jsp/auth/inicio.jsp");
            } else {
                System.out.println("Error al insertar la vivienda.");
                response.sendRedirect(request.getContextPath() + "/jsp/auth/formularioVivienda.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/auth/formularioVivienda.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
