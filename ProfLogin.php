<?php
	// Assumes the input is a JSON file in the format of {"email":"", "password":""}
	// Outputs int he form of {"error":"", "session":""}

	$inData = getRequestInfo();

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

	$id = 0;
	$email = trimAndSanitize($inData["email"]);
	$password = trimAndSanitize($inData["password"]);

	$error_occurred = false;
	$found_user = false;

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error){
		$error_occurred = true;
		returnWithError($conn->connect_error);
	}
	else{
		$stmt = $conn->stmt_init();
		if(!$stmt->prepare("Select professorID, Name from Professor where Email = ? and Password = ?")){
			$error_occurred = true;
			returnWithError($conn->errno());
		}
		else{
			$stmt->bind_param("ss", $email, $password);
			$stmt->execute();
			$stmt->bind_result($id, $name);
			while($stmt->fetch()){
				if(!$found_user){
					$found_user = true;
				}
				else{
					$error_occurred = true;
					$found_user = false;
					break;
				}
			}
			if($found_user){
				if (!session_start()){
					returnWithError("Failed to initialize session");
					exit();
				}
				$_SESSION["name"] = $name;
				$_SESSION["professorID"] = $id;
				returnWithInfo(session_id());
			}
			else{
				returnWithError("Could not find account");
			}
		}

		$conn->close();
	}

	// Removes whitespace at the front and back, and removes single quotes and semi-colons
	function trimAndSanitize($str){
		$str = trim($str);
		$str = str_replace("'", "", $str );
		$str = str_replace(";", "", $str);
		return $str;
	}

	// Parse JSON file input
	function getRequestInfo(){
		return json_decode(file_get_contents('php://input'), true);
	}

	// Send the user's username and ID as JSON
	function sendAsJSON($obj){
		header('Content-type: application/json');
		echo $obj;
	}

	// Return in the case of an error
	function returnWithError( $err )
	{
		$retValue = '{"error":"' . $err . '", "session":""}';
		sendAsJson( $retValue );
	}

	// Return and send the user's name and id
	function returnWithInfo( $session )
	{
		$retValue = '{"error":"", "session":"' . $session . '"}';
		sendAsJson( $retValue );
	}
?>
