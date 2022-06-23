<?php
require "../db_connection.php";

 //connection
 $conn = new mysqli($servername, $username, $password, $dbname);
 
 //status error
 if($conn->connect_error){
     die("Connection Failed : ". $conn->connect_error);
     return;
 }

    $userID = $_POST["userID"];

    $levents = array();
    $sql = "SELECT * FROM employee_schedules WHERE admin_id = $userID";
    $result = $conn->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo "ERROR";
    }
    $conn->close();
    return;
 ?>