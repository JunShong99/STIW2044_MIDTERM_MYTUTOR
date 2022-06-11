<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$results_per_page = 5;
$pageno = (int)$_POST['pageno'];


$page_first_result = ($pageno - 1) * $results_per_page;

$sqltutor = "SELECT * FROM `tbl_tutors`";
$result = $conn->query($sqltutor);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqltutor = $sqltutor . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqltutor);

if ($result->num_rows > 0) {
    //do something
    $tutors["tutors"] = array();
    while ($row = $result->fetch_assoc()) {
        $tlist = array();
        $tlist['tutor_id'] = $row['tutor_id'];
        $tlist['tutor_email'] = $row['tutor_email'];
        $tlist['tutor_phone'] = $row['tutor_phone'];
        $tlist['tutor_name'] = $row['tutor_name'];
        $tlist['tutor_password'] = $row['tutor_password'];
        $tlist['tutor_description'] = $row['tutor_description'];
        $tlist['tutor_datereg'] = $row['tutor_datereg'];
        array_push($tutors["tutors"],$tlist);
    }
    $response = array('status' => 'success', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $tutors);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page",'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>