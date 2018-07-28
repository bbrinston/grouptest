<?php

	$inData = getRequestInfo();

	$pollID = trimAndSanitize($inData["pollID"]);
	$answer = trimAndSanitize($inData["answer"]);

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

	$error_occurred = false;
	$numAns = 0;

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error){
		$error_occured = true;
		returnWithError($conn->connect_error);
	}
	else{
		// Get information about the poll being voted on
		if (!$error_occurred){
			// Insert the new vote
			$stmt = $conn->stmt_init();
			if (!$stmt->prepare("Insert into Vote (PollID, Answer) values (?, ?)")){
				returnWithError("Could not prepare statement.");
				exit();
			}
			else{
				$stmt->bind_param("ii", $pollID, $answer);
				if (!$stmt->execute()){
					returnWithError("Could not insert vote to DB");
					exit();
				}
			}
			$stmt->close();
		}
	}
	$conn->close();

	if (!$error_occurred){
		returnWithError("");
	}

	// Removes whitespace at the front and back, and removes single quotes, pipes, and semi-colons
	function trimAndSanitize($str){
		$str = trim($str);
		$str = str_replace("'", "", $str );
		$str = str_replace(";", "", $str);
		$str = str_replace("|", "", $str);
		return $str;
	}

	function getRequestInfo()
	{
		return json_decode(file_get_contents('php://input'), true);
	}

	function sendAsJson( $obj )
	{
		header('Content-type: application/json');
		echo $obj;
	}

	function returnWithError( $err )
	{
		$retValue = '{"error":"' . $err . '"}';
		sendAsJson( $retValue );
	}
?>
