<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include("baglanti.php");
require 'vendor/autoload.php';
use \Firebase\JWT\JWT;

$key = "your_secret_key";
$response = array();

// JSON verisini al ve decode et
$input = json_decode(file_get_contents('php://input'), true);

if (isset($input['user_name']) && isset($input['email']) && isset($input['password'])) {
    $user_name = $input['user_name'];
    $email = $input['email'];
    $password = $input['password'];

    // Kullanıcı adı veya e-posta adresinin zaten kayıtlı olup olmadığını kontrol edin
    $sqlsorgu = $baglanti->prepare("SELECT * FROM kullanicilar WHERE email = ? OR user_name = ?");
    $sqlsorgu->bind_param("ss", $email, $user_name);
    $sqlsorgu->execute();
    $result = $sqlsorgu->get_result();

    if ($result->num_rows > 0) {
        $existingUser = $result->fetch_assoc();
        if ($existingUser['email'] === $email) {
            // E-posta adresi zaten kayıtlıysa hata mesajı döndür
            http_response_code(409);  // Conflict
            $response["success"] = 0;
            $response["message"] = "Bu e-posta adresi zaten kayıtlı";
        } else if ($existingUser['user_name'] === $user_name) {
            // Kullanıcı adı zaten kayıtlıysa hata mesajı döndür
            http_response_code(409);  // Conflict
            $response["success"] = 0;
            $response["message"] = "Bu kullanıcı adı zaten kayıtlı";
        }
    } else {
        // Kullanıcı adı ve e-posta adresi mevcut değilse, yeni kullanıcı kaydını yap
        $sqlsorgu = $baglanti->prepare("INSERT INTO kullanicilar (user_name, email, password, date_of_registration) VALUES (?, ?, ?, NOW())");
        $sqlsorgu->bind_param("sss", $user_name, $email, $password);
        if ($sqlsorgu->execute()) {
            // Kayıt başarılı olursa kullanıcı bilgilerini çek ve yanıt olarak döndür
            $user_id = $sqlsorgu->insert_id; // Son eklenen kullanıcının ID'sini al
            $sqlsorgu->close();

            $sqlsorgu = $baglanti->prepare("SELECT * FROM kullanicilar WHERE id = ?");
            $sqlsorgu->bind_param("i", $user_id);
            $sqlsorgu->execute();
            $result = $sqlsorgu->get_result();

            if ($result->num_rows > 0) {
                $user = $result->fetch_assoc();

                // JWT token oluştur
                $payload = array(
                    "iss" => "https://ahmettarikdemirci.io",
                    "iat" => time(),
                    "exp" => time() + 9999999999999999999999999999999, // 1 saat geçerli
                    "user_id" => $user["id"]
                );
                $jwt = JWT::encode($payload, $key, 'HS256');

                http_response_code(201);  // Created
                $response["success"] = 1;
                $response["message"] = "Kayıt başarılı";
                $response["token"] = $jwt;
                $response["user"] = array(
                    "id" => $user["id"],
                    "user_name" => $user["user_name"],
                    "email" => $user["email"],
                    "date_of_registration" => strtotime($user["date_of_registration"])
                );
            } else {
                http_response_code(500);  // Internal Server Error
                $response["success"] = 0;
                $response["message"] = "Kullanıcı bilgileri alınamadı";
            }
        } else {
            http_response_code(500);  // Internal Server Error
            $response["success"] = 0;
            $response["message"] = "Kayıt başarısız: " . $sqlsorgu->error;
        }
    }
    $sqlsorgu->close();
} else {
    http_response_code(400);  // Bad Request
    $response["success"] = 0;
    $response["message"] = "Gerekli alan(lar) eksik";
}

header('Content-Type: application/json');
echo json_encode($response, JSON_UNESCAPED_UNICODE);
mysqli_close($baglanti);
?>
