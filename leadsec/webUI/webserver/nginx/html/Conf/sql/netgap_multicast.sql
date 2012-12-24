BEGIN TRANSACTION;

create table protocol
(
	id		INT,				--序号
	name	CHAR(50) primary key,			--名称
	port	CHAR(10),
	protocol	CHAR(50),		--协议
	packet	CHAR(256)			--子元素
);

create table packet
(
	id		INT,
	name	CHAR(50) primary key,
	itype    CHAR(50),           --名称
	length CHAR(50),           --版本号
	field    CHAR(256),       --包
	comment VARCHAR(255)
);


create table field
(
	id		INT,
	flags   CHAR(50) primary key,
	name	CHAR(50),			--字段名称
	itype    CHAR(50),           --字段类型
	length CHAR(50),           --字段长度
	icheck    CHAR(50),       --是否检查
	value    CHAR(256)       --有效值
);


--TCP透明模式客户端访问表--
create table tcp_trans_client_acl 
(
	id		INTEGER PRIMARY KEY,
	sa		CHAR(50),
	da		CHAR(50),			--外部服务器真实地址
	dport		CHAR(12),		--外部服务器的端口
	usergrp		CHAR(50),		--认证用户组
	time		CHAR(50),
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	fast_pass 	INTEGER,   --快速通道开关，Added by Yanghong 2007-4-11 10:39
	killvirus	CHAR(1),
	comment		VARCHAR(255)
	
);

--TCP普通模式客户端访问表--
create table tcp_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--
	sa			CHAR(50),				--源地址对象
	lip			CHAR(50),				--本机地址
	lport		INT,					--本机端口
	usergrp		CHAR(50),				--认证用户组
	time		CHAR(50),				--
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	killvirus	CHAR(1),
	comment		VARCHAR(255),			--
	source		CHAR(1),			--是否绑定源地址
	s_mode		CHAR(1),				--源地址穿越模式	'1'-auto
	audit		CHAR(1),
	log			CHAR(1),
	protocol	CHAR(255)
);

--TCP普通模式服务端访问表--
create table tcp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--序号
	serverip	CHAR(50),				--服务器（外部服务）地址对象
	sport		INT,					--服务器（外部服务）端口
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--描述信息
	source		CHAR(1),			--是否绑定源地址
	lip			CHAR(16)
);

--UDP透明模式客户端访问表--
create table udp_trans_client_acl 
(
	id		INTEGER PRIMARY KEY,
	sa		CHAR(50),
	da		CHAR(50),		--外部服务器真实地址
	dport	CHAR(12),		--外部服务器的端口
	usergrp		CHAR(50),	--认证用户组
	time		CHAR(50),
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	fast_pass 	INTEGER,   --快速通道开关，Added by Yanghong 2007-4-19 18:38
	killvirus	CHAR(1),
	comment		VARCHAR(255)
);
--insert into udp_trans_client_acl values(1,'any','any',1234,'','','1',0,'0','comment');
--insert into udp_trans_client_acl values(2,'any','any',1230,'','','0',0,'0','comment');


--multicast普通模式客户端访问表--
create table multicast_comm_client_acl 
(
	id		INTEGER PRIMARY KEY,	--
	sa		CHAR(50),			--源地址对象
	lip		CHAR(50),			--本机地址
	lport		INT,			--本机端口
	usergrp		CHAR(50),		--认证用户组
	time		CHAR(50),		--
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	killvirus   CHAR(1),
	comment		VARCHAR(255),	--
	source		CHAR(1),			--是否绑定源地址	'1'-yes		'0'-no
	s_mode		CHAR(1),				--源地址穿越模式	'1'-auto
	t_mode		CHAR(10),
	maddr		CHAR(16),			--组播地址
	smaddr		CHAR(16),			--组播源地址
	audit		CHAR(1),			--是否调用接口  1 调用 0 不调用
	log			CHAR(1),
	protocol	CHAR(255)			--协议
);
--insert into multicast_comm_client_acl values(3,'any','10.0.0.10',1234,'','','1','0','comment');
--insert into multicast_comm_client_acl values(4,'any','10.0.0.10',1230,'','','0','0','comment');

--multicast普通模式服务端访问表--
create table multicast_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--序号
	serverip	CHAR(50),				--服务器（外部服务）地址对象
	sport		INT,					--服务器（外部服务）端口
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--描述信息
	source		CHAR(1),
	lip			CHAR(16),
	ttl			CHAR(10),
	srcport		CHAR(10)			--源端口
);
--insert into multicast_comm_server_acl values(5,'10.1.1.10',1234,'1','comment');
--insert into multicast_comm_server_acl values(6,'10.1.1.10',1230,'0','comment');

COMMIT;
