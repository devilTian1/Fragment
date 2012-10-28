BEGIN TRANSACTION;

--消息模块客户端任务表--
create table msg_client_task 
(
	id					INTEGER PRIMARY KEY,		--任务标识，需要与服务端的任务号保持一致
	sa					CHAR(15), 							--源IP地址
	lip					CHAR(15),		  					--本机IP地址
	lport				CHAR(5),	 							--本机端口号
	ssl					CHAR(1),	 							--是否加密传输
	scanvirus		CHAR(1),								--是否扫描病毒
	backup			CHAR(1),	 							--是否进行本地备份
	time				CHAR(50),								--消息任务的执行时段对象
	active			CHAR(4),
	comment			VARCHAR(255)						--备注
);

--消息模块服务端访问表--
create table msg_server_task 
(
	id				INTEGER PRIMARY KEY,		--任务标识
	serip			CHAR(15), 							--接收客户端IP地址
	serport		CHAR(5),  							--接收客户端端口号
	ssl				CHAR(1),								--是否加密传输
	backup		CHAR(1),	 							--是否进行本地备份
	time			CHAR(50),								--消息任务的执行时段对象
	active			CHAR(4),
	comment		VARCHAR(255)						--备注
);

--消息模块服务状态表--
create table msg_ctl_status
(
	service_status				CHAR(1),			--服务是否开启 'Y'|'N'
	blacklist_status			CHAR(1),			--'Y':on     'N':off
	whitelist_status			CHAR(1),			--'Y':on     'N':off
	namefilter_status			CHAR(1),			--'Y':on     'N':off
	bin_file_status				CHAR(1)				--'A':Allow  'F':Forbid
);

insert into msg_ctl_status (service_status, blacklist_status, whitelist_status, namefilter_status, bin_file_status) values ('N','N','N','N','F');

--消息模块文件名过滤表--
create table msg_filter_filename 
(
	filename				CHAR(128) PRIMARY KEY				--允许的文件名
);

--消息模块黑名单设置表--
create table msg_filter_blacklist
(
	blacklist 	 		VARCHAR(64) PRIMARY KEY			--黑名单设置
);

--消息模块白名单设置表--
create table msg_filter_whitelist
(
	whitelist				VARCHAR(64) PRIMARY KEY			--白名单设置
);

--消息模块用户权限设置表--
create table msg_user_privilege
(
	username		VARCHAR(16) PRIMARY KEY,		--用户名
	password		CHAR(32),										--用户口令
	send_pri		CHAR(1),										--是否拥有发送权限 'Y'|'N'
	recv_pri		CHAR(1)		 									--是否拥有接收权限 'Y'|'N'
);

--消息模块用户认证设置表--
create table msg_user_auth
(
	username		VARCHAR(16)	PRIMARY KEY,		--用户名
	password		CHAR(32)				--用户口令
);

COMMIT;
