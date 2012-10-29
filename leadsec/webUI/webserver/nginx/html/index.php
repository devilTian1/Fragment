<?php
@session_start();
// Load Common Function
require_once('Function/common.php');

if (isset($_GET['logout']) && $_GET['logout'] === '1') {
	logout();
}

if (!isset($_SESSION['account'])) {
	login();
} else { 
	bootstrap();
}

?>
