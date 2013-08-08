<?php
    class LangController extends commonController {

        public function switchLang() {
            $model = $this->getModel('login/login');
            $view  = $this->getView('login/login');
            $model->login();
            $view->showLoginPage();
        }
    }
?>
