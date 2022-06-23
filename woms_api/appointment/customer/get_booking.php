<?php
require '../../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}

$cusID = $_POST['customerID'];
$dateNow = $_POST['dateNow'];
$type = $_POST['type'];

//get Future appointment
if ($type == 'getFuture') {
    $sql = "SELECT bookings.id,
    bookings.from,
    bookings.product_id,
    bookings.status,
    bookings.outlet_id,
    bookings.order_id,
    bookings.hold_order_id,
    product_flat.name as product,
    booking_statuses.title as statusTitle,
    pos_outlets.name as booking_outlet from bookings
    LEFT JOIN product_flat ON product_flat.product_id = bookings.product_id
    LEFT JOIN pos_outlets ON pos_outlets.id = bookings.outlet_id
    LEFT JOIN booking_statuses ON booking_statuses.code = bookings.status
    WHERE bookings.customer_id = $cusID AND bookings.from >= $dateNow AND bookings.status != 'cancelled'
    ORDER BY bookings.from";

    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR getFuture Appointment';
    }
}
//get Last appointment
elseif ($type == 'getLast') {
    $sql0 = "SELECT bookings.id, bookings.from
            FROM bookings WHERE bookings.from < $dateNow
            AND bookings.customer_id = $cusID AND bookings.status != 'cancelled'
            ORDER BY bookings.from DESC LIMIT 1";

    $result0 = $conn->query($sql0);
    if ($result0->num_rows > 0) {
        $fromData;
        while ($row0 = $result0->fetch_assoc()) {
            $fromData = $row0['from'];
        }
        // echo $fromData . "\n";
        // echo json_encode($db_data);

        $sql = "SELECT bookings.id,
            bookings.from,
            bookings.product_id,
            bookings.status,
            bookings.outlet_id,
            bookings.order_id,
            bookings.hold_order_id,
            product_flat.name as product,
            booking_statuses.title as statusTitle,
            pos_outlets.name as booking_outlet
            FROM bookings
            LEFT JOIN product_flat ON product_flat.product_id = bookings.product_id
            LEFT JOIN pos_outlets ON pos_outlets.id=bookings.outlet_id
            LEFT JOIN booking_statuses ON booking_statuses.code=bookings.status
            WHERE bookings.customer_id = $cusID AND bookings.status != 'cancelled' AND bookings.from = $fromData
            ORDER BY bookings.from DESC";

        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $db_data[] = $row;
            }
            echo json_encode($db_data);
        } else {
            echo 'ERROR 3';
        }
    } else {
        echo 'ERROR 2';
    }
}

$conn->close();
return;
?>
