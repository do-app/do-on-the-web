<?php
header('Content-type: application/json');
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

   // This SQL statement selects email, password from users table
   /*
if($_POST) {

    if($_POST['username'] == 'pam' && $_POST['password'] == 'jaworski') {
    echo '{"success":1}';
 } else {
    echo '{"success":0,"error_message":"Username and/or password is invalid."}';
}

}else {    echo '{"success":0,"error_message":"Username and/or password is invalid."}';}
*/
//session_start();

//echo 'Welcome to page #1';

//$_SESSION['sessionEmail'] = $_POST['username'];

// Works if session cookie was accepted
//echo '<br /><a href="page2.php">page 2</a>';


if($_POST) 
{ 
	$query="SELECT * FROM users WHERE email='{$_POST['username']}' AND password='{$_POST['password']}'";

//	$query="SELECT * FROM users WHERE email='qjane@gmail.com' AND password='janespass'";


        $result = mysqli_query($conn,$query);

//	if (!$result = mysqli_query($conn,$query))
        if (mysqli_num_rows($result)==0)
	{		
		echo '{"success":0,"error_message":"Username and/or password is invalid."}';
	}
	else
	{
		echo '{"success":1}';
	}



}

else
{
	echo '{"success":0,"error_message":"if $_Post failing"}';
}

/*
//$sql = "SELECT email, password FROM users";

// Check if there are results
if ($result = mysqli_query($conn,$sql))
//if ($result = $conn->query($sql)) 
{
	//echo 'Connected to user results successfully';
  
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();
 
	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}

else
{
	echo 'did not connect to user results successfully';
}
  

*/


 mysqli_close($conn);



?>
