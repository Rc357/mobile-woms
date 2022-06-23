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
$password = $_POST['password'];

$sql = "SELECT id, email, uname, password FROM admins WHERE email = '$username'";
$result = $conn->query($sql);

if ($result->num_rows == 1) {
    // output data of each row
    while ($row = $result->fetch_assoc()) {
        //  echo "id: " . $row["id"]. " - email: " . $row["email"]. " " . $row["uname"]. " ". $row["password"]."<br>";
        if (password_verify($password, $row['password'])) {
            echo json_encode('success');
        } else {
            echo json_encode('error');
        }
    }
} else {
    echo '0 results';
}
$conn->close();
return;

?>
