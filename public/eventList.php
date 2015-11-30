<?php

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

   // This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT name, points from events where household_id=32";
 

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

   mysqli_close($conn);
?>
