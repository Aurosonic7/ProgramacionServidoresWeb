package src.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexion {
private static final Logger logger = Logger.getLogger(Conexion.class.getName());
    private static final String URL = "jdbc:mysql://localhost:3306/prueba";
    private static final String USER = "root";
    private static final String PASSWORD = "12345678";

    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            logger.log(Level.INFO, "Conexión a la base de datos establecida.");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Error al cargar el driver JDBC: " + e.getMessage(), e);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error al establecer la conexión con la base de datos: " + e.getMessage(), e);
        }
        return connection;
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                logger.log(Level.INFO, "Conexión a la base de datos cerrada.");
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Error al cerrar la conexión a la base de datos: " + e.getMessage(), e);
            }
        }
    }    
}
