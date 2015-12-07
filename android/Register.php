<?php
	$con=mysqli_connect("localhost","root","dbdoapp2015","mydb");

	$name = $_POST["name"];
	$email = $_POST["email"];
	$password = $_POST["password"];

	$statement = mysqli_prepare($con, "INSERT INTO User (name, email, password) VALUES (?, ?, ?) ");
	mysqli_stmt_bind_param($statement, "sss", $name, $email, $password);
	mysqli_stmt_execute($statement);


	mysqli_stmt_close($statement);


	mysqli_close($con);
?>