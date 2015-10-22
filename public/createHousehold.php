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

   echo "connection works";
*/


if($_POST) 
{ 
	$users_name = $_POST['username'];
	$households_name = $_POST['household'];

	$query="SELECT * FROM households WHERE name='{$_POST['household']}'";


        $result = mysqli_query($conn,$query);

//	if (!$result = mysqli_query($conn,$query))
        if (mysqli_num_rows($result)>0) //join existing household
	{		
		echo '{"success":0,"error_message":"Household already exists"}';
	}
	else //create new household 
	{ 
		
//	$query2="INSERT INTO users ('email','name','household_id','password') values ('{$_POST['username']}','{$_POST['firstname']}','3','{$_POST['password']}')";

	 $query2="INSERT INTO households (name) VALUES ('".$households_name."')"; 	
	$result2 = mysqli_query($conn,$query2);
	//$query3="SELECT * FROM households WHERE name='{$_POST['household']}'";
	//$result3 = mysqli_query($conn,$query3);
	//$query4="UPDATE users SET household_id = '".$query3."'";
	//	echo '{"success":1}';
	}



}

else
{
	echo '{"success":0,"error_message":"if $_Post failing"}';
}


 mysqli_close($conn);



?>
