<?php
   
   $dbhost = '159.203.73.135';
   $dbuser = 'doappUser';
   $dbpass = 'user_pass_8285';
   $conn = mysql_connect($dbhost, $dbuser, $dbpass);
   
   if(! $conn )
   {
      die('Could not connect: ' . mysql_error());
   }
   
   echo 'Connected successfully';
   mysql_close($conn);
?>
