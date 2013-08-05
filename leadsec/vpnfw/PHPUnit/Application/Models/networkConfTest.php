<?php
//define('WEB_PATH', '/usr/local/webserver/nginx/html/PHPUnit/Lib/')
require 'Conf/global.php';
require WEB_PATH . '/Lib/driver/exception.php';
require WEB_PATH . '/Application/Models/networkConf.php';

class NetworkConfModelTest extends PHPUnit_Framework_TestCase {
    
    private $model;

    function setUp() {
        date_default_timezone_set('Asia/Chongqing');
        $this->model = new NetworkConfModel();
    }

    function testSetDns() {
        // empty request param
        $_POST['dnssrv']  = '';
        $_POST['dnssrv2'] = '';
        $stub = $this->getMock('cli', array('run', 'setLog'));
        $stub->expects($this->any())
             ->method('setLog')
             ->with('将域名服务器IP置空')
             ->will($this->returnValue($stub));
        $stub->expects($this->any())
             ->method('run')
             ->with('dns unset');
        $this->model->setCli($stub);
        $this->model->setDns();

        // correct
        $_POST['dnssrv']  = '1.1.1.1';
        $_POST['dnssrv2'] = '2.2.2.2';
        $stub = $this->getMock('cli', array('run', 'setLog'));
        $stub->expects($this->any())
             ->method('run')
             ->with('dns set ip 1.1.1.1 2.2.2.2');

        $stub->expects($this->any())
             ->method('setLog')
             ->with('设置域名服务器IP')
             ->will($this->returnValue($stub));

        $this->model->setCli($stub);
        $this->model->setDns();

        // exception
        $_SESSION = array('account' => 'admin', 'roles' => array('super'));
        $stub = $this->getMock('cli', array('setLog', 'exec'));
        $stub->expects($this->any())
             ->method('setLog')
             ->with('设置域名服务器IP')
             ->will($this->returnValue($stub));
        $stub->expects($this->any())
             ->method('exec')
             ->will($this->returnValue(array('1', array('error'))));
        $this->model->setCli($stub);
        $this->setExpectedException('ExecCmdException');
        $this->model->setDns();
    }
}
?>
