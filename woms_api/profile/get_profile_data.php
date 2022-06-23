<?php

require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$username = $_POST['username'];

$sql = "SELECT id, name, 
        first_name, middle_name, last_name, nick_name, uname, gender, date_of_birth, personal_phone_number,
        personal_phone_number, work_phone_number, personal_email, work_email, email, profile_image  
        FROM admins WHERE email = '$username'";
$result = $conn->query($sql);

if ($result->num_rows == 1) {
    // output data of each row
    while ($row = $result->fetch_assoc()) {
        echo json_encode($row);
    }
} else {
    echo 'results';
}
$conn->close();
return;

?>
