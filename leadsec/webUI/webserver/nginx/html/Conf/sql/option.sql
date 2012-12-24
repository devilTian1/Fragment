
-- Use(Create database):
--   #rm option.db
--   #sqlite option.db<option.sql

-- 创建
-- 1. 黄琛 2003/12/09 

BEGIN TRANSACTION;

-- 表名: 安全选项
create table security_option
(
    anti_ipspoofing    BOOL,             --抗IP spoofing攻击
    anti_teardrop      BOOL,             --抗TEAR DROP
    anti_sourseroute   BOOL,             --抗Filter IP Source Route Option攻击 
    anti_smurf         BOOL,             --抗smurf 
    anti_land          BOOL,             --抗Land攻击
    anti_winnuke       BOOL,             --抗WinNuke攻击  
    anti_queso         BOOL,             --抗Queso攻击  
    anti_sfscan        BOOL,             --抗sf_scan攻击  
    anti_nullscan      BOOL,             --抗null_scan攻击  
    anti_fillxmasscan  BOOL,             --抗full_xmas_scan攻击  
    anti_xmasscan      BOOL,             --抗xmas_scan攻击  
    ipmac_check        BOOL,             --IP/MAC 检查开关
    ipmac_policy       BOOL,             --IP/MAC 检查未通过时，是否允许的策略开关 (失效：2005/6/19 zhuxp)
    filter_policy      BOOL,             --包过滤缺省策略
    state_check        BOOL,             --严格的TCP状态检测
    rule_first         BOOL,             --下规则立即生效
    fast_mode          BOOL              --快速模式
);
insert into security_option values(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0);


-- 表名: 安全选项
create table eth_pro
(
    id              INTEGER PRIMARY KEY,    --ID号
    name 	    CHAR(20),               --名称
    protocol	    INT,                    --协议号
    policy          BOOL                    --是否允许, 0为drop, 1为accept
);
insert into eth_pro values(1,'LOOP',96,0);
insert into eth_pro values(2,'PUP',512,0);
insert into eth_pro values(3,'PUPAT',513,0);
insert into eth_pro values(4,'IP',2048,1);
insert into eth_pro values(5,'X25',2053,0);
insert into eth_pro values(6,'ARP',2054,1);
insert into eth_pro values(7,'BPQ',2303,0);
insert into eth_pro values(8,'IEEEPUP',2560,0);
insert into eth_pro values(9,'IEEEPUPAT',2561,0);
insert into eth_pro values(10,'DEC',24576,0);
insert into eth_pro values(11,'DNA_DL',24577,0);
insert into eth_pro values(12,'DNA_RC',24578,0);
insert into eth_pro values(13,'DNA_RT',24579,0);
insert into eth_pro values(14,'LAT',24580,0);
insert into eth_pro values(15,'DIAG',24581,0);
insert into eth_pro values(16,'CUST',24582,0);
insert into eth_pro values(17,'SCA',24583,0);
insert into eth_pro values(18,'RARP',32821,0);
insert into eth_pro values(19,'ATALK',32923,0);
insert into eth_pro values(20,'AARP',33011,0);
insert into eth_pro values(21,'8021Q',33024,0);
insert into eth_pro values(22,'IPX',33079,0);
insert into eth_pro values(23,'IPV6',34525,0);
insert into eth_pro values(24,'PPP_DISC',34915,0);
insert into eth_pro values(25,'PPP_SES',34916,0);
insert into eth_pro values(26,'ATMMPOA',34892,0);
insert into eth_pro values(27,'ATMFATE',34948,0);
insert into eth_pro values(28,'EDP2',34978,0);
insert into eth_pro values(29,'802_3',1,0);
insert into eth_pro values(30,'AX25',2,0);
insert into eth_pro values(31,'802_2',4,0);
insert into eth_pro values(32,'SNAP',5,0);
insert into eth_pro values(33,'DDCMP',6,0);
insert into eth_pro values(34,'WAN_PPP',7,0);
insert into eth_pro values(35,'PPP_MP',8,0);
insert into eth_pro values(36,'LOCALTALK',9,0);
insert into eth_pro values(37,'PPPTALK',16,0);
insert into eth_pro values(38,'TR_802_2',17,0);
insert into eth_pro values(39,'MOBITEX',21,0);
insert into eth_pro values(40,'CONTROL',22,0);
insert into eth_pro values(41,'IRDA',23,0);
insert into eth_pro values(42,'ECONET',24,0);
insert into eth_pro values(43,'HDLC',25,0);

insert into eth_pro values(44,'',0,0);
insert into eth_pro values(45,'',0,0);
insert into eth_pro values(46,'',0,0);
insert into eth_pro values(47,'',0,0);
insert into eth_pro values(48,'',0,0);

insert into eth_pro values(49,'OTHER',3,0);
insert into eth_pro values(50,'ALL',3,1);

--默认不启动，不影响性能
--表名：系统监控
create table monitor
(
    id	INTEGER PRIMARY KEY,    --ID号
    name	CHAR(20),			--模块名称
    active	BOOL,				--模块是否启动
    start	CHAR(128),			--模块启动的命令行
    stop	CHAR(128)			--模块停止的命令行
);
insert into monitor values(1,'interfacemon',0,'/usr/local/bin/interfacemon -d','/usr/local/bin/interfacemon -k');
insert into monitor values(2,'sysmon',0,'/usr/local/bin/sysmon -d','/usr/bin/killall -9 sysmon');
insert into monitor values(3,'domain',0,'/usr/local/bin/domain_monitor -s','/usr/bin/killall domain_monitor');

--系统调试开关
create table debug
(
	module	CHAR(32),			--模块名称,all代表所有模块
	debug	BOOL,				--调试开关
	facility	INT				--调试信息输出设备,1:控制台；2:日志
);

insert into debug values("all",0,1);
insert into debug values("acsc",0,1);
insert into debug values("address",0,1);
insert into debug values("addrgrp",0,1);
insert into debug values("admacct",0,1);
insert into debug values("admcert",0,1);
insert into debug values("admhost",0,1);
insert into debug values("admmode",0,1);
insert into debug values("adsl",0,1);
insert into debug values("alertmail",0,1);
insert into debug values("authserver",0,1);
insert into debug values("bandwidth",0,1);
insert into debug values("blacklist",0,1);
insert into debug values("block",0,1);
insert into debug values("bw",0,1);
insert into debug values("cleardb",0,1);
insert into debug values("cli",0,1);
insert into debug values("clock",0,1);
insert into debug values("conn_query",0,1);
insert into debug values("controlkw",0,1);
insert into debug values("ddns",0,1);
insert into debug values("debug",0,1);
insert into debug values("dhcpclient",0,1);
insert into debug values("dhcprelay",0,1);
insert into debug values("dhcpserver",0,1);
insert into debug values("domain",0,1);
insert into debug values("exportdb",0,1);
insert into debug values("fwarp",0,1);
insert into debug values("fwping",0,1);
insert into debug values("fwroute",0,1);
insert into debug values("fwtcpdump",0,1);
insert into debug values("fwtraceroute",0,1);
insert into debug values("ha",0,1);
insert into debug values("hadetect",0,1);
insert into debug values("hostname",0,1);
insert into debug values("ids",0,1);
insert into debug values("interface",0,1);
insert into debug values("linkage",0,1);
insert into debug values("log",0,1);
insert into debug values("logserver",0,1);
insert into debug values("macbind",0,1);
insert into debug values("mailfilter",0,1);
insert into debug values("monitor",0,1);
insert into debug values("newconfig",0,1);
insert into debug values("ntp",0,1);
insert into debug values("option",0,1);
insert into debug values("proxy",0,1);
insert into debug values("route",0,1);
insert into debug values("rule",0,1);
insert into debug values("sarp",0,1);
insert into debug values("sataddr",0,1);
insert into debug values("serveraddr",0,1);
insert into debug values("servgrp",0,1);
insert into debug values("service",0,1);
insert into debug values("setdb",0,1);
insert into debug values("snmp",0,1);
insert into debug values("system",0,1);
insert into debug values("time",0,1);
insert into debug values("upgrade",0,1);
insert into debug values("upnp",0,1);
insert into debug values("url",0,1);
insert into debug values("user",0,1);
insert into debug values("usergrp",0,1);
insert into debug values("usernum",0,1);
insert into debug values("vlanid",0,1);
insert into debug values("vpn",0,1);
insert into debug values("vpnpolicy",0,1);

-- 表名: SOHO参数选择
create table soho_parameter
(
    bridge_num    int,             --网桥设备数
    alias_num    int,             --别名设备数
    route_num    int,             --静态路由数
    portmap_num    int,             --端口映射规则数
    ipmap_num    int,             --IP映射规则数
    pf_num    int,             --包过滤规则数
    nat_num    int,             --NAT规则数
    macbind_num    int,             --地址绑定规则数
    bw_num    int,             --带宽管理规则数
    blacklist_num    int,             --黑名单数
    remotevpn_num    int,             --远程VPN规则数
    vpntunnel_num    int,             --VPN隧道数
    vpnuser_num    int,             --VPN远程拨号用户数
    user_num    int,             --用户列表数
    userg_num    int,             --用户组数
    bandwidth_num    int,             --带宽资源数
    urlfilter_num    int,             --URL过滤关键字数
    webkey_num    int             --网页过滤关键字数  
);

insert into soho_parameter values(1,8,20,50,50,300,300,100,50,50,100,100,50,50,50,40,64,64);

COMMIT;
