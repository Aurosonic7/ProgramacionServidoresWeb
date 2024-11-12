package bean;

import java.util.ArrayList;
import java.util.List;

public class ZooBean {
    private List<AnimalesBean> listaAnimales;

    public ZooBean() {
        this.listaAnimales = new ArrayList<>();
    }

    // Método para agregar un animal a la lista
    public void agregarAnimal(AnimalesBean animal) {
        this.listaAnimales.add(animal);
    }

    // Método para obtener la lista de animales
    public List<AnimalesBean> getListaAnimales() {
        return listaAnimales;
    }
}

