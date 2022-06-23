<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$type = $_POST['type'];
$id = $_POST['id'];
$orderId = $_POST['orderId'];

$levents = [];
if ($type == 'id') {
    $sql = "SELECT * FROM bookings WHERE id = $id";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR';
    }
} elseif ($type == 'orderId') {
    $sql = "SELECT * FROM bookings WHERE order_id = $orderId";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR';
    }
}
$conn->close();
return;
?>
