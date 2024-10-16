package src.model;

import java.sql.Date;

public class Persona {
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    private int id;
    private String nombre;
    private double altura;
    private boolean genero;
    private Date createdAt;
    
    public Persona () { }

    public Persona(int id, String nombre, double altura, boolean genero, Date createdAt) {
        this.id = id;
        this.nombre = nombre;
        this.altura = altura;
        this.genero = genero;
        this.createdAt = createdAt;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public double getAltura() { return altura; }
    public void setAltura(double altura) { this.altura = altura; }
    public boolean isGenero() { return genero; }
    public void setGenero(boolean genero) { this.genero = genero; }
    public Date getCreatedAt() { return createdAt; }

    @Override
    public String toString() {
        return "Persona{" + "id=" + id + ", nombre=" + nombre + ", altura=" + altura + ", genero=" + genero + ", createdAt=" + createdAt + '}';
    }
    
    
}
