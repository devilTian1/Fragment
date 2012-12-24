BEGIN TRANSACTION;

--用户表
create table user
(
		user_name	CHAR(20) PRIMARY KEY,								--用户名
		passwd		CHAR(32),								--密码
		permit		BOOL,										--是否允许登录
		time			UNSIGNED INT,						--已用时间
		flux			UNSIGNED INT,						--已用流量
		createdate			CHAR(32),					--开始时间，格式为2003/07/08/17
		screatedate			UNSIGNED INT,			--开始时间，从1900年epoch开始的秒数
		
		validday	UNSIGNED INT,						--总有效天数，最大为3650天
    is_bind_ip BOOL,									--是否绑定IP 
    bind_ip   CHAR(16),               --绑定的IP地址
    netmask   CHAR(16),               --子网掩码
    is_check_version  BOOL,					  --是否检查版本
    nversion  CHAR(6),                 --版本号
   	--add by tonglr 20080222
		spassdate			UNSIGNED LONG,			--密码创建时间，从1900年epoch开始的秒数
		passvaliddate			UNSIGNED LONG,			--密码有效天数，最大为3650天
		--end by tonglr 20080222
		passwdm		CHAR(32)
);

--用户组表
create table groups
(
		group_name	CHAR(20) PRIMARY KEY,							--组名
		group_id	UNSIGNED SMALLINT,			--组id（内核用）
		time		UNSIGNED INT,							--最大时间
		flux		UNSIGNED INT,							--最大流量
		user_num	UNSIGNED SMALLINT,			--包含用户数
		is_proc_check		BOOL,							--客户端是否检查进程
		proc_rule				BOOL,							--客户端进程检查策略
		proc_list				TEXT,							--客户端进程提示信息
		users		TEXT											--所有用户名集合，中间以;隔开
);

--网闸表
create table wangzha
(
		workmode	UNSIGNED INT
);

insert into wangzha values(0);

--日志记录表
create table log
(
		log	UNSIGNED INT
);

insert into log values(0);

--标准保活时间间隔表
create table other
(
		alivetime	UNSIGNED INT
);

insert into other values(120); -- 2分钟，客户端超时时间

--表名：server
create table server
(
	localport		UNSIGNED SMALLINT,		--监听端口
	workmode		UNSIGNED SMALLINT,		--工作模式1为local，2为radius
	ip					CHAR(20),							--IP地址
	timeout			UNSIGNED SMALLINT,		--重试时间
	authport		UNSIGNED SMALLINT,		--认证端口
	auditport		UNSIGNED SMALLINT,		--计费端口
	secret			CHAR(21)							--共享密钥
);
insert into server values(9998,1,"10.50.10.18",3,1812,1813,"leadsec");

COMMIT;

