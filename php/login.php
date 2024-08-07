<?php
header('Content-Type: application/json; charset=UTF-8');
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include("baglanti.php");
require 'vendor/autoload.php';
use \Firebase\JWT\JWT;

$key = "your_secret_key";
$response = array();

// Gelen tüm verileri kontrol edelim
$input = json_decode(file_get_contents("php://input"), true);

// Gelen verileri ekrana yazdıralım (Debug)
file_put_contents('php://stderr', print_r($input, TRUE));

if (isset($input['email']) && isset($input['password'])) {
    $email = $input['email'];
    $password = $input['password'];
    
    $sqlsorgu = $baglanti->prepare("SELECT * FROM kullanicilar WHERE email = ? AND password = ?");
    $sqlsorgu->bind_param("ss", $email, $password);
    $sqlsorgu->execute();
    $result = $sqlsorgu->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();

        $payload = array(
            "iss" => "https://ahmettarikdemirci.io",
            "iat" => time(),
            "exp" => time() + 9999999999999999999999999999999999999999,
            "user_id" => $user["id"]
        );
        $jwt = JWT::encode($payload, $key, 'HS256');

        $response["success"] = 1;
        $response["message"] = "Giriş başarılı";
        $response["token"] = $jwt;
        $response["user"] = array(
            "id" => $user["id"],
            "user_name" => $user["user_name"],
            "email" => $user["email"],
            "date_of_registration" => strtotime($user["date_of_registration"])
        );
    } else {
        $response["success"] = 0;
        $response["message"] = "Geçersiz e-posta veya şifre";
    }
    $sqlsorgu->close();
} else {
    $response["success"] = 0;
    $response["message"] = "Gerekli alan(lar) eksik";
}

echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>
