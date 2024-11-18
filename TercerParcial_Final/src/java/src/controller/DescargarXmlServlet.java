package src.controller;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DescargarXmlServlet", urlPatterns = {"/DescargarXmlServlet"})
public class DescargarXmlServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String xmlData = request.getParameter("xmlData");
        String fileName = request.getParameter("fileName");

        if (xmlData == null || fileName == null || xmlData.isEmpty()) {
            response.sendRedirect("jsp/dashboard.jsp");
            return;
        }

        response.setContentType("application/xml");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName);

        try (OutputStream outputStream = response.getOutputStream()) {
            outputStream.write(xmlData.getBytes("UTF-8"));
            outputStream.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}