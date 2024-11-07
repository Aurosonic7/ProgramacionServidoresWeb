package model;

public class Persona {
    private String nombre;
    private String apellido_p;
    private String email;
    
    public Persona() { }

    public Persona(String nombre, String apellido_p, String email) {
        this.nombre = nombre;
        this.apellido_p = apellido_p;
        this.email = email;
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido_p() { return apellido_p; }
    public void setApellido_p(String apellido_p) { this.apellido_p = apellido_p; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    @Override
    public String toString() { return "Persona{" + "nombre=" + nombre + ", apellido_p=" + apellido_p + ", email=" + email + '}'; }
}
