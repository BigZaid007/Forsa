<?php

include "../connect.php";


//$user_id = htmlspecialchars(strip_tags($_POST['user_id']));

$stmt=$con->prepare("SELECT * FROM `jobs`");



$stmt->execute();

$data=$stmt->fetchAll(PDO::FETCH_ASSOC);

$count=$stmt->rowCount();

if($count > 0)
{
    echo json_encode(
        array(
            "status" => "success","data"=>$data
        )
        );
}
else 
{
    echo json_encode(
        array(
            "status" => "falied"
        )
        );
}