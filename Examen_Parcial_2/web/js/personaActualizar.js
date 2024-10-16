function actualizarPersona() {
    var id = document.getElementById("id").value;
    var nombre = document.getElementById("nombre").value;
    var genero = document.getElementById("genero").value;
    var altura = document.getElementById("altura").value;
    var createdAt = document.getElementById("createdAt").value;

    var persona = {
        id: id,
        nombre: nombre,
        genero: genero,
        altura: altura,
        createdAt: createdAt
    };

    fetch(contextPath + '/NewServletPersona', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(persona)
    })
    .then(response => {
        if (response.ok) {
            window.location.href = contextPath + '/jsp/Persona.jsp';
        } else {
            return response.text().then(text => { throw new Error(text); });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('resultado').innerText = 'Hubo un error al actualizar: ' + error.message;
    });
}