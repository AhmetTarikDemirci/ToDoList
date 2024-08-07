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

            if (isset($input['id']) && isset($input['category_name'])) {
                $id = $input['id'];
                $category_name = $input['category_name'];

                // Kategoriyi güncelle
                $sqlsorgu = $baglanti->prepare("UPDATE categories SET name = ? WHERE id = ? AND user_id = ?");
                $sqlsorgu->bind_param("sii", $category_name, $id, $user_id);

                if ($sqlsorgu->execute()) {
                    // Güncellenmiş kategori verisini ve ilgili todos öğelerini döndür
                    $todosQuery = $baglanti->prepare("SELECT * FROM todos WHERE category_id = ? AND user_id = ?");
                    $todosQuery->bind_param("ii", $id, $user_id);
                    $todosQuery->execute();
                    $todosResult = $todosQuery->get_result();

                    $todos = array();
                    while ($todo = $todosResult->fetch_assoc()) {
                        $todos[] = array(
                            "id" => $todo["id"],
                            "title" => $todo["title"],
                            "due_date" => (double) $todo["due_date"],
                            "created_date" => (double) $todo["created_date"],
                            "is_done" => (bool) $todo["is_done"],
                            "category_id" => (int) $todo["category_id"]
                        );
                    }

                    $updatedCategory = array(
                        "id" => $id,
                        "category_name" => $category_name,
                        "todos" => $todos
                    );

                    $response = $updatedCategory;

                    $todosQuery->close();
                } else {
                    http_response_code(400);
                    $response = array("message" => "Kategori güncellenirken bir hata oluştu: " . $sqlsorgu->error);
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