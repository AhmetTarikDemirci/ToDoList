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

            // Gelen PUT verilerini al
            $input = json_decode(file_get_contents("php://input"), true);

            if (isset($input['id']) && isset($input['is_done'])) {
                $id = $input['id'];
                $is_done = (int) $input['is_done'];

                // Kullanıcının sadece kendi todo'sunu güncellemesini sağla
                $sqlCheck = $baglanti->prepare("SELECT * FROM todos WHERE id = ? AND user_id = ?");
                $sqlCheck->bind_param('si', $id, $user_id);
                $sqlCheck->execute();
                $result = $sqlCheck->get_result();

                if ($result->num_rows > 0) {
                    $sqlCheck->close();

                    $sqlsorgu = $baglanti->prepare("UPDATE todos SET is_done = ? WHERE id = ?");
                    $sqlsorgu->bind_param('is', $is_done, $id);

                    if ($sqlsorgu->execute()) {
                        http_response_code(200);  // OK
                        $response["success"] = 1;
                        $response["message"] = "Todo güncellendi";
                    } else {
                        http_response_code(500);  // Internal Server Error
                        $response["success"] = 0;
                        $response["message"] = "Todo güncelleme başarısız: " . $sqlsorgu->error;
                    }

                    $sqlsorgu->close();
                } else {
                    http_response_code(403);  // Forbidden
                    $response["success"] = 0;
                    $response["message"] = "Yetkisiz erişim: Bu todo'yu güncelleyemezsiniz.";
                    $sqlCheck->close();
                }
            } else {
                http_response_code(400);  // Bad Request
                $response["success"] = 0;
                $response["message"] = "Gerekli alan(lar) eksik: 'id' ve 'is_done' alanları gerekli.";
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