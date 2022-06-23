<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$itemID = $_POST['itemID'];

$sql = "SELECT * FROM order_items WHERE id = $itemID";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $db_data[] = $row;
    }
    echo json_encode($db_data);
} else {
    echo 'ERROR';
}
$conn->close();
return;
?>
