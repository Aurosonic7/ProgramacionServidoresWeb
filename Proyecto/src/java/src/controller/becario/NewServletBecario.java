package src.controller.becario;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import src.config.db.Mysql;

@WebServlet(name = "NewServletBecario", urlPatterns = {"/NewServletBecario"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50)
public class NewServletBecario extends HttpServlet {
    private static final String UPLOAD_DIR = "images";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("extendSession".equals(action)) {
            // Extender la sesión reiniciando el temporizador de la sesión
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(2 * 60); // Reiniciar el temporizador a 2 minutos
            response.getWriter().write("Sesión extendida");  // Respuesta al cliente
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String curp = request.getParameter("curp");
        
        if (curp == null || curp.isEmpty()) {
            response.getWriter().println("CURP no proporcionado.");
            return;
        }

        Part part = request.getPart("image");
        String fileType = part.getContentType();
        if (fileType == null || !fileType.startsWith("image/")) {
            response.getWriter().println("Solo se permiten imágenes.");
            return;
        }

        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
        String filePath = uploadFilePath + File.separator + fileName;
        part.write(filePath);

        
        String relativePath = UPLOAD_DIR + File.separator + fileName;
        saveImagePathToDatabase(relativePath, curp);

        request.setAttribute("message", "Imagen subida correctamente.");
        request.getRequestDispatcher("/jsp/auth/inicio.jsp").forward(request, response);
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1).replace("\\", "/"); // Evitar problemas con caracteres
            }
        }
        return "";
    }

    private void saveImagePathToDatabase(String imagePath, String curp) {
        String sql = "UPDATE becario SET foto = ? WHERE curp = ?";
        try (Connection conn = new Mysql().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setString(2, curp);
            int filasInsertadas = ps.executeUpdate();
            if (filasInsertadas > 0) {
                System.out.println("Imagen registrada correctamente.");
            } else {
                System.out.println("No se pudo registrar la imagen.");
            }
        } catch (SQLException e) {
            System.out.println("Error al guardar la ruta de la imagen en la base de datos.");
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() { 
        return "Servlet para manejar la subida de imágenes de becarios."; 
    }
}