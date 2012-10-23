<?php
// Load Common Function
require_once('Function/common.php');
$account = $_POST['account'];
$passwd  = $_POST['passwd'];
if (isset($account) && isset($passwd)) {
    bootstrap();
} else {
    login();
}

?>
