BEGIN TRANSACTION;

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
	s_mode		CHAR(1)				--源地址穿越模式	'1'-auto
);

--TCP普通模式服务端访问表--
create table tcp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--序号
	serverip	CHAR(50),				--服务器（外部服务）地址对象
	sport		INT,					--服务器（外部服务）端口
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--描述信息
	source		CHAR(1)			--是否绑定源地址
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


--UDP普通模式客户端访问表--
create table udp_comm_client_acl 
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
	s_mode		CHAR(1)				--源地址穿越模式	'1'-auto
);
--insert into udp_comm_client_acl values(3,'any','10.0.0.10',1234,'','','1','0','comment');
--insert into udp_comm_client_acl values(4,'any','10.0.0.10',1230,'','','0','0','comment');

--UDP普通模式服务端访问表--
create table udp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--序号
	serverip	CHAR(50),				--服务器（外部服务）地址对象
	sport		INT,					--服务器（外部服务）端口
	active		CHAR(1),			--当前服务启停开关：'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--描述信息
	source		CHAR(1)
);
--insert into udp_comm_server_acl values(5,'10.1.1.10',1234,'1','comment');
--insert into udp_comm_server_acl values(6,'10.1.1.10',1230,'0','comment');

COMMIT;
