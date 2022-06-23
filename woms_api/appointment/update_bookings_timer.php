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
$timeDuration = $_POST['timeDuration'];
$sqlUp = "UPDATE bookings SET actual_time = '$timeDuration' WHERE id = $id";
if ($conn->query($sqlUp) === true) {
    echo 'SUCCESS';
} else {
    echo 'ERROR';
}
$conn->close();
return;

// $sql = "INSERT INTO appointment_event (eventTitle, eventDescription, eventClientName, eventEstheticians, eventStartTime, eventEndTime)
//                 VALUES ('$eventTitle', '$eventDescription', '$eventClientName', '$eventEstheticians', '$eventStartTime', '$eventEndTime')";
// // $result = $conn->query($sql);
// if ($conn->query($sql) === true) {
//     echo 'SUCCESS';
// } else {
//     echo 'Error: ' . $sql . '<br>' . $conn->error;
// }

// $conn->close();
// return;

?>
