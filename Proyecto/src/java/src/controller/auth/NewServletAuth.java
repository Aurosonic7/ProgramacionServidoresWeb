package src.controller.auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import src.config.db.Mysql;
import src.model.Becario;

@WebServlet(name = "NewServletAuth", urlPatterns = {"/NewServletAuth"})
public class NewServletAuth extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("extendSession".equals(action)) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(2 * 60); // Reiniciar a 2 minutos
            response.getWriter().write("Sesión extendida");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String curp = request.getParameter("curp");
        String password = request.getParameter("password");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Mysql conexion = new Mysql();
            conn = conexion.getConnection();
            String sql = "SELECT password FROM Becario WHERE curp = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, curp);
            rs = ps.executeQuery();

            if (rs.next()) {
                String hashPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("curp", curp);
                    session.setMaxInactiveInterval(2 * 60); // Sesión expira en 2 minutos
                    
                    Cookie cookie = new Cookie("curp", curp);
                    cookie.setMaxAge(15 * 60); // Cookie expira en 15 minutos
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    
                    response.sendRedirect(request.getContextPath() + "/jsp/auth/inicio.jsp");
                } else {
                    request.setAttribute("error", "Contraseña incorrecta.");
                    request.getRequestDispatcher("/index.html").forward(request, response);
                }
            } else {
                request.setAttribute("error", "CURP no encontrado.");
                request.getRequestDispatcher("/index.html").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error de servidor.");
            request.getRequestDispatcher("/index.html").forward(request, response);
            System.out.println("Error: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Date fecha_nac = null;

        String curp = request.getParameter("curp");
        String ap_pat = request.getParameter("ap_pat");
        String ap_mat = request.getParameter("ap_mat");
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");
        String genero = request.getParameter("genero");
        try {
            fecha_nac = getDateOfString(curp);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Becario becario = new Becario();
        becario.setCURP(curp);
        becario.setApellido_p(ap_pat);
        becario.setApellido_m(ap_mat);
        becario.setNombre(nombre);
        becario.setGenero(genero);
        String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        becario.setPassword(hashPassword);
        becario.setFecha_nac(fecha_nac);

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = new Mysql().getConnection();
            String sql = "INSERT INTO Becario(curp, apellido_p, apellido_m, nombre, genero, password, fecha_nac) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);

            ps.setString(1, becario.getCURP());
            ps.setString(2, becario.getApellido_p());
            ps.setString(3, becario.getApellido_m());
            ps.setString(4, becario.getNombre());
            ps.setString(5, becario.getGenero());
            ps.setString(6, becario.getPassword());
            ps.setDate(7, becario.getFecha_nac());

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("¡El nuevo Becario fue insertado exitosamente en la base de datos!");
                response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/registro.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(NewServletAuth.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private Date getDateOfString(String curp) {
        String fecha_nac = "";
        String mes = "-".concat(curp.substring(6, 8));
        String day = "-".concat(curp.substring(8, 10));
        int year = Integer.parseInt(curp.substring(4, 6));

        if (year >= 50) fecha_nac = "19".concat(String.valueOf(year));
        else if (year <= 9) fecha_nac = "200".concat(String.valueOf(year));
        else fecha_nac = "20".concat(String.valueOf(year));

        return Date.valueOf(fecha_nac.concat(mes).concat(day));
    }
    
    @Override
    public String getServletInfo() { return "Short description"; }

}
