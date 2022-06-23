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
$timeIn = $_POST['timeIn'];
$tokenKey = $_POST['tokenKey'];

$sql = "SELECT id, email, uname, password, role_id, customer_id, personal_phone_number FROM admins WHERE email = '$username'";
$result = $conn->query($sql);

$userID = 0;
$userExist = 0;
//If user exist
if ($result->num_rows == 1) {
    while ($row = $result->fetch_assoc()) {
        $userID = $row['id'];
        // echo "id: " . $row["id"]. " - email: " . $row["email"]. " " . $row["uname"]. " ". $row["password"]."<br>";
        if ($row['role_id'] == 5) {
            if (password_verify($password, $row['password'])) {
                echo json_encode('customer');
            } else {
                $rest = substr($row['personal_phone_number'], -4);
                if ($rest == $password) {
                    echo json_encode('customer');
                } else {
                    echo json_encode('error customer');
                    return;
                }
            }
        } elseif (password_verify($password, $row['password'])) {
            $userExist = 1;
        } elseif ($row['role_id'] == 2) {
            $rest = substr($row['personal_phone_number'], -4);

            if ($rest == $password) {
                $userExist = 1;
            } else {
                echo json_encode('error role 2');
                return;
            }
        } else {
            echo json_encode('error');
            return;
        }
    }

    // $sqlIns = "INSERT INTO admins_session (admins_id, work_in, tokenKey) VALUES ('$userID', '$timeIn', '$tokenKey')";
    // $result = $conn->query($sqlIns);

    if ($userExist == 1) {
        echo json_encode('success');
    }
} else {
    echo '0 results';
}
$conn->close();
return;

?>
