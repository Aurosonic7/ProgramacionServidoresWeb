package src.model;

public class Persona {
    private Integer id;
    private String nombre;
    private String correo;
    private Double altura;
    private Boolean genero;
    
    public Persona() { }
    
    public Persona(String nombre, String correo, Double altura, Boolean genero) {
        this.nombre = nombre;
        this.correo = correo;
        this.altura = altura;
        this.genero = genero;
    }

    public Persona(Integer id, String nombre, String correo, Double altura, Boolean genero) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.altura = altura;
        this.genero = genero;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public Double getAltura() { return altura; }
    public void setAltura(Double altura) { this.altura = altura; }

    public Boolean getGenero() { return genero; }
    public void setGenero(Boolean genero) { this.genero = genero; }

    @Override
    public String toString() {
        return "Persona{" + "id=" + id + ", nombre=" + nombre + ", correo=" + correo + ", altura=" + altura + ", genero=" + genero + '}';
    }
    
}
