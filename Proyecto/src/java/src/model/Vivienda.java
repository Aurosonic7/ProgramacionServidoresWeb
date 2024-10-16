package src.model;

public class Vivienda {
    private Integer id;
    private String calle;
    private String colonia;
    private String municipio;
    private String cp;
    private String curp;
    
    public Vivienda () { }

    public Vivienda(Integer id, String calle, String colonia, String municipio, String cp, String curp) {
        this.id = id;
        this.calle = calle;
        this.colonia = colonia;
        this.municipio = municipio;
        this.cp = cp;
        this.curp = curp;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getCalle() { return calle; }
    public void setCalle(String calle) { this.calle = calle; }
    public String getColonia() { return colonia; }
    public void setColonia(String colonia) { this.colonia = colonia; }
    public String getMunicipio() { return municipio; }
    public void setMunicipio(String municipio) { this.municipio = municipio; }
    public String getCp() { return cp; }
    public void setCp(String cp) { this.cp = cp; }
    public String getCurp() { return curp; }
    public void setCurp(String curp) { this.curp = curp; }

    @Override
    public String toString() {
        return "Vivienda{" + "id=" + id + ", calle=" + calle + ", colonia=" + colonia + ", municipio=" + municipio + ", cp=" + cp + ", curp=" + curp + '}';
    }
}
