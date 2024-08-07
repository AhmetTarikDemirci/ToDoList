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

            if (isset($input['id']) && isset($input['title']) && isset($input['due_date']) && isset($input['created_date']) && isset($input['is_done']) && isset($input['category_id'])) {
                $id = $input['id'];
                $title = $input['title'];
                $due_date = $input['due_date'];
                $created_date = $input['created_date'];
                $is_done = $input['is_done'];
                $category_id = $input['category_id'];

                // Todo öğesini veritabanına ekle
                $sqlsorgu = $baglanti->prepare("INSERT INTO todos (id, user_id, title, due_date, created_date, is_done, category_id) VALUES (?, ?, ?, ?, ?, ?, ?)");
                $sqlsorgu->bind_param("sisdiis", $id, $user_id, $title, $due_date, $created_date, $is_done, $category_id);

                if ($sqlsorgu->execute()) {
                    $todoItem = array(
                        "id" => $id,
                        "title" => $title,
                        "due_date" => (double) $due_date,
                        "created_date" => (double) $created_date,
                        "is_done" => (bool) $is_done,
                        "category_id" => (int) $category_id
                    );
                    $response = $todoItem;
                } else {
                    http_response_code(400);
                    $response = array("message" => "Todo eklenirken bir hata oluştu: " . $sqlsorgu->error);
                }

                $sqlsorgu->close();
            } else {
                http_response_code(400);  // Bad Request
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