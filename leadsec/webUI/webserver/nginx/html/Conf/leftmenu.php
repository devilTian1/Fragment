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
        array('pid' => 1,  'name' => '配置',       'link' => 'conf'),//11
        array('pid' => 1,  'name' => '管理员设置', 'link' => 'admin'),//12
        array('pid' => 1,  'name' => '维护',       'link' => 'maintain'),//13

        //level2 netManage
        array('pid' => 2,  'name' => '网络接口', 'link' => '#'),//14
        array('pid' => 2,  'name' => '基本配置', 'link' => '#'),//15
        array('pid' => 2,  'name' => '高可用性', 'link' => '#'),//16

        //level2 resConf
        array('pid' => 3,  'name' => '地址',     'link' => '#'),//17
        array('pid' => 3,  'name' => '时间',     'link' => '#'),//18
        array('pid' => 3,  'name' => '用户',     'link' => '#'),//19
        array('pid' => 3,  'name' => '过滤配置', 'link' => '#'),//20

        //levev2 client
        array('pid' => 4,  'name' => '文件交换',  'link' => '#'),//21
        array('pid' => 4,  'name' => '数据库同步','link' => '#'),//22
        array('pid' => 4,  'name' => '安全浏览',  'link' => '#'),//23
        array('pid' => 4,  'name' => 'FTP访问',   'link' => '#'),//24
        array('pid' => 4,  'name' => '邮件访问',  'link' => '#'),//25
        array('pid' => 4,  'name' => '数据库访问','link' => '#'),//26
        array('pid' => 4,  'name' => '定制访问',  'link' => '#'),//27
        array('pid' => 4,  'name' => '安全通道',  'link' => '#'),//28
        array('pid' => 4,  'name' => '消息传输',  'link' => '#'),//29

        //levev2 server
        array('pid' => 5,  'name' => '文件交换',  'link' => '#'),//21
        array('pid' => 5,  'name' => '数据库同步','link' => '#'),//22
        array('pid' => 5,  'name' => '安全浏览',  'link' => '#'),//23
        array('pid' => 5,  'name' => 'FTP访问',   'link' => '#'),//24
        array('pid' => 5,  'name' => '邮件访问',  'link' => '#'),//25
        array('pid' => 5,  'name' => '数据库访问','link' => '#'),//26
        array('pid' => 5,  'name' => '定制访问',  'link' => '#'),//27
        array('pid' => 5,  'name' => '安全通道',  'link' => '#'),//28
        array('pid' => 5,  'name' => '消息传输',  'link' => '#'),//29

        //level2 appS
        array('pid' => 6, 'name' => '病毒防护', 'link' => '#'),//30
        array('pid' => 6, 'name' => '入侵防护', 'link' => '#'),//31
        array('pid' => 6, 'name' => '地址绑定', 'link' => '#'),//32

        //level2  statMonitor
        array('pid' => 7, 'name' => '资源状态', 'link' => '#'),//33
        array('pid' => 7, 'name' => '网络状态', 'link' => '#'),//34
        array('pid' => 7, 'name' => '用户状态', 'link' => '#'),//35
        array('pid' => 7, 'name' => '服务状态', 'link' => '#'),//36
        array('pid' => 7, 'name' => '网络测试', 'link' => '#'),//37

        //level2  log
        array('pid' => 8, 'name' => '日志配置', 'link' => '#'),//38
        array('pid' => 8, 'name' => '日志访问', 'link' => '#'),//39

        //level3  systemManagement/conf
        array('pid' => 11, 'name' => '日期时间', 'link' => '#', 'title' => ''),//40
        array('pid' => 11, 'name' => '系统参数', 'link' => '#', 'title' => ''),//41
        array('pid' => 11, 'name' => '集中管理', 'link' => '#', 'title' => ''),//42

        //level3 systemManagement/admin
        array('pid' => 12, 'name' => '管理员帐号', 'link' => 'account'),//43
        array('pid' => 12, 'name' => '管理主机',   'link' => 'host'),//44
        array('pid' => 12, 'name' => '管理证书',   'link' => 'cert'),//45
        array('pid' => 12, 'name' => '管理方式',   'link' => 'mode'),//46

        //level3 systemManagement/maintain
        array('pid' => 13, 'name' => '系统更新',   'link' => '#'),//47
        array('pid' => 13, 'name' => '备份与恢复', 'link' => '#'),//48
        array('pid' => 13, 'name' => '许可证管理', 'link' => '#'),//49
        array('pid' => 13, 'name' => '批处理工具', 'link' => '#'),//50

        //level3 networkManagement/interface
        array('pid' => 14, 'name' => '物理设备', 'link' => '#'),//51
        array('pid' => 14, 'name' => '别名设备', 'link' => '#'),//52
        array('pid' => 14, 'name' => '冗余设备', 'link' => '#'),//53

        //level3 networkManagement/basic
        array('pid' => 15, 'name' => '域名服务器', 'link' => '#'),//54
        array('pid' => 15, 'name' => '静态路由',   'link' => '#'),//55

        //level3 networkManagement/HA
        array('pid' => 16, 'name' => '双击热备', 'link' => '#'),//56
        array('pid' => 16, 'name' => '负载均衡', 'link' => '#'),//57
        
        //level3  appS/ips
        array('pid' => 31, 'name' => '基本配置',     'link' => '#'),//58
        array('pid' => 31, 'name' => '策略配置',     'link' => '#'),//59
        array('pid' => 31, 'name' => '自定义检测',   'link' => '#'),//60
        array('pid' => 31, 'name' => '扫描检测配置', 'link' => '#'),//61
        array('pid' => 31, 'name' => '自动响应配置', 'link' => '#'),//62
        array('pid' => 31, 'name' => '检测结果',     'link' => '#'),//63
        
        //level3 log/conf
        array('pid' => 38, 'name' => '日志服务器', 'link' => '#'),//64

        //level3 log/conf
        array('pid' => 39, 'name' => '日志访问', 'link' => '#'),//65
    );
