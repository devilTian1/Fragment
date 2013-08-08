<?php
	$leftmenuArr = array(
		//level 1
    'stm' => array('pid' => 0, 'name' => '状态监控', 'link' => 'statusMonitor'),
    'sm' => array('pid' => 0, 'name' => '系统管理', 'link' => 'systemManagement'),
	'ua' => array('pid'=>0, 'name'=>'用户认证','link'=>'userAuthentication'),
	'sv' => array('pid'=>0,'name'=>'SSLVPN','link'=>'SSLVPN'),
	'iv' => array('pid'=>0,'name'=>'IPSECVPN','link'=>'IPSECVPN'),
	'vp' => array('pid'=>0,'name'=>'VPDN','link'=>'VPDN'),
	'fw' => array('pid'=>0,'name'=>'防火墙','link'=>'firewall'),
	'ha' => array('pid'=>0,'name'=>'高可用性','link'=>'highAvailability'),
	'la' => array('pid'=>0,'name'=>'日志审计','link'=>'logAudit'),
		
	//level 2 statusMonitor
	'smt_s' => array('pid'=>'stm','name'=>'系统状态','link'=>'systemStatus'),
	'smt_o' => array('pid'=>'stm','name'=>'在线用户','link'=>'onlineUser'),
	'smt_t' => array('pid'=>'stm','name'=>'隧道状态','link'=>'tunnelStatus'),
	'smt_a' => array('pid'=>'stm','name'=>'告警日志','link'=>'alarmLog'),
	
	//level 3 statusMonitor/
	'smt_s_p' => array('pid' => 'smt_s', 'name' => '状态面板', 'link' => 'statusPanal'),
	'smt_o_o' => array('pid'=>'smt_o','name'=>'在线用户','link'=>'onlineUser'),
	'smt_t_t' => array('pid'=>'smt_t','name'=>'隧道状态','link'=>'tunnelStatus'),
	'smt_a_a' => array('pid'=>'smt_a','name'=>'告警日志','link'=>'alarmLog'),

	//level 2 systemManagement
	'sm_s' => array('pid'=>'sm','name'=>'系统设置','link'=>'systemConf'),
	'sm_n' => array('pid'=>'sm','name'=>'网络设置','link'=>'networkConf'),

	//level 2 userAuthentication
	'ua_m' => array('pid'=>'ua','name'=>'用户管理','link'=>'userManagement'),
	'ua_a' => array('pid'=>'ua','name'=>'认证管理','link'=>'authenManagement'),
	'ua_p' => array('pid'=>'ua','name'=>'PKI','link'=>'PKI'),
	'ua_s' => array('pid'=>'ua','name'=>'SAML','link'=>'SAML'),

	//level 3 userManagement
	'ua_m_l' => array('pid'=>'ua_m','name'=>'用户列表','link'=>'userList'),
	'ua_m_i' => array('pid'=>'ua_m','name'=>'用户导入导出','link'=>'importExport'),

	//level 3 authenManagement
	'ua_a_o' => array('pid'=>'ua_a','name'=>'认证顺序','link'=>'order'),
	'ua_a_l' => array('pid'=>'ua_a','name'=>'本地口令认证设置','link'=>'local'),
	'ua_a_r' => array('pid'=>'ua_a','name'=>'Radius','link'=>'Radius'),
	'ua_a_d' => array('pid'=>'ua_a','name'=>'LDAP','link'=>'LDAP'),
	'ua_a_s' => array('pid'=>'ua_a','name'=>'短信认证','link'=>'shortMessage'),
	'ua_a_p' => array('pid'=>'ua_a','name'=>'硬件特征码','link'=>'physicalNo.'),
	'ua_a_t' => array('pid'=>'ua_a','name'=>'动态令牌','link'=>'token'),

	//level 3 PKI
	'ua_p_c' => array('pid'=>'ua_p','name'=>'CA属性','link'=>'CA'),
	'ua_p_l' => array('pid'=>'ua_p','name'=>'本地CA','link'=>'localCA'),
	'ua_p_t' => array('pid'=>'ua_p','name'=>'第三方CA','link'=>'thirdCA'),

	//level 3 SAML
	'ua_s_b' => array('pid'=>'ua_s','name'=>'基本配置','link'=>'basicConf'),

	//level 2 SSLVPN
	'sv_s' => array('pid'=>'sv','name'=>'资源管理','link'=>'sourcesManagement'),
	'sv_r' => array('pid'=>'sv','name'=>'角色授权','link'=>'roleAuthorization'),
	'sv_p' => array('pid'=>'sv','name'=>'接入策略','link'=>'sslvpnPolicy'),
	'sv_v' => array('pid'=>'sv','name'=>'虚拟门户','link'=>'vartuaGateway'),
	'sv_w' => array('pid'=>'sv','name'=>'WAF','link'=>'WAF'),

	//level 3 SSLVPN/sourcesManagement
	'sv_s_a' => array('pid'=>'sv_s','name'=>'应用服务资源','link'=>'appSources'),
	'sv_s_n' => array('pid'=>'sv_s','name'=>'网段服务资源','link'=>'networkSources'),

	//level 4 appSources
	'sv_s_a_b' => array('pid'=>'sv_s_a','name'=>'B/S应用','link'=>'BSApp'),
	'sv_s_a_c' => array('pid'=>'sv_s_a','name'=>'C/S应用','link'=>'CSApp'),
	'sv_s_a_r' => array('pid'=>'sv_s_a','name'=>'远程应用','link'=>'remoteApp'),
	'sv_s_a_g' => array('pid'=>'sv_s_a','name'=>'资源组','link'=>'resGroup'),

	//level 4 networkSources
	'sv_s_n_n' => array('pid'=>'sv_s_n','name'=>'网段应用','link'=>'networkApp'),

	//level 3 
	'sv_r_a' => array('pid'=>'sv_r','name'=>'角色授权','link'=>'roleAcl'),
	'sv_p_p' => array('pid'=>'sv_p','name'=>'接入策略','link'=>'policy'),
		
	'sv_v_p' => array('pid'=>'sv_v','name'=>'图片定制','link'=>'picture'),
	'sv_v_w' => array('pid'=>'sv_v','name'=>'文字定制','link'=>'word'),
	'sv_v_f' => array('pid'=>'sv_v','name'=>'文件定制','link'=>'file'),

	'sv_w_a' => array('pid'=>'sv_w','name'=>'反垃圾邮件','link'=>'antiSpam'),
	'sv_w_s' => array('pid'=>'sv_w','name'=>'抗扫描','link'=>'scan'),

	//level 2 IPSECVPN
	'iv_c' => array('pid'=>'iv','name'=>'基本配置','link'=>'basicConf'),
	'iv_t' => array('pid'=>'iv','name'=>'隧道配置','link'=>'tunnelConf'),
	'iv_m' => array('pid'=>'iv','name'=>'隧道监控','link'=>'tunnelMonitor'),

	//level 3 
	'iv_c_b' => array('pid'=>'iv_c','name'=>'基本配置','link'=>'basicConf'),
	'iv_t_r' => array('pid'=>'iv_t','name'=>'VPN规则','link'=>'VPNRules'),
	'iv_t_i' => array('pid'=>'iv_t','name'=>'IKE配置','link'=>'IKEConf'),
	'iv_t_w' => array('pid'=>'iv_t','name'=>'网关隧道配置','link'=>'tunnelConf'),
	'iv_t_c' => array('pid'=>'iv_t','name'=>'客户端隧道配置','link'=>'clientConf'),
	'iv_t_g' => array('pid'=>'iv_t','name'=>'隧道组','link'=>'tunnelGroup'),
	'iv_m_m' => array('pid'=>'iv_m','name'=>'隧道监控','link'=>'tunnelMonitor'),


	//level 2 VPDN
	'vp_l' => array('pid'=>'vp','name'=>'L2TP','link'=>'L2TP'),
	'vp_p' => array('pid'=>'vp','name'=>'PPTP','link'=>'PPTP'),

	//level 3 
	'vp_l_b' => array('pid'=>'vp_l','name'=>'基本配置','link'=>'L2TPConf'),
	'vp_p_b' => array('pid'=>'vp_p','name'=>'基本配置','link'=>'PPTPConf'),


	//level 2 firewall
	'fw_p' => array('pid'=>'fw','name'=>'策略','link'=>'policy'),
	'fw_a' => array('pid'=>'fw','name'=>'地址','link'=>'address'),
	'fw_s' => array('pid'=>'fw','name'=>'服务','link'=>'service'),
	'fw_t' => array('pid'=>'fw','name'=>'时间','link'=>'time'),
	'fw_b' => array('pid'=>'fw','name'=>'带宽','link'=>'bandwidth'),
	'fw_k' => array('pid'=>'fw','name'=>'黑名单','link'=>'blacklist'),
	'fw_d' => array('pid'=>'fw','name'=>'地址绑定','link'=>'addrBind'),
	'fw_o' => array('pid'=>'fw','name'=>'安全选项','link'=>'safeOpions'),

	//level 3
	'fw_p_s' => array('pid'=>'fw_p','name'=>'安全策略','link'=>'safePolicy'),
	'fw_p_n' => array('pid'=>'fw_p','name'=>'NAT策略','link'=>'NATPolicy'),
	'fw_p_b' => array('pid'=>'fw_p','name'=>'带宽策略','link'=>'bandwidthPolicy'),

	'fw_a_a' => array('pid'=>'fw_a','name'=>'地址','link'=>'address'),
	'fw_a_g' => array('pid'=>'fw_a','name'=>'地址组','link'=>'addrGroup'),
	'fw_a_p' => array('pid'=>'fw_a','name'=>'地址池','link'=>'addrPool'),
	'fw_a_d' => array('pid'=>'fw_a','name'=>'域名资源','link'=>'dnSource'),

	'fw_s_p' => array('pid'=>'fw_s','name'=>'预定义服务','link'=>'default'),
	'fw_s_d' => array('pid'=>'fw_s','name'=>'动态服务','link'=>'dynamic'),
	'fw_s_i' => array('pid'=>'fw_s','name'=>'ICMP服务','link'=>'ICMP'),
	'fw_s_b' => array('pid'=>'fw_s','name'=>'基本服务','link'=>'basic'),
	'fw_s_g' => array('pid'=>'fw_s','name'=>'服务组','link'=>'servGroup'),
	
	'fw_t_t' => array('pid'=>'fw_t','name'=>'时间','link'=>'time'),
	'fw_t_g' => array('pid'=>'fw_t','name'=>'时间列表','link'=>'timeList'),

	'fw_b_n' => array('pid'=>'fw_b','name'=>'非共享带宽','link'=>'nonsharedBandwidth'),
	'fw_b_s' => array('pid'=>'fw_b','name'=>'共享带宽','link'=>'sharedBandwidth'),
	'fw_b_g' => array('pid'=>'fw_b','name'=>'带宽资源组','link'=>'bandwidthGroup'),

	'fw_k_k' => array('pid'=>'fw_k','name'=>'黑名单','link'=>'blicklist'),
	'fw_d_d' => array('pid'=>'fw_d','name'=>'地址绑定','link'=>'addrbind'),
	'fw_o_o' => array('pid'=>'fw_o','name'=>'安全选项','link'=>'safeOptions'),


	//level 2 HA
	'ha_h' => array('pid'=>'ha','name'=>'双机热备','link'=>'HA'),
	'ha_l' => array('pid'=>'ha','name'=>'负载均衡','link'=>'loadBalancing'),
	'ha_d' => array('pid'=>'ha','name'=>'分布式统一接入','link'=>'cluster'),
	'ha_r' => array('pid'=>'ha','name'=>'智能选路','link'=>'routing'),

	//level 3 
	'ha_a_b' => array('pid'=>'ha_h','name'=>'基本配置','link'=>'basicConf'),
	'ha_l_s' => array('pid'=>'ha_l','name'=>'SSLVPN负载均衡','link'=>'SSLVPN'),
	'ha_l_i' => array('pid'=>'ha_l','name'=>'IPSECVPN负载均衡','link'=>'IPSECVPN'),
	'ha_d_b' => array('pid'=>'ha_d','name'=>'基本配置','link'=>'dConf'),
	'ha_r_b' => array('pid'=>'ha_r','name'=>'基本配置','link'=>'routing'),


	//level 2 logAudit
	'la_c' => array('pid'=>'la','name'=>'日志配置','link'=>'logConf'),
	'la_s' => array('pid'=>'la','name'=>'日志访问','link'=>'logShow'),
	'la_a' => array('pid'=>'la','name'=>'审计','link'=>'logAudit'),

	//level 3
	'la_c_s' => array('pid'=>'la_c','name'=>'日志服务器','link'=>'logServer'),
	'la_c_c' => array('pid'=>'la_c','name'=>'日志配置','link'=>'logConf'),
	'la_c_a' => array('pid'=>'la_c','name'=>'邮件报警','link'=>'mailAlarm'),
	'la_c_t' => array('pid'=>'la_c','name'=>'邮件测试','link'=>'mailTest'),
	'la_c_v' => array('pid'=>'la_c','name'=>'日志分类存储设置','link'=>'logSave'),

	'la_s_s' => array('pid'=>'la_s','name'=>'日志查看','link'=>'logShow'),
	'la_a_a' => array('pid'=>'la_a','name'=>'日志审计','link'=>'logAudit'),


	//level 3 systemManagement/systemConf
	'sm_s_i' => array('pid'=>'sm_s','name'=>'系统信息','link'=>'systemInformation'),
	'sm_s_c' => array('pid'=>'sm_s','name'=>'管理员设置','link'=>'adminConf'),
	'sm_s_m' => array('pid'=>'sm_s','name'=>'系统维护','link'=>'systemMaintaining'),

	//level 4 systemManagement/systemConf/systemInformation
	'sm_s_i_t' => array('pid'=>'sm_s_i','name'=>'日期时间','link'=>'dateTime'),
	'sm_s_i_p' => array('pid'=>'sm_s_i','name'=>'系统参数','link'=>'systemParams'),
	'sm_s_i_s' => array('pid'=>'sm_s_i','name'=>'SNMP','link'=>'SNMP'),
	'sm_s_i_d' => array('pid'=>'sm_s_i','name'=>'动态域名','link'=>'dynamicDN'),

	//level 4 systemManagement/systemConf/managementConf
	'sm_s_c_a' => array('pid'=>'sm_s_c','name'=>'管理员账号','link'=>'adminAccount'),
	'sm_s_c_a' => array('pid'=>'sm_s_c','name'=>'访问权限','link'=>'acl'),
	'sm_s_c_h' => array('pid'=>'sm_s_c','name'=>'管理主机','link'=>'ManagementHost'),
	'sm_s_c_c' => array('pid'=>'sm_s_c','name'=>'设置','link'=>'configration'),
	'sm_s_c_l' => array('pid'=>'sm_s_c','name'=>'管理证书','link'=>'licenseManagement'),
	
	//level 4 systemManagement/systemConf/systemMaintaining
	'sm_s_m_b' => array('pid'=>'sm_s_m','name'=>'备份与恢复','link'=>'backupRecovery'),
	'sm_s_m_u' => array('pid'=>'sm_s_m','name'=>'升级','link'=>'upgrade'),
	'sm_s_m_l' => array('pid'=>'sm_s_m','name'=>'许可证','link'=>'license'),
	'sm_s_m_t' => array('pid'=>'sm_s_m','name'=>'双系统','link'=>'twoSystem'),
	'sm_s_m_d' => array('pid'=>'sm_s_m','name'=>'调试','link'=>'debug'),


	//level 3 systemManagement/networkConf
	'sm_n_i' => array('pid'=>'sm_n','name'=>'接口设置','link'=>'interfaceConf'),
	'sm_n_b' => array('pid'=>'sm_n','name'=>'基本配置','link'=>'basicConf'),
	'sm_n_r' => array('pid'=>'sm_n','name'=>'路由设置','link'=>'routingConf'),
	'sm_n_n' => array('pid'=>'sm_n','name'=>'网络服务','link'=>'networkService'),
	
	
	//level 4 /interfaceConf
	'sm_n_i_p' => array('pid'=>'sm_n_i','name'=>'物理设备','link'=>'physical'),
	'sm_n_i_v' => array('pid'=>'sm_n_i','name'=>'VLAN设备','link'=>'VLAN'),
	'sm_n_i_b' => array('pid'=>'sm_n_i','name'=>'桥设备','link'=>'bridge'),
	'sm_n_i_a' => array('pid'=>'sm_n_i','name'=>'别名设备','link'=>'alias'),
	'sm_n_i_r' => array('pid'=>'sm_n_i','name'=>'冗余设备','link'=>'redundance'),
	'sm_n_i_d' => array('pid'=>'sm_n_i','name'=>'拨号设备','link'=>'dial'),
	'sm_n_i_w' => array('pid'=>'sm_n_i','name'=>'无线设备','link'=>'wireless'),
	'sm_n_i_3' => array('pid'=>'sm_n_i','name'=>'3G设备','link'=>'3G'),
	'sm_n_i_g' => array('pid'=>'sm_n_i','name'=>'GRE设备','link'=>'GRE'),
	
	//level 4 /basicConf
	'sm_n_b_d' =>array('pid'=>'sm_n_b','name'=>'域名服务器','link'=>'dns'),
	
	//level 4 //routingConf
	'sm_n_r_d' => array('pid'=>'sm_n_r','name'=>'默认路由','link'=>'default'),
	'sm_n_r_s' => array('pid'=>'sm_n_r','name'=>'静态路由','link'=>'static'),
	'sm_n_r_i' => array('pid'=>'sm_n_r','name'=>'ISP路由表','link'=>'ISP'),
	'sm_n_r_a' => array('pid'=>'sm_n_r','name'=>'高级路由表','link'=>'advanced'),
	'sm_n_r_p' => array('pid'=>'sm_n_r','name'=>'高级路由策略','link'=>'advacedPolicy'),
	'sm_n_r_dy'=> array('pid'=>'sm_n_r','name'=>'动态路由','link'=>'dynamic'),

	//level 4 /networkService
	'sm_n_n_d' => array('pid'=>'sm_n_n','name'=>'DHCP域配置','link'=>'DHCPConf'),
	'sm_n_n_s' => array('pid'=>'sm_n_n','name'=>'DHCP静态IP','link'=>'staticIP')
	);
