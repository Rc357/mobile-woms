<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$cusID = $_POST['customerID'];
$cusEmail = $_POST['customerEmail'];
$type = $_POST['type'];

if ($type == 'id') {
    $sql = "SELECT id, first_name, last_name, gender, date_of_birth, email, phone FROM customers WHERE id = $cusID";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR id';
    }
} elseif ($type == 'email') {
    $sql = "SELECT id, first_name, last_name, gender, date_of_birth, email, phone FROM customers WHERE email = '$cusEmail' ";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR email';
    }
}
$conn->close();
return;
?>
