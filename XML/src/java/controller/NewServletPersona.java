package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import model.Persona;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet(name = "NewServletPersona", urlPatterns = {"/NewServletPersona"})
public class NewServletPersona extends HttpServlet {

    private static final ArrayList<Persona> personas = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Leer datos del formulario
        String nombre = request.getParameter("nombre");
        String apellidoP = request.getParameter("apellido_p");
        String email = request.getParameter("email");

        // Crear un objeto Persona y agregarlo a la lista
        Persona persona = new Persona(nombre, apellidoP, email);
        personas.add(persona);

        // Redirigir a la página JSP para mostrar los datos
        response.sendRedirect("jsp/mostrar_datos.jsp");
    }

    // Método para generar XML de una persona específica
    public static void crearXML(Persona persona) throws ParserConfigurationException, TransformerException, IOException {
        // Crear un nombre de archivo único usando el nombre y apellido
        String fileName = persona.getNombre() + "_" + persona.getApellido_p() + ".xml";
        File file = new File("/Users/christianvicente/Desktop/users/" + fileName);

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.newDocument();

        // Raiz del XML
        Element root = document.createElement("Usuario");
        document.appendChild(root);

        Element nombreElement = document.createElement("Nombre");
        nombreElement.appendChild(document.createTextNode(persona.getNombre()));
        root.appendChild(nombreElement);

        Element apellidoPElement = document.createElement("ApellidoPaterno");
        apellidoPElement.appendChild(document.createTextNode(persona.getApellido_p()));
        root.appendChild(apellidoPElement);

        Element emailElement = document.createElement("Email");
        emailElement.appendChild(document.createTextNode(persona.getEmail()));
        root.appendChild(emailElement);

        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        DOMSource source = new DOMSource(document);
        StreamResult result = new StreamResult(file);
        transformer.transform(source, result);
    }

    public static ArrayList<Persona> getPersonas() {
        return personas;
    }
}