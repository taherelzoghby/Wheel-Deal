<?php

require_once("../includes/connection.php");
require __DIR__ . '/../vendor/autoload.php';
use Firebase\JWT\JWT;

// Retrieve and decode JSON data sent from Flutter
$jsonData = file_get_contents('php://input');
$data = json_decode($jsonData, true); // Decode JSON data into associative array

// Check if JSON data was successfully parsed
if ($data === null) {
    http_response_code(400);
    echo json_encode(array("Message" => "Invalid JSON data received"));
    exit;
}

// Grab email and password from the decoded JSON data
$email = $data['email'] ?? '';
$password = $data['password'] ?? '';

// If Empty Fields
if (empty($email) || empty($password)) {
    http_response_code(400);
    echo json_encode(array("Message" => "Email and Password are required"));
} else {
    // Query if Inputs are not empty
    $sql = "SELECT * FROM users WHERE email = :email";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':email', $email, PDO::PARAM_STR);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC); // Fetch user data

    // If User Is Found
    if ($user) {
        // Check The Password
        if (password_verify($password, $user['password'])) {
            // Password Is Correct
            $secret_key = "your_secret_key";
            $issued_at = time();
            $expiration_time = $issued_at + 3600;  // token valid for 1 hour
            $payload = array(
                'user_id' => $user['user_id'],
                'email' => $user['email']
            );

            $token = JWT::encode($payload, $secret_key, 'HS256');
            setcookie("token", $token, $expiration_time, "/", "", true, true);
            
            // Return success response with JWT
            http_response_code(200);
            echo json_encode(array("Message" => "Login Successful", "jwt" => $token));
        } else {
            // Password is incorrect
            http_response_code(401);
            echo json_encode(array("Message" => "Password Is Incorrect"));
        }
    } else {
        // User not found
        http_response_code(404);
        echo json_encode(array("Message" => "User Not Found. Try Signing Up First"));
    }

    // Close statement and database connection
    $stmt->closeCursor();
    $pdo = null;
}