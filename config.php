<?php 

$serverName = "den1.mysql4.gear.host"; //serverName\instanceName 
$connectionInfo = array( "Database"=>"database46", "UID"=>"database46", "PWD"=>"pass123?"); 
$conn = sqlsrv_connect( $serverName, $connectionInfo); 
if( $conn ) { echo "Connection established.
"; }else{ echo "Connection could not be established.
"; die( print_r( sqlsrv_errors(), true)); } 

?>