package model;

public class Animal {
    private Integer id;
    private String color;
    private String especie;
    private String tipo_animal;
    private String tipo_alimento;
    private Double peso;
    private String habitad;
    private Double altura;
    
    public Animal () { }
    
    public Animal(Integer id, String color, String especie, String tipo_animal, String tipo_alimento, Double peso, String habitad, Double altura) {
        this.id = id;
        this.color = color;
        this.especie = especie;
        this.tipo_animal = tipo_animal;
        this.tipo_alimento = tipo_alimento;
        this.peso = peso;
        this.habitad = habitad;
        this.altura = altura;
    }
   
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getEspecie() { return especie; }
    public void setEspecie(String especie) { this.especie = especie; }
    public String getTipo_animal() { return tipo_animal; }
    public void setTipo_animal(String tipo_animal) { this.tipo_animal = tipo_animal; }
    public String getTipo_alimento() { return tipo_alimento; }
    public void setTipo_alimento(String tipo_alimento) { this.tipo_alimento = tipo_alimento; }
    public Double getPeso() { return peso; }
    public void setPeso(Double peso) { this.peso = peso; }
    public String getHabitad() { return habitad; }
    public void setHabitad(String habitad) { this.habitad = habitad; }
    public Double getAltura() { return altura; }
    public void setAltura(Double altura) { this.altura = altura; }
    
    public String toString() { 
        return "Id: "+id+"\n"+"Color: "+color+"\n"+"Especie: "+especie+"\n"+"Tipo Animal: "+tipo_animal+"\n"
        +"Tipo Alimento: "+tipo_alimento+"\n"+"Peso: "+peso+"\n"+"Habitad: "+habitad+"\n"+"Altura: "+altura;
    }
    
}
