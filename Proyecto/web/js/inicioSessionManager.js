var sessionTimeout = 30 * 1000;  // 30 segundos de sesión
var warningTime = 15 * 1000;  // 15 segundos de inactividad antes de la advertencia
var sessionExtensionTime = 30 * 1000; // Extiende la sesión por 30 segundos

var sessionTimer;  // Variable para el temporizador de sesión
var warningTimer;  // Variable para el temporizador de advertencia

// Función para extender la sesión manualmente
function extendSession() {
    console.log("Extensión de sesión solicitada...");
    clearTimeout(sessionTimer);  // Limpiar el temporizador actual de sesión
    clearTimeout(warningTimer);  // Limpiar el temporizador de advertencia
    startSessionTimer();  // Reiniciar el temporizador de sesión
}

// Función que redirige al usuario al login cuando la sesión expira
function autoLogout() {
    console.log("Sesión expirada, redirigiendo al login.");
    window.location.href = "/Proyecto/jsp/login.jsp";  // Cambiar URL si es necesario
}

// Función para advertir al usuario que su sesión está por expirar
function sessionWarning() {
    console.log("Advertencia: La sesión está por expirar.");
    var continueSession = confirm("Tu sesión está a punto de expirar. ¿Deseas continuar?");
    if (continueSession) {
        extendSession();  // Extiende la sesión si el usuario quiere continuar
    } else {
        autoLogout();  // Cierra la sesión si no responde
    }
}

// Función para iniciar el temporizador de sesión
function startSessionTimer() {
    console.log("Iniciando temporizador de sesión");
    clearTimeout(sessionTimer);  // Limpiar cualquier temporizador previo
    clearTimeout(warningTimer);  // Limpiar cualquier advertencia previa

    // Temporizador para mostrar la advertencia de inactividad
    warningTimer = setTimeout(function() {
        sessionWarning();  // Mostrar advertencia después de 15 segundos de inactividad
    }, warningTime);

    // Temporizador para cerrar sesión automáticamente después de 30 segundos
    sessionTimer = setTimeout(function() {
        autoLogout();  // Cerrar sesión después de los 30 segundos
    }, sessionTimeout);
}

// Función para extender la sesión al detectar clics en la página
function extendSessionOnClick() {
    document.addEventListener('click', function() {
        console.log("Clic detectado, extendiendo la sesión...");
        extendSession();  // Solicita al servidor extender la sesión y reiniciar temporizadores
    });
}

// Inicializar los temporizadores cuando la página se carga
window.onload = function () {
    console.log("Página cargada y script activo");
    startSessionTimer();  // Iniciar el temporizador principal de sesión
    extendSessionOnClick();  // Activar la extensión de sesión en clics
};