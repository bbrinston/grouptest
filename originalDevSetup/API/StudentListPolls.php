<?php
  // Receives the session code and returns a list of questions for that session.
  // Endpoint for the student app.

	$inData = getRequestInfo();

	// Server info for connection
	$servername = "127.0.0.1";
	$dbUName = "root";
	$dbPwd = "password";
	$dbName = "group5";

  $sessionID = trimAndSanitize($inData["sessionID"]);
  $pollList = '[';

	// Connect to database
	$conn = new mysqli($servername, $dbUName, $dbPwd, $dbName);
	if ($conn->connect_error) {
		$error_occurred = true;
		returnWithError($conn->connect_error);
	}
	else {

    // First, verify that the session exists.
    $stmt = $conn->stmt_init();
    if (!$stmt->prepare("Select Name from Session where SessionID = ?")) {
      $error_occurred = true;
      returnWithError($conn->errno());
    } else {
      $stmt->bind_param("i", $sessionID);
      $stmt->execute();
      $stmt->store_result();
      $stmt->bind_result($name);
      $numRows = 0;
      while ($stmt->fetch()) {
        $numRows = $numRows + 1;
      }

      // We didn't retrieve any rows so we return with no results found.
      if ($numRows == 0) {
        returnWithError("No sessions found.");
      } else {
				$stmt->close();

		    // Finally get the professor polls for this session
				$stmt = $conn->stmt_init();
				if(!$stmt->prepare("Select PollID, Pollcol, QuestionText, NumAnswers,
		      Answer1, Answer2, Answer3, Answer4, Answer5, DateCreated from Poll
					where SessionID = ? and IsArchived = 0")) {
					$error_occurred = true;
					returnWithError($conn->errno());
				}
				else {
					$stmt->bind_param("i", $sessionID);
					$stmt->execute();
					$stmt->store_result();
					$stmt->bind_result($id, $pollCol, $text, $numAns, $ans1, $ans2, $ans3,
					 $ans4, $ans5, $dateCreated);

		      $count = 0;
					while ($stmt->fetch()) {
		        if ($count > 0) {
		          $pollList = $pollList . ',';
		        }

		        $pollList = $pollList . '{"pollID":"' . $id . '",';
						$pollList = $pollList . '"pollCol":"' . $pollCol . '",';
		        $pollList = $pollList . '"questionText":"' . $text . '",';
		        $pollList = $pollList . '"numAnswers":"' . $numAns . '",';
						$pollList = $pollList . '"dateCreated":"' . $dateCreated . '",';
		        $pollList = $pollList . '"answers":[{"answer":"' . $ans1 . '", "index":1 },' .
						'{"answer":"' . $ans2 . '", "index":2 },' .
						'{"answer":"' . $ans3 . '", "index":3 },' .
						'{"answer":"' . $ans4 . '", "index":4 },' .
						'{"answer":"' . $ans5 . '", "index":5 }]}';

		        $count = $count + 1;
					}
		      $pollList = $pollList . ']';
					returnWithInfo($sessionID, $pollList);
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
	function returnWithInfo( $sessionID, $polls) {
		$retValue = '{"sessionID":"' . $sessionID . '", "questionList":' .
			$polls . ', "error":""}';
		sendAsJson( $retValue );
	}
?>
