<?php
require '../db_connection.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
    return;
}

$username = $_POST['username'];
$timeOut = $_POST['timeOut'];
$tokenKey = $_POST['tokenKey'];

$sql = "SELECT id, email FROM admins WHERE email = '$username'";
$result = $conn->query($sql);

$userID = 0;
//If user exist
if ($result->num_rows == 1) {
    while ($row = $result->fetch_assoc()) {
        $userID = $row['id'];
    }

    $sqlSel = "SELECT id, work_in, work_out FROM admins_session WHERE admins_id = '$userID' ORDER BY id DESC LIMIT 1";
    $resultSel = $conn->query($sqlSel);

    $dateTimeIn;
    if ($resultSel->num_rows == 1) {
        while ($row = $resultSel->fetch_assoc()) {
            $dateTimeIn = $row['work_in'];
            $dateTimeOut = $row['work_out'];
            $adminsSessionID = $row['id'];
        }
        $timestamp1 = strtotime($dateTimeIn);
        $timestamp2 = strtotime($dateTimeOut);
        $hour = abs($timestamp2 - $timestamp1) / (60 * 60);

        $sqlUp = "UPDATE admins_session SET work_time='$hour' WHERE admins_id = '$userID' AND id = '$adminsSessionID'";
        if ($conn->query($sqlUp) === true) {
            echo json_encode('success');
        } else {
            echo json_encode('error');
        }
    } else {
        echo 'NO work_in';
    }

    // $sqlUp = "UPDATE admins_session SET work_out = '$timeOut' WHERE admins_id = '$userID' AND tokenKey = '$tokenKey'";
    // if($conn->query($sqlUp) === TRUE){
    //   echo json_encode("success");
    // }else{
    //   echo json_encode("error");
    // }

    //   if($userExist == 1){
    //     echo json_encode("success");
    //   }
} else {
    echo '0 results';
}
$conn->close();
return;

?>
