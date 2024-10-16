function eliminarPersona(id) {
    console.log(`eliminarPersona?id=` + id + "El id ya fue...");
    if (confirm("¿Estás seguro de que quieres eliminar esta persona?")) {
        fetch(`${contextPath}/NewServletPersona?id=${id}`, {
            method: 'DELETE'
        }).then(response => {
            if (response.ok) {
                alert('Persona eliminado exitosamente');
                location.reload();
            } else {
                alert('Error al eliminar el Persona');
            }
        }).catch(error => console.error('Error:', error));
    }
}