<?php
  // Endpoint for students to ask questions from the React Native app

	$inData = getRequestInfo();

	date_default_timezone_set('America/New_York');

	$sessionID = trimAndSanitize($inData["sessionID"]);
	$text = sanitizeText(substr(htmlspecialchars($inData["text"]), 0, 280));

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

	$error_occurred = false;

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error) {
		$error_occured = true;
		returnWithError($conn->connect_error);
	}
	else {
    $stmt = $conn->stmt_init();
		if (!$stmt->prepare("INSERT INTO Question (SessionID, Text, IsRead) VALUES
          (?, ?, 0)")) {
			$error_occurred = true;
			returnWithError("Failed to prepare insert statement");
		}
		else {
			$stmt->bind_param("is", $sessionID, $text);
			if (!$stmt->execute()) {
				$error_occurred = true;
				returnWithError("Error adding to database");
			}
			$stmt->close();
		}
		$conn->close();
	}

	if (!$error_occurred) {
		returnWithError("");
	}

	// Removes whitespace at the front and back, and removes single quotes and semi-colons
	function trimAndSanitize($str) {
		$str = trim($str);
		$str = str_replace("'", "", $str);
		$str = str_replace(";", "", $str);
		return $str;
	}
	function sanitizeText($str) {
		$str = str_replace("|", "", $str);
		return $str;
	}

	function getRequestInfo() {
		return json_decode(file_get_contents('php://input'), true);
	}

	function sendAsJson($obj) {
		header('Content-type: application/json');
		echo $obj;
	}

	function returnWithError($err) {
		$retValue = '{"error":"' . $err . '"}';
		sendAsJson($retValue);
	}
?>
