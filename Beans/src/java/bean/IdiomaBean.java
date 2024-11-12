package bean;

public class IdiomaBean {

    private String nombre;
    private String idioma;

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the idioma
     */
    public String getIdioma() {
        return idioma;
    }

    /**
     * @param idioma the idioma to set
     */
    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    public String getOpinion() {
        if (idioma.equals("Ingles")) {
            return "Idioma básico para comunicación";
        } else if (idioma.equals("Francés")) {
            return "Idioma elegante";
        } else if (idioma.equals("Ruso")) {
            return "Idioma que recuerda a la Unión Soviética";
        } else {
            return "";
        }
    }
}