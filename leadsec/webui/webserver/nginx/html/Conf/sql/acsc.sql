-- Use(Create database):
-- #rm acsc.db
-- #sqlite acsc.db < acsc.sql
-- 杨聪毅2004/09/20 创建 用于进行并发连接数的管理
BEGIN TRANSACTION; 

--表名 连接管理系统参数表
create table acsc_option
(
	active 				BOOL,		--模块开关
	rule_option			BOOL,		--规则选项有效
	session_option		BOOL,		--会话统计方式
	learn				BOOL,		--动态类型学习开关
	maxip				INT,		--支持统计IP的最大数目，用户不可见
	def_src_type		INT,		--默认源连接检查类型
	def_src_threhold	INT,		--默认源连接阈值
	def_dest_type		INT,		--默认目的连接检查类型
	def_dest_threhold	INT,		--默认目的连接阈值
	daemon				BOOL,		--是否提供联动服务
	daemon_PORT			INT,		--防火墙服务端口
	admin				CHAR[15],	--管理主机
	audit				CHAR[15]	--审计主机
);
insert into acsc_option values(0,0,1,1,10000,1,5000,1,10000,0,2008,'','');

--表名 连接管理规则表，即静态类型表
create table acsc_rule
(
	ip					CHAR[15] PRIMARY KEY,	--地址
	src_type			INT,		--源连接检查类型
	src_threhold		INT,		--源连接阈值
	dest_type			INT,		--目的连接检查类型
	dest_threhold		INT,		--目的连接阈值
	comment				CHAR[20]	--注释
);
-- insert into acsc_rule values('80.1.1.2',1,100,1,100,'');
COMMIT;