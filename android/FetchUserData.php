<?php
	$con=mysqli_connect("localhost","root","dbdoapp2015","mydb");

	$email = $_POST["email"];
	$password = $_POST["password"];

	$statement = mysqli_prepare($con, "SELECT * FROM User WHERE email = ? AND password = ?");
	mysqli_stmt_bind_param($statement, "ss", $email, $password);
	mysqli_stmt_execute($statement);

	mysqli_stmt_store_result($statement);
	mysqli_stmt_bind_result($statement, $user_id, $name, $email, $password);


	$user = array();

	while(mysqli_stmt_fetch($statement)){
		$user[name] = $name;
		$user[email] = $email;
		$user[password] = $password;
	}

	echo json_encode($user);

	mysqli_stmt_close($statement);

	mysqli_close($con);
?>