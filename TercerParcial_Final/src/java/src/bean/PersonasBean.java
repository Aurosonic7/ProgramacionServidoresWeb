package src.bean;

import src.config.Mysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PersonasBean {
    private int personaId;
    private String nombre;
    private int edad;
    private double altura;
    private String curp;

    public int getPersonaId() { return personaId; }
    public void setPersonaId(int personaId) { this.personaId = personaId; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }
    public double getAltura() { return altura; }
    public void setAltura(double altura) { this.altura = altura; }
    public String getCurp() { return curp; }
    public void setCurp(String curp) { this.curp = curp; }

    public static List<PersonasBean> obtenerPersonas() {
        List<PersonasBean> personas = new ArrayList<>();
        Mysql conexion = new Mysql();
        try (Connection connection = conexion.getConnection()) {
            String query = "SELECT * FROM personas";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                PersonasBean persona = new PersonasBean();
                persona.setPersonaId(resultSet.getInt("persona_id"));
                persona.setNombre(resultSet.getString("nombre"));
                persona.setEdad(resultSet.getInt("edad"));
                persona.setAltura(resultSet.getDouble("altura"));
                persona.setCurp(resultSet.getString("curp"));
                personas.add(persona);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return personas;
    }

    public static PersonasBean obtenerDetallePersona(int id) {
        Mysql conexion = new Mysql();
        PersonasBean persona = null;
        try (Connection connection = conexion.getConnection()) {
            String query = "SELECT * FROM personas WHERE persona_id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                persona = new PersonasBean();
                persona.setPersonaId(resultSet.getInt("persona_id"));
                persona.setNombre(resultSet.getString("nombre"));
                persona.setEdad(resultSet.getInt("edad"));
                persona.setAltura(resultSet.getDouble("altura"));
                persona.setCurp(resultSet.getString("curp"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return persona;
    }
}