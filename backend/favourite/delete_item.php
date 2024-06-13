<?php
require_once("../includes/connection.php"); // Include your database connection file
require __DIR__ . '/../vendor/autoload.php'; // Include JWT library

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

if ($_SERVER["REQUEST_METHOD"] === 'POST') {

    // Check if the Authorization header is present and contains a valid JWT token
    $headers = apache_request_headers();
    $authorizationHeader = isset($headers['Authorization']) ? $headers['Authorization'] : null;

    if ($authorizationHeader && preg_match('/Bearer\s+(.*)$/i', $authorizationHeader, $matches)) {
        $token = $matches[1];
        // Decode and verify JWT token
        $Algorithm = 'HS256';
        $AlgorithmArray = [$Algorithm];
        $Secret_Key = 'your_secret_key';
        $object = (object) $AlgorithmArray;
        $order_fetch_key = new Key($Secret_Key, $Algorithm);
        $decoded = JWT::decode($token, $order_fetch_key, $object);
        $user_id = $decoded->user_id;
        if ($user_id) {

            $car_id = isset($_POST['car_id']) ? $_POST['car_id'] : null;

            if ($car_id) {
                // Prepare SQL query to delete the order
                $sql = "DELETE FROM favourite_list_item WHERE user_id = :user_id AND car_id = :car_id";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':car_id', $car_id, PDO::PARAM_INT);
                $stmt->execute();

                // Check if any rows were affected
                if ($stmt->rowCount() > 0) {
                    // Order deleted successfully
                    $response = array("status" => "success", "Message" => "Deleted Favourite Car Successfully.");
                    http_response_code(200); // OK
                } else {
                    // No orders found to delete
                    $response = array("status" => "success", "Message" => "No Favourite Cars Found To Delete.");
                    http_response_code(200); // Not Found
                }
            } else {
                // Missing car_id parameter
                $response = array("status" => "failed", "Message" => "Missing Car To Delete.");
                http_response_code(400); // Bad Request
            }

            // Set content type to JSON
            header('Content-Type: application/json');
            // Output JSON response
            echo json_encode($response);

        } else {
            // Invalid or expired token
            http_response_code(401); // Unauthorized
            echo json_encode(array("status" => "failed", "Message" => "Unauthorized"));
        }
    } else {
        // Missing or invalid Authorization header
        http_response_code(401); // Unauthorized
        echo json_encode(array("status" => "failed", "Message" => "Unauthorized"));
    }
} else {
    http_response_code(405);
    echo json_encode(array("status" => "failed", "Message" => "Only POST Method is allowed"));
}