<?php

session_start();

if (isset($_SESSION['sessionEmail'])){
echo "isset";
  if ($_SESSION['sessionEmail'] != NULL){
      echo $_SESSION['sessionEmail'];                   
echo "session not null";
  }
}

//echo $_SESSION['sessionEmail']; // green
echo 'Welcome to page2';
?>
