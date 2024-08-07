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

            if (isset($input['id']) && isset($input['title']) && isset($input['due_date']) && isset($input['is_done']) && isset($input['category_id'])) {
                $id = $input['id'];
                $title = $input['title'];
                $due_date = (double) $input['due_date']; // TimeInterval formatında bekleniyor
                $is_done = (int) $input['is_done'];
                $category_id = (int) $input['category_id'];

                // Kullanıcının sadece kendi todo'sunu güncellemesini sağla
                $sqlCheck = $baglanti->prepare("SELECT * FROM todos WHERE id = ? AND user_id = ?");
                if (!$sqlCheck) {
                    error_log("Prepare hatası: " . $baglanti->error);
                }
                $sqlCheck->bind_param('si', $id, $user_id);  // Bind id as string and user_id as integer
                $sqlCheck->execute();
                $result = $sqlCheck->get_result();

                if ($result->num_rows > 0) {
                    error_log("Todo bulundu: " . $id);
                    $sqlCheck->close();

                    $sqlsorgu = $baglanti->prepare("UPDATE todos SET title = ?, due_date = ?, is_done = ?, category_id = ? WHERE id = ? AND user_id = ?");
                    if (!$sqlsorgu) {
                        error_log("Prepare hatası: " . $baglanti->error);
                    }
                    $sqlsorgu->bind_param('sdiiis', $title, $due_date, $is_done, $category_id, $id, $user_id);  // Bind parameters

                    if ($sqlsorgu->execute()) {
                        http_response_code(200);  // OK
                        $response["success"] = 1;
                        $response["message"] = "Todo güncellendi";
                    } else {
                        error_log("Todo güncelleme hatası: " . $sqlsorgu->error);
                        http_response_code(500);  // Internal Server Error
                        $response["success"] = 0;
                        $response["message"] = "Todo güncelleme başarısız: " . $sqlsorgu->error;
                    }

                    $sqlsorgu->close();
                } else {
                    error_log("Yetkisiz erişim: Bu todo'yu güncelleyemezsiniz.");
                    http_response_code(403);  // Forbidden
                    $response["success"] = 0;
                    $response["message"] = "Yetkisiz erişim: Bu todo'yu güncelleyemezsiniz.";
                    $sqlCheck->close();
                }
            } else {
                error_log("Gerekli alanlar eksik: 'id', 'title', 'due_date', 'is_done' ve 'category_id'");
                http_response_code(400);  // Bad Request
                $response["success"] = 0;
                $response["message"] = "Gerekli alan(lar) eksik: 'id', 'title', 'due_date', 'is_done' ve 'category_id' alanları gerekli.";
            }
        } catch (Exception $e) {
            error_log("Yetkisiz erişim: " . $e->getMessage());
            http_response_code(401); // Unauthorized
            $response = array("message" => "Yetkisiz erişim: " . $e->getMessage());
        }
    } else {
        error_log("Token eksik");
        http_response_code(400);  // Bad Request
        $response = array("message" => "Token eksik");
    }
} else {
    error_log("Authorization başlığı eksik");
    http_response_code(400);  // Bad Request
    $response = array("message" => "Authorization başlığı eksik");
}

echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>