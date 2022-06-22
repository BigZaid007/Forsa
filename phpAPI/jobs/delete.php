<?php

include "../connect.php";


$user_id = htmlspecialchars(strip_tags($_POST['user_id']));



$stmt=$con->prepare("DELETE FROM `jobs` WHERE `user_id` = ? 
  ");

$stmt->execute(array($user_id));

$count=$stmt->rowCount();

if($count > 0)
{
    echo json_encode(
        array(
            "status" => "success"
        )
        );
}
else 
{
    echo json_encode(
        array(
            "status" => "failed"
        )
        );
}