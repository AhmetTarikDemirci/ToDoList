<?php
header('Content-Type: application/json; charset=UTF-8'); // Yanıt başlığını ayarlayın
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

            if (isset($input['id'])) {
                $category_id = $input['id'];

                // Kategoriye ait tüm todo öğelerini sil (Uygulama düzeyinde)
                $deleteTodosQuery = $baglanti->prepare("DELETE FROM todos WHERE category_id = ? AND user_id = ?");
                $deleteTodosQuery->bind_param("ii", $category_id, $user_id);
                if (!$deleteTodosQuery->execute()) {
                    http_response_code(400);
                    $response = array("message" => "Todo öğeleri silinirken bir hata oluştu: " . $deleteTodosQuery->error);
                    echo json_encode($response, JSON_UNESCAPED_UNICODE);
                    mysqli_close($baglanti);
                    exit;
                }
                $deleteTodosQuery->close();

                // Kategori öğesini sil
                $deleteCategoryQuery = $baglanti->prepare("DELETE FROM categories WHERE id = ? AND user_id = ?");
                $deleteCategoryQuery->bind_param("ii", $category_id, $user_id);
                if ($deleteCategoryQuery->execute()) {
                    $response = array("message" => "Kategori ve ilgili todo öğeleri başarıyla silindi.");
                } else {
                    http_response_code(400);
                    $response = array("message" => "Kategori silinirken bir hata oluştu: " . $deleteCategoryQuery->error);
                }

                $deleteCategoryQuery->close();
            } else {
                http_response_code(400);
                $response = array("message" => "Eksik parametreler.");
            }
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

echo json_encode($response, JSON_UNESCAPED_UNICODE);

mysqli_close($baglanti);
?>