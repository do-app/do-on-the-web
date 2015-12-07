<?php
session_id('mySessionID'); //SET id first before calling  session start
session_start();

$name = "Nitin Hurkadli";
$_SESSION['username'] = $name;

//session_start(); 

// set the value of the session variable 'foo'
//$_SESSION['foo']='bar'; 

// echo a little message to say it is done
//echo 'Setting value of foo';
echo 'The value of foo is '.$_SESSION['username'];  
?>
