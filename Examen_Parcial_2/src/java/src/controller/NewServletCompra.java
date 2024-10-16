package src.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import src.config.mysql.Mysql;

@WebServlet(name = "NewServletCompra", urlPatterns = {"/NewServletCompra"})
public class NewServletCompra extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idPers = Integer.parseInt(request.getParameter("idPers"));
        int idProd = Integer.parseInt(request.getParameter("idProd"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        BigDecimal descuento = new BigDecimal(request.getParameter("descuento"));
        String statusMessage = "";
        
        Connection conn = null;
        CallableStatement cs = null;
        
        try {
            conn = new Mysql().getConnection();
            
            String sql = "{CALL realizar_compra(?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);
            
            cs.setInt(1, idPers);
            cs.setInt(2, idProd);
            cs.setInt(3, cantidad);
            cs.setBigDecimal(4, descuento);
            cs.registerOutParameter(5, java.sql.Types.VARCHAR);
            
            cs.execute();
            statusMessage = cs.getString(5);
            request.setAttribute("statusMessage", statusMessage);
            request.getRequestDispatcher("index.html").forward(request, response);
            
        } catch(SQLException e) {
            request.setAttribute("statusMessage", "Error al realizar la compra: " + e.getMessage());
            request.getRequestDispatcher("resultadoCompra.jsp").forward(request, response);
        } finally {
            if (cs != null) try { cs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
    }
}
