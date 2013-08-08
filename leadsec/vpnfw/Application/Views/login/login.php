<?php
    class loginView extends commonView {
   
        private function showHomePage() {
            $headerNav = array(
                '0' => array('id'   => 'homepage',   'img' => 'top_icon_1.png',
                             'name' => '首页'),
                '1' => array('id'   => 'fastconf',   'img' => 'top_icon_3.png',
                             'name' => '快捷配置'),
                '2' => array('id'   => 'save',       'img' => 'top_icon_4.png',
                             'name' => '保存配置'),
                '3' => array('id'   => 'exportconf', 'img' => 'top_icon_14.png',
                             'name' => '导出配置'),
                '4' => array('id'   => 'exportlog',  'img' => 'top_icon_8.png',
                             'name' => '导出日志'),
                '5' => array('id'   => 'refresh',    'img' => 'top_icon_6.png',
                             'name' => '刷新'),
                '6' => array('id'   => 'first',      'img' => 'top_icon_9.png',
                             'name' => '上一步'),
                '7' => array('id'   => 'next',       'img' => 'top_icon_10.png',
                             'name' => '下一步')
            );
            $hostStatus = $this->model->hostStatus === 'I' ? '内网' : '外网';
            // generate smarty instance
            V::getInstance()->assign('headerNav', $headerNav)
                            ->assign('leftmenu', $this->model->leftmenu)
                            ->assign('hostStatus', $hostStatus)
                            ->assign('loginname', $_SESSION['account'])
                            ->display('index.tpl');
        }

        public function showLoginPage() {
            if (isset($this->model->isValidUser) &&
                true === $this->model->isValidUser) {
                $this->showHomePage();
            } else {
                $notation = array(
                    'langZh'    => _('Chinese'),  'langUs'   => _('English'),
                    'account'   => _('Account'),  'passwd'   => _('Password'),
                    'submitBtn' => _('confirm'),  'resetBtn' => _('cancel'),
                    'userReq' => _('User Required'),
                    'pwdReq'  => _('Password Required'),
                    'welcome' => sprintf(_('Welcome to use %s'), PRODUCT_NAME)
                );
                V::getInstance()->assign('n',            $notation)
                                ->assign('errMsg', $this->model->getErrMsg())
                                ->display('login/login.tpl');
            }
        }
    }
?>
