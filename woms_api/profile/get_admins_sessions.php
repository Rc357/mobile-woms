<?php

require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$functionType = $_POST['functionType'];
$username = $_POST['username'];
$tokenKey = $_POST['tokenKey'];
$dateTimeNow = $_POST['dateTimeNow'];

// echo $functionType;

if ($functionType == 'CHECK_TIME') {
    $sql = "SELECT id, email FROM admins WHERE email = '$username'";
    $result = $conn->query($sql);

    $userID = 0;
    //If user exist
    if ($result->num_rows == 1) {
        while ($row = $result->fetch_assoc()) {
            $userID = $row['id'];
        }

        $sqlSel = "SELECT work_in, work_out FROM admins_session WHERE admins_id = '$userID' ORDER BY id DESC LIMIT 1";
        $resultSel = $conn->query($sqlSel);

        $dateTimeIn;
        $dateTimeOut;
        //If user exist
        if ($resultSel->num_rows == 1) {
            while ($row = $resultSel->fetch_assoc()) {
                $dateTimeIn = $row['work_in'];
                $dateTimeOut = $row['work_out'];
            }

            if ($dateTimeOut == '0000-01-01 00:00:00') {
                $timestamp1 = strtotime($dateTimeIn);
                $timestamp2 = strtotime($dateTimeNow);
                $hour = abs($timestamp2 - $timestamp1) / (60 * 60);
                // echo $hour;
                if ($hour >= 8) {
                    $sqlUp = "UPDATE admins_session SET work_out = '$dateTimeNow', work_time='$hour' WHERE admins_id = '$userID'";
                    if ($conn->query($sqlUp) === true) {
                        echo json_encode('success');
                    } else {
                        echo json_encode('error');
                    }
                }
            }
        } else {
            echo 'NO work_in';
        }
    } else {
        echo 'NO results';
    }
} else {
    echo '0 results';
}
$conn->close();
return;

?>
