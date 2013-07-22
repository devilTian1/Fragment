<?php
    session_start();
    class LoginController extends commonController {
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }

        public function index() {
            $this->view->showLoginPage();
        }

        public function login() {
            $this->model->login();
            $this->view->showLoginPage();
        }
    }
?>
