package src.controller;

import src.bean.PersonasBean;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DetallePersonaServlet", urlPatterns = {"/DetallePersonaServlet"})
public class DetallePersonaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int id = 0;
        try {
            if (idParam != null) id = Integer.parseInt(idParam);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("jsp/dashboard.jsp");
            return;
        }
        
        PersonasBean persona = PersonasBean.obtenerDetallePersona(id);

        if (persona == null) response.sendRedirect("jsp/dashboard.jsp");
        else {
            request.setAttribute("persona", persona);
            request.getRequestDispatcher("jsp/detallePersona.jsp").forward(request, response);
        }
    }
}