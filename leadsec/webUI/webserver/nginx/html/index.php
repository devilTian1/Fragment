<?php
error_reporting(E_ALL);
@session_start();
// Load Common Function
require_once('Function/common.php');
if(isset($_GET['logout'])){
	logout();
}
if(!isset($_SESSION['account'])){
	login();
}else { 
	bootstrap();
}

?>
