<?php
session_id('mySessionID');
session_start();
   $dbhost = 'localhost';
   $dbuser = 'root';
   $dbpass = 'dbdoapp2015';
   $dbname = 'mydb';
   $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname );

/*
   if(! $conn )
   {
      die('Could not connect: ' . mysql_error());
   }

   echo 'Connected successfully';
*/ 
echo 'in deleteChore';
   // This SQL statement selects ALL from the table 'Locations'
if($_POST)
{echo 'in if post';
echo 'the value of session is '.$_SESSION['sessionEmail'];
echo 'the value of post is '.$_POST['nameToDelete'];
$query1="SELECT household_id from users WHERE email='{$_SESSION['sessionEmail']}'";
$result1=mysqli_query($conn,$query1);
$householdInfo=mysqli_fetch_row($result1);
$householdResult=$householdInfo[0];

echo 'householdResult is ' .$householdResult;

 
	$nameToDelete = $_POST['nameToDelete'];

	$query="DELETE FROM choresEdit WHERE household_id='$householdResult' AND name='{$_POST['nameToDelete']}'";


        $result = mysqli_query($conn,$query);
}
	else 
	{ 
		echo '{"success":0}';
	}

 mysqli_close($conn);



?>
