package src.model;

import java.sql.Date;

public class Producto {
    private int id;
    private String nombre;
    private double precio;
    private boolean estado;
    private Date createdAt;
    private int cantidad;
    
    public Producto () { }

    public Producto(int id, String nombre, double precio, boolean estado, Date createdAt, int cantidad) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.estado = estado;
        this.createdAt = createdAt;
        this.cantidad = cantidad;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
    public boolean isEstado() { return estado; }
    public void setEstado(boolean estado) { this.estado = estado; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Producto{" + "id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", estado=" + estado + ", cantidad=" + cantidad + ", createdAt=" + createdAt + '}';
    }
}
