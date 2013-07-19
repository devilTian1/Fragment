<?php
    session_start();
    class LoginController extends commonController {
        function __construct() {
        }

        function login() {
            var_dump($this);
            echo 'CCC';
        }
    }
?>
