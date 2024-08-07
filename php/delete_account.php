<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include("baglanti.php");
require 'vendor/autoload.php';
use \Firebase\JWT\JWT;
use \Firebase\JWT\Key;

$key = "your_secret_key"; // Bu anahtarı güvenli bir yerde saklayın
$response = array();

// HTTP başlıklarını al
$headers = getallheaders();

if (isset($headers['Authorization'])) {
    $authHeader = $headers['Authorization'];
    list($jwt) = sscanf($authHeader, 'Bearer %s');

    if ($jwt) {
        try {
            $decoded = JWT::decode($jwt, new Key($key, 'HS256'));

            // Kullanıcının ID'sini al
            $user_id = $decoded->user_id;

            // Kullanıcıyı veritabanından sil
            $sqlsorgu = $baglanti->prepare("DELETE FROM kullanicilar WHERE id = ?");
            $sqlsorgu->bind_param("i", $user_id);

            if ($sqlsorgu->execute()) {
                http_response_code(200);  // OK
                $response["success"] = 1;
                $response["message"] = "Kullanıcı başarıyla silindi";
            } else {
                http_response_code(500);  // Internal Server Error
                $response["success"] = 0;
                $response["message"] = "Kullanıcı silinirken bir hata oluştu: " . $sqlsorgu->error;
            }

            $sqlsorgu->close();
        } catch (Exception $e) {
            http_response_code(401); // Unauthorized
            $response = array("message" => "Yetkisiz erişim: " . $e->getMessage());
        }
    } else {
        http_response_code(400);  // Bad Request
        $response = array("message" => "Token eksik");
    }
} else {
    http_response_code(400);  // Bad Request
    $response = array("message" => "Authorization başlığı eksik");
}

header('Content-Type: application/json');
echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>
