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


if($_POST) 
{ 
	$users_name = $_POST['username'];
	$users_firstname = $_POST['firstname'];
	$users_household_id = 3;
	$users_password = $_POST['password'];

	$query="SELECT * FROM users WHERE email='{$_POST['username']}' AND password='{$_POST['password']}'";


        $result = mysqli_query($conn,$query);

//	if (!$result = mysqli_query($conn,$query))
        if (mysqli_num_rows($result)>0)
	{		
		echo '{"success":0,"error_message":"User already exists"}';
	}
	else 
	{ 
		
//	$query2="INSERT INTO users ('email','name','household_id','password') values ('{$_POST['username']}','{$_POST['firstname']}','3','{$_POST['password']}')";

	 $query2="INSERT INTO users (email,name,household_id,password) VALUES ('".$users_name."','".$users_firstname."','".$users_household_id."','".$users_password."')"; 	
	$result2 = mysqli_query($conn,$query2);
	// $query2="INSERT INTO users (email,name,household_id,password) VALUES ('$users_name','$users_firstname','$users_household_id','$users_password')"; 	
	
		echo '{"success":1}';
	}



}

else
{
	echo '{"success":0,"error_message":"if $_Post failing"}';
}


 mysqli_close($conn);



?>
