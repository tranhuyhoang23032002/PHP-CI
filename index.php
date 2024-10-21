<?php
$servername = "mysql";
$username = "user";
$password = "password";
$dbname = "mydb";

// Tạo kết nối
$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}
echo "Kết nối thành công đến MySQL!";
?>

