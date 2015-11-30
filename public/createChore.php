
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



if($_POST) 
{ 
	$household = $_POST['household'];
	$chore = $_POST['choreName'];
	$points = $_POST['points'];
	$times = $_POST['times'];

	$query="SELECT * FROM households WHERE name='{$_POST['household']}'";


        $result = mysqli_query($conn,$query);

//	if (!$result = mysqli_query($conn,$query))
        if (mysqli_num_rows($result)<1)
	{		
		echo '{"success":0,"error_message":This household does not exist"}';
	}
	else 
	{ 

	$query3="SELECT id FROM households WHERE name='{$_POST['household']}'";
	$result3 = mysqli_query($conn,$query3);
	$idInfo=mysqli_fetch_row($result3);
	$idResult=$idInfo[0];
//	$query4="UPDATE users SET household_id='$idResult' WHERE email='{$_POST['username']}'";
//	$result4=mysqli_query($conn,$query4);



		
//	$query2="INSERT INTO users ('email','name','household_id','password') values ('{$_POST['username']}','{$_POST['firstname']}','3','{$_POST['password']}')";

	 $query2="INSERT INTO chores (name,points,times_per_week,household_id) VALUES ('".$chore."','".$points."','".$times."','".$idResult."')"; 	
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
