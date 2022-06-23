<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$id = $_POST['id'];
$orderId = $_POST['orderId'];
$startTime = $_POST['startTime'];
$endTime = $_POST['endTime'];
$status = $_POST['status'];
if ($status == 'start') {
    $sqlUp = "UPDATE bookings SET status = '$status', start_time = '$startTime' WHERE order_id = $orderId";
    if ($conn->query($sqlUp) === true) {
        echo 'SUCCESS';
    } else {
        echo 'ERROR';
    }
} else {
    $sqlUp = "UPDATE bookings SET status = '$status', end_time = '$endTime' WHERE order_id = $orderId";
    if ($conn->query($sqlUp) === true) {
        echo 'SUCCESS';
    } else {
        echo 'ERROR';
    }
}
$conn->close();
return;

?>
