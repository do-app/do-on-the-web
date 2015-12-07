<?php 
// begin our session
session_id('mySessionID'); 
session_start();

$name = $_SESSION['username'];
echo "Hello  " . $name;

//session_start(); 

// echo the session variable
echo 'The value of foo is '.$_SESSION['username']; 
?>
