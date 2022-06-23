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
$imageUrl = $_POST['imageUrl'];
$type = $_POST['type'];

if ('addUpdate' == $type) {
    $sqlUp = "UPDATE admins SET profile_image='$imageUrl' WHERE id = '$userId'";
    if ($conn->query($sqlUp) === true) {
        echo json_encode('success');
    } else {
        echo 'Error: ' . $sql . '<br>' . $conn->error;
        echo json_encode('error');
    }
}
$conn->close();
return;

?>
