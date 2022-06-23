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
$outletID = $_POST['outletID'];
$type = $_POST['type'];

//get member
$sql = "SELECT product_flat.product_id as code,
        product_flat.name as label,
        product_flat.price,
        products.type,
        booking_product_appointment_slots.duration as duration,
        memberships.id as membership_id,
        memberships.status as membership_status,
        memberships.end_date as expiration_date
        FROM product_flat
        LEFT JOIN pos_outlet_product ON pos_outlet_product.product_id = product_flat.product_id
        LEFT JOIN products ON pos_outlet_product.product_id = products.id
        LEFT JOIN booking_products ON booking_products.product_id = products.id
        LEFT JOIN booking_product_appointment_slots ON booking_product_appointment_slots.booking_product_id=booking_products.id
        LEFT JOIN memberships ON memberships.membership_id = product_flat.product_id
        WHERE memberships.customer_id = $cusID 
        AND (memberships.status ='pending' OR memberships.status ='active' OR memberships.status ='frozen')
        AND memberships.deleted_at IS NULL
        AND pos_outlet_product.outlet_id = $outletID
        AND pos_outlet_product.status = 1
        AND products.type = 'membership'
        AND product_flat.url_key IS NOT NULL
        ORDER BY membership_status ASC";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $member_data[] = $row;
        $lCode[] = $row['code'];
    }
} else {
    $lCode[] = 0;
    // echo 'ERROR PRODUCT 0';
}

// $lCode1 = json_encode($lCode) . "\n";
// echo json_encode($member_data);

//Not Member
$sql1 =
    "SELECT product_flat.product_id as code,
            product_flat.name as label,
            product_flat.price,
            products.type,
            booking_product_appointment_slots.duration as duration,
            0 as membership_id
        FROM product_flat
        LEFT JOIN pos_outlet_product ON pos_outlet_product.product_id = product_flat.product_id
        LEFT JOIN products ON pos_outlet_product.product_id = products.id
        LEFT JOIN booking_products ON booking_products.product_id = products.id
        LEFT JOIN booking_product_appointment_slots ON booking_product_appointment_slots.booking_product_id = booking_products.id
        WHERE products.id NOT IN ( '" .
    implode("', '", $lCode) .
    "' )
        AND pos_outlet_product.outlet_id = $outletID
        AND pos_outlet_product.status = 1
        AND products.type = 'membership'
        AND product_flat.url_key IS NOT NULL
        UNION SELECT product_flat.product_id as code,
        product_flat.name as label,
        product_flat.price,
        products.type,
        booking_product_appointment_slots.duration as duration,
        0 as membership_id
    FROM product_flat
    LEFT JOIN pos_outlet_product ON pos_outlet_product.product_id = product_flat.product_id
    LEFT JOIN products ON pos_outlet_product.product_id=products.id
    LEFT JOIN booking_products ON booking_products.product_id = products.id
    LEFT JOIN booking_product_appointment_slots ON booking_product_appointment_slots.booking_product_id=booking_products.id
    WHERE pos_outlet_product.outlet_id = $outletID
    AND pos_outlet_product.status = 1
    AND products.type = 'booking'
    AND product_flat.url_key IS NOT NULL";

$result1 = $conn->query($sql1);
if ($result1->num_rows > 0) {
    while ($not_member_data[] = $result1->fetch_assoc());
    $not_member_data[] = $row1;
    // echo json_encode($not_member_data);
} else {
    echo 'ERROR PRODUCT 1';
}

if (is_null($member_data)) {
    echo json_encode($not_member_data);
} else {
    $merged_results = array_merge($member_data, $not_member_data);
    echo json_encode($merged_results);
}
// $merged_results = array_merge($member_data, $not_member_data);
// echo json_encode($merged_results);
// echo json_encode($not_member_data);

// //services
// $sql2 = "SELECT product_flat.product_id as code,
//     product_flat.name as label,
//     product_flat.price,
//     products.type,
//     booking_product_appointment_slots.duration as duration,
//     0 as membership_id
// FROM product_flat
// LEFT JOIN pos_outlet_product ON pos_outlet_product.product_id = product_flat.product_id
// LEFT JOIN products ON pos_outlet_product.product_id=products.id
// LEFT JOIN booking_products ON booking_products.product_id = products.id
// LEFT JOIN booking_product_appointment_slots ON booking_product_appointment_slots.booking_product_id=booking_products.id
// WHERE pos_outlet_product.outlet_id = $outletID
// AND pos_outlet_product.status = 1
// AND products.type = 'booking'
// AND product_flat.url_key IS NOT NULL";

// $result2 = $conn->query($sql2);
// if ($result2->num_rows > 0) {
//     while ($row2 = $result2->fetch_assoc()) {
//         $services[] = $row2;
//     }
//     echo json_encode($services);
// } else {
//     echo 'ERROR PRODUCT 1';
// }

$conn->close();
return;
?>
