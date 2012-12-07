<?php
    $leftmenuArr = array(
        // level 1
        array('pid' => 0,  'name' => '系统管理',   'link' => 'systemManagement'),//menu id = 1
        array('pid' => 0,  'name' => '网络管理',   'link' => 'networkMangement'),//2
        array('pid' => 0,  'name' => '资源配置',   'link' => 'resConf'),//3
        array('pid' => 0,  'name' => '客户端',     'link' => 'client'),//4
        array('pid' => 0,  'name' => '服务端',     'link' => 'server'),//5
        array('pid' => 0,  'name' => '应用防护',   'link' => 'appS'),//6
        array('pid' => 0,  'name' => '状态监控',   'link' => 'statMonitor'),//7
        array('pid' => 0,  'name' => '日志与报表', 'link' => 'log'),//8

        //level2 sysManage
        array('pid' => 1,  'name' => '系统概览',   'link' => 'overview'),//9
        array('pid' => 1,  'name' => '快捷配置',   'link' => 'quick'),//10
        array('pid' => 1,  'name' => '系统配置',       'link' => 'conf'),//11
        array('pid' => 1,  'name' => '管理员设置', 'link' => 'admin'),//12
        array('pid' => 1,  'name' => '系统维护',       'link' => 'maintain'),//13

        //level2 netManage
        array('pid' => 2,  'name' => '网络接口', 'link' => 'interface'),//14
        array('pid' => 2,  'name' => '基本配置', 'link' => 'basic'),//15
        array('pid' => 2,  'name' => '高可用性', 'link' => 'HA'),//16

        //level2 resConf
        array('pid' => 3,  'name' => '地址',     'link' => 'addr'),//17
        array('pid' => 3,  'name' => '时间',     'link' => 'time'),//18
        array('pid' => 3,  'name' => '用户',     'link' => 'user'),//19
        array('pid' => 3,  'name' => '过滤配置', 'link' => 'addrBind'),//20

        //levev2 client
        array('pid' => 4,  'name' => '文件交换',  'link' => 'fileEx'),//21
        array('pid' => 4,  'name' => '数据库同步','link' => 'dbSync'),//22
        array('pid' => 4,  'name' => '安全浏览',  'link' => 'safeBrowse'),//23
        array('pid' => 4,  'name' => 'FTP访问',   'link' => 'ftp'),//24
        array('pid' => 4,  'name' => '邮件访问',  'link' => 'mail'),//25
        array('pid' => 4,  'name' => '数据库访问','link' => 'db'),//26
        array('pid' => 4,  'name' => '定制访问',  'link' => 'customized'),//27
        array('pid' => 4,  'name' => '安全通道',  'link' => 'safePass'),//28
        array('pid' => 4,  'name' => '消息传输',  'link' => 'msgTrans'),//29

        //levev2 server
        array('pid' => 5,  'name' => '文件交换',  'link' => 'fileEx'),//30
        array('pid' => 5,  'name' => '数据库同步','link' => 'dbSync'),//31
        array('pid' => 5,  'name' => '安全浏览',  'link' => 'safeBrowse'),//32
        array('pid' => 5,  'name' => 'FTP访问',   'link' => 'ftp'),//33
        array('pid' => 5,  'name' => '邮件访问',  'link' => 'mail'),//34
        array('pid' => 5,  'name' => '数据库访问','link' => 'db'),//35
        array('pid' => 5,  'name' => '定制访问',  'link' => 'customized'),//36
        array('pid' => 5,  'name' => '安全通道',  'link' => 'safePass'),//37
        array('pid' => 5,  'name' => '消息传输',  'link' => 'msgTrans'),//38

        //level2 appS
        array('pid' => 6, 'name' => '病毒防护', 'link' => 'virusProtection'),//39
        array('pid' => 6, 'name' => '入侵防护', 'link' => 'ips'),//40
        array('pid' => 6, 'name' => '地址绑定', 'link' => 'addrBind'),//41

        //level2  statMonitor
        array('pid' => 7, 'name' => '资源状态', 'link' => 'res'),//42
        array('pid' => 7, 'name' => '网络状态', 'link' => 'network'),//43
        array('pid' => 7, 'name' => '用户状态', 'link' => 'user'),//44
        array('pid' => 7, 'name' => '服务状态', 'link' => 'service'),//45
        array('pid' => 7, 'name' => '网络测试', 'link' => 'test'),//46

        //level2  log
        array('pid' => 8, 'name' => '日志配置', 'link' => 'conf'),//47
        array('pid' => 8, 'name' => '日志访问', 'link' => 'view'),//48

        array('pid' => 9,  'name' => '系统概览',   'link' => 'overview'),//9
        
        //level3  systemManagement/conf
        array('pid' => 11, 'name' => '日期时间', 'link' => 'time', 'title' => ''),//49
        array('pid' => 11, 'name' => '系统参数', 'link' => 'params', 'title' => ''),//50
        array('pid' => 11, 'name' => '集中管理', 'link' => 'snmp', 'title' => ''),//51

        //level3 systemManagement/admin
        array('pid' => 12, 'name' => '管理员帐号', 'link' => 'account', 'title' => ''),//52
        array('pid' => 12, 'name' => '管理主机',   'link' => 'host', 'title' => ''),//53
        array('pid' => 12, 'name' => '管理证书',   'link' => 'cert', 'title' => 'something'),//54
        array('pid' => 12, 'name' => '管理方式',   'link' => 'mode', 'title' => ''),//55

        //level3 systemManagement/maintain
        array('pid' => 13, 'name' => '系统更新',   'link' => 'upgrade'),//56
        array('pid' => 13, 'name' => '备份与恢复', 'link' => 'backupAndRecovery'),//57
        array('pid' => 13, 'name' => '许可证管理', 'link' => 'license'),//58
        array('pid' => 13, 'name' => '生产',       'link' => 'manufacture'),//59
        array('pid' => 13, 'name' => '批处理工具', 'link' => 'batchTool'),//60

        //level3 networkManagement/interface
        array('pid' => 14, 'name' => '物理设备', 'link' => 'physical'),//61
        array('pid' => 14, 'name' => '别名设备', 'link' => 'alias'),//62
        array('pid' => 14, 'name' => '冗余设备', 'link' => 'redundance'),//63

        //level3 networkManagement/basic
        array('pid' => 15, 'name' => '域名服务器', 'link' => 'dns'),//64
        array('pid' => 15, 'name' => '静态路由',   'link' => 'staticRoute'),//65

        //level3 networkManagement/HA
        array('pid' => 16, 'name' => '双机热备', 'link' => 'ha'),//66
        array('pid' => 16, 'name' => '负载均衡', 'link' => 'lvs'),//67
        
        //level3 resConf
        array('pid' => 17,  'name' => '地址列表', 'link' => 'addrList'),//17
        array('pid' => 17,  'name' => '地址组',   'link' => 'addrGroup'),//18
        array('pid' => 17,  'name' => '域名地址', 'link' => 'realmAddr'),//19
        
        array('pid' => 18,  'name' => '时间列表',     'link' => 'timeList'),//18
        array('pid' => 18,  'name' => '时间组',     'link' => 'timeGroup'),//18
        
        array('pid' => 19,  'name' => '用户列表',     'link' => 'userList'),//19
        array('pid' => 19,  'name' => '用户组',     'link' => 'userGroup'),//19
        
        array('pid' => 20,  'name' => '安全浏览', 'link' => 'safeBrowse'),//20
        array('pid' => 20,  'name' => '文件同步', 'link' => 'fileSyn'),//20
        array('pid' => 20,  'name' => '文件交换', 'link' => 'fileExchange'),//20
        array('pid' => 20,  'name' => 'FTP访问', 'link' => 'ftpVisit'),//20
        array('pid' => 20,  'name' => '邮件访问', 'link' => 'emailVisit'),//20
        array('pid' => 20,  'name' => '数据库访问', 'link' => 'dataVisit'),//20
        array('pid' => 20,  'name' => '消息传递', 'link' => 'msgPass'),//20
        
        
        //levev3 client
        array('pid' => 21,  'name' => '文件交换',  'link' => 'fileEx'),//
        array('pid' => 22,  'name' => '数据库同步','link' => 'dbSync'),//
        
        array('pid' => 23,  'name' => '透明访问',  'link' => 'transVisit'),//
        array('pid' => 23,  'name' => '普通访问',  'link' => 'generalVisit'),//
        
        array('pid' => 24,  'name' => '透明访问',   'link' => 'transVisit'),//
        array('pid' => 24,  'name' => '普通访问',   'link' => 'generalVisit'),//
        
        array('pid' => 25,  'name' => 'SMTP访问',  'link' => 'smtpVisit'),//
        array('pid' => 25,  'name' => 'POP3访问',  'link' => 'pop3Visit'),//
        
        array('pid' => 26,  'name' => '透明访问','link' => 'transVisit'),//
        array('pid' => 26,  'name' => '普通访问','link' => 'generalVisit'),//
        
        array('pid' => 27,  'name' => 'TCP透明访问',  'link' => 'tcpTransVisit'),//
        array('pid' => 27,  'name' => 'TCP普通访问',  'link' => 'tcpGeneralVisit'),//
        array('pid' => 27,  'name' => 'UDP透明访问',  'link' => 'udpTransVisit'),//
        array('pid' => 27,  'name' => 'UDP普通访问',  'link' => 'udpGeneralVisit'),//
        
        array('pid' => 28,  'name' => '安全通道',  'link' => 'safePass'),//
        array('pid' => 29,  'name' => '消息传输',  'link' => 'msgTrans'),//
        
        
        //levev3 server
        array('pid' => 30,  'name' => '文件交换',  'link' => 'fileEx'),//30
        array('pid' => 31,  'name' => '数据库同步','link' => 'dbSync'),//31
        array('pid' => 32,  'name' => '安全浏览',  'link' => 'safeBrowse'),//32
        array('pid' => 33,  'name' => 'FTP访问',   'link' => 'ftp'),//33
        
        array('pid' => 34,  'name' => 'SMTP访问',  'link' => 'smtpMail'),//34
        array('pid' => 34,  'name' => 'POP3访问',  'link' => 'pop3Mail'),//34
        
        array('pid' => 35,  'name' => '数据库访问','link' => 'db'),//35
        
        array('pid' => 36,  'name' => 'TCP访问',  'link' => 'tcpCustomized'),//36
        array('pid' => 36,  'name' => 'UDP访问',  'link' => 'udpCustomized'),//36
        
        array('pid' => 37,  'name' => '安全通道',  'link' => 'safePass'),//37
        array('pid' => 38,  'name' => '消息传输',  'link' => 'msgTrans'),//38
        
        array('pid' => 39, 'name' => '病毒库升级', 'link' => 'virusUpgrade'),//39
        
        //level3  appS/ips
        array('pid' => 40, 'name' => '基本配置',     'link' => 'conf'),//67
        array('pid' => 40, 'name' => '策略配置',     'link' => 'policy'),//68
        array('pid' => 40, 'name' => '自定义检测',   'link' => 'customTest'),//69
        array('pid' => 40, 'name' => '扫描检测配置', 'link' => 'scanConf'),//70
        array('pid' => 40, 'name' => '自动响应配置', 'link' => 'autoConf'),//71
        array('pid' => 40, 'name' => '检测结果',     'link' => 'testResult'),//72
        
        //level3  appS/addrBind
        array('pid' => 41, 'name' => '地址绑定', 'link' => 'addrBind'),//41
        
        //level3  statMonitor
        array('pid' => 42, 'name' => '资源状态', 'link' => 'res'),//42
        array('pid' => 43, 'name' => '网络状态', 'link' => 'network'),//43
        array('pid' => 44, 'name' => '用户状态', 'link' => 'user'),//44
        array('pid' => 45, 'name' => '服务状态', 'link' => 'service'),//45
        array('pid' => 46, 'name' => '网络测试', 'link' => 'test'),//46
        
        //level3 log/conf
        array('pid' => 47, 'name' => '日志服务器', 'link' => 'server'),//73

        //level3 log/conf
        array('pid' => 48, 'name' => '日志查看', 'link' => 'lookOver'),//74
    );
