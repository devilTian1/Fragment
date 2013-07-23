<?php
    require_once WEB_PATH . '/Application/Controllers/common.php';

    class LoginController extends commonController {
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }

        public function index() {
            $model = $this->getModel('login');
            $view  = $this->getView('login');
            $view->showLoginPage();
        }

        public function login() {
            $model = $this->getModel('login');
            $view  = $this->getView('login');
            $model->login();
            $view->showLoginPage();
        }
    }
?>
