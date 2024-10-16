package src.model;

import java.sql.Date;

public class Becario {
    private String curp;
    private String apellido_p;
    private String apellido_m;
    private String nombre;
    private String genero;
    private String password;
    private Date fecha_nac;
    private String foto;
    
    public Becario() { }
    
    public Becario(String curp, String apellido_p, String apellido_m, String nombre, String genero, String password, Date fecha_nac) {
        this.curp = curp;
        this.apellido_p = apellido_p;
        this.apellido_m = apellido_m;
        this.nombre = nombre;
        this.genero = genero;
        this.password = password;
        this.fecha_nac = fecha_nac;
    }

    public Becario(String curp, String apellido_p, String apellido_m, String nombre, String genero, String password, Date fecha_nac, String foto) {
        this.curp = curp;
        this.apellido_p = apellido_p;
        this.apellido_m = apellido_m;
        this.nombre = nombre;
        this.genero = genero;
        this.password = password;
        this.fecha_nac = fecha_nac;
        this.foto = foto;
    }

    public String getCURP() { return curp; }
    public void setCURP(String curp) { this.curp = curp; }
    
    public String getApellido_p() { return apellido_p; }
    public void setApellido_p(String apellido_p) { this.apellido_p = apellido_p; }

    public String getApellido_m() { return apellido_m; }
    public void setApellido_m(String apellido_m) { this.apellido_m = apellido_m; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Date getFecha_nac() { return fecha_nac; }
    public void setFecha_nac(Date fecha_nac) { this.fecha_nac = fecha_nac; }

    public String getFoto() { return foto; }
    public void setFoto(String foto) { this.foto = foto; }

    @Override
    public String toString() {
        return "Becario{" + "curp=" + curp + ", apellido_p=" + apellido_p + ", apellido_m=" + apellido_m + ", nombre=" + nombre + ", genero=" + genero + ", password=" + password + ", fecha_nac=" + fecha_nac + ", foto=" + foto + '}';
    }
    
}
