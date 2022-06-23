<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$userId = $_POST['userId'];

$sql = "SELECT id, admins_id, work_in, work_out, work_time FROM admins_session  WHERE admins_id = $userId ORDER BY id DESC LIMIT 5";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while ($row = $result->fetch_assoc()) {
        $db_data[] = $row;
    }
    echo json_encode($db_data);
} else {
    echo '0 results';
}

$conn->close();
return;
?>
