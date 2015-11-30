<?php

   $dbhost = 'localhost';
   $dbuser = 'root';
   $dbpass = 'dbdoapp2015';
   $dbname = 'mydb';
   $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname );


   if(! $conn )
   {
      die('Could not connect: ' . mysql_error());
   }

//   echo 'Connected successfully';

if($_POST) 
{ 
	$email = $_POST['useremail'];

	$query="SELECT household_id FROM users WHERE email='{$_POST['useremail']}'";
        $result = mysqli_query($conn,$query);
	$house_id=mysqli_fetch_row($result);
	$house_id_result=$house_id[0];

	$query3="SELECT name FROM chores  WHERE household_id='$house_id_result';
	$result3 = mysqli_query($conn,$query3);
	
}

else
{
	echo '{"success":0,"error_message":"if $_Post failing"}';
}


	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();
 
	// Loop through each row in the result set
	while($row = $result3->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}


   mysqli_close($conn);
?>
