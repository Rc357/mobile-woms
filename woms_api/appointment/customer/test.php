<?php
require '../../db_connection.php';

//connection
$conn = new mysqli($servername, $username, $password, $dbname);

//status error
if ($conn->connect_error) {
    die('Connection Failed : ' . $conn->connect_error);
    return;
}
$type = $_POST['type'];
$cusID = $_POST['customerID'];
$outletID = $_POST['outletID'];

if ($type == 'book') {
    $sql = "SELECT id,
    qty,
    bookings.from,
    bookings.to,
    order_item_id,
    booking_product_event_ticket_id,
    order_id,
    product_id,
    employee_id,
    room_id,
    hold_order_item_id,
    hold_order_id,
    outlet_id,
    bookings.status,
    customer_id,
    created_at,
    updated_at,
    deleted_at,
    checked_in_time,
    start_time,
    end_time,
    checked_out_time,
    cashier_id,
    before_pending_actions_status,
    before_voicemail_sent_status,
    esthetician_is_requested,
    before_no_voicemail_status,
    before_no_show_status,
    reschedule_by,
    is_multiple,
    sms_confirmation_sent,
    sms_auto_call_sent,
    confirmed_via_sms,
    confirmed_via_auto_call,
    sms_reply_value,
    cancelled_time,
    no_show_time,
    actual_time,
    sms_replied_time,
    reason_for_cancellation
    FROM bookings
    WHERE  customer_id = $cusID
    AND outlet_id = $outletID
    GROUP BY bookings.from, bookings.room_id, bookings.customer_id";

    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            //get name of service
            // $iID = $row['order_item_id'];
            // $sql0 = "SELECT id, name FROM order_items WHERE id =  $iID";
            // $result0 = $conn->query($sql0);
            // if ($result0->num_rows > 0) {
            //     while ($row0 = $result0->fetch_assoc()) {
            //         $row['order_item_id'] = $row0['name'];
            //     }
            // }
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR ss';
    }
} else {
    $sql = 'SELECT * FROM admins';

    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    } else {
        echo 'ERROR ss';
    }
}

$conn->close();
return;
?>
