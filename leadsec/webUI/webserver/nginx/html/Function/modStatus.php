<?php

require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

if (!empty($_GET['getModStatus'])) {
    $result = getCurModStat(array(1 => $_GET['l1'], 2 => $_GET['l2']));
    echo json_encode(array('active' => $result['active'],
                           'serv'   => $result['serv']));
} else if (!empty($_GET['switchModStat'])) {
    $serv   = $_GET['serv'];
    $active = $_GET['active'];
    if ($active === 'start') {
        $statC = '启动';
    } else {
        $statC = '关闭';
    }
    if($serv === 'http_status' && $active === 'start') {
        $active = "_start.sh";
    } else if($serv === 'http_status' && $active === 'stop') {
        $active = " stop";
    }
    $map = array('ctcp_status' => array('cli' => "ctcpctl $active",
                                        'log' => '定制访问(tcp)服务' . $statC),
                 'cudp_status' => array('cli' => "cudpctl $active",
                                        'log' => '定制访问(udp)服务' . $statC),
                 'tcp'         => array('cli' => "ctcpctl $active",
                                        'log' => '定制访问(tcp)服务' . $statC),
                 'udp'         => array('cli' => "cudpctl $active",
                                        'log' => '定制访问(udp)服务' . $statC),
                 'sync_status' => array('cli' => "fsctl $active",
                                        'log' => '文件交换服务' . $statC),
    		     'pop3_status' => array('cli' => "pop3ctl $active",
    				                    'log' => '邮件访问(pop3)' . $statC),
    		     'smtp_status' => array('cli' => "smtpctl $active",
    				                    'log' => '邮件访问(SMTP)' . $statC),
    		     'db_swap_status' => array('cli' => "dbswapctl $active",
                                        'log' => '数据库同步(db_swap_status)' . $statC),
				 'fs_new_status' => array('cli' => "fs2ctl $active",
                                        'log' => '文件同步(db_swap_status)' . $statC),
    			 'db_status'            => array('cli' => "dbctl $active",
                                        'log' => '数据库访问(db_status)' . $statC),
				 'sync_msg_status' => array('cli' => "msgctl $active",
                                        'log' => '消息传输(sync_msg_status)' . $statC),
    			 'ftp_status'            => array('cli' => "cftpctl $active",
                                        'log' => 'FTP访问(ftp_status)' . $statC),
                 'http_status' => array('cli' => "httpctl{$active}",'log' => '安全浏览服务'. $statC),
                 'status' => array('cli' => "fpctl $active",'log' => '安全通道服务'. $statC)
    );
    $cli = new cli();
    $cli->setLog($map[$serv]['log'])->run($map[$serv]['cli']);
    echo json_encode(array('status' => 0));
}
?>
