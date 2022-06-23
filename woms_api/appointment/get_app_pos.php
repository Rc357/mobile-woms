<?php
require '../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$userID = $_POST['userID'];

$levents = [];
$sql = "SELECT * FROM bookings WHERE employee_id = $userID AND order_item_id IS NOT NULL AND (status='confirmed' OR status='checked_in')";
// $sql = "SELECT * FROM bookings WHERE employee_id = $userID AND order_item_id IS NOT NULL AND status='confirmed'";

// $sql = 'SELECT id, name FROM order_items WHERE id = 15439';
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // echo nl2br(
        //     'id: ' .
        //         $row['id'] .
        //         'order_item_id: ' .
        //         $row['order_item_id'] .
        //         "\n"
        // );
        //Get name of item avail
        $iID = $row['order_item_id'];
        $sql0 = "SELECT id, name FROM order_items WHERE id =  $iID";
        $result0 = $conn->query($sql0);
        if ($result0->num_rows > 0) {
            while ($row0 = $result0->fetch_assoc()) {
                // echo nl2br(
                //     'id: ' . $row0['id'] . 'name: ' . $row0['name'] . "\n"
                // );
                // $db_data0 = $row0;

                $row['order_item_id'] = $row0['name'];
            }
            // echo json_encode($db_data0);
        } else {
            echo 'order_item_id ERROR';
        }

        //Get name of customer
        $cID = $row['customer_id'];

        $sql1 = "SELECT first_name, last_name FROM customers WHERE id = $cID";
        $result1 = $conn->query($sql1);
        if ($result1->num_rows > 0) {
            while ($row1 = $result1->fetch_assoc()) {
                $row['customer_id'] =
                    $row1['first_name'] . ' ' . $row1['last_name'];
            }
        } else {
            echo 'customer_id ERROR';
        }

        $db_data[] = $row;
    }

    echo json_encode($db_data);
} else {
    echo 'bookings ERROR';
}
$conn->close();
return;
?>
