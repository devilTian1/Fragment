BEGIN TRANSACTION;

--数据库同步客户端访问表--
create table db_swap_client_acl 
(	
	id		INTEGER PRIMARY KEY,		--序号
	sa		CHAR(50),								--源地址对象
	lip		CHAR(50),								--本机地址
	lport		INT,									--本机端口 
	ssl			CHAR(1),								--是否采用SSL加密: 'Y'/'N'
	time		CHAR(50),							-- 时间对象
	killvirus           CHAR(1),
	active 		CHAR(1),			--当前任务启停开关：'1'-ON, '0'-OFF
	commname		VARCHAR(255),			--对端证书共公名
	ip_ver		CHAR(10),
	comment		VARCHAR(255)
);

--数据库同步服务端访问表--
create table db_swap_server_acl 
(	
	id			INTEGER PRIMARY KEY,	--序号
	serverip	CHAR(50),						--服务器（外部服务）地址对象
	sport		INT,									--服务器（外部服务）端口  
	ssl						CHAR(1),				--是否采用SSL加密: 'Y'/'N'
	commname		VARCHAR(255),			--对端证书共公名
	active 		CHAR(1),			--当前任务启停开关：'1'-ON, '0'-OFF
	ip_ver		CHAR(10),
	comment		VARCHAR(255)				--描述信息
);

--数据库同步用户控制表--
create table db_swap_user_auth
(
	userid		INT,						--用户ID
	username	CHAR(50),				--用户名
	password	CHAR(50),				--用户密码
	comment	VARCHAR(255),				--描述信息
	flag		CHAR(50)					--暂时保留
);

COMMIT;
