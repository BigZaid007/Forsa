<?php

include "../connect.php";

$email=htmlspecialchars(strip_tags($_POST['email']));
$password =htmlspecialchars(strip_tags($_POST['password']));


$stmt=$con->prepare("SELECT * FROM `users` WHERE `email` = ? AND `password` = ?");

$stmt->execute(array(
    $email,$password
));

$data=$stmt->fetch(PDO::FETCH_ASSOC);

$stmt->execute(array(
    $email,$password,
));


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
            "status" => "failed","data"=>$data
        )
        );
}