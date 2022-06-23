<?php
require 'db_connection.php';


 //connection
 $conn = new mysqli($servername, $username, $password, $dbname);

//action from app to operate in the database
 $action = $_POST["action"];
 $table = "sample";
 
 //status error
 if($conn->connect_error){
     die("Connection Failed : ". $conn->connect_error);
     return;
 }

 //status OK
 if("CREATE_TABLE" == $action){
     $sql = "CREATE TABLE IF NOT EXISTS $table(
         id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
         first_name VARCHAR(50) NOT NULL,
         last_name VARCHAR(50) NOT NULL
     )";
     if($conn->query($sql) === TRUE){
         echo "TABLE CREATED";
     } else {
         echo "ERROR";
     }
     $conn->close();
     return;
 }

 if ("GET_ALL" == $action){
     $db_data = array();
     $sql = "SELECT id, first_name, last_name FROM $table ORDER BY id DESC";
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
 }

 if("ADD_EMP" == $action){
     $first_name = $_POST["first_name"];
     $last_name = $_POST["last_name"];
     $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name', '$last_name)";
     $result = $conn->query($sql);
     echo "SUCCESS";
     $conn->close();
     return;
 }

 if("UPDATE_EMP" == $action){
     $emp_id = $_POST["$emp_id"];
     $first_name = $_POST["first_name"];
     $last_name = $_POST["last_name"];
     $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = $emp_id";
     if($conn->query($sql) === TRUE){
         echo "SUCCESS";
     }else{
         echo "ERROR";
     }
     $conn->close();
     return;
 }

 if("DELETE_EMP" == $action){
    $emp_id = $_POST["$emp_id"];
    $sql = "DELETE FROM $table WHERE id = $emp_id";
    if($conn->query($sql) === TRUE){
        echo "SUCCESS";
    }else{
        echo "ERROR";
    }
    $conn->close();
    return;
 }


?>