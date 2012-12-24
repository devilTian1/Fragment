BEGIN TRANSACTION;

--透明模式客户端访问表--
create table db_trans_client_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, 三个访问表须保持唯一性
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	sa			CHAR(50),
	da			CHAR(50),				--外部服务器真实地址
	dport		INT,					--外部服务器的端口
	usergrp		CHAR(50),				--认证用户组,added at 2008-3-8
	time		CHAR(50),
	filter		CHAR(20),		--协议过滤集名称
	active 		CHAR(1),			--当前任务启停开关：'1'-ON, '0'-OFF
	comment		VARCHAR(255)
);
--insert into db_trans_client_acl values(2,'oracle','any','any','1000','','','filter01','0','aaaaa');

--普通模式客户端访问表--
create table db_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, 三个访问表须保持唯一性
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	sa			CHAR(50),				--源地址对象
	lip			CHAR(50),				--本机地址
	lport		INT,					--本机端口
	usergrp		CHAR(50),				--认证用户组,added at 2008-3-8
	time		CHAR(50),				--
	filter		CHAR(20),				--协议过滤集名称
	active 		CHAR(1),				--当前任务启停开关：'1'-ON, '0'-OFF
        ip_ver           CHAR(10),
	comment		VARCHAR(255)			--
);
--insert into db_comm_client_acl values(12,'oracle','any','10.0.0.1','1000','','','filter01','1','aaaaa');
--insert into db_comm_client_acl values(13,'oracle','any','10.0.0.1','1000','','','filter01','0','aaaaa');

--普通模式服务端访问表--
create table db_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, 三个访问表须保持唯一性
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	serverip	CHAR(50),				--服务器（外部服务）地址对象
	sport		INT,					--服务器（外部服务）端口
	active 		CHAR(1),			--当前任务启停开关：'1'-ON, '0'-OFF
        ip_ver           CHAR(10),
	comment		VARCHAR(255)			--描述信息
);
--insert into db_comm_server_acl values(5,'oracle','10.1.1.1','1521','1','aaaaa');
--insert into db_comm_server_acl values(6,'oracle','10.1.1.1','1521','0','aaaaa');

create table db_option_list
(
  	id				INTEGER PRIMARY KEY,	--序号
	name	    	CHAR(20),				--过滤选项名称
	usergrp      	CHAR(20),               --URL过滤组名
	sqlgrp     		CHAR(20),               --MIME组名
	bufav       	CHAR(1),                --流模式病毒检测: '1'表示扫描,'0'表示不扫描
	comment			VARCHAR(255)			--描述信息
);
--insert into db_option_list values(1,'filter01','usergrp01','','1','aaaaa');


--用户访问控制表--
create table  db_user_filter
(
	id				INTEGER PRIMARY KEY,	--序号
	name		CHAR(15),			--用户过滤选项对象名称
	allow		CHAR(1),			--'A': allow    'F': forbidden
	usrnamelist	VARCHAR(1024),		--用户名之间的分割符号：逗号(默认)或空格或\t
	comment		VARCHAR(255)			--描述信息
);
--insert into db_user_filter values('usergrp01','A','abc,aaa,user','comment');
--insert into db_user_filter values('usergrp02','F','sa','this is test');

--SQL控制表--
create table  db_sql_filter
(
  	id				INTEGER PRIMARY KEY,	--序号
	name		CHAR(15),			--SQL命令过滤选项对象名称
	allow		CHAR(1),			--'A': allow    'F': forbidden
	sqllist		VARCHAR(1024),		--SQL语句之间的分割符号：逗号(默认)
	comment		VARCHAR(255)		--描述信息
);
--insert into db_sql_filter values('sql01','A','SELECT,UPDATE','comment');

--全局参数配置表--
create table  db_option
(
	default_allow	CHAR(1)			--访问控制参数全不匹配时，默认通过方式：'1'-allow    '0'-forbidden
);
insert into db_option values('1');	--default: allow

--Oracle 数据通道IP地址--
create table oracle_dataip
(
	dataip		CHAR(15)			--Oracle数据库的数据通道IP地址,仅针对数据库访问模块中的oracle透明客户端
);
insert into oracle_dataip values('10.0.0.1'); --添加出厂默认的数据通道IP，该值同fe1的值

--数据库类型表--
create table  db_type
(
	type		CHAR(15)			--数据库类型
);
insert into db_type values('oracle');
insert into db_type values('sqlserver2000');
insert into db_type values('sqlserver2005');
insert into db_type values('mysql');
insert into db_type values('DB2');
insert into db_type values('sybase');
--insert into db_type values('access');

COMMIT;
