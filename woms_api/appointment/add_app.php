<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$eventTitle = $_POST['eventTitle'];
$eventDescription = $_POST['eventDescription'];
$eventClientName = $_POST['eventClientName'];
$eventEstheticians = $_POST['eventEstheticians'];
$bookingID = $_POST['bookingID'];
$eventStartTime = $_POST['eventStartTime'];
$eventEndTime = $_POST['eventEndTime'];

$sql = "INSERT INTO appointment_event (eventTitle, eventDescription, eventClientName, eventEstheticians, bookings_id, eventStartTime, eventEndTime)
                VALUES ('$eventTitle', '$eventDescription', '$eventClientName', '$eventEstheticians', '$bookingID', '$eventStartTime', '$eventEndTime')";
if ($conn->query($sql) === true) {
    echo 'SUCCESS';
} else {
    echo 'Error: ' . $sql . '<br>' . $conn->error;
}

$conn->close();
return;
?>
