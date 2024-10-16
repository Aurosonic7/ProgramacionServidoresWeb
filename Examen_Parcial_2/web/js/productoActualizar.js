function actualizarProducto() {
    var id = document.getElementById("id").value;
    var nombre = document.getElementById("nombre").value;
    var precio = document.getElementById("precio").value;
    var estado = document.getElementById("estado").value;
    var cantidad = document.getElementById("cantidad").value;
    var createdAt = document.getElementById("createdAt").value;

    var persona = {
        id: id,
        nombre: nombre,
        precio: precio,
        estado: estado,
        cantidad: cantidad,
        createdAt: createdAt
    };

    fetch(contextPath + '/NewServletProducto', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(persona)
    })
    .then(response => {
        if (response.ok) {
            window.location.href = contextPath + '/jsp/Producto.jsp';
        } else {
            return response.text().then(text => { throw new Error(text); });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById('resultado').innerText = 'Hubo un error al actualizar: ' + error.message;
    });
}