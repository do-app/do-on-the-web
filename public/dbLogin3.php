
<?php
header('Content-type: application/json');
   $dbhost = 'localhost';
   $dbuser = 'root';
   $dbpass = 'dbdoapp2015';
   $dbname = 'mydb';
   $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname );


   if(! $conn )
   {
      die('Could not connect: ' . mysql_error());
   }

   echo 'Connected successfully';


   // This SQL statement selects email, password from users table
 
$sql = "SELECT email, password FROM users";

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
  
//try to compare to database
/*
$sql2="SELECT email, password FROM users WHERE email='$username'";
if($result2=mysqli_query($conn, $sql2)
{
	$resultArray2=array();
	$tempArray2=array();


// Loop through each row in the result set
        while($row2 = $result2->fetch_object())
        {
                // Add each row into our results array
                $tempArray2 = $row2;
            array_push($resultArray2, $tempArray2);
        }

        // Finally, encode the array to JSON and output the results
        echo json_encode($resultArray2);
}

else
{
        echo 'did not connect to user results2 successfully';
}
*/



  
//original for program
 mysqli_close($conn);


if($_POST) {

$tempPost=$_POST['username'];
echo "username is $tempPost";
    if($_POST['username'] == 'pam' && $_POST['password'] == 'jaworski') {
    echo '{"success":1}';
 } else {
    echo '{"success":0,"error_message":"Username and/or password is invalid."}';
}

}else {    echo '{"success":0,"error_message":"Username and/or password is invalid."}';}
?>
