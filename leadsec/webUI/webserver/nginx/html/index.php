<?php
// Load Common Function
require_once('Function/common.php');
$pass = $_GET['pass'];
if (isset($pass) && $pass == true) {
    bootstrap();
} else {
    login();
}

?>
