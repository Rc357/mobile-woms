<?php
require '../db_connection.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
    return;
}

$sql = 'SELECT * FROM admins';
$result = $conn->query($sql);

//If user exist
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo json_encode($row);
    }
} else {
    echo '0 results';
}
$conn->close();
return;

?>
