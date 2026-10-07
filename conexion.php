<?php
// Permite acceso desde cualquier lugar (CORS) - Útil para la app
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Railway inyecta estas variables automáticamente cuando creas una base de datos MySQL
$host = getenv('MYSQLHOST') ?: 'localhost'; // Si no está en Railway, usa localhost
$port = getenv('MYSQLPORT') ?: '3306';
$dbname = getenv('MYSQLDATABASE') ?: 'tu_base_local'; // Cambia esto si pruebas en XAMPP
$username = getenv('MYSQLUSER') ?: 'root';
$password = getenv('MYSQLPASSWORD') ?: '';

try {
    // Crear la conexión PDO
    $dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";
    $pdo = new PDO($dsn, $username, $password);
    
    // Configurar PDO para que lance excepciones en caso de error
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
} catch (PDOException $e) {
    // Si falla, detiene todo y muestra el error en formato JSON
    die(json_encode([
        'success' => false, 
        'mensaje' => 'Error de conexión a la BD: ' . $e->getMessage()
    ]));
}
?>
