<?php

session_start();

if (isset($_SESSION['sessionEmail']))
  if ($_SESSION['sessionEmail'] != NULL){
      echo $_SESSION['sessionEmail'];                   
  }

//echo $_SESSION['sessionEmail']; // green
echo 'Welcome to page2';
?>
