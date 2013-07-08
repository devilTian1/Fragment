<?php
abstract class Log {
    protected $time;

    protected $msg;
	/**
	 * 操作日志
	 * @param string. timestamp $time 操作时间
	 * @param String. $msg 信息描述
	 */
    protected function __construct($time, $msg) {
        $this->add($time, $msg);
    }

    public function add($time, $msg) {
        $this->time = $time;
        $this->msg  = $msg;
    }

    abstract protected function record();
}
?>
