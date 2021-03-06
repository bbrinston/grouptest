<?php
	// Assumes the input is a JSON file in the format of {"session":"", "questionID":""}
	// Removes the specified question from the current session

	$inData = getRequestInfo();

	$session = trimAndSanitize($inData["session"]);
	$questionID = trimAndSanitize($inData["questionID"]);

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

	if ($session != ""){
		session_id($session);
	}
	if (!session_start()){
		returnWithError("Unable to access session");
		exit();
	}

	$sessionID = $_SESSION["sessionID"];
	$professorID = $_SESSION["professorID"];

	if ($sessionID == ""){
		returnWithError("Session must be set before deleting.");
		exit();
	}
	if ($professorID == ""){
		returnWithError("Only professors can delete questions.");
		exit();
	}

	$error_occurred = false;
	$in_use = false;

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error){
		$error_occured = true;
		returnWithError($conn->connect_error);
	}
	else{
		if (!$error_occurred){
			$stmt = $conn->stmt_init();
			if(!$stmt->prepare("DELETE FROM Question WHERE QuestionID = ? AND SessionID = ?")){
				$error_occurred = true;
				returnWithError($conn->errno());
			}
			$stmt->bind_param("ii", $questionID, $sessionID);
			if (!$stmt->execute()){
				$error_occurred = true;
				returnWithError("Failed to remove question.");
			}
			$stmt->close();
		}
	}
	$conn->close();

	if (!$error_occurred){
		returnWithError("");
	}

	// Removes whitespace at the front and back, and removes single quotes and semi-colons
	function trimAndSanitize($str){
		$str = trim($str);
		$str = str_replace("'", "", $str );
		$str = str_replace(";", "", $str);
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
