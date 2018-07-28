<?php
  // Receives the class code and returns the class information and list of
  // sessions.

	$inData = getRequestInfo();

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

  $classID = trimAndSanitize($inData["classID"]);
  $sessionList = '[';

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error) {
		$error_occurred = true;
		returnWithError($conn->connect_error);
	}
	else {

    // First, pull the class information
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare("Select Name, ProfessorID from Class where ClassID = ?")) {
      $error_occurred = true;
      returnWithError($conn->errno());
    } else {
      $stmt->bind_param("i", $classID);
      $stmt->execute();
      $stmt->store_result();
      $stmt->bind_result($className, $professorID);
      $numRows = 0;
      while ($stmt->fetch()) {
        $numRows = $numRows + 1;
      }

      // We didn't retrieve any rows so we return with no results found.
      if ($numRows == 0) {
        returnWithError("No sessions found.");
      } else {
				$stmt->close();

        $stmt = $conn->stmt_init();
        if(!$stmt->prepare("Select Name from Professor where professorID = ?")) {
          $error_occurred = true;
          returnWithError($conn->errno());
        } else {
          $stmt->bind_param("i", $professorID);
					$stmt->execute();
					$stmt->store_result();
					$stmt->bind_result($professor);
          while ($stmt->fetch()) {
            $professor = $professor;
          }
        }
        $stmt->close();

		    // Pull the list of sessions for this class
				$stmt = $conn->stmt_init();
				if(!$stmt->prepare("Select SessionID, Name, DateCreated from Session
								where ClassID = ? and Archived = 0")) {
					$error_occurred = true;
					returnWithError($conn->errno());
				}
				else {
					$stmt->bind_param("i", $classID);
					$stmt->execute();
					$stmt->store_result();
					$stmt->bind_result($sessionID, $sessionName, $dateCreated);

		      $count = 0;
					while ($stmt->fetch()) {
		        if ($count > 0) {
		          $sessionList = $sessionList . ',';
		        }

		        $sessionList = $sessionList . '{"sessionID":"' . $sessionID . '",';
		        $sessionList = $sessionList . '"sessionName":"' . $sessionName . '",';
		        $sessionList = $sessionList . '"dateCreated":"' . $dateCreated . '"}';

		        $count = $count + 1;
					}
		      $sessionList = $sessionList . ']';
					returnWithInfo($classID, $className, $professor, $sessionList);
					$stmt->close();
				}
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
	function sendAsJSON($obj) {
		header('Content-type: application/json');
		echo $obj;
	}

	// Return in the case of an error
	function returnWithError( $err ) {
		$retValue = '{"active":"", "archived":"", "error":"' . $err . '"}';
		sendAsJson( $retValue );
	}

  // Return and send the sessionID, classID, session name, class name,
  // professor name, and list of poll questions
	function returnWithInfo($classID, $className, $professor, $sessionList) {
		$retValue = '{"classID":"' . $classID . '", "className":"' . $className .
      '", "professor":"' . $professor . '", "sessionList":' . $sessionList .
       ', "error":""}';
		sendAsJson( $retValue );
	}
?>
