function eliminarProducto(id) {
    console.log(`eliminarProducto?id=` + id + "El id ya fue...");
    if (confirm("¿Estás seguro de que quieres eliminar esta producto?")) {
        fetch(`${contextPath}/NewServletProducto?id=${id}`, {
            method: 'DELETE'
        }).then(response => {
            if (response.ok) {
                alert('Producto eliminado exitosamente');
                location.reload();
            } else { alert('Error al eliminar el Producto'); }
        }).catch(error => console.error('Error:', error));
    }
}