<?php


include'connect.php';

$statment=$con->prepare("SELECT * FROM users");
$statment->execute();
$user=$statment->fetchAll(PDO::FETCH_ASSOC);
//$count=$statment->rowCount();

echo json_encode($user);



?>