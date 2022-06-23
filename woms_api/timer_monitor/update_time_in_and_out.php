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
$userId = $_POST['userId'];
$currentTime = $_POST['currentTime'];
$tokenKey = $_POST['tokenKey'];

if ($type == 'timeIn') {
    $sqlIns = "INSERT INTO admins_session (admins_id, work_in, tokenKey) VALUES ('$userId', '$currentTime', '$tokenKey')";
    // $result = $conn->query($sqlIns);
    if ($conn->query($sqlIns) === true) {
        echo 'SUCCESS';
    } else {
        echo 'Error: ' . $sql . '<br>' . $conn->error;
    }
}

$sql = "SELECT id, admins_id, tokenKey FROM admins_session  WHERE admins_id = $userId ORDER BY id DESC LIMIT 1";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $aID = $row['id'];
        if ($type == 'timeOut') {
            $sqlUp = "UPDATE admins_session SET work_out = '$currentTime' WHERE id = $aID";
            if ($conn->query($sqlUp) === true) {
                echo 'SUCCESS';
            } else {
                echo 'ERROR 2';
            }
        }
    }
} else {
    echo 'admins_session ERROR';
}

$conn->close();
return;
?>
