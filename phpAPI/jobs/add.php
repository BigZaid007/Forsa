<?php

include "../connect.php";




$title  = htmlspecialchars(strip_tags($_POST['title']));
$content = htmlspecialchars(strip_tags($_POST['content']));
$user_id = htmlspecialchars(strip_tags($_POST['user_id']));

$stmt=$con->prepare("INSERT INTO `jobs`
(`title` , `content`,`user_id`) VALUES (?,?,?)
 ");


$stmt->execute (array ($title,$content,$user_id));

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