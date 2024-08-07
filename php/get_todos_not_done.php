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

            // Kategorileri getirme
            $categoryQuery = $baglanti->prepare("SELECT * FROM categories WHERE user_id = ?");
            $categoryQuery->bind_param("i", $user_id);
            $categoryQuery->execute();
            $categoryResult = $categoryQuery->get_result();

            $categories = array();
            while ($category = $categoryResult->fetch_assoc()) {
                $categories[] = array(
                    "id" => (int) $category["id"],
                    "category_name" => $category["name"],
                    "todos" => array()
                );
            }

            // Todos öğelerini getirme ve kategorilere ekleme (is_done = false)
            $todoQuery = $baglanti->prepare("SELECT * FROM todos WHERE user_id = ? AND is_done = 0 ORDER BY created_date DESC");
            $todoQuery->bind_param("i", $user_id);
            $todoQuery->execute();
            $todoResult = $todoQuery->get_result();

            while ($todo = $todoResult->fetch_assoc()) {
                $todoItem = array(
                    "id" => $todo["id"],
                    "title" => $todo["title"],
                    "due_date" => (double) $todo["due_date"],
                    "created_date" => (double) $todo["created_date"],
                    "is_done" => (bool) $todo["is_done"],
                    "category_id" => (int) $todo["category_id"]
                );

                // Todo öğesini ilgili kategoriye ekleme
                foreach ($categories as &$category) {
                    if ($category["id"] === (int) $todo["category_id"]) {
                        $category["todos"][] = $todoItem;
                        break;
                    }
                }
            }

            if (count($categories) > 0) {
                $response = $categories;
            } else {
                $response = array();
            }

            $categoryQuery->close();
            $todoQuery->close();
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