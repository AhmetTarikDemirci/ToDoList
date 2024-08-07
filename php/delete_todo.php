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

            $user_id = $decoded->user_id; // `user_id` token'dan alınır

            // Gelen JSON verisini al
            $input = json_decode(file_get_contents('php://input'), true);

            if (isset($input['id'])) {
                $id = $input['id'];

                // İlk olarak silinecek olan todo kaydını seçelim
                $selectQuery = $baglanti->prepare("SELECT * FROM todos WHERE id = ? AND user_id = ?");
                $selectQuery->bind_param('si', $id, $user_id);

                if ($selectQuery->execute()) {
                    $result = $selectQuery->get_result();
                    if ($result->num_rows > 0) {
                        $todoItem = $result->fetch_assoc();

                        // Silme işlemini gerçekleştirelim
                        $deleteQuery = $baglanti->prepare("DELETE FROM todos WHERE id = ? AND user_id = ?");
                        $deleteQuery->bind_param('si', $id, $user_id);

                        if ($deleteQuery->execute()) {
                            http_response_code(200);  // OK
                            $response["success"] = 1;
                            $response["message"] = "Todo silindi";
                            $response["deleted_item"] = $todoItem;  // Silinen öğeyi cevaba ekleyelim
                        } else {
                            http_response_code(500);  // Internal Server Error
                            $response["success"] = 0;
                            $response["message"] = "Todo silme başarısız: " . $deleteQuery->error;
                        }

                        $deleteQuery->close();
                    } else {
                        http_response_code(404);  // Not Found
                        $response["success"] = 0;
                        $response["message"] = "Todo bulunamadı";
                    }
                } else {
                    http_response_code(500);  // Internal Server Error
                    $response["success"] = 0;
                    $response["message"] = "Todo seçme başarısız: " . $selectQuery->error;
                }

                $selectQuery->close();
            } else {
                http_response_code(400);  // Bad Request
                $response["success"] = 0;
                $response["message"] = "Gerekli alan(lar) eksik";
            }
        } catch (Exception $e) {
            http_response_code(401); // Unauthorized
            $response["success"] = 0;
            $response["message"] = "Yetkisiz erişim: " . $e->getMessage();
        }
    } else {
        http_response_code(400);  // Bad Request
        $response["success"] = 0;
        $response["message"] = "Token eksik";
    }
} else {
    http_response_code(400);  // Bad Request
    $response["success"] = 0;
    $response["message"] = "Authorization başlığı eksik";
}

echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>