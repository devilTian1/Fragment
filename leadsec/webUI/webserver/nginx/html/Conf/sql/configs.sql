
-- Use(Create database):
--   #sqlite configs.db<configs.sql

-- History:
-- 2004/1/8	zhuxp	去掉表fwips,antiatk
-- 2004/1/11	zhuxp	加入表tbl_ddns_user，修改表interface，加入动态域名

BEGIN TRANSACTION;

-- 表名：防火墙名称
create table hostname
(
	hostname		  CHAR(20)
);
insert into hostname values("NetGap");

-- 表名：动态DNS注册用户名，密码
create table ddns_info
(
	username		  CHAR(32),			--用户名
	password		  CHAR(32)			--密码
);
insert into ddns_info values('','');

--生产前，默认的管理设备是fe1
--生产后， 默认的管理设备是fe2
--默认的管理IP是10.0.0.1,默认的管理主机IP是10.0.0.200
--默认启用brg0设备
--默认不启用ipsec0设备
--如果物理设备被HA模块使用，则不要启用,默认的HA设备是fe2
--增加拨号设备
-- 表名: 网络接口
create table interface
(
    external_name     CHAR(20),         --网络接口外部名字 
    internal_name     CHAR(20),         --网络接口内部名字, 命令行自用，他人请勿修改
    mac_address       CHAR(17),         --MAC地址
    linkmode          INT,              --0:自动检测 1:全双工 2:半双工
    mtu               INT,              --MTU size 
    trunk             BOOL,             --是否是Trunk口,只能配置在物理设备上
	device_type		  INT,				--0:未指定 1:以太网物理设备 2:VLAN设备 3:网桥设备 4:VPN设备 5:别名设备 6:冗余设备 7：拨号设备
	network_type	  INT,				--0:未指定 1:内网 2:DMZ 3:外网 4:HA口(属于独立的网络)
	interface_list	  CHAR(255),		--如果是网桥设备或冗余设备，它的真实设备名称列表，冗余设备中最多可以加两个物理设备
	phy_device		  CHAR(20),			--如果是别名或VLAN,VPN设备,它所对应的真实设备名称,其他为空
    vlan_id           INT,              --如果是VLAN设备，它的VLAN ID(它的名称自动生成，不能修改)
	alias_id	  	  INT,				--如果是别名设备,它的ID号(它的名称自动生成，不能修改)
	ipaddr_type		  INT,				--0:未指定 1:静态IP地址 2:无效 3: 使用DHCP获得IP地址,只允许以太网物理设备 
    qos_enable		  BOOL,				--启用带宽管理
    qos_device_bw	  INT,				--设备带宽
    dhcp_relay		  BOOL,				--启用DHCP中继，只允许以太网物理设备
    stp_enable		  BOOL,				--启用网桥STP
    enable			  BOOL,				--是否启用设备
    ip                CHAR(15),         --接口IP地址
    mask              CHAR(15),         --接口IP地址掩码
    admin             BOOL,             --接口是否用于管理
    ping              BOOL,             --接口是否可以被PING
    traceroute        BOOL,             --接口是否可以被TRACEROUTE	
    workmode		  INT,				--物理设备的工作模式 0:未指定 1:路由模式(默认) 2:透明模式 3:冗余设备模式
    rd_mode			  INT,				--冗余设备的工作模式 0:非全(半?)冗余 1:全冗余(默认) 
	dns_enable		  BOOL,				--启用动态域名注册
	domain_name		  CHAR(255),		--域名名称
	ha_enable		  BOOL,				--HA设备
	valid			  BOOL,				--网络接口是否有效，默认是无效，在系统启动时检测并更新数据库
	speed			  INT,				--网络接口的速度，eth0-eth3固定为百兆，eth4-eth7需要在系统启动时检测并更新数据库
	dhcpserver		  CHAR(255),		--DHCP中继里配置的DHCP服务器，是以空格分割的IP地址列表
	ipmac_check		  INT,				--MAC地址绑定检查 0：不检查（默认）， 1：检查
	ipmac_check_policy INT,				--未绑定地址的策略 0：不通过， 1：通过（默认）
	antispoof		  INT,				--地址欺骗检查 0：不检查（默认） 1：检查
    if_property       INT ,				--设备属性: 0:未指定  1:HA接口  2:管理接口  3:网络接口  4:网络扩展口
    ipv6              CHAR(50),         --IPv6
    ipv6_mask         CHAR(15)         --IPv6
);
insert into interface values('fe1','eth0','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",1,1,100,"",0,1,0,1,"","");
insert into interface values('fe2','eth1','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.0.1","255.255.255.0",1,1,1,1,0,0,"",0,1,100,"",0,1,0,2,"","");
insert into interface values('fe3','eth2','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.1.1","255.255.255.0",0,0,0,1,0,0,"",0,1,100,"",0,1,0,3,"","");
insert into interface values('fe4','eth3','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe5','eth4','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe6','eth5','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.2.1","255.255.255.0",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe7','eth6','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe8','eth7','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe9','eth8','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe10','eth9','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe11','eth10','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe12','eth11','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe13','eth12','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe14','eth13','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe15','eth14','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
--insert into interface values('brg0','brg0',0,'',0,1500,0,3,1,"","",-1,-1,1,0,0,0,1,1,"10.1.5.254","255.255.255.0",1,1,1,1,0,0,"",0,1,0,"",0,1,0);
--insert into interface values('ipsec0','ipsec0',0,'',0,1500,0,4,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,0,"",0,1,0);
--insert into interface values('dial0','ppp0',0,'',0,1500,0,7,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,10,"",0,1,0);


--表名：冗余设备参数
--2004/11/23 yangcy	创建，网络设备中冗余设备的参数
create table redevice_option
(
	version		INT,				--冗余设备参数版本，若数据库格式发生改变则修改
	max_devices	INT,				--最大支持的冗余设备个数4，默认为5，其中bond0设备保留给HA，其它供冗余设备使用
	work_mode	INT,				--冗余设备工作的模式0-6，默认为0
	link_watch	INT,				--监控时间，单位为毫秒
	updelay		INT,				--up延迟时间，值为watch_time的倍数
	downdelay	INT,				--down延迟时间，值为watch_time的倍数
	lacp_rate	INT,				--802.3ad模式参数0或1
	usr_carries	INT					--默认为1
);
insert into redevice_option values(1,5,0,300,0,0,0,1);

--表名：拨号设备参数
create table dial
(
	name		CHAR(20),				--拨号设备外部名称，目前只支持一个拨号设备
	interface	CHAR(20),				--拨号设备的绑定设备，外部名
	protocol	INT,					--拨号协议，1：PPPoE
	username	CHAR(64),				--拨号用户名
	passwd		CHAR(64),				--拨号密码
	startup		BOOL,					--系统启动时拨号
	auto		BOOL,					--自动拨号
	time		CHAR(20)				--时间资源名称
);
insert into dial values('dial0',"",1,"","",0,1,"");

--表名：TRUNK
create table trunk
(
	crossvlan  INT
);
insert into trunk values('0');

-- 表名: upnp接口
create table upnp_if
(
    exif_name     CHAR(20),         --外部网络接口名字//interface的外部名字
    inif_name     CHAR(20),         --内部网络接口名字//interface的外部名字
    active		  INT				--0:未启用 1:启用
);
insert into upnp_if values('','',0);

-- 表名: upnp规则
create table upnp_rule
(
    id			  INTEGER PRIMARY KEY, --ID  sequence
    name			CHAR(20),            --名称
    ip              CHAR(45),            --IP
    mask            CHAR(15),                 --掩码
    comment         VARCHAR(255)            --本机备注    
);
-- 表名：ARP表
create table arp_static
(
	id              INTEGER PRIMARY KEY,    --ID号
	ip              CHAR(45),               --地址
	mac             CHAR(17),               --MAC地址
	interface       CHAR(20),               --添加时写入，设备的外部名称
	active          INT                     --是否启用1：启用 0：不启用
);

-- 表名：缺省路由
create table defaultroute
(
	defaultroute	CHAR(15)
);
insert into defaultroute values ("");


-- 表名: 静态路由
create table route_static
(
    id              INTEGER PRIMARY KEY,    --ID号, 默认路由放置在第一条记录 id = 1, 永不删除  
    destip          CHAR(45),               --目的地址   
    destmask        CHAR(15),               --目的地址掩码         
    nexthopip       CHAR(45),               --下一跳地址
    interface		CHAR(20),               --添加时写入，从interface表中得来，同时是接口表中的接口内部名称用作修改和删除。
    active 			INT 					--是否启用1：启用 0：不启用
);

-- 表名: 策略路由
create table route_policy
(
    id              INTEGER PRIMARY KEY,    --ID号, 默认路由放置在第一条记录 id = 1, 永不删除
    sourceip        CHAR(45),               --源地址
    destip          CHAR(45),               --目的地址
    sourcemask      CHAR(15),               --源地址掩码
    destmask        CHAR(15),               --目的地址掩码         
    nexthopip       CHAR(45),               --下一跳地址
    interface		CHAR(20),               --添加时写入，从interface表中得来，同时是接口表中的接口内部名称用作修改和删除。
    active 			INT, 					--是否启用1：启用 0：不启用
	tableid			INT,					--对应的表ID
	priority		INT 					--规则优先级
);

------表名: 集中管理
create table snmp
(
    ip              CHAR(255),              --集中管理主机IP,多个ip是用"|"分隔开，一共可支持16个ip   
    adminname       CHAR(20),               --负责人姓名    
    adminphone      CHAR(30),               --负责人电话    
    cpu             INT  default 85,        --CPU利用率阀值
    mem             INT  default 85,        --内存利用率阀值
    file            INT  default 85,        --文件系统利用率阀值
    comment         VARCHAR(255),           --本机备注    
    rcomm           CHAR(64) default 'public',  --只读团体串
    wcomm           CHAR(64) default 'private', --读写团体串
    trapcomm        CHAR(64) default 'public',  --trap团体串
    comm2sec        CHAR(4)  default 'on'       --whether or not use community to security
);
insert into snmp (ip) values (NULL);


--snmp v3支持
create table snmpusm
(
    --id              INTEGER PRIMARY KEY, 
    username    CHAR(64) default 'leadsec',       --security name
    seclevel    CHAR(6) default 'noauth',  --security level
    authproto   CHAR(8) default 'MD5',     --authentication protocol (MD5|SHA)
    authphrase  CHAR(32),                  --authentication protocol pass phrase
    privproto   CHAR(8) default 'DES',     --privacy protocol (DES | AES)
    privphrase  CHAR(32),                  --privacy protocol pass phrase
    v3usm       CHAR(4) default 'off'       --whether or not use SNMPv3 USM 
);
INSERT INTO snmpusm (v3usm) VALUES('off');


-- 表名: 管理主机
--create table adminips
--(
--    id              INTEGER PRIMARY KEY,    --序号
--    ip              CHAR(15),               --IP地址
--    comment         VARCHAR(255)            --描述
--);
--INSERT INTO adminips VALUES(1,'10.0.0.200','管理主机1');
--modified for netgap
--INSERT INTO adminips VALUES(2,'10.1.5.49','PPP拨号管理主机');
create table adminips
(
    id              INTEGER PRIMARY KEY,    --序号
    ip              CHAR(45),               --IP地址
    netmask	    		CHAR(15),		    				--子网掩码	
    comment         VARCHAR(255)            --描述
);
INSERT INTO adminips VALUES(1,'0.0.0.0','0.0.0.0','管理主机1');

-- 表名: 报警邮箱
create table mailbox 
(
    mailbox         CHAR(64),           --报警邮箱
    smtp            CHAR(64),           --SMTP地址
    port            INT,                --SMTP 端口
    sender          CHAR(64),
    receiver1       CHAR(64),
    receiver2       CHAR(64),
    receiver3       CHAR(64),
    gwmail_smtp     CHAR(64),
    gwmail_port     INT,
    passwd          CHAR(20),
    power           CHAR(1),
    log_power       CHAR(1)
);
INSERT INTO mailbox VALUES('','',25,'','','','','',25,'','','');

create table gwmail
(
    sender          CHAR(64),
    receiver1       CHAR(64),
    receiver2       CHAR(64),
    receiver3       CHAR(64),
    gwmail_smtp     CHAR(64),
    gwmail_port     INT,
    passwd          CHAR(20),
    power           INT,
    log_power       INT,
    accessory_name  CHAR(64),
    now_subject     CHAR(100),
    now_content     CHAR(1000),
    now_signature   CHAR(100)
);
INSERT INTO gwmail VALUES('','','','','',25,'','1','1','','','','');

-- 表名: 日志服务基本配置   add by caixc 2012-11-22
create table log_basic
(
    sendother  BOOL,    --是否发送日志到对端主机
    tcp_enable     BOOL,    --是否开启rsyslogd的tcp监听端口
    udp_enable     BOOL,    --是否开启rsyslogd的udp监听端口
    sizelimit      INT      --日志文件的大小限制(单位M)
);
INSERT INTO log_basic VALUES(0,1,1,20);

-- 表名: 日志服务器
create table logsrv
(
    --sourceip        CHAR(45),           --源地址（发送日志IP）
    logsrv          CHAR(45),           --日志服务器IP地址    
    protocol        CHAR(5),            --协议号    
    port            INT,                --端口    
    comment         VARCHAR(255)        --描述
);

--表名: 设置将日志发送到设定的ftp服务器
create table log_ftpsrv
(
    ftpsrv      CHAR(45),       --FTP服务器IP地址
    user        CHAR(25),       --ftp用户名
    pass        CHAR(25),       --ftp用户密码
    passive     BOOL           --连接模式，1被动 0，主动
);

create table logupload
(
    minute      INT,            --设置每小时的多少分钟自动上传,0表示此项不生效；可用值1-59
    hour        INT,            --设置每天的几点自动上传，0表示此项不生效；可用值1-23
    day         INT,            --设置每月的哪天自动上传，0表示此项不生效；可用值1-31
    enable      BOOL            --1开启日志自动上传功能，0关闭日志自动上传
);
INSERT INTO logupload VALUES(0,0,0,0);


-- 表名: 管理方式
create table admin_style
(
    use_ssh                 BOOL,       --启用远程SSH
    use_ppp                 BOOL        --支持拨号PPP接入
);
INSERT INTO admin_style VALUES(0,0);

-- 表名: 管理员帐号
create table accounts
(
    account     CHAR(20) PRIMARY KEY,   --管理员账号
    super       BOOL,                   --超级管理员权限
    manager     BOOL,                   --配置管理员权限
    policyer    BOOL,                   --策略管理员权限
    auditor     BOOL,                   --审计员权限
    passwd      VARCHAR(255),           --密码
    locktime   intergaer               --账号被锁时间
);
INSERT INTO accounts VALUES('administrator',1,1,1,1,'administrator',0);
INSERT INTO accounts VALUES('admin',0,1,1,1,'admin123',0);



-- 表名: 管理员策略
create table allow_multiple
(
    allow       BOOL            --允许多管理员
);
INSERT INTO allow_multiple VALUES(1);

-- 表名：允许登录失败次数
create table allow_failure
(
	times       interger,
    expiration  interger
);
INSERT INTO allow_failure VALUES(3,5);


-- 表名: 域名服务器
create table dnssrv
(
    dnssrv      CHAR(45),       --域名服务器1 IP地址
    dnssrv2     CHAR(45)       --域名服务器2 IP地址
);
INSERT INTO dnssrv VALUES('','');



-- 表名: 时间服务器
create table timeserver
(
    enable_time_server      BOOL,       --是否启动时间服务器
    server_ip               CHAR(45),   --服务器IP地址
    syninterval             INT         --同步时间间隔
);
INSERT INTO timeserver VALUES(0,'',300);



-- 表名: IDS联动
create table ids
(
    puma        BOOL,                   --网御通用安全协议联动0为禁用，1为启用
    puma_ip     VARCHAR(255),           --网御通用安全协议IP
    puma_port   INT,                    --网御通用安全协议端口    
    puma_passwd VARCHAR(255),           --网御通用安全协议口令
    tian        BOOL,                   --联动"天阗"IDS0为禁用，1为启用
    tian_ip     VARCHAR(256),           -- "天阗"联动IP
    tian_port   INT,                    --"天阗"联动端口
    yan         BOOL,                   --联动"天眼"IDS0为禁用，1为启用
    yan_ip      VARCHAR(256),           -- "天眼"联动IP
    yan_port    INT,                    --"天眼"联动端口
    safemate    BOOL,                   -- 联动SafeMate IDS 0为禁用，1为启用
    safemate_ip VARCHAR(256),           --SafeMate联动IP
    safemate_port     INT,              --safeMate 端口 （默认UDP2001）
    iplist      VARCHAR(1024)           -- 忽略阻断的IP地址
);
INSERT INTO ids VALUES(0,'',5000,'',0,'',2000,0,'',4000,0,'',2001,'');



-- 表名: 代理服务
create table proxy
(
    http            BOOL,               --是否启用HTTP代理
    http_port       INT,                --HTTP代理服务端口
    http_java       BOOL,               --是否过滤Java, 0为deny，1为allow
    http_javascript BOOL,               --是否过滤JavaScript, 0为deny，1为allow
    http_activex    BOOL,               --是否过滤ActiveX, 0为deny，1为allow
    ftp             BOOL,               --是否启用FTP代理, 0为off，1为on
    ftp_port        INT,                --FTP代理服务端口
    ftp_controlcnt  BOOL,               --是否控制多线程, 0为off，1为on
    ftp_get         BOOL,               --是否能使用get命令
    ftp_put         BOOL,               --是否能使用put命令
    telnet          BOOL,               --是否启用TELNET代理
    telnet_port     INT,                --TELNET代理服务端口
    smtp            BOOL,               --是否启用SMTP代理
    smtp_port       INT,                --SMTP代理服务端口
    smtp_dns        VARCHAR(255),       --域名列表
    smtp_srv        VARCHAR(255),       --防火墙真实域名
    smtp_inmail     VARCHAR(255),       --内部邮件域名
    smtp_insrv      VARCHAR(255),       --内部邮件服务器
    smtp_max_length INT,                --SMTP邮件最大长度
    max_accepter    INT,                --最大接收人数
    pop3            BOOL,               --是否启用POP3代理
    pop3_port       INT,                --POP3代理服务端口
    pop3_srv        VARCHAR(255),       --POP3服务器列表
    pop3_max_length INT,                --POP3邮件最大长度
    socks           BOOL,               --是否启用SOCKS代理
    socks_port      INT,                --SOCKS代理服务端口
    dns             BOOL,               --是否启用DNS代理   
    dns_server      VARCHAR(255),       --DNS代理二级服务器
    ping            BOOL,               --是否启用ICMP代理
    msn             BOOL,               --是否启用MSN代理
    smtp_span		INT,                --SMTP代理时间间隔，单位为分钟
    smtp_count		INT                 --SMTP代理时间间隔内邮件数目
);
insert into proxy values(1,80,1,1,1,1,21,1,1,1,1,23,0,25,'dns.leadsec.com','smtp.leadsec.com','dns.leadsec.com','192.168.1.10',2048,5,0,110,'pop3.leadsec.com',20480,0,1080,0,'',0,0,600,100);



-- 表名: 自定义代理
create table proxy_custom
(
    id              INTEGER PRIMARY KEY, --序号
    name            CHAR(20),            --服务名
    port            INT,                 --端口
    protocol        INT,                 --协议, 用getprotobynumber()来实现解析
    enable          BOOL                 --是否启用
);


-- 表名: 邮件过滤
create table mail_filter
(
    smtp_sender         BOOL,           --是否过滤发信人、发信人地址
    smtp_sender_list    VARCHAR(255),   --发信人、发信人地址列表
    smtp_receiver       BOOL,           --是否过滤收信人、收信人地址
    smtp_receiver_list  VARCHAR(255),   --收信人、收信人地址列表
    smtp_subject        BOOL,           --是否过滤邮件主题
    smtp_subject_list   VARCHAR(255),   --邮件主题列表
    smtp_content        INT,            --是否过滤邮件及其附件内容, 0禁用，1关键字匹配，2智能过滤
    smtp_content_list   VARCHAR(255),   --关键字列表
    smtp_attach         BOOL,           --是否过滤附件文件名
    smtp_attach_list    VARCHAR(255),   --附件文件名列表
    pop3_sender         BOOL,           --是否过滤发信人、发信人地址
    pop3_sender_list    VARCHAR(255),   --发信人、发信人地址列表
    pop3_receiver       BOOL,           --是否过滤收信人、收信人地址
    pop3_receiver_list  VARCHAR(255),   --收信人、收信人地址列表
    pop3_subject        BOOL,           --是否过滤邮件主题
    pop3_subject_list   VARCHAR(255),   --邮件主题列表
    pop3_content        INT,            --是否过滤邮件及其附件内容, 0禁用，1关键字匹配，2智能过滤
    pop3_content_list   VARCHAR(255),   --关键字列表
    pop3_attach         BOOL,           --是否过滤附件文件名
    pop3_attach_list    VARCHAR(255)    --附件文件名列表
);
INSERT INTO mail_filter VALUES(0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

-- added by liype for DHCP Server configuration 2003.12.08 begin
create table dhcpserver_domain
(
	id		INTEGER PRIMARY KEY,
	interface	CHAR(20),
	network		CHAR(15),
	netmask		CHAR(15),
	gateway		CHAR(15),
	domainname	CHAR(64),
	dns		CHAR(128),
	range		CHAR(20),
	comment		VARCHAR(255),
	is_vpnclient	CHAR(8),
	vpnclient_netmask 	CHAR(15)
);
create table dhcpserver_static
(
	id		INTEGER PRIMARY KEY,
	hostname	CHAR(64),
	mac		CHAR(17),
	ip		CHAR(45),
	comment		VARCHAR(255)
);
create table dhcpserver_startup
(
	startup		BOOL
);
insert into dhcpserver_startup values(0);
-- added by liype for DHCP Server configuration 2003.12.08 end

-- added by liype for DHCP Client configuration 2003.12.10 begin
create table dhcpclient
(
	interface	CHAR(20)
);
-- added by liype for DHCP Client configuration 2003.12.10 end

-- added by liype for DHCP relay configuration 2003.12.13 begin
create table dhcprelay
(
	interface	CHAR(20),
	servers		CHAR(255)
);
-- added by liype for DHCP relay configuration 2003.12.10 end

-- added by liype for ADSL configuration 2003.12.12 begin
create table adsl
(
	interface	CHAR(16),
	username	CHAR(16),
	passwd		CHAR(16),
	autodown	INT,
	startup		BOOL
);
create table adsl_auto
(
	auto		BOOL
);
insert into adsl_auto values (0);
-- added by liype for ADSL configuration 2003.12.12 end

-- added by yuzy for neight table 2005.09.21 begin
create table neightab
(
	thresh1		INT,
	thresh2		INT,
	thresh3		INT
);
insert into neightab values (128,512,1024);
-- added by yuzy for neight table 2005.09.21 end


COMMIT;


