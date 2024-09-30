function eliminarAnimal(id) {
    console.log(`eliminarAnimal?id=` + id);
    if (confirm("¿Estás seguro de que quieres eliminar este animal?")) {
        fetch(`${contextPath}/NewServletAnimal?id=${id}`, {
            method: 'DELETE'
        }).then(response => {
            if (response.ok) {
                alert('Animal eliminado exitosamente');
                location.reload(); // Recarga la página para reflejar los cambios
            } else {
                alert('Error al eliminar el animal');
            }
        }).catch(error => console.error('Error:', error));
    }
}