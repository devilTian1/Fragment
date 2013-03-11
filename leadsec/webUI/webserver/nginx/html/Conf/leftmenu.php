<?php
  $leftmenuArr = array(
    // level 1
    'sm' => array('pid' => 0, 'name' => '系统管理', 'link' => 'systemManagement'),
    'nm' => array('pid' => 0, 'name' => '网络管理', 'link' => 'networkManagement'),
    'rc' => array('pid' => 0, 'name' => '资源配置', 'link' => 'resConf'),
    'c' => array('pid' => 0, 'name' => '客户端', 'link' => 'client'),
    's' => array('pid' => 0, 'name' => '服务端', 'link' => 'server'),
    'as' => array('pid' => 0, 'name' => '应用防护', 'link' => 'appS'),
    'stm' => array('pid' => 0, 'name' => '状态监控', 'link' => 'statMonitor'),
    'log' => array('pid' => 0, 'name' => '日志与报表', 'link' => 'log'),

    //level2 sysManage
    'sm_o' => array('pid' => 'sm', 'name' => '系统概览', 'link' => 'overview'),
    'sm_q' => array('pid' => 'sm', 'name' => '快捷配置', 'link' => 'quick'),
    'sm_c' => array('pid' => 'sm', 'name' => '系统配置', 'link' => 'conf'),
    'sm_a' => array('pid' => 'sm', 'name' => '管理员设置', 'link' => 'admin'),
    'sm_m' => array('pid' => 'sm', 'name' => '系统维护', 'link' => 'maintain'),

    //level2 netManage
    'nm_i' => array('pid' => 'nm', 'name' => '网络接口', 'link' => 'interface'),
    'nm_b' => array('pid' => 'nm', 'name' => '基本配置', 'link' => 'basic'),
    'nm_h' => array('pid' => 'nm', 'name' => '高可用性', 'link' => 'HA'),
    'nm_l' => array('pid' => 'nm', 'name' => '负载均衡', 'link' => 'lvs'),

    //level2 resConf
    'rc_a' => array('pid' => 'rc', 'name' => '地址', 'link' => 'addr'),
    'rc_t' => array('pid' => 'rc', 'name' => '时间', 'link' => 'time'),
    'rc_u' => array('pid' => 'rc', 'name' => '用户', 'link' => 'user'),
    'rc_fc' => array('pid' => 'rc', 'name' => '过滤配置', 'link' => 'filterConf'),
  	'rc_v' => array('pid' => 'rc', 'name' => '虚拟地址', 'link' => 'virtualAddr'),

    //levev2 client
    'c_fe' => array('pid' => 'c', 'name' => '文件交换', 'link' => 'fileEx'),
    'c_fs' => array('pid' => 'c', 'name' => '文件同步', 'link' => 'fileSync'),
    'c_d' => array('pid' => 'c', 'name' => '数据库同步','link' => 'dbSync'),
    'c_s' => array('pid' => 'c', 'name' => '安全浏览', 'link' => 'safeBrowse'),
    'c_f' => array('pid' => 'c', 'name' => 'FTP访问',  'link' => 'ftp'),
    'c_m' => array('pid' => 'c', 'name' => '邮件访问', 'link' => 'mail'),
    'c_db' => array('pid' => 'c', 'name' => '数据库访问','link' => 'db'),
    'c_c' => array('pid' => 'c', 'name' => '定制访问', 'link' => 'customized'),
    'c_sp' => array('pid' => 'c', 'name' => '安全通道', 'link' => 'safePass'),
    'c_mt' => array('pid' => 'c', 'name' => '消息传输', 'link' => 'msgTrans'),    

    //levev2 server
    's_fe' => array('pid' => 's', 'name' => '文件交换', 'link' => 'fileEx'),
    's_fs' => array('pid' => 's', 'name' => '文件同步', 'link' => 'fileSync'),
    's_d' => array('pid' => 's', 'name' => '数据库同步','link' => 'dbSync'),
    's_s' => array('pid' => 's', 'name' => '安全浏览', 'link' => 'safeBrowse'),
    's_f' => array('pid' => 's', 'name' => 'FTP访问', 'link' => 'ftp'),
    's_m' => array('pid' => 's', 'name' => '邮件访问', 'link' => 'mail'),
    's_db' => array('pid' => 's', 'name' => '数据库访问','link' => 'db'),
    's_c' => array('pid' => 's', 'name' => '定制访问', 'link' => 'customized'),
    's_sp' => array('pid' => 's', 'name' => '安全通道', 'link' => 'safePass'),
    's_mt' => array('pid' => 's', 'name' => '消息传输', 'link' => 'msgTrans'),    

    //level2 appS
    'as_v' => array('pid' => 'as', 'name' => '病毒防护', 'link' => 'virusProtection'),
    'as_i' => array('pid' => 'as', 'name' => '入侵防护', 'link' => 'ips'),
    'as_a' => array('pid' => 'as', 'name' => '地址绑定', 'link' => 'addrBind'),

    //level2 statMonitor
    'stm_r' => array('pid' => 'stm', 'name' => '资源状态', 'link' => 'res'),
    'stm_n' => array('pid' => 'stm', 'name' => '网络状态', 'link' => 'network'),
    'stm_u' => array('pid' => 'stm', 'name' => '用户状态', 'link' => 'user'),
    'stm_t' => array('pid' => 'stm', 'name' => '网络测试', 'link' => 'test'),

    //level2 log
    'log_c' => array('pid' => 'log', 'name' => '日志配置', 'link' => 'conf'),
    'log_v' => array('pid' => 'log', 'name' => '日志访问', 'link' => 'view'),

    //level3 systemManagement/conf
    'sm_c_t' => array('pid' => 'sm_c', 'name' => '日期时间', 'link' => 'time', 'title' => ''),
    'sm_c_p' => array('pid' => 'sm_c', 'name' => '系统参数', 'link' => 'params', 'title' => ''),
    'sm_c_f' => array('pid' => 'sm_c', 'name' => '服务状态', 'link' => 'service', 'title' => ''),
    'sm_c_s' => array('pid' => 'sm_c', 'name' => '集中管理', 'link' => 'snmp', 'title' => ''),

    //level3 systemManagement/admin
    'sm_a_a' => array('pid' => 'sm_a', 'name' => '管理员帐号', 'link' => 'account', 'title' => ''),
    'sm_a_h' => array('pid' => 'sm_a', 'name' => '管理主机', 'link' => 'host', 'title' => ''),
    'sm_a_c' => array('pid' => 'sm_a', 'name' => '管理证书', 'link' => 'cert', 'title' => 'something'),
    'sm_a_m' => array('pid' => 'sm_a', 'name' => '管理方式', 'link' => 'mode', 'title' => ''),

    //level3 systemManagement/maintain
    'sm_m_u' => array('pid' => 'sm_m', 'name' => '系统更新', 'link' => 'upgrade'),
    'sm_m_br' => array('pid' => 'sm_m', 'name' => '备份与恢复', 'link' => 'backupAndRecovery'),
    'sm_m_l' => array('pid' => 'sm_m', 'name' => '许可证管理', 'link' => 'license'),
    'sm_m_b' => array('pid' => 'sm_m', 'name' => '批处理工具', 'link' => 'batchTool'),

    //level3 networkManagement/interface
    'nm_i_p' => array('pid' => 'nm_i', 'name' => '物理设备', 'link' => 'physical'),
    'nm_i_a' => array('pid' => 'nm_i', 'name' => '别名设备', 'link' => 'alias'),
    'nm_i_r' => array('pid' => 'nm_i', 'name' => '冗余设备', 'link' => 'redundance'),

    //level3 networkManagement/basic
    'nm_b_d' => array('pid' => 'nm_b', 'name' => '域名服务器', 'link' => 'dns'),
    'nm_b_s' => array('pid' => 'nm_b', 'name' => '静态路由', 'link' => 'staticRoute'),

    //level3 networkManagement/HA
    'nm_h_v' => array('pid' => 'nm_h', 'name' => '虚拟地址', 'link' => 'viraddr'),
    'nm_h_h' => array('pid' => 'nm_h', 'name' => '双机热备', 'link' => 'ha'),
    'nm_h_l' => array('pid' => 'nm_h', 'name' => '负载均衡', 'link' => 'lvs'),

    //level3 networkManagement/lvs
    'nm_l_b' => array('pid' => 'nm_l', 'name' => '基本配置', 'link' => 'basic'),
    'nm_l_v' => array('pid' => 'nm_l', 'name' => '虚拟地址', 'link' => 'virtualAddr'),
    'nm_l_s' => array('pid' => 'nm_l', 'name' => '调度器配置', 'link' => 'schedule'),
    
    //level3 resConf/addr
    'rc_a_a' => array('pid' => 'rc_a', 'name' => '地址列表', 'link' => 'addrList'),
    'rc_a_ag' => array('pid' => 'rc_a', 'name' => '地址组',  'link' => 'addrGroup'),
    'rc_a_r' => array('pid' => 'rc_a', 'name' => '域名地址', 'link' => 'realmAddr'),
    
    //level3 resConf/time
    'rc_t_t' => array('pid' => 'rc_t', 'name' => '时间列表', 'link' => 'timeList'),
    'rc_t_tm' => array('pid' => 'rc_t', 'name' => '时间组', 'link' => 'timeGroup'),
    
    //level3 resConf/user
    'rc_u_u' => array('pid' => 'rc_u', 'name' => '用户列表', 'link' => 'userList'),
    'rc_u_rl' => array('pid' => 'rc_u', 'name' => '角色列表', 'link' => 'roleList'),
    
    //level3 resConf/filterConf
    'rc_fc_s' => array('pid' => 'rc_fc', 'name' => '安全浏览', 'link' => 'safeBrowse'),
    'rc_fc_fe' => array('pid' => 'rc_fc', 'name' => '文件交换', 'link' => 'fileExchange'),
    'rc_fc_fv' => array('pid' => 'rc_fc', 'name' => 'FTP访问', 'link' => 'ftp'),
    'rc_fc_e' => array('pid' => 'rc_fc', 'name' => '邮件访问', 'link' => 'emailVisit'),
    'rc_fc_d' => array('pid' => 'rc_fc', 'name' => '数据库访问', 'link' => 'dataVisit'),
    'rc_fc_m' => array('pid' => 'rc_fc', 'name' => '消息传递', 'link' => 'msgPass'),
    
  	//levev3 client/fileEx
  	'c_fe_st' => array('pid' => 'c_fe', 'name' => '发送任务', 'link' => 'sendTask'),
  	'c_fe_af' => array('pid' => 'c_fe', 'name' => '文件名控制', 'link' => 'allowedFile'),
  	'c_fe_bc' => array('pid' => 'c_fe', 'name' => '内容黑名单', 'link' => 'bannedContent'),
  	'c_fe_ac' => array('pid' => 'c_fe', 'name' => '内容白名单', 'link' => 'allowedContent'),
  	'c_fe_fpc' => array('pid' => 'c_fe', 'name' => '文件属性控制', 'link' => 'filter'),
  	'c_fe_task' => array('pid' => 'c_fe', 'name' => '共享目录', 'link' => 'shareDir'),
    
  	//levev3 client/fileSync
  	'c_fs_fe' => array('pid' => 'c_fs', 'name' => '文件同步', 'link' => 'fileSync'),

    //levev3 client/safeBrowse
    'c_s_bc' => array('pid' => 'c_s', 'name' => '基本配置', 'link' => 'basicConfig'),
    'c_s_t' => array('pid' => 'c_s', 'name' => '透明访问控制', 'link' => 'transVisit'),
    'c_s_g' => array('pid' => 'c_s', 'name' => '普通访问控制', 'link' => 'generalVisit'),
  	'c_s_ua' => array('pid' => 'c_s', 'name' => '用户认证方式', 'link' => 'usrAuthen'),
  	'c_s_um' => array('pid' => 'c_s', 'name' => '本地用户管理', 'link' => 'localUsrManage'),
  	'c_s_fc' => array('pid' => 'c_s', 'name' => '过滤配置', 'link' => 'filterGl'),
  	'c_s_url' => array('pid' => 'c_s', 'name' => 'URL过滤', 'link' => 'urlFilter'),
  	'c_s_pf' => array('pid' => 'c_s', 'name' => '文件名过滤', 'link' => 'postfixFilter'),
  	'c_s_kf' => array('pid' => 'c_s', 'name' => '关键字过滤', 'link' => 'keywordFilter'),
    
    //levev3 client/ftp
    'c_f_t' => array('pid' => 'c_f', 'name' => '透明访问',  'link' => 'transVisit'),
    'c_f_g' => array('pid' => 'c_f', 'name' => '普通访问',  'link' => 'generalVisit'),
  	'c_f_gl'=> array('pid' => 'c_f', 'name' => '过滤配置',  'link' => 'filterGl'),
    
    //levev3 client/mail
    'c_m_pgv' => array('pid' => 'c_m', 'name' => 'POP3普通访问', 'link' => 'pop3GeneralVisit'),
    'c_m_ptv' => array('pid' => 'c_m', 'name' => 'POP3透明访问', 'link' => 'pop3TransVisit'),
    'c_m_sgv' => array('pid' => 'c_m', 'name' => 'SMTP普通访问', 'link' => 'smtpGeneralVisit'),
    'c_m_stv' => array('pid' => 'c_m', 'name' => 'SMTP透明访问', 'link' => 'smtpTransVisit'),
  	'c_m_ma'=> array('pid' => 'c_m', 'name' => '邮件地址',  'link' => 'mailAddr'),
  	'c_m_k'=> array('pid' => 'c_m', 'name' => '内容关键字',  'link' => 'keyword'),
  	'c_m_ae'=> array('pid' => 'c_m', 'name' => '附件扩展名',  'link' => 'attachExt'),
  	'c_m_f'=> array('pid' => 'c_m', 'name' => '过滤选项集',  'link' => 'filter'),
    
    //levev3 client/db
    'c_db_t' => array('pid' => 'c_db', 'name' => '透明访问','link' => 'transVisit'),
    'c_db_g' => array('pid' => 'c_db', 'name' => '普通访问','link' => 'generalVisit'),  	
    
    //levev3 client/customized
    'c_c_tt' => array('pid' => 'c_c', 'name' => 'TCP透明访问', 'link' => 'tcpTransVisit'),
    'c_c_tg' => array('pid' => 'c_c', 'name' => 'TCP普通访问', 'link' => 'tcpGeneralVisit'),
    'c_c_ut' => array('pid' => 'c_c', 'name' => 'UDP透明访问', 'link' => 'udpTransVisit'),
    'c_c_ug' => array('pid' => 'c_c', 'name' => 'UDP普通访问', 'link' => 'udpGeneralVisit'),
    
  	//levev3 client/msgTrans
  	'c_mt_mt' => array('pid' => 'c_mt', 'name' => '消息传输', 'link' => 'msgTrans'),
    'c_mt_af' => array('pid' => 'c_mt', 'name' => '文件名控制', 'link' => 'callowedFile'),
  	'c_mt_bc' => array('pid' => 'c_mt', 'name' => '内容黑名单', 'link' => 'cbannedContent'),
  	'c_mt_ac' => array('pid' => 'c_mt', 'name' => '内容白名单', 'link' => 'callowedContent'),	
    'c_mt_lu' => array('pid' => 'c_mt', 'name' => '本地用户认证', 'link' => 'localUserAuthen'),
  	'c_mt_up' => array('pid' => 'c_mt', 'name' => '用户权限', 'link' => 'userPrivilege'),	
  
  	//levev3 server/fileEx
  	's_fe_rt' => array('pid' => 's_fe', 'name' => '接受任务', 'link' => 'receiveTask'),
  
  	//levev3 server/fileSync
  	's_fs_fe' => array('pid' => 's_fs', 'name' => '文件同步', 'link' => 'fileSync'),

    //levev3 server/safeBrowse
  	's_s_gl' => array('pid' => 's_s', 'name' => '服务管理', 'link' => 'serviceManage'),
  
  	//levev3 server/ftp
    's_f_f' => array('pid' => 's_f', 'name' => '普通访问',  'link' => 'generalVisit'),
    
    //levev3 server/mail
    's_m_p' => array('pid' => 's_m', 'name' => 'POP3访问', 'link' => 'pop3'),
    's_m_s' => array('pid' => 's_m', 'name' => 'SMTP访问', 'link' => 'smtp'),
    
    //levev3 server/db
    's_db_d' => array('pid' => 's_db', 'name' => '数据库访问','link' => 'db'),
    
    //levev3 server/customized
    's_c_t' => array('pid' => 's_c', 'name' => 'TCP访问', 'link' => 'tcp'),
    's_c_u' => array('pid' => 's_c', 'name' => 'UDP访问', 'link' => 'udp'),
    
  	//levev3 client/msgTrans
  	's_mt_mt' => array('pid' => 's_mt', 'name' => '消息传输', 'link' => 'msgTrans'),
  
    //level3 appS/ips
    'as_v_v' => array('pid' => 'as_v', 'name' => '病毒库升级', 'link' => 'virusUpgrade'),
    
    //level3 appS/ips
    'as_i_c' => array('pid' => 'as_i', 'name' => '基本配置', 'link' => 'conf'),
    'as_i_p' => array('pid' => 'as_i', 'name' => '策略配置', 'link' => 'policy'),
    'as_i_ct' => array('pid' => 'as_i', 'name' => '自定义检测', 'link' => 'customTest'),
    'as_i_s' => array('pid' => 'as_i', 'name' => '扫描检测配置', 'link' => 'scanConf'),
    'as_i_a' => array('pid' => 'as_i', 'name' => '自动响应配置', 'link' => 'autoConf'),
    'as_i_t' => array('pid' => 'as_i', 'name' => '检测结果', 'link' => 'testResult'),
    
    //level3 log/conf
    'log_c_s' => array('pid' => 'log_c', 'name' => '日志服务器', 'link' => 'server'),

    //level3 log/conf
    'log_v_l' => array('pid' => 'log_v', 'name' => '日志查看', 'link' => 'lookOver'),

  );
