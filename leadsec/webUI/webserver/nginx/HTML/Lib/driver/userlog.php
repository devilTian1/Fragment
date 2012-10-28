<?php
class Userlog {
	/**
	 * 记录用户操作日志
	 * @param unknown_type $time 操作时间
	 * @param unknown_type $user 操作管理员
	 * @param unknown_type $module 操作模块
	 * @param unknown_type $msg 信息描述
	 */
    public function __construct($time,$user,$module,$msg) {
    	//把数据存放在auth数据库中，新建一个userlog表中---有待进一步确定。
    }
}
?>
