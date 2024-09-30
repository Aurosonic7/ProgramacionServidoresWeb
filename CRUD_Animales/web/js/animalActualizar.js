function actualizarAnimal() {
    const color = document.getElementById("txt_color").value;
    const especie = document.getElementById("txt_especie").value;
    const tipo_animal = document.getElementById("txt_tipo_animal").value;
    const tipo_alimento = document.getElementById("txt_tipo_alimento").value;
    const peso = document.getElementById("txt_peso").value;
    const habitad = document.getElementById("txt_habitad").value;
    const altura = document.getElementById("txt_altura").value;
    const id = document.getElementById("txt_id").value;

    // Crear un objeto con los datos
    const datos = {
        id: id,
        color: color,
        especie: especie,
        tipo_animal: tipo_animal,
        tipo_alimento: tipo_alimento,
        peso: peso,
        habitad: habitad,
        altura: altura
    };

    fetch(`${contextPath}/NewServletAnimal`, {
        method: "PUT",
        body: JSON.stringify(datos), // Convertir los datos a JSON
        headers: {
            'Content-Type': 'application/json' // Establecer el tipo de contenido a JSON
        }
    })
    .then(response => response.text())
    .then(data => {
        document.getElementById("resultado").innerText = data;
    })
    .catch(error => {
        document.getElementById("resultado").innerText = "Error al actualizar animal.";
        console.error('Error:', error);
    });
}