<?php
    class LoginController extends commonController {
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }

        public function index() {
            $model = $this->getModel();
            $view  = $this->getView();
            $view->showLoginPage();
        }

        public function login() {
            $model = $this->getModel();
            $view  = $this->getView();
            $model->login();
            $view->showLoginPage();
        }
    }
?>
