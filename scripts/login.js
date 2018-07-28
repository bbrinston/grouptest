

var baseURL = "http://newlook.gearhostpreview.com/originalDevSetup/API";
//var baseURL = "http://localhost:3306/API";
// Login error responses
var badLogin = "Incorrect username or password";

function login(){

    var email = document.getElementById("login-email").value;
    var password = document.getElementById("login-password").value;

	var payload = '{"email" : "' + email + '", "password" : "' + password + '"}';

	var xhr = new XMLHttpRequest();
	xhr.open("POST", baseURL + "/ProfLogin.php", false);
	xhr.setRequestHeader("Content-type", "application/json; charset = UTF-8");

	try {
		xhr.onreadystatechange = function(){
			if(xhr.readyState === 4){
				var data = JSON.parse(xhr.responseText);
				var error = data.error;

				if(error != '') {
					printError(error);
					return;
				}

				document.getElementsByName("email")[0].value = "";
				document.getElementsByName("password")[0].value = "";
				window.location.href = "main.html";
			}
		}

		xhr.send(payload);
	}
	catch(error) {
		printError(error.message);
	}
	return false;
}



function printError(error){
	
}

