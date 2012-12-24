
-- Use(Create database):
--   #rm rule.db
--   #sqlite rule.db<rule.sql

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
    name        CHAR(20),               --地址名    
    type        INT,                    --地址类型,1为子网/掩码形式，2为地址段形式，3为反地址
    ip          CHAR(15),               --地址 （或低地址） 
    mask        CHAR(15),               --掩码 （或高地址)
    comment     VARCHAR(255)           --备注
);

insert into  address values(1,'any',1,'0.0.0.0','0.0.0.0','全部地址');


--表名: 地址组
create table addrgrp
(
    id          INTEGER PRIMARY KEY,    --地址组ID sequence
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

----表名: 服务器地址
create table serveraddr
(
    id          INTEGER PRIMARY KEY,    --服务器地址ID
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

--表名：域名地址
create table domain_property
(
	id			INTEGER PRIMARY KEY,	--域名地址ID
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
	comment		VARCHAR(255)			--备注	
);

--2005/1/13	zhuxp	创建
--视图：地址和域名地址的名称
CREATE VIEW address_domain AS
SELECT id,name,type FROM address
UNION
SELECT id,name,type FROM domain_property;

--视图: 地址和地址组的名称
CREATE VIEW addrname AS
SELECT name FROM address
UNION
SELECT name FROM addrgrp
UNION
SELECT name FROM domain_property;

--视图: 地址和地址组的名称
CREATE VIEW pfaddrname AS
SELECT name FROM address_domain
UNION
SELECT name FROM addrgrp
UNION
SELECT name FROM serveraddr WHERE name NOT LIKE "fp_%s%"
UNION
SELECT name FROM domain_property;

--表名: 地址池
create table addrpool
(
    id          INTEGER PRIMARY KEY,    --地址池ID  sequence
    name        CHAR(20),               --地址池名
    ip_from     CHAR(15),               --起始地址 
    ip_to       CHAR(15),               --终止地址  
    comment     VARCHAR(255)            --备注
);

--表名: 带宽 作废20050503 yangcy
--create table bandwidth
--(
--    id          INTEGER PRIMARY KEY,    --ID号
--    name        Char(20),               --带宽名    
--    priority    INT,                    --优先级    
--    maxbw       INT,                    --最大带宽  
--    minbw       INT,                    --最小带宽
--    comment     VARCHAR(255)            --注释  
--);

--表名：带宽根类 yangcy 20050503
create table bandwidth_parentclass
(
	id			INT,    				--ID号
	name		Char(20),               --带宽名 
	minbw		INT,                    --最小带宽，即保证带宽
	maxbw		INT,                    --最大带宽  
	ethout		CHAR(20),               --流出网卡    
	comment		VARCHAR(255)			--注释  
);

--表名：带宽子类 yangcy 20050503
create table bandwidth_childclass
(
	id			INT,    				--ID号
	name		Char(20),               --带宽名 
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
	name		Char(20),               --带宽组名     
	comment		VARCHAR(255)			--注释  
);

--表名：带宽资源和资源组映射表 yangcy 20050503
create table bandwidth_classgrpmap
(
	classgrpid	INT,					--地址组ID  
	childclassid	INT,					--子类ID
	parentclassid	INT,    				--父类ID
	ethout		CHAR(20)				--流出网卡
);

----表名: 预定义服务
create table streamservice
(
    id          INTEGER PRIMARY KEY,    --ID号
    name        CHAR(20),               --预定义服务名称
    protocol    INT,                    --协议
    port        INT,                    --端口号
    comment     VARCHAR(255)            --注释
);
INSERT INTO streamservice VALUES(1,'any',0,-1,'任意服务');
INSERT INTO streamservice VALUES(4,'http',6,80,"www service");
INSERT INTO streamservice VALUES(5,'tcp_any',6,-1,"tcp service");
INSERT INTO streamservice VALUES(6,'udp_any',17,-1,"udp service");


----表名: 预定义服务
create table defaultservice
(
    id          INTEGER PRIMARY KEY,    --ID号
    name        CHAR(20),               --预定义服务名称
    protocol    INT,                    --协议
    port        INT,                    --端口号
    comment     VARCHAR(255)            --注释
);
INSERT INTO defaultservice VALUES(1,'any',0,-1,'任意服务');
INSERT INTO defaultservice VALUES(4,'http',6,80,"www service");
INSERT INTO defaultservice VALUES(5,'tcp_any',6,-1,"tcp service");
INSERT INTO defaultservice VALUES(6,'udp_any',17,-1,"udp service");
--INSERT INTO defaultservice VALUES(7,'icmp_any',1,-1,"icmp service");
INSERT INTO defaultservice VALUES(8,'telnet',6,23,"telnet service");
INSERT INTO defaultservice VALUES(9,'smtp',6,25,"smtp service");
INSERT INTO defaultservice VALUES(10,'pop3',6,110,"pop3 service");
INSERT INTO defaultservice VALUES(11,'snmp',17,161,"snmp service");
INSERT INTO defaultservice VALUES(12,'dns',17,53,"dns service");
INSERT INTO defaultservice VALUES(13,'https',6,443,"https service");
INSERT INTO defaultservice VALUES(14,'oicq',17,8000,"oicq service");

--INSERT INTO defaultservice VALUES(15,'IGMP',2,-1,"IGMP");
--INSERT INTO defaultservice VALUES(16,'OSPF',89,-1,"OSPF");
--INSERT INTO defaultservice VALUES(17,'IGRP',88,-1,"IGRP");
--INSERT INTO defaultservice VALUES(18,'GRE',47,-1,"GRE");

INSERT INTO defaultservice VALUES(19,'Syslog',17,514,"Syslog");
INSERT INTO defaultservice VALUES(20,'RemoteDesk',6,3389,"微软远程桌面");



----表名: 自定义服务(普通)
create table service
(
    id          INTEGER PRIMARY KEY,    --服务ID  sequence
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

INSERT INTO service VALUES(1,"netbios",0,65535,137,139,6,0,65535,137,139,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"NetBIOS");
INSERT INTO service VALUES(2,"lotusnotes",0,65535,1352,1352,6,0,65535,1352,1352,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Lotus Notes");
INSERT INTO service VALUES(3,"radius",0,65535,1812,1813,6,0,65535,1812,1813,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Radius");


----表名: 自定义服务(动态)
create table dynamic_service
(
    id                INTEGER PRIMARY KEY,    --ID号
    name              CHAR(20),               --动态协议名称
    protocol          INT,                    --基于协议, 1为ftp，2为h.323，3为tns,注意：这里不是用getprotobynumber()来解析
    port              VARCHAR(255),           --动态协议端口
    ftp_get           BOOL,                   --ftp的get动作, 0为禁止,1为允许
    ftp_put           BOOL,                   --ftp的put动作, 0为禁止,1为允许
    ftp_multi_thread  BOOL,                   --ftp的多线程, 0为禁止,1为允许
    comment           VARCHAR(255)            --备注
);

INSERT INTO dynamic_service VALUES(1,'ftp',1,21,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(2,'h323',2,1720,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(3,'tns',3,1521,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(4,'rtsp',5,554,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(5,'tftp',6,69,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(6,'irc',7,6667,0,0,0,"default service");

----表名: 自定义服务(动态)
create table dynamic_stream_service
(
    id                INTEGER PRIMARY KEY,    --ID号
    name              CHAR(20),               --动态协议名称
    protocol          INT,                    --基于协议, 1为ftp，2为h.323，3为tns,注意：这里不是用getprotobynumber()来解析
    port              VARCHAR(255),           --动态协议端口
    ftp_get           BOOL,                   --ftp的get动作, 0为禁止,1为允许
    ftp_put           BOOL,                   --ftp的put动作, 0为禁止,1为允许
    ftp_multi_thread  BOOL,                   --ftp的多线程, 0为禁止,1为允许
    comment           VARCHAR(255)            --备注
);

INSERT INTO dynamic_stream_service VALUES(1,'h323',2,1720,0,0,0,"default service");
INSERT INTO dynamic_stream_service VALUES(2,'rtsp',5,554,0,0,0,"default service");

----表名: 自定义服务(ICMP)
create table icmp_service
(
    id              INTEGER PRIMARY KEY,    -- ID号
    name            CHAR(20),               -- ICMP动态协议名称
    type            INT,                    -- -1表示任意type
    code            INT,                    -- -1表示任意code
    comment         VARCHAR(255)            -- 备注
);



----表名: 服务组
create table servicegrp
(
    id              INTEGER PRIMARY KEY,    --服务组ID sequence
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

--视图: 所有服务的服务名
CREATE VIEW servicename AS
SELECT name  FROM   defaultservice
UNION
SELECT name  FROM   service              
UNION
SELECT name  FROM   dynamic_service                
UNION
SELECT name  FROM   icmp_service
UNION
SELECT name  FROM   servicegrp;

--视图: 所有服务的服务名
CREATE VIEW portservicename AS
SELECT name  FROM   defaultservice
UNION
SELECT name  FROM   service              
UNION
SELECT name  FROM   dynamic_service                
UNION
SELECT name  FROM   icmp_service;


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
SELECT name, id  FROM   defaultservice where ((protocol = 6 or protocol = 17 ) and port != -1) or (protocol != 6 and protocol != 17 and protocol != 0);

CREATE VIEW proxyservice AS
SELECT name, id  FROM   service  where ((protocol1 = 6 or protocol1 = 17) and (dlport1=dhport1)) 
                                   and (protocol2 = 256)
                                   and (protocol3 = 256)
                                   and (protocol4 = 256)
                                   and (protocol5 = 256)
                                   and (protocol6 = 256)
                                   and (protocol7 = 256)
                                   and (protocol8 = 256);

CREATE VIEW proxydyservice AS
SELECT name, id  FROM   dynamic_service where protocol = 1 and port != '' and port != '-1';

CREATE VIEW proxyservicename AS
SELECT name  FROM   proxydfservice
UNION
SELECT name  FROM   proxyservice
UNION
SELECT name  FROM   icmp_service
UNION
SELECT name  FROM   proxydyservice;                

--2005/1/13	zhuxp	增加域名地址
----表名: 安全规则
create table policyinfo
(
    id              INT,                    --序号，规则序号，表示顺序，唯一，非自动增长，由程序控制增长
    name            CHAR(20),               --规则名 
    type            INT,                    --类型，1为permit，2为deny，3为proxy，4为nat，5为portmap，6为ipmap, 7为auth, 8为masquerade,9为vpn,10 nataccept,11 portaccept 12 ipaccept
    saddrtype       INT,                    --源地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    saddrid         INT,                    --源地址ID
    saddrip         CHAR(15),               --源地址IP
    saddrmask       CHAR(15),               --源地址MASK
    sattype         INT,                    --源地址转换类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的) 5为地址池，6为防火墙地址， 11/12为网闸隔离卡IP(127.1.0.1/127.1.0.2)(zhouxj-2007-12-03)
    satid           INT,                    --源地址转换ID
    satip           CHAR(15),               --源地址转换IP  //如果sattype=6，该项存放接口外部名称
    satmask         CHAR(17),               --源地址转换MASK
    sport           CHAR(128),              --源端口
    smac            CHAR(17),               --源MAC
    satport         CHAR(128),              --源端口转换
    daddrtype       INT,                    --目的地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    daddrid         INT,                    --目的地址ID
    daddrip         CHAR(15),               --目的地址IP
    daddrmask       CHAR(17),               --目的地址MASK
    pubtype         INT,                    --公开地址类型     2为地址定义,6为防火墙地址，21/22/23为网闸隔离卡IP（127.1.0.1/127.1.0.2,127.1.0.0/24）(zhouxj 2007-12-03)
    pubid           CHAR(15),               --公开地址ID       (对应interface里的外部地址)
    innertype       INT,                    --内部服务器地址类型, (1为IP地址/掩码,在这里不出现), (2为地址定义, 不出现)，(3为地址组定义, 不出现)，4服务器地址
    innerid         INT,                    --内部服务器地址ID
    innerip         CHAR(15),               --内部地址IP(现在不用，防止以后要加上该项功能,只支持一个内部服务器)
    ethin           CHAR(20),                --流入网卡, "any"表示任意网络接口
    ethout          CHAR(20),                --流出网卡, "any"表示任意网络接口
    servicetype     INT,                    --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid       INT,                    --服务ID
    pubservicetype  INT,                    --对外服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
    pubserviceid    INT,                    --对外服务ID
    innerservicetype    INT,                --内部服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
    innerserviceid  INT,                    --内部服务ID
    proxytype       INT,                    --代理类型, 1为固定代理，2为自定义代理
    proxyid         INT,                    --代理ID，1为http，2为ftp,3为telnet,4为smtp,5为pop3,6为socks,7为dns,8为icmp,9为msn
    timetype        INT,                    --时间类型, 1为时间定义，2为时间组(暂不使用该字段，为扩展做准备)
    timeid          INT,                    --时间ID，(暂不使用该字段，为扩展做准备)
    timename        CHAR(20),               --时间调度名称（现在的程序中用名称来联系）
--    urlid           INT,                    --URL规则ID, 0表示无，1表示启用URL检查
    longcon         INT,                   --是否支持长连接，0为禁用，>0为启用, 单位为秒
    log             BOOL,                   --是否记录过滤日志，0为禁用，1为启用
--    logurl          BOOL,                   --是否记录URL日志，0为禁用，1为启用
    synflood        INT,                   --是否抗SYN Flood攻击，0为禁用，>0为启用, 单位为个/秒
    udpflood        INT,                   --是否抗UDP Flood攻击，0为禁用，>0为启用, 单位为个/秒
    icmpflood       INT,                   --是否抗ICMP Flood攻击，0为禁用，>0为启用, 单位为个/秒
    pod             BOOL,                   --是否抗Ping of Death攻击，0为禁用，1为启用
    active          BOOL,                    --是否启用(即是否生效)，0为禁用，1为启用
--    keycheck        BOOL,                    --是否启用网页关键字检查，0表示无，1为启用   
    hideinner		BOOL, 					--是否隐藏内部地址或端口，用于端口映射和ip映射
--    logkey			BOOL					--是否纪录关键字检查日志
-- added by hanhz, 2005/06/27, begin
    dcf           INT DEFAULT 0,                      --深度过滤策略，0为禁用
    bt							BOOL,											--是否启用bt，0为禁用，1为启用
    edk							BOOL,											--是否启用edk，0为禁用，1为启用
    btlog							BOOL,									--是否纪录bt,edk日志
-- added by hanhz, 2005/06/27, end

-- Added by zhouxj, 2008/04/11, for user auth at Kernel.
	username	CHAR(20),				--用户组名
	usergpid	INT,					--用户组id
-- End

    dport	INT,     --for netgap
    toport	INT,     --for netgap
    proto	INT,     --for netgap
	proto_type INT,
	saname VARCHAR(30), --for netgap
	daname VARCHAR(30), --for netgap
    comment	VARCHAR(255),					--注释

	POLICY_W            INT,                        -- 1 in filter          
	PROXY_INPUT_W       INT,                        -- 2 in filter  
	AUTH_SERVER_W       INT,                        -- 3 in filter  
	AUTH_W              INT,                        -- 4 in filter  
	IPMAP_W             INT,                        -- 5 in nat 
	IPMAPNAT_W          INT,                        -- 6 in nat 
	HIDEIPMAP_W         INT,                        -- 7 in nat 
	PORTMAP_W           INT,                        -- 8 in nat 
	PORTMAPNAT_W        INT,                        -- 9 in nat 
	HIDEPORTMAP_W       INT,                        -- 10 in nat    
	TRANS_PROXY_W       INT,                        -- 11 in nat    
	POSTROUTINGNAT_W    INT,                        -- 12 in nat    
	VPN_POSTROUTING_MANGLE_DROP_W       INT,                -- 13 in mangle 
	APCPOLICY_W         INT,                        -- 14 in filter  tonglr 20081015    
	URLPOLICY_W         INT,                        -- 15 in filter     tonglr 20081015
	NETGAP_W            INT,
	NETGAP_INPUT_W      INT
    
);


----表名: 安全规则计数
create table rule_count
(
    count           INT                     --安全规则计数
);
INSERT INTO rule_count VALUES(0);

--2005/1/13	zhuxp	增加域名地址
----表名: 安全规则
create table policyinfo6
(
    id              INT,                    --序号，规则序号，表示顺序，唯一，非自动增长，由程序控制增长
    name            CHAR(20),               --规则名 
    type            INT,                    --类型，1为permit，2为deny，3为proxy，4为nat，5为portmap，6为ipmap, 7为auth, 8为masquerade,9为vpn,10 nataccept,11 portaccept 12 ipaccept
    saddrtype       INT,                    --源地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    saddrid         INT,                    --源地址ID
    saddrip         CHAR(128),               --源地址IP
    saddrmask       CHAR(128),               --源地址MASK
    sattype         INT,                    --源地址转换类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的) 5为地址池，6为防火墙地址， 11/12为网闸隔离卡IP(127.1.0.1/127.1.0.2)(zhouxj-2007-12-03)
    satid           INT,                    --源地址转换ID
    satip           CHAR(15),               --源地址转换IP  //如果sattype=6，该项存放接口外部名称
    satmask         CHAR(17),               --源地址转换MASK
    sport           CHAR(128),              --源端口
    smac            CHAR(17),               --源MAC
    satport         CHAR(128),              --源端口转换
    daddrtype       INT,                    --目的地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    daddrid         INT,                    --目的地址ID
    daddrip         CHAR(128),               --目的地址IP
    daddrmask       CHAR(128),               --目的地址MASK
    pubtype         INT,                    --公开地址类型     2为地址定义,6为防火墙地址，21/22/23为网闸隔离卡IP（127.1.0.1/127.1.0.2,127.1.0.0/24）(zhouxj 2007-12-03)
    pubid           CHAR(15),               --公开地址ID       (对应interface里的外部地址)
    innertype       INT,                    --内部服务器地址类型, (1为IP地址/掩码,在这里不出现), (2为地址定义, 不出现)，(3为地址组定义, 不出现)，4服务器地址
    innerid         INT,                    --内部服务器地址ID
    innerip         CHAR(15),               --内部地址IP(现在不用，防止以后要加上该项功能,只支持一个内部服务器)
    ethin           CHAR(20),                --流入网卡, "any"表示任意网络接口
    ethout          CHAR(20),                --流出网卡, "any"表示任意网络接口
    servicetype     INT,                    --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid       INT,                    --服务ID
    pubservicetype  INT,                    --对外服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
    pubserviceid    INT,                    --对外服务ID
    innerservicetype    INT,                --内部服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组
    innerserviceid  INT,                    --内部服务ID
    proxytype       INT,                    --代理类型, 1为固定代理，2为自定义代理
    proxyid         INT,                    --代理ID，1为http，2为ftp,3为telnet,4为smtp,5为pop3,6为socks,7为dns,8为icmp,9为msn
    timetype        INT,                    --时间类型, 1为时间定义，2为时间组(暂不使用该字段，为扩展做准备)
    timeid          INT,                    --时间ID，(暂不使用该字段，为扩展做准备)
    timename        CHAR(20),               --时间调度名称（现在的程序中用名称来联系）
--    urlid           INT,                    --URL规则ID, 0表示无，1表示启用URL检查
    longcon         INT,                   --是否支持长连接，0为禁用，>0为启用, 单位为秒
    log             BOOL,                   --是否记录过滤日志，0为禁用，1为启用
--    logurl          BOOL,                   --是否记录URL日志，0为禁用，1为启用
    synflood        INT,                   --是否抗SYN Flood攻击，0为禁用，>0为启用, 单位为个/秒
    udpflood        INT,                   --是否抗UDP Flood攻击，0为禁用，>0为启用, 单位为个/秒
    icmpflood       INT,                   --是否抗ICMP Flood攻击，0为禁用，>0为启用, 单位为个/秒
    pod             BOOL,                   --是否抗Ping of Death攻击，0为禁用，1为启用
    active          BOOL,                    --是否启用(即是否生效)，0为禁用，1为启用
--    keycheck        BOOL,                    --是否启用网页关键字检查，0表示无，1为启用   
    hideinner		BOOL, 					--是否隐藏内部地址或端口，用于端口映射和ip映射
--    logkey			BOOL					--是否纪录关键字检查日志
-- added by hanhz, 2005/06/27, begin
    dcf           INT DEFAULT 0,                      --深度过滤策略，0为禁用
    bt							BOOL,											--是否启用bt，0为禁用，1为启用
    edk							BOOL,											--是否启用edk，0为禁用，1为启用
    btlog							BOOL,									--是否纪录bt,edk日志
-- added by hanhz, 2005/06/27, end

-- Added by zhouxj, 2008/04/11, for user auth at Kernel.
	username	CHAR(20),				--用户组名
	usergpid	INT,					--用户组id
-- End

    dport	INT,     --for netgap
    toport	INT,     --for netgap
    proto	INT,     --for netgap
-- add by caoli 2013/01/08
	proto_type INT,	--IP协议类型 4 、6
	saname VARCHAR(30), --for netgap 源地址链名
	daname VARCHAR(30), --for netgap 目的地址链名
-- End
    comment	VARCHAR(255),					--注释

	POLICY_W            INT,                        -- 1 in filter          
	PROXY_INPUT_W       INT,                        -- 2 in filter  
	AUTH_SERVER_W       INT,                        -- 3 in filter  
	AUTH_W              INT,                        -- 4 in filter  
	IPMAP_W             INT,                        -- 5 in nat 
	IPMAPNAT_W          INT,                        -- 6 in nat 
	HIDEIPMAP_W         INT,                        -- 7 in nat 
	PORTMAP_W           INT,                        -- 8 in nat 
	PORTMAPNAT_W        INT,                        -- 9 in nat 
	HIDEPORTMAP_W       INT,                        -- 10 in nat    
	TRANS_PROXY_W       INT,                        -- 11 in nat    
	POSTROUTINGNAT_W    INT,                        -- 12 in nat    
	VPN_POSTROUTING_MANGLE_DROP_W       INT,                -- 13 in mangle 
	APCPOLICY_W         INT,                        -- 14 in filter  tonglr 20081015    
	URLPOLICY_W         INT,                        -- 15 in filter     tonglr 20081015
	NETGAP_W            INT,
	NETGAP_INPUT_W      INT
    
);


----表名: 安全规则计数
create table rule_count6
(
    count           INT                     --安全规则计数
);
INSERT INTO rule_count VALUES(0);

----表名：带宽管理规则
----表名：带宽管理规则
create table bandwidth_rule
(
    id              INT,                    --序号，规则序号，表示顺序，唯一，非自动增长，由程序控制增长
    name            CHAR(20),               --规则名 
    saddrtype       INT,                    --源地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    saddrid         INT,                    --源地址ID
    saddrip         CHAR(15),               --源地址IP
    saddrmask       CHAR(15),               --源地址MASK    
    sport           CHAR(128),              --源端口    
    daddrtype       INT,                    --目的地址类型, 1为IP地址/掩码, 2为地址定义，3为地址组定义，(4服务器地址,但在这里不出现的),7为any,8为域名地址
    daddrid         INT,                    --目的地址ID
    daddrip         CHAR(15),               --目的地址IP
    daddrmask       CHAR(17),               --目的地址MASK 
   
    ethin           CHAR(20),                --流入网卡, "any"表示任意网络接口
    servicetype     INT,                    --服务类型,  --1为预定义服务，2为自定义服务（动态协议）3为自定义服务（ICMP协议）, 4为自定义服务（普通自定义服务）,--5为服务组, --6为any
    serviceid       INT,                    --服务ID
    
    timetype        INT,                    --时间类型, 1为时间定义，2为时间组(暂不使用该字段，为扩展做准备)
    timeid          INT,                    --时间ID，(暂不使用该字段，为扩展做准备)
		timename        CHAR(20),               --时间调度名称（现在的程序中用名称来联系）    
		bwid						INT,										--带宽资源ID
		comment					VARCHAR(255), 						--注释
		active          BOOL,                    --是否启用(即是否生效)，0为禁用，1为启用 		
		locaton					INT,										--1,转发，0,映射前
		 bt							BOOL,											--是否启用bt，0为禁用，1为启用
    edk							BOOL											--是否启用edk，0为禁用，1为启用
);

-- 表名: 黑名单
create table blacklist
(
	id		INTEGER PRIMARY KEY, 	--序号
	addrip 	        CHAR(15), 		--地址
    	time            INT,                    --阻断时间，单位是分钟
    	start           CHAR(20),               --阻断开始时间
	comment		VARCHAR(255) 		--注释
);


COMMIT;
