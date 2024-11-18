package src.controller;

import src.bean.PersonasBean;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "XmlPersonaServlet", urlPatterns = {"/XmlPersonaServlet"})
public class XmlPersonaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int id = 0;

        try {
            if (idParam != null) {
                id = Integer.parseInt(idParam);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("jsp/dashboard.jsp");
            return;
        }

        PersonasBean persona = PersonasBean.obtenerDetallePersona(id);

        if (persona == null) {
            response.sendRedirect("jsp/dashboard.jsp");
        } else {
            // Generar XML asegurando caracteres válidos
            StringBuilder xmlBuilder = new StringBuilder();
            xmlBuilder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            xmlBuilder.append("<persona>");
            xmlBuilder.append("<id>").append(persona.getPersonaId()).append("</id>");
            xmlBuilder.append("<nombre>").append(escapeXml(persona.getNombre())).append("</nombre>");
            xmlBuilder.append("<edad>").append(persona.getEdad()).append("</edad>");
            xmlBuilder.append("<altura>").append(persona.getAltura()).append("</altura>");
            xmlBuilder.append("<curp>").append(escapeXml(persona.getCurp())).append("</curp>");
            xmlBuilder.append("</persona>");

            request.setAttribute("xmlData", xmlBuilder.toString());
            request.setAttribute("persona", persona);
            request.getRequestDispatcher("jsp/verXml.jsp").forward(request, response);
        }
    }

    private String escapeXml(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&apos;");
    }
}