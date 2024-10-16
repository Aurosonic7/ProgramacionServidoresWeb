package src.model;

import java.sql.Date;

public class Compra {
    private int id;
    private String nombre;
    private boolean estado;
    private double precio;
    private Date createdAt;
    private int idPers;
    private int idProd;
    
    public Compra () { }

    public Compra(int id, String nombre, boolean estado, double precio, Date createdAt, int idPers, int idProd) {
        this.id = id;
        this.nombre = nombre;
        this.estado = estado;
        this.precio = precio;
        this.createdAt = createdAt;
        this.idPers = idPers;
        this.idProd = idProd;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public boolean isEstado() { return estado; }
    public void setEstado(boolean estado) { this.estado = estado; }
    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public int getIdPers() { return idPers; }
    public void setIdPers(int idPers) { this.idPers = idPers; }
    public int getIdProd() { return idProd; }
    public void setIdProd(int idProd) { this.idProd = idProd; }

    @Override
    public String toString() {
        return "Compra{" + "id=" + id + ", nombre=" + nombre + ", estado=" + estado + ", precio=" + precio + ", createdAt=" + createdAt + ", idPers=" + idPers + ", idProd=" + idProd + '}';
    }
}
