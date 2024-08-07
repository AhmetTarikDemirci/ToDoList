<?php
header('Content-Type: application/json; charset=UTF-8');
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include("baglanti.php");
require 'vendor/autoload.php';
use \Firebase\JWT\JWT;

$response = array();

$headers = getallheaders();

if (isset($headers['Authorization'])) {
    $authHeader = $headers['Authorization'];
    list($jwt) = sscanf($authHeader, 'Bearer %s');

    if ($jwt) {
        try {
            $key = "your_secret_key";
            $decoded = JWT::decode($jwt, new \Firebase\JWT\Key($key, 'HS256'));
            $user_id = $decoded->user_id;

            $input = json_decode(file_get_contents("php://input"), true);

            if (isset($input['email']) && isset($input['password'])) {
                $email = $input['email'];
                $password = $input['password'];

                $sqlsorgu = $baglanti->prepare("SELECT * FROM kullanicilar WHERE id = ? AND password = ?");
                $sqlsorgu->bind_param("is", $user_id, $password);
                $sqlsorgu->execute();
                $result = $sqlsorgu->get_result();

                if ($result->num_rows > 0) {
                    $sqlsorgu = $baglanti->prepare("UPDATE kullanicilar SET email = ? WHERE id = ?");
                    $sqlsorgu->bind_param("si", $email, $user_id);
                    if ($sqlsorgu->execute()) {
                        $response["success"] = 1;
                        $response["message"] = "E-posta adresi başarıyla güncellendi";
                    } else {
                        http_response_code(500);
                        $response["success"] = 0;
                        $response["message"] = "Güncelleme başarısız: " . $sqlsorgu->error;
                    }
                } else {
                    http_response_code(400);
                    $response["success"] = 0;
                    $response["message"] = "Geçersiz şifre";
                }

                $sqlsorgu->close();
            } else {
                http_response_code(400);
                $response["success"] = 0;
                $response["message"] = "Gerekli alan(lar) eksik";
            }
        } catch (Exception $e) {
            http_response_code(401);
            $response["success"] = 0;
            $response["message"] = "Yetkilendirme hatası: " . $e->getMessage();
        }
    } else {
        http_response_code(400);
        $response["success"] = 0;
        $response["message"] = "Token bulunamadı";
    }
} else {
    http_response_code(400);
    $response["success"] = 0;
    $response["message"] = "Authorization başlığı eksik";
}

echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>
