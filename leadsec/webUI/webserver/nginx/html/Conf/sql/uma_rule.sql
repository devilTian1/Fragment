
-- Use(Create database):
--   #rm rule.db
--   #sqlite3 rule.db<rule.sql

-- History:
-- 1. xiaowj 2003/08/15 增加一个视图addrname

BEGIN TRANSACTION;

--表名: MAC地址绑定
create table addrbind
(
    id          INTEGER PRIMARY KEY,    --绑定地址序号
    ip          CHAR(15),               --IP地址
    mac         CHAR(17),               --Mac地址
    eth         CHAR(20),               --网络接口外部名称
    doubledir   BOOL                    --是否双向检测,0为禁用，1为启用
);

--表名: 地址
create table address
(
    id          INTEGER PRIMARY KEY,    --地址ID  sequence
    vmfwid		int not null,               --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙    
    name        CHAR(20),               --地址名
    type        INT,                    --地址类型,1为子网/掩码形式，2为地址段形式，3为反地址
    ip          CHAR(15),               --地址 （或低地址）
    mask        CHAR(15),               --掩码 （或高地址)
    comment     VARCHAR(255)           --备注
);

insert into  address values(1,0,'any',1,'0.0.0.0','0.0.0.0','全部地址');

-- 2011/6/16 zhuhq add
--表名: IPv6地址列表
create table address6
(
    id          INTEGER PRIMARY KEY,    --地址ID  sequence
    vmfwid		int not null,           --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙    
    name        CHAR(20),               --地址名
    type        INT,                    --地址类型,1为IPv6地址/前缀长度形式，2为地址段形式，3为反IPv6地址
	ip			CHAR(45),				--IPv6地址 type为1和3时有效 无效时为::
	prefixlen	INT,					--IPv6地址前缀长度(1 - 128) type为1和3时有效 无效时为默认值128
    ip_l        CHAR(45),             	--（低地址）type为2时有效 无效时为::
    ip_h        CHAR(45),               --（高地址) type为2时有效 无效时为::
    comment     VARCHAR(255)           --备注
);

insert into  address6 values(1,0,'any',1,'::',128,'::','::','全部地址');

--表名: 地址组
create table addrgrp
(
    id          INTEGER PRIMARY KEY,    --地址组ID sequence
    vmfwid		int not null,                --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --地址组名
    comment     VARCHAR(255)            --地址组说明
);

-- 2011/6/16 zhuhq add
--表名: IPv6地址组
create table addrgrp6
(
    id          INTEGER PRIMARY KEY,    --地址组ID sequence
    vmfwid		int not null,           --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --地址组名
    comment     VARCHAR(255)            --地址组说明
);

--2005/1/13	zhuxp	增加地址类型
--表名: 地址(地址地址组)对应表
create table addrmap
(
    addrgrpid   INT,                    --地址组ID
    addrid      INT,                    --地址ID
	type		INT						--地址类型，1为子网/掩码形式，2为地址段形式，3为反地址，8为域名地址
);

-- 2011/6/16 zhuhq add
--表名: 地址(地址地址组)对应表
create table addr6map
(
    addrgrpid   INT,                    --地址组ID
    addrid      INT,                    --地址ID
	type		INT						--地址类型，1为子网/掩码形式，2为地址段形式，3为反地址
);

----表名: 服务器地址
create table serveraddr
(
    id          INTEGER PRIMARY KEY,    --服务器地址ID
    vmfwid		int not null,                --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --服务器地址名
    ip1         CHAR(15),               --服务器1的IP地址
    weight1     INT,                    --服务器1的权重
    ip2         CHAR(15),               --服务器2的IP地址
    weight2     INT,                    --服务器2的权重
    ip3         CHAR(15),               --服务器3的IP地址
    weight3     INT,                    --服务器3的权重
    ip4         CHAR(15),               --服务器4的IP地址
    weight4     INT,                    --服务器4的权重
    ip5         CHAR(15),               --服务器5的IP地址
    weight5     INT,                    --服务器5的权重
    ip6         CHAR(15),               --服务器6的IP地址
    weight6     INT,                    --服务器6的权重
    ip7         CHAR(15),               --服务器7的IP地址
    weight7     INT,                    --服务器7的权重
    ip8         CHAR(15),               --服务器8的IP地址
    weight8     INT,                    --服务器8的权重
    comment     VARCHAR(255)            --注释
);

-- 2011/6/16 zhuhq add
----表名: IPv6服务器地址
create table serveraddr6
(
    id          INTEGER PRIMARY KEY,    --服务器地址ID
    vmfwid		int not null,                --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --服务器地址名
    ip1         CHAR(49),               --服务器1的IP地址
    weight1     INT,                    --服务器1的权重
    ip2         CHAR(49),               --服务器2的IP地址
    weight2     INT,                    --服务器2的权重
    ip3         CHAR(49),               --服务器3的IP地址
    weight3     INT,                    --服务器3的权重
    ip4         CHAR(49),               --服务器4的IP地址
    weight4     INT,                    --服务器4的权重
    ip5         CHAR(49),               --服务器5的IP地址
    weight5     INT,                    --服务器5的权重
    ip6         CHAR(49),               --服务器6的IP地址
    weight6     INT,                    --服务器6的权重
    ip7         CHAR(49),               --服务器7的IP地址
    weight7     INT,                    --服务器7的权重
    ip8         CHAR(4),               --服务器8的IP地址
    weight8     INT,                    --服务器8的权重
    comment     VARCHAR(255)            --注释
);

--表名：域名地址
create table domain_property
(
	id			INTEGER PRIMARY KEY,	--域名地址ID
	vmfwid		int not null,                --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
	name		CHAR(20),				--域名地址名称
	type		INT,					--域名地址类型8
	domain		CHAR(128),				--域名
	auto_resolve	BOOL DEFAULT 0,		--是否自动解析
	primary_dns	CHAR(16),				--主DNS服务器
	slave_dns	CHAR(16),				--次DNS服务器
	record_type	INT DEFAULT 1,			--自动解析类型
	max_record	INT DEFAULT 64,			--自动解析的最大记录数
	interval	INT DEFAULT 30,			--自动解析间隔,单位：分钟
	expire		INT DEFAULT 2,			--超时时间
	comment		VARCHAR(255),			--备注
	rule_id		INTEGER				--规则引用的ID号
);

--2011/6/19 zhuhq 
--视图：地址名称
CREATE VIEW ip6_address_domain AS
SELECT id,name,type,vmfwid FROM address6;

--2005/1/13	zhuxp	创建
--视图：地址和域名地址的名称
CREATE VIEW address_domain AS
SELECT id,name,type,vmfwid FROM address
UNION
SELECT id,name,type,vmfwid FROM domain_property;

--视图: 地址和地址组的名称
CREATE VIEW addrname AS
SELECT name,vmfwid FROM address
UNION
SELECT name,vmfwid FROM addrgrp
UNION
SELECT name,vmfwid FROM domain_property;

--视图: 地址和地址组的名称
CREATE VIEW pfaddrname AS
SELECT name,vmfwid FROM address_domain
UNION
SELECT name,vmfwid FROM addrgrp
UNION
SELECT name,vmfwid FROM serveraddr
UNION
SELECT name,vmfwid FROM domain_property;

CREATE VIEW scanaddrname AS
SELECT name FROM address where type=2;


--表名: 地址池
create table addrpool
(
    id          INTEGER PRIMARY KEY,    --地址池ID  sequence
    vmfwid		int not null,                --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --地址池名
    ip_from     CHAR(15),               --起始地址
    ip_to       CHAR(15),               --终止地址
    comment     VARCHAR(255)            --备注
);

--表名：带宽根类 yangcy 20050503
create table bandwidth_parentclass
(
	id			INT,    				--ID号
	name		Char(30),               --带宽名
	minbw		INT,                    --最小带宽，即保证带宽
	maxbw		INT,                    --最大带宽
	ethout		CHAR(20),               --流出网卡
	comment		VARCHAR(255)			--注释
);

--表名：带宽子类 yangcy 20050503
create table bandwidth_childclass
(
	id			INT,    				--ID号
	name		Char(30),               --带宽名
	minbw		INT,                    --最小带宽，即保证带宽
	maxbw		INT,                    --最大带宽
	priority	INT,                    --优先级
	parentid	INT,					--父分类ID
	ethout		CHAR(20),               --流出网卡
	comment		VARCHAR(255)			--注释
);

--表名：带宽资源组 yangcy 20050503
create table bandwidth_classgrp
(
	id			INT,    				--ID号
	name		Char(30),               --带宽组名
	comment		VARCHAR(255)			--注释
);

--表名：带宽资源和资源组映射表 yangcy 20050503
create table bandwidth_classgrpmap
(
	classgrpid		INT,					--地址组ID
	childclassid	INT,					--子类ID
	parentclassid	INT,    				--父类ID
	ethout			CHAR(20)				--流出网卡
);

----表名: 预定义服务
create table defaultservice
(
    id          INTEGER PRIMARY KEY,    --ID号
    vmfwid		int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙,用于servicename
    name        CHAR(32),               --预定义服务名称
    protocol    INT,                    --协议
    port        INT,                    --端口号
    comment     VARCHAR(255)            --注释
);
INSERT INTO defaultservice VALUES(1,0,'any',0,-1,'任意服务');
INSERT INTO defaultservice VALUES(2,0,'http',6,80,"www service");
INSERT INTO defaultservice VALUES(3,0,'tcp_any',6,-1,"tcp service");
INSERT INTO defaultservice VALUES(4,0,'udp_any',17,-1,"udp service");
INSERT INTO defaultservice VALUES(5,0,'icmp_any',1,-1,"icmp service");
INSERT INTO defaultservice VALUES(6,0,'telnet',6,23,"telnet service");
INSERT INTO defaultservice VALUES(7,0,'smtp',6,25,"smtp service");
INSERT INTO defaultservice VALUES(8,0,'pop3',6,110,"pop3 service");
INSERT INTO defaultservice VALUES(9,0,'snmp',17,161,"snmp service");
INSERT INTO defaultservice VALUES(10,0,'dns_query',17,53,"dns_query service");
INSERT INTO defaultservice VALUES(11,0,'https',6,443,"https service");
INSERT INTO defaultservice VALUES(12,0,'SQLNet_1521',6,1521,"SQLNet_1521 service");
INSERT INTO defaultservice VALUES(13,0,'IGMP',2,-1,"IGMP");
INSERT INTO defaultservice VALUES(14,0,'OSPF',89,-1,"OSPF");
INSERT INTO defaultservice VALUES(15,0,'IGRP',88,-1,"IGRP");
INSERT INTO defaultservice VALUES(16,0,'GRE',47,-1,"GRE");
INSERT INTO defaultservice VALUES(17,0,'Syslog',17,514,"Syslog");
INSERT INTO defaultservice VALUES(18,0,'RemoteDesk',6,3389,"微软远程桌面");
INSERT INTO defaultservice VALUES(19,0,'ssh',6,22,"ssh service");
INSERT INTO defaultservice VALUES(20,0,'imap',6,143,"imap service");
INSERT INTO defaultservice VALUES(21,0,'cvs',6,2401,"cvs service");
INSERT INTO defaultservice VALUES(22,0,'dhcp_tcp_67',6,67,"dhcp_tcp_67 service");
INSERT INTO defaultservice VALUES(23,0,'dhcp_tcp_68',6,68,"dhcp_tcp_68 service");
INSERT INTO defaultservice VALUES(24,0,'MS_NetMeeting',6,1503,"MS_NetMeeting service");
INSERT INTO defaultservice VALUES(25,0,'MS_NetShow',17,1755,"MS_NetShow service");
INSERT INTO defaultservice VALUES(26,0,'ntp_tcp',6,123,"ntp_tcp service");
INSERT INTO defaultservice VALUES(27,0,'ntp_udp',17,123,"ntp_udp service");
INSERT INTO defaultservice VALUES(28,0,'nntp',6,119,"nntp service");
INSERT INTO defaultservice VALUES(29,0,'pcanywhere_tcp',6,5631,"pcanywhere_tcp service");
INSERT INTO defaultservice VALUES(30,0,'pcanywhere_udp',17,5632,"pcanywhere_udp service");
INSERT INTO defaultservice VALUES(31,0,'oracle_1521',6,1521,"oracle_1521 service");
INSERT INTO defaultservice VALUES(32,0,'oracle_1526',6,1526,"oracle_1526 service");
INSERT INTO defaultservice VALUES(33,0,'mssql',6,1433,"mssql service");
INSERT INTO defaultservice VALUES(34,0,'mysql',6,3306,"mysql service");
INSERT INTO defaultservice VALUES(35,0,'postgresql',6,5432,"postgresql service");
INSERT INTO defaultservice VALUES(36,0,'sybase',6,5000,"sybase service");
INSERT INTO defaultservice VALUES(37,0,'db2',6,50000,"db2 service");
INSERT INTO defaultservice VALUES(38,0,'l2tp_tcp',6,1701,"l2tp_tcp service");
INSERT INTO defaultservice VALUES(39,0,'l2tp_udp',17,1701,"l2tp_udp service");
INSERT INTO defaultservice VALUES(40,0,'pptp',6,1723,"pptp service");
INSERT INTO defaultservice VALUES(41,0,'echo_tcp',6,7,"echo_tcp service");
INSERT INTO defaultservice VALUES(42,0,'echo_udp',17,7,"echo_udp service");
INSERT INTO defaultservice VALUES(43,0,'ldap_389',6,389,"ldap_389 service");
INSERT INTO defaultservice VALUES(44,0,'ldap_636',6,636,"ldap_636 service");
INSERT INTO defaultservice VALUES(45,0,'gmail_imap',6,993,"gmail_imap service");
INSERT INTO defaultservice VALUES(46,0,'icmpv6_any',58,-1,"icmpv6 service");
INSERT INTO defaultservice VALUES(47,0,'OSPFv3',89,-1,"OSPFv3 service");
INSERT INTO defaultservice VALUES(48,0,'LOOP',96,-1,"Ethernet Loopback packet");
INSERT INTO defaultservice VALUES(49,0,'X11',6,6000,"X11 service");
INSERT INTO defaultservice VALUES(50,0,'QQ',17,8000,"QQ service");
INSERT INTO defaultservice VALUES(51,0,'ASP_Net_Session',6,42424,"ASP.Net_Session service");
INSERT INTO defaultservice VALUES(52,0,'NFSD',17,2049,"NFSD");
INSERT INTO defaultservice VALUES(53,0,'H_225',6,1720,"H.225 service");
INSERT INTO defaultservice VALUES(54,0,'H_225RAS',17,1719,"H.225RAS service");
INSERT INTO defaultservice VALUES(55,0,'MMS',6,1755,"MMS");
INSERT INTO defaultservice VALUES(56,0,'msn',6,1863,"msn service");
INSERT INTO defaultservice VALUES(57,0,'nfs',6,2049,"nfs service");
INSERT INTO defaultservice VALUES(58,0,'MS_Theater',17,2460,"MS_Theater service");
INSERT INTO defaultservice VALUES(59,0,'UPNP',6,2869,"UPNP");
INSERT INTO defaultservice VALUES(60,0,'squid',6,3128,"squid service");
INSERT INTO defaultservice VALUES(61,0,'cluster',17,3343,"cluster service");
INSERT INTO defaultservice VALUES(62,0,'MSTerminal',6,3389,"MSTerminal service");
INSERT INTO defaultservice VALUES(63,0,'BINL',17,4011,"BINL service");
INSERT INTO defaultservice VALUES(64,0,'NAT-T',17,4500,"NAT-T service");
INSERT INTO defaultservice VALUES(65,0,'RTP',17,5004,"RTP");
INSERT INTO defaultservice VALUES(66,0,'RTCP',17,5005,"RTCP");
INSERT INTO defaultservice VALUES(67,0,'AOL',6,5190,"AOL");
INSERT INTO defaultservice VALUES(68,0,'securID_tcp',6,5510,"securID_tcp service");
INSERT INTO defaultservice VALUES(69,0,'securID_udp',17,5510,"securID_udp service");
INSERT INTO defaultservice VALUES(70,0,'RealAudio_ctrl',6,7070,"RealAudio_ctrl service");
INSERT INTO defaultservice VALUES(71,0,'RIPng',17,521,"RIPng service");
INSERT INTO defaultservice VALUES(72,0,'PPTP',6,1723,"PPTP service");
INSERT INTO defaultservice VALUES(73,0,'IPIP',4,-1,"IPIP tunnels");
INSERT INTO defaultservice VALUES(74,0,'EGP',8,-1,"Exterior Gateway Protocol");
INSERT INTO defaultservice VALUES(75,0,'PUP',12,-1,"PUP protocol");
INSERT INTO defaultservice VALUES(76,0,'IDP',22,-1,"XNS IDP protocol");
INSERT INTO defaultservice VALUES(77,0,'RSVP',46,-1,"RSVP protocol");
INSERT INTO defaultservice VALUES(78,0,'IPV6',41,-1,"IPv6-in-IPv4 tunnelling");
INSERT INTO defaultservice VALUES(79,0,'PIM',103,-1,"Protocol Independent Multicast");
INSERT INTO defaultservice VALUES(80,0,'ESP',50,-1,"Encapsulation Security Payload protocol");
INSERT INTO defaultservice VALUES(81,0,'AH',51,-1,"Authentication Header protocol");
INSERT INTO defaultservice VALUES(82,0,'SQLNet_1525',6,1525,"SQLNet_1525 service");
INSERT INTO defaultservice VALUES(83,0,'PING',1,8,"PING");
INSERT INTO defaultservice VALUES(84,0,'Discard_tcp',6,9,"Discard_tcp service");
INSERT INTO defaultservice VALUES(85,0,'Discard_udp',17,9,"Discard_udp service");
INSERT INTO defaultservice VALUES(86,0,'Daytime_tcp',6,13,"Daytime_tcp service");
INSERT INTO defaultservice VALUES(87,0,'Daytime_udp',17,13,"Daytime_udp service");
INSERT INTO defaultservice VALUES(88,0,'NETSTAT',6,15,"NETSTAT");
INSERT INTO defaultservice VALUES(89,0,'Quotd_tcp',6,17,"Quotd_tcp service");
INSERT INTO defaultservice VALUES(90,0,'Quotd_udp',17,17,"Quotd_udp service");
INSERT INTO defaultservice VALUES(91,0,'Chargen_tcp',6,19,"Chargen_tcp service");
INSERT INTO defaultservice VALUES(92,0,'Chargen_udp',17,19,"Chargen_udp service");
INSERT INTO defaultservice VALUES(93,0,'FTP',6,21,"FTP");
INSERT INTO defaultservice VALUES(94,0,'TIME_tcp',6,37,"TIME_tcp service");
INSERT INTO defaultservice VALUES(95,0,'TIME_udp',17,37,"TIME_udp service");
INSERT INTO defaultservice VALUES(96,0,'WinsReplic_tcp',6,42,"WINS_Replication(tcp) service");
INSERT INTO defaultservice VALUES(97,0,'WinsReplic_udp',17,42,"WINS_Replication(udp) service");
INSERT INTO defaultservice VALUES(98,0,'TACACS_PLUS',6,49,"TACACS_PLUS");
INSERT INTO defaultservice VALUES(99,0,'TACACS',17,49,"TACACS");
INSERT INTO defaultservice VALUES(100,0,'TACACS_DS',6,65,"TACACS_DS");
INSERT INTO defaultservice VALUES(101,0,'SQL_NET',6,66,"SQL_NET");
INSERT INTO defaultservice VALUES(102,0,'Bootstrap_Serv',17,67,"Bootstrap_Server(DHCP) service");
INSERT INTO defaultservice VALUES(103,0,'Bootstrap_Cli',17,68,"Bootstrap_Client service");
INSERT INTO defaultservice VALUES(104,0,'dns_transfer',6,53,"dns_transfer service");
INSERT INTO defaultservice VALUES(105,0,'TFTP',17,69,"TFTP");
INSERT INTO defaultservice VALUES(106,0,'Gopher',6,70,"Gopher service");
INSERT INTO defaultservice VALUES(107,0,'Finger',6,79,"Finger service");
INSERT INTO defaultservice VALUES(108,0,'KERBEROS_TCP',6,88,"KERBEROS_KEY(TCP)");
INSERT INTO defaultservice VALUES(109,0,'KERBEROS_UDP',17,88,"KERBEROS_KEY(UDP)");
INSERT INTO defaultservice VALUES(110,0,'NPP',6,92,"NPP");
INSERT INTO defaultservice VALUES(111,0,'X_400',6,102,"X.400");
INSERT INTO defaultservice VALUES(112,0,'rtelnet',6,107,"rtelnet service");
INSERT INTO defaultservice VALUES(113,0,'SNA_GAS',6,108,"SNA_GAS");
INSERT INTO defaultservice VALUES(114,0,'SUNRPC',6,111,"SUNRPC");
INSERT INTO defaultservice VALUES(115,0,'AUTH',6,113,"AUTH");
INSERT INTO defaultservice VALUES(116,0,'SQLSERV',6,118,"SQLSERV");
INSERT INTO defaultservice VALUES(117,0,'SQL-NET',6,150,"SQL-NET");
INSERT INTO defaultservice VALUES(118,0,'SQLSRV',6,156,"SQLSRV");
INSERT INTO defaultservice VALUES(119,0,'XDMCP',6,177,"XDMCP");
INSERT INTO defaultservice VALUES(120,0,'BGP',6,179,"BGP");
INSERT INTO defaultservice VALUES(121,0,'GACP',6,190,"GACP");
INSERT INTO defaultservice VALUES(122,0,'IRC',6,194,"IRC");
INSERT INTO defaultservice VALUES(123,0,'DLS',6,197,"DLS");
INSERT INTO defaultservice VALUES(124,0,'DLS-MON',6,198,"DLS-MON");
INSERT INTO defaultservice VALUES(125,0,'SRC',6,200,"SRC");
INSERT INTO defaultservice VALUES(126,0,'WAIS',6,210,"WAIS");
INSERT INTO defaultservice VALUES(127,0,'epmap_tcp',6,135,"epmap_tcp service");
INSERT INTO defaultservice VALUES(128,0,'epmap_udp',17,135,"epmap_udp service");
INSERT INTO defaultservice VALUES(129,0,'NETBIOS-NS',17,137,"NETBIOS-NS");
INSERT INTO defaultservice VALUES(130,0,'NETBIOS-DGM',17,138,"NETBIOS-DGM");
INSERT INTO defaultservice VALUES(131,0,'NETBIOS-SSN_TCP',6,139,"NETBIOS-SSN(TCP)");
INSERT INTO defaultservice VALUES(132,0,'NETBIOS-SSN_UDP',17,139,"NETBIOS-SSN(UDP)");
INSERT INTO defaultservice VALUES(133,0,'Micrsoft-ds_udp',17,445,"MICROSOFT-DS(UDP)");
INSERT INTO defaultservice VALUES(134,0,'Micrsoft-ds_tcp',6,445,"MICROSOFT-DS(TCP)");
INSERT INTO defaultservice VALUES(135,0,'HttpRpcEpmapUdp',17,593,"http-rpc-epmap(UDP) service");
INSERT INTO defaultservice VALUES(136,0,'HttpRpcEpmapTcp',6,593,"http-rpc-epmap(TCP) service");
INSERT INTO defaultservice VALUES(137,0,'HP-collector',6,381,"HP-collector service");
INSERT INTO defaultservice VALUES(138,0,'HP-managed-node',6,382,"HP-managed-node service");
INSERT INTO defaultservice VALUES(139,0,'HP-alarm-mgr',6,383,"HP-alarm-mgr service");
INSERT INTO defaultservice VALUES(140,0,'netware_IP',6,396,"netware_IP service");
INSERT INTO defaultservice VALUES(141,0,'snpp',6,444,"snpp service");
INSERT INTO defaultservice VALUES(142,0,'KerberosPwd_TCP',6,464,"kerberos_passwd(TCP) service");
INSERT INTO defaultservice VALUES(143,0,'Apple_QTC',6,458,"Apple_QTC");
INSERT INTO defaultservice VALUES(144,0,'RCP',6,469,"RCP");
INSERT INTO defaultservice VALUES(145,0,'ROUTER',17,520,"ROUTER");
INSERT INTO defaultservice VALUES(146,0,'IPSEC_ISAKMP',17,500,"IPSEC_ISAKMP");
INSERT INTO defaultservice VALUES(147,0,'REXEC',6,512,"REXEC");
INSERT INTO defaultservice VALUES(148,0,'RLOGIN',6,513,"RLOGIN");
INSERT INTO defaultservice VALUES(149,0,'WHO',17,513,"WHO");
INSERT INTO defaultservice VALUES(150,0,'RSH',6,514,"RSH");
INSERT INTO defaultservice VALUES(151,0,'LPD',6,515,"LPD");
INSERT INTO defaultservice VALUES(152,0,'EFS',6,520,"EFS");
INSERT INTO defaultservice VALUES(153,0,'IBM-DB2',6,523,"IBM-DB2");
INSERT INTO defaultservice VALUES(154,0,'UUCP',6,540,"UUCP");
INSERT INTO defaultservice VALUES(155,0,'dhcpv6_client',6,546,"dhcpv6_client service");
INSERT INTO defaultservice VALUES(156,0,'dhcpv6_server',6,547,"dhcpv6_server service");
INSERT INTO defaultservice VALUES(157,0,'RTSP',6,554,"RTSP");
INSERT INTO defaultservice VALUES(158,0,'nntps',6,563,"nntps service");
INSERT INTO defaultservice VALUES(159,0,'MacFile',6,548,"MacFile service");
INSERT INTO defaultservice VALUES(160,0,'IIOP',17,530,"IIOP");
INSERT INTO defaultservice VALUES(161,0,'corba-IIOP',6,683,"corba-IIOP service");
INSERT INTO defaultservice VALUES(162,0,'corba-IIOP-SSL',6,684,"corba-IIOP-SSL service");
INSERT INTO defaultservice VALUES(163,0,'IPCSERVER',6,600,"IPCSERVER");
INSERT INTO defaultservice VALUES(164,0,'kerberos-adm',6,749,"kerberos-adm service");
INSERT INTO defaultservice VALUES(165,0,'kerberos_tcp',6,750,"kerberos_tcp service");
INSERT INTO defaultservice VALUES(166,0,'kerberos_udp',6,750,"kerberos_udp service");
INSERT INTO defaultservice VALUES(167,0,'pop3_over_ssl',6,995,"pop3_over_ssl service");
INSERT INTO defaultservice VALUES(168,0,'socks',6,1080,"socks service");
INSERT INTO defaultservice VALUES(169,0,'WebSadmin_boot',6,900,"WebSphere_admin_bootstrap service");
INSERT INTO defaultservice VALUES(170,0,'WebSadmin_lsd',6,9000,"WebSphere_admin_admin_lsd service");
INSERT INTO defaultservice VALUES(171,0,'WebSS_engine',6,8110,"WebSphere_servlet_engine service");
INSERT INTO defaultservice VALUES(172,0,'WebSS_redirect',6,9367,"WebSphere_servlet_redirector service");
INSERT INTO defaultservice VALUES(173,0,'vosaic',6,1235,"vosaic service");
INSERT INTO defaultservice VALUES(174,0,'LotusNotes',6,1352,"LotusNotes service");
INSERT INTO defaultservice VALUES(175,0,'WINS',6,1512,"WINS");
INSERT INTO defaultservice VALUES(176,0,'radacct_1813',17,1813,"radacct_1813 service");
INSERT INTO defaultservice VALUES(177,0,'MS-SQL-M',6,1434,"MS-SQL-M");
INSERT INTO defaultservice VALUES(178,0,'MS-SQL-R',17,1434,"MS-SQL-R");
INSERT INTO defaultservice VALUES(179,0,'radius_1645',17,1645,"radius_1645 service");
INSERT INTO defaultservice VALUES(180,0,'radacct_1646',17,1646,"radacct_1646 service");
INSERT INTO defaultservice VALUES(181,0,'radius_1812',17,1812,"radius_1812 service");


----表名: 自定义服务(普通)
create table service
(
    id          INTEGER PRIMARY KEY,    --服务ID  sequence
    vmfwid		int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name        CHAR(20),               --服务名
    slport1     INT,                    --源低端口1
    shport1     INT,                    --源高端口1
    dlport1     INT,                    --目标低端口1
    dhport1     INT,                    --目标高端口1
    protocol1   INT,                    --协议1, 协议存数字
    slport2     INT,                    --源低端口2
    shport2     INT,                    --源高端口2
    dlport2     INT,                    --目标低端口2
    dhport2     INT,                    --目标高端口2
    protocol2   INT,                    --协议2
    slport3     INT,                    --源低端口3
    shport3     INT,                    --源高端口3
    dlport3     INT,                    --目标低端口3
    dhport3     INT,                    --目标高端口3
    protocol3   INT,                    --协议3
    slport4     INT,                    --源低端口4
    shport4     INT,                    --源高端口4
    dlport4     INT,                    --目标低端口4
    dhport4     INT,                    --目标高端口4
    protocol4   INT,                    --协议4
    slport5     INT,                    --源低端口5
    shport5     INT,                    --源高端口5
    dlport5     INT,                    --目标低端口5
    dhport5     INT,                    --目标高端口5
    protocol5   INT,                    --协议5
    slport6     INT,                    --源低端口6
    shport6     INT,                    --源高端口6
    dlport6     INT,                    --目标低端口6
    dhport6     INT,                    --目标高端口6
    protocol6   INT,                    --协议6
    slport7     INT,                    --源低端口7
    shport7     INT,                    --源高端口7
    dlport7     INT,                    --目标低端口7
    dhport7     INT,                    --目标高端口7
    protocol7   INT,                    --协议7
    slport8     INT,                    --源低端口8
    shport8     INT,                    --源高端口8
    dlport8     INT,                    --目标低端口8
    dhport8     INT,                    --目标高端口8
    protocol8   INT,                    --协议8
    comment     VARCHAR(255)            --备注
);

INSERT INTO service VALUES(1,0,"netbios",0,65535,137,139,6,0,65535,137,139,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"NetBIOS");
INSERT INTO service VALUES(2,0,"lotusnotes",0,65535,1352,1352,6,0,65535,1352,1352,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Lotus Notes");
INSERT INTO service VALUES(3,0,"radius",0,65535,1812,1813,6,0,65535,1812,1813,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Radius");

----表名: 自定义服务(动态)
create table dynamic_service
(
    id                INTEGER PRIMARY KEY,    --ID号
    vmfwid		int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name              CHAR(20),               --动态协议名称
    protocol          INT,                    --基于协议, 1为ftp，2为h.323，3为tns,注意：这里不是用getprotobynumber()来解析
    port              VARCHAR(255),           --动态协议端口
    ftp_get           BOOL,                   --ftp的get动作, 0为禁止,1为允许
    ftp_put           BOOL,                   --ftp的put动作, 0为禁止,1为允许
    ftp_multi_thread  BOOL,                   --ftp的多线程, 0为禁止,1为允许
    comment           VARCHAR(255)            --备注
);

INSERT INTO dynamic_service VALUES(1,0,'ftp',1,21,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(2,0,'h323',2,1720,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(3,0,'tns',3,1521,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(4,0,'rtsp',5,554,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(5,0,'tftp',6,69,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(6,0,'irc',7,6667,0,0,0,"default service");

----表名: 自定义服务(ICMP)
create table icmp_service
(
    id              INTEGER PRIMARY KEY,    -- ID号
     vmfwid		int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
   name            CHAR(20),               -- ICMP动态协议名称
    type            INT,                    -- -1表示任意type
    code            INT,                    -- -1表示任意code
    comment         VARCHAR(255)            -- 备注
);

----表名: 自定义服务(ICMPv6)
create table icmpv6_service
(
    id              INTEGER PRIMARY KEY,    -- ID号
    vmfwid			int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
   	name            CHAR(20),               -- ICMP动态协议名称
    type            INT,                    -- -1表示任意type
    code            INT,                    -- -1表示任意code
    comment         VARCHAR(255)            -- 备注
);


----表名: 服务组
create table servicegrp
(
    id              INTEGER PRIMARY KEY,    --服务组ID sequence
    vmfwid		int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
    name            CHAR(20),               --服务组名
    comment         VARCHAR(255)            --服务组说明
);

----表名:IPv6服务组
create table servicegrp6
(
    id              INTEGER PRIMARY KEY,    --服务组ID sequence
    vmfwid			int no null,			--虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙
   	name            CHAR(20),               --服务组名
    comment         VARCHAR(255)            --服务组说明
);

----表名: 服务对应表
create table servicemap
(
    servicegrpid     INT,                   --服务组ID
    servicetype      INT,                   --服务类型
                                              --1为预定义服务，
                                              --2为自定义服务（动态协议）
                                              --3为自定义服务（ICMP协议）
                                              --4为自定义服务（普通自定义服务）
                                              --(5为服务组, 在这里不会出现)
    serviceid        INT                    --地址ID
);

----表名: IPv6服务对应表
create table service6map
(
    servicegrpid     INT,                   --服务组ID
    servicetype      INT,                   --服务类型
                                              --1为预定义服务，
                                              --2为自定义服务（动态协议）
                                              --3为自定义服务（ICMPv6协议）
                                              --4为自定义服务（普通自定义服务）
                                              --(5为服务组, 在这里不会出现)
    serviceid        INT                    --地址ID
);
--视图: 所有服务的服务名
CREATE VIEW servicename AS
SELECT name, vmfwid  FROM   defaultservice
UNION
SELECT name,vmfwid  FROM   service
UNION
SELECT name,vmfwid  FROM   dynamic_service
UNION
SELECT name,vmfwid  FROM   icmp_service
UNION
SELECT name,vmfwid  FROM   servicegrp;
--视图：ipv6所有的服务名
CREATE VIEW service6name AS
SELECT name, vmfwid  FROM   defaultservice
UNION
SELECT name,vmfwid  FROM   service
UNION
SELECT name,vmfwid  FROM   dynamic_service
UNION
SELECT name,vmfwid  FROM   icmpv6_service
UNION
SELECT name,vmfwid  FROM   servicegrp6;
--视图: 所有服务的服务名
CREATE VIEW portservicename AS
SELECT name,vmfwid  FROM   defaultservice
UNION
SELECT name,vmfwid  FROM   service
UNION
SELECT name,vmfwid  FROM   dynamic_service
UNION
SELECT name,vmfwid  FROM   icmp_service;


--视图: TCP+UDP的服务名,用于端口映射规则
CREATE VIEW tudfservice AS
SELECT name, id  FROM   defaultservice where (protocol = 6 or protocol = 17 );

CREATE VIEW tuservice AS
SELECT name, id  FROM   service  where (protocol1 = 6 or protocol1 = 17) and (protocol2 = 6 or protocol2 = 17 or protocol2 = 256) and (protocol3 = 6 or protocol3 = 17 or protocol3 = 256)and (protocol4 = 6 or protocol4 = 17 or protocol4 = 256)and (protocol5 = 6 or protocol5 = 17 or protocol5 = 256)and (protocol6 = 6 or protocol6 = 17 or protocol6 = 256)and (protocol7 = 6 or protocol7 = 17 or protocol7 = 256)and (protocol8 = 6 or protocol8 = 17 or protocol8 = 256);

CREATE VIEW tudyservice AS
SELECT name, id  FROM   dynamic_service;

CREATE VIEW tuservicegrp1 AS
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudfservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 1 and (servicemap.serviceid in (select id from tudfservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudyservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 2 and (servicemap.serviceid in (select id from tudyservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tuservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 4 and (servicemap.serviceid in (select id from tuservice));

CREATE VIEW tuservicegrp2 AS
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudfservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 1 and (servicemap.serviceid not in (select id from tudfservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudyservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 2 and (servicemap.serviceid not in (select id from tudyservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tuservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 4 and (servicemap.serviceid not in (select id from tuservice));


CREATE VIEW tuservicegrp AS
SELECT DISTINCT(name) AS name FROM tuservicegrp1 where  name not in (select name from tuservicegrp2);



CREATE VIEW pnatservicename AS
SELECT name  FROM   tudfservice
UNION
SELECT name  FROM   tuservice
UNION
SELECT name  FROM   tudyservice
UNION
SELECT name  FROM   tuservicegrp;




--视图: TCP+UDP单个端口的服务名,用于代理规则
CREATE VIEW proxydfservice AS
SELECT name, id,vmfwid  FROM   defaultservice where ((protocol = 6 or protocol = 17 ) and port != -1) or (protocol != 6 and protocol != 17 and protocol != 0);

CREATE VIEW proxyservice AS
SELECT name, id,vmfwid  FROM   service  where ((protocol1 = 6 or protocol1 = 17) and (dlport1=dhport1))
                                   and (protocol2 = 256)
                                   and (protocol3 = 256)
                                   and (protocol4 = 256)
                                   and (protocol5 = 256)
                                   and (protocol6 = 256)
                                   and (protocol7 = 256)
                                   and (protocol8 = 256);

CREATE VIEW proxydyservice AS
SELECT name, id,vmfwid  FROM   dynamic_service where protocol = 1 and port != '' and port != '-1';

CREATE VIEW proxyservicename AS
SELECT name,vmfwid  FROM   proxydfservice
UNION
SELECT name,vmfwid  FROM   proxyservice
UNION
SELECT name,vmfwid  FROM   icmp_service
UNION
SELECT name,vmfwid  FROM   proxydyservice;

--2005/1/13	zhuxp	增加域名地址
----表名: 安全规则
create table policyinfo
(
	id     INT,        --序号，规则序号，表示顺序，唯一，非自动增长，由程序控制增长
	vmfwid INT,         --虚拟防火墙id,用来标识这条规则属于那个虚拟防火墙。
	name  CHAR(256),  --规则名 
	type   INT,        --类型，1为permit，2为deny，3为proxy，4为nat，5为portmap，6为ipmap, 7为auth, 8为masquerade,9为vpn,10 nataccept,11 portaccept 12 ipaccept
	saddrtype INT,       --源地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
	saddrid  INT,        --源地址ID
	saddrip  CHAR(15),  --源地址IP
	saddrmask CHAR(15),  --源地址MASK
	sattype   INT,        --源地址转换类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的) 5为地址池，6为防火墙地址
	satid     INT,         --源地址转换ID
	satip     CHAR(15),   --源地址转换IP  //如果sattype=6，该项存放接口外部名称
	satmask  CHAR(17),   --源地址转换MASK
	sport    CHAR(128),   --源端口
	smac    CHAR(17),    --源MAC
	satport   CHAR(128),   --源端口转换
	daddrtype   INT,       --目的地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
	daddrid     INT,       --目的地址ID
	daddrip   CHAR(15),   --目的地址IP
	daddrmask  CHAR(17),  --目的地址MASK
	pubtype     INT,       --公开地址类型     2为地址定义,6为防火墙地址
	pubid     CHAR(15),    --公开地址ID       (对应interface里的外部地址)
	innertype    INT,        --内部服务器地址类型, (1为IP地址/掩码,在这里不出现), (2为地址定义, 不出现)，(3为地址组定义, 不出现)，4服务器地址
	innerid      INT,        --内部服务器地址ID
	innerip     CHAR(15),   --内部地址IP(现在不用，防止以后要加上该项功能,只支持一个内部服务器)
	ethin     CHAR(20),     --流入网卡, "any"表示任意网络接口
	ethout    CHAR(20),     --流出网卡, "any"表示任意网络接口
	servicetype   INT,        --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
  serviceid       INT,      --服务ID
  pubservicetype  INT,      --对外服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
  pubserviceid    INT,      --对外服务ID
  innerservicetype  INT,     --内部服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
  innerserviceid  INT,       --内部服务ID
  proxytype     INT,       --代理类型, 1为固定代理，2为自定义代理
  proxyid       INT,       --代理ID，1为http，2为ftp,3为telnet,4为smtp,5为pop3,6为socks,7为dns,8为icmp,9为msn
  timetype      INT,       --时间类型, 1为时间定义，2为时间组(暂不使用该字段，为扩展做准备)
  timeid        INT,        --时间ID，(暂不使用该字段，为扩展做准备)
  timename   CHAR(20),    --时间调度名称（现在的程序中用名称来联系）
  longcon      INT,        --是否支持长连接，0为禁用，>0为启用, 单位为秒
  log         BOOL,       --是否记录过滤日志，0为禁用，1为启用
  synflood     INT,         --是否抗SYN Flood攻击，0为禁用，>0为启用, 单位为个/秒
  udpflood     INT,       --是否抗UDP Flood攻击，0为禁用，>0为启用, 单位为个/秒
  icmpflood    INT,       --是否抗ICMP Flood攻击，0为禁用，>0为启用, 单位为个/秒
  pod        BOOL,      --是否抗Ping of Death攻击，0为禁用，1为启用
  active      BOOL,      --是否启用(即是否生效)，0为禁用，1为启用
  hideinner	BOOL, 		--是否隐藏内部地址或端口，用于端口映射和ip映射
	--added by hanhz, 2005/06/27, begin
	dcf        INT DEFAULT 0,     --深度过滤策略，0为禁用  
	username	CHAR(20), 		   	--用户组名
	usergpid	INT,  				--用户组id
	apc   INT,                    --是否开启应用协议控制
	urlblock   INT,                 --是否开启urlblock过滤
	comment	VARCHAR(255), 	--注释
	--add for utm begin
	avpolicy	INT DEFAULT 0,	--AV策略,0为禁用
	ipspolicy	INT DEFAULT 0,	--IPS策略，0为禁用
	pcpolicy	INT DEFAULT 0,	--PC策略，0为禁用
	eimpolicy	INT DEFAULT 0,	--上网行为管理策略，0为禁用
	--add for utm end
	
	--added by songpy begin
	roleid		VARCHAR(1024),	--角色ID(auth)
	--added by songpy end
    
	--added by hanhz, 2005/06/27, end
	--added by jianghai begin
	--add for utm antispam begein

	ANTISPAM_INPUT_W		INT, --反垃圾邮件
	ANTISPAM_PREROUTING_W		INT, --反垃圾邮件
	--add for utm antispam end
	IPS_POLICY_W			INT,          	-- 主动防御
	APCPOLICY_W			INT,          	-- 应用识别
	URLPOLICY_W			INT,         	-- URL过滤
	POLICY_W 		    INT,				-- 包过滤			
	PROXY_INPUT_W		INT,				-- 代理相关	
	AUTH_SERVER_W		INT,				-- 用户认证相关	
	AUTH_W			    INT,				-- 用户认证相关	
	IPMAP_W		        INT,				-- ip映射
	IPMAPNAT_W		    INT,				-- ip映射中的源地址转换
	HIDEIPMAP_W		    INT,				-- ip映射中隐藏地址
	PORTMAP_W		    INT,				-- 端口映射	
	PORTMAPNAT_W		INT,				-- 端口映射中的源地址转换
	HIDEPORTMAP_W		INT,				-- 端口映射隐藏地址	
	TRANS_PROXY_W		INT,				-- 代理相关	
	POSTROUTINGNAT_W	INT,				-- 源地址转换
	VPN_POSTROUTING_MANGLE_DROP_W		INT,		    -- VPN相关
	IPSCADM_W			INT,				-- 抗synflood攻击 此规则没有自己的链
	ANTIATTACK_W		INT, -- icmpflood udpflood pingofdeath
	VMCHAIN_W   			INT,		-- 虚拟防火墙相关
	VMPOSTROUTINGNAT_W	INT,	-- 虚拟防火墙相关
	VMPORTMAP_W			INT, 		-- 虚拟防火墙相关
	VMGNCHAIN_W			INT, 		-- 虚拟防火墙相关
	VMBLACKCHAIN_W		INT, 		-- 虚拟防火墙相关
	VMHIDEPORTMAP_W		INT, 		-- 虚拟防火墙相关
	VMPORTMAPNAT_W		INT, 		-- 虚拟防火墙相关
	VMIPMAP_W				INT, 		-- 虚拟防火墙相关
	VMHIDEIPMAP_W			INT, 		-- 虚拟防火墙相关	
	VMIPMAPNAT_W			INT			-- 虚拟防火墙相关
	--added by jianghai end
);



--add by gaozhi,20110705 begin
-- 表名:IPv6简单包过滤
create table pkgfilter6
(
    id    INTERGER PRIMARY KEY,        --主键,规则序号
    name    CHAR(256) not null,         --规则名称  
    type    INTERGER,                  --类型 1为permit,2为deny
    activecnt    INTERGER,   	       --保留,此条规则前处于激活状态的规则数目
    active    BOOL DEFAULT 1,          --是否处于激活状态
    flag    INTERGER,    	       --保留,位图表示设置了那些内容
    srciptype    INTERGER,   	       --源IP地址类型,1为IP地址/掩码, 2为地址定义,3为地址组定义,(4服务器地址,但在这里不出现的),7为any,8为域名地址
    srcipid   INT,      	       --源地址ID
    srcip    CHAR(48),   	       --IP地址或IP地址组名称
	srcipmask  CHAR(8),                --源地址前缀
    srcport    CHAR(128),             --源端口
    smac     CHAR(17),     	       --源MAC
    iif    CHAR(20),    	       --流入网口名称,"any"表示任意网络接口
    dstiptype    INTERGER,   	       --目的地址类型, 1为IP地址/掩码, 2为地址定义,3为地址组定义,(4服务器地址,但在这里不出现的),7为any,8为域名地址
    dstipid   INT,      	       --目的地址ID
    dstip    CHAR(48),  	       --目的IP地址或IP地址组名称
	dstipmask  CHAR(8), 	       --目的地址前缀
    oif    CHAR(20),   		       --流出网口名称,"any"表示任意网络接口
    servicetype    INT,     	       --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid   INT,       	       --服务ID
    servicename    CAHR(20), 	       --服务名称
    timetype     INT,     	       --时间类型, 1为时间定义,2为时间组(暂不使用该字段,为扩展做准备)
    timeid       INT,     	       --时间ID,(暂不使用该字段,为扩展做准备)
    timename   CHAR(20),               --时间调度名称
    pkgsize    CHAR(10),               --保留,IP数据包的净荷长度
    ttl    CHAR(20),                   --保留,IP数据包的跳极限
    tos    INTERGER,                   --保留,IP数据包的类别
    log    BOOL,                     --是否记录日志
    comment    CHAR(256),              --备注
    ah_flag    INTERGER,               --位图表示设置了那些内容
    ah_spi    CHAR(22),   	       --身份验证头,spi的取值或范围
    ah_length    CHAR(11),  	       --身份验证头,长度
    ah_reschk    BOOL DEFAULT 0,       --身份验证头,是否检测预留域
    dst_flag    INTERGER,   	       --位图表示设置了那些内容
    dst_length    CHAR(11),   	       --目的地选项头,此选项头的长度
    dst_opt    CHAR(128),    	       --目的地选项头,携带选项的类型及长度
    frag_flag    INTERGER,  	       --位图表示设置了那些内容
    frag_id    CHAR(16),   	       --分段头,指定的标识符或范围
    frag_length    CHAR(11),           --分段头,此选项头的长度
    frag_reschk    BOOL DEFAULT 0,     --分段头,是否检测预留域
    frag_first    BOOL DEFAULT 0,      --分段头,是否匹配第一个分片
    frag_more_or_last    INTERGER,     --分段头,0表示未使用,1表示匹配有更多分片,2表示匹配最后的分片
    hbh_flag    INTERGER,              --位图表示设置了那些内容
    hbh_length    CHAR(11),            --逐跳选项头,此选项头的长度
    hbh_opt    CHAR(128),              --逐跳选项头,携带选项的类型及长度
    mh_flag    INTERGER,               --位图表示设置了那些内容
    mh_type    CHAR(16),               --移动头,指定的类型或范围
    rt_flag    INTERGER,               --位图表示设置了那些内容
    rt_type    CHAR(8),                --选路头,类型
    rt_segsleft    CHAR(16),           --选路头,匹配Segments Left域的值或范围
    rt_length    CHAR(8),              --选路头,此选项头的长度
    esp_flag    INTERGER,              --位图表示设置了那些内容
    esp_spi    CHAR(22),               --封装安全性净荷头,spi的取值或范围
    --utm add for ipv6 begin
	  avpolicy	INT DEFAULT 0,	--AV策略,0为禁用
	  ipspolicy	INT DEFAULT 0,	--IPS策略，0为禁用
	  pcpolicy	INT DEFAULT 0,	--PC策略，0为禁用
	  eimpolicy	INT DEFAULT 0,	--上网行为管理策略，0为禁用
	  --utm add for ipv6 end
    pkgfilter6_w   INT		       -- 包过滤,自定义链标记位
);
--add by gaozhi,20110705 end


----表名: 安全规则计数
create table rule_count
(
    count           INT                     --安全规则计数
);
INSERT INTO rule_count VALUES(0);

--add by gaozhi,20110705 begin
----表名: 安全规则计数
create table rule6_count
(
    count           INT                     --安全规则计数
);
INSERT INTO rule6_count VALUES(0);
--add by gaozhi,20110705 end


----表名：带宽管理规则
create table bandwidth_rule
(
    id              INT,                --序号，规则序号，表示顺序，唯一，非自动增长，由程序控制增长
    name            CHAR(20),           --规则名
    saddrtype       INT,                --源地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    saddrid         INT,                --源地址ID
    saddrip         CHAR(15),           --源地址IP
    saddrmask       CHAR(15),           --源地址MASK
    sport           CHAR(128),          --源端口
    daddrtype       INT,                --目的地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    daddrid         INT,                --目的地址ID
    daddrip         CHAR(15),           --目的地址IP
    daddrmask       CHAR(17),           --目的地址MASK
    dport           CHAR(128),          --目的端口
    ethin           CHAR(20),           --流入网卡, "any"表示任意网络接口
    timetype        INT,                --时间类型, 1为时间定义，2为时间组(暂不使用该字段，为扩展做准备)
    timeid          INT,                --时间ID，(暂不使用该字段，为扩展做准备)
    timename        CHAR(20),			--时间调度名称（现在的程序中用名称来联系）
    locaton	    	INT,				--1,转发，0,映射前
    level			INT,				--快速安全级别配置 共分三个安全级别：3高，2中，1低  0非快速安全级别配置带宽规则
    servicetype     INT,                --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid       INT,                --服务ID
    bwid	    	INT,				--带宽资源ID
    apc             INT,				--apc策略id
    url		    	INT,				--url策略id
    file	    	INT,				--file策略id
    hostrate        CHAR(20),           --主机带宽限制值  
    hostmode        INT,           --主机带宽的控制方向
    ethout          CHAR(20),            --流出网卡, "any"表示任意网络接口
    ccrate          CHAR(20),
    ccmode          INT,
    ncrate          CHAR(20),
    ncmode          INT,
    autodelbw		INT,				--是否自动删除带宽资源 0:关闭   1:启用
    active          BOOL,				--是否启用(即是否生效)，0为禁用，1为启用

    --added by songpy begin
    roleid		VARCHAR(1024),	--角色ID(auth)
    --added by songpy end
    
    comment	    	VARCHAR(255) 		--注释
);


CREATE TABLE bw_easyconfig
(    
    level           INT,                --快速安全级别配置 共分三个安全级别：3高，2中，1低  0非快速安全级别配置带宽规则
    servicetype     INT,                --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid       INT,                --服务ID
    bwid            INT,                --带宽资源ID
    apc             INT,                --apc策略id
    url             INT,                --url策略id
    file            INT,                --file策略id
    hostrate        CHAR(20),           --主机带宽限制值  
    hostmode        INT,           --主机带宽的控制方向
    ethout          CHAR(20),            --流出网卡, "any"表示任意网络接口
    ccrate          CHAR(20),
    ccmode          INT,
     ncrate         CHAR(20),
    ncmode          INT
);
INSERT INTO "bw_easyconfig" VALUES(1,1,0,0,0,0,0,'','2','','',0,'',0);
INSERT INTO "bw_easyconfig" VALUES(2,1,0,0,0,0,0,'','1','','',0,'',0);
INSERT INTO "bw_easyconfig" VALUES(3,1,0,0,0,0,0,'','2','','',0,'',0);


-- 表名: 黑名单
create table blacklist
(
	id		INTEGER PRIMARY KEY, 	--序号
    	vmfwid		int not null,           --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙    
	addrip 	        CHAR(15), 		--地址
    	time            INT,                    --阻断时间，单位是分钟
    	start           CHAR(20),               --阻断开始时间
	comment		VARCHAR(255) 		--注释
);

create table blacklist6
(
	id		INTEGER PRIMARY KEY, 	--序号
    	vmfwid		int not null,           --虚拟防火墙id,用来标识这个数据属于哪个虚拟防火墙    
	addrip 	        CHAR(46), 		--地址
    	time            INT,                    --阻断时间，单位是分钟
    	start           CHAR(20),               --阻断开始时间
	comment		VARCHAR(255) 		--注释
);
COMMIT;
