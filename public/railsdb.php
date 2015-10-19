<?php
header('Content-type: application/json');
   $dbhost = 'localhost';
   $dbuser = 'root';
   $dbpass = 'dbdoapp2015';
   $dbname = 'mydatabase';
   $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname );


   if(! $conn )
   {
      die('Could not connect: ' . mysql_error());
   }

   echo 'Connected successfully';


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


if($_POST) 
{ 
	$query="SELECT * FROM users WHERE email='{$_POST['username']}' AND password_digest='{$_POST['password']}'";



        $result = mysqli_query($conn,$query);

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



 mysqli_close($conn);



?>
