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

            // Gelen JSON verisini al
            $input = json_decode(file_get_contents('php://input'), true);

            if (isset($input['category_name'])) {
                $category_name = $input['category_name'];

                // Yeni kategori ekle
                $sqlsorgu = $baglanti->prepare("INSERT INTO categories (user_id, name) VALUES (?, ?)");
                $sqlsorgu->bind_param("is", $user_id, $category_name);

                if ($sqlsorgu->execute()) {
                    $category_id = $sqlsorgu->insert_id;
                    $response = array(
                        "id" => $category_id,
                        "category_name" => $category_name,
                        "todos" => array()
                    );
                } else {
                    http_response_code(400);
                    $response = array("message" => "Kategori eklenirken bir hata oluştu: " . $sqlsorgu->error);
                }

                $sqlsorgu->close();
            } else {
                http_response_code(400);
                $response = array("message" => "Eksik parametreler.");
            }
        } catch (Exception $e) {
            http_response_code(401);
            $response = array("message" => "Yetkisiz erişim: " . $e->getMessage());
        }
    } else {
        http_response_code(400);
        $response = array("message" => "Token eksik");
    }
} else {
    http_response_code(400);
    $response = array("message" => "Authorization başlığı eksik");
}

echo json_encode($response, JSON_UNESCAPED_UNICODE);

mysqli_close($baglanti);
?>