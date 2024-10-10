package src.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import src.configuration.Conexion;

@WebServlet(name = "Upload", urlPatterns = {"/Upload"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50)
public class Upload extends HttpServlet {
    private static final String UPLOAD_DIR = "images";
    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> imagePaths = getImagePathsFromDatabase();
        request.setAttribute("imagePaths", imagePaths);
        
        request.getRequestDispatcher("/views/display_images.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        
        Part part = request.getPart("image");
        String fileName = getFileName(part);
        
        String filePath = uploadFilePath + File.separator + fileName;
        part.write(filePath);
        
        String relativePath = UPLOAD_DIR + File.separator + fileName;
        System.out.println("Path: "+relativePath);
        
        saveImagePathToDatabase(relativePath);
        
        response.getWriter().println("Imagen subida correctament. Ruta: "+relativePath);
    }
    
    private String getFileName (Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) 
            if (token.trim().startsWith("filename"))
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
        return "";
    }
    
    private void saveImagePathToDatabase(String imagePath) {
        try {
            Conexion conexion = new Conexion();
            conn = conexion.getConnection();
            String sql = "INSERT INTO imagenes (ruta_image) VALUES (?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, imagePath);
            
            int filasInsertadas = ps.executeUpdate();
            if (filasInsertadas > 0) System.out.println("Imagen Registrada");
            else System.out.println("Imagen no Registrada");
            
            ps.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private List<String> getImagePathsFromDatabase () {
        List<String> imagePaths = new ArrayList<>();
        try {
            Conexion conexion = new Conexion();
            String sql = "SELECT ruta_image FROM imagenes";
            
            conn = conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
           
            while (rs.next()) imagePaths.add(rs.getString("ruta_image"));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return imagePaths;
    }
    
    @Override
    public String getServletInfo() { return "Short description"; }

}
