-- Use(Create database):
-- #rm dcf.db
-- #sqlite dcf.db < dcf.sql

-- History:
-- 1. create hanhz 2005/03/08

BEGIN TRANSACTION;

--表名：深度过滤策略
create table policy
(
	id			INTEGER PRIMARY KEY,	--策略ID
	name			CHAR(20),		--策略名称
	enable			BOOL DEFAULT 0,		--策略是否启用
	http_enable		BOOL DEFAULT 0,		--是否启用HTTP过滤
	url_enable		BOOL DEFAULT 0,		--是否启用URL过滤
	url_mode		INT DEFAULT 0,		--黑名单"0"、白名单"1"、或黑名单允许记录日志2
	url_reassembly		BOOL DEFAULT 0,		--是否URL碎片重组
	url_log_src		BOOL DEFAULT 0,		--是否同源日志
	url_log			BOOL DEFAULT 0,		--URL是否记录日志
	page_keyword_enable	BOOL DEFAULT 0,		--是否启用网页关键字过滤
	page_keyword_log	BOOL DEFAULT 0,		--网页关键字过滤是否记录日志
	ftp_enable		BOOL DEFAULT 0,		--是否启用FTP过滤
	download_enable		BOOL DEFAULT 0,		--是否启用文件下载过滤
	download_deny		BOOL DEFAULT 0,		--"1"禁止下载
	download_log		BOOL DEFAULT 0,		--文件下载是否记录日志
	upload_enable		BOOL DEFAULT 0,		--是否启用文件上传过滤
	upload_deny		BOOL DEFAULT 0,		--"1"禁止上传
	upload_log		BOOL DEFAULT 0,		--文件上传过滤是否记录日志
	smtp_enable		BOOL DEFAULT 0,		--是否启用SMTP过滤
	send_enable		BOOL DEFAULT 0,		--是否启用发件人过滤
	send_log		BOOL DEFAULT 0,		--发件人过滤是否记录日志
	recv_enable		BOOL DEFAULT 0,		--是否启用发件人过滤
	recv_log		BOOL DEFAULT 0,		--发件人过滤是否记录日志
	subject_enable		BOOL DEFAULT 0,		--是否启用邮件主题过滤
	subject_log		BOOL DEFAULT 0,		--邮件主题过滤是否记录日志
	antirelay_enable	BOOL DEFAULT 0,		--是否启用反邮件中转
	antirelay_log		BOOL DEFAULT 0,		--反邮件中转是否记录日志
	worm_enable		BOOL DEFAULT 0,		--是否启用蠕虫过滤
	worm_log		BOOL DEFAULT 0,		--蠕虫过滤是否记录日志
	comment			VARCHAR(255)		--备注
);
INSERT INTO policy VALUES(1, "worm", 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "蠕虫过滤策略");

--表名 策略-URL组映射
create table policy_urlgrp_map
(
	gid			INT,			--URL组ID
	pid			INT,			--策略ID
	mod			CHAR(20)		--url
);

--表名 策略-关键字组映射
create table policy_keywordgrp_map
(
	gid			INT,			--网页关键字组ID
	pid			INT,			--策略ID
	mod			CHAR(20)		--httpkw, mailsubject
);

--表名 策略-文件名组映射
create table policy_filenamegrp_map
(
	gid			INT,			--文件路径组ID
	pid			INT,			--策略ID
	mod			CHAR(20)		--download, upload
);

--表名 策略-邮件地址组映射
create table policy_mailaddrgrp_map
(
	gid			INT,			--邮件地址组ID
	pid			INT,			--策略ID
	mod			CHAR(20)		--smtpsend, smtprecv, antirelay
);

--表名 策略-蠕虫映射
create table policy_worm_map
(
	gid			INT,			--蠕虫ID
	pid			INT,			--策略ID
	mod			CHAR(20)		--worm
);
INSERT INTO policy_worm_map VALUES(1, 1, "worm");
INSERT INTO policy_worm_map VALUES(2, 1, "worm");
INSERT INTO policy_worm_map VALUES(3, 1, "worm");
INSERT INTO policy_worm_map VALUES(4, 1, "worm");
INSERT INTO policy_worm_map VALUES(5, 1, "worm");
INSERT INTO policy_worm_map VALUES(6, 1, "worm");
INSERT INTO policy_worm_map VALUES(7, 1, "worm");
INSERT INTO policy_worm_map VALUES(8, 1, "worm");

--表名 URL
create table url
(
	url			VARCHAR(255),		--url
	gid			INT,			--URL组ID
	comment			VARCHAR(255)		--备注
);
INSERT INTO url VALUES("%2e.asp", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".asp|3a3a|$data", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".bat?&", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/null.htw?CiWebHitsFile", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/CGImail.exe", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/..%c0%af../", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/..%c1%1c../", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/..%c1%9c../", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/iisadmin", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".asp.", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/iisadmin/bdir.htr", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/ServerVariables_Jscript.asp", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/scripts/|20|", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("scripts/root.exe?", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/../../", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/nessus_is_probing_you_", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".html/......", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/~root/", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/cgitest.exe|0d0a|user", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".js%2570", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".j%2573p", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".%256Asp", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/%3f.jsp", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("readme.eml", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/cgi-bin/console.exe", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/bin/ls", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/bin/ps", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES(".htgroup", 1, "入侵检测类,请勿修改");
INSERT INTO url VALUES("/cmd.exe?/c", 1, "入侵检测类,请勿修改");

--表名 URLGRP
create table urlgrp
(
	id			INT PRIMARY KEY,	--URL组ID
	name			CHAR(20),		--URL组名称
	enable			BOOL DEFAULT 0,		--是否启用
	comment			VARCHAR(255)		--备注
);
INSERT INTO urlgrp VALUES(1, "IDS",1, "入侵检测类");

--表名 关键字
create table keyword
(
	keyword			VARCHAR(255),		--网页关键字
	gid			INT,			--网页关键字组ID
	comment			VARCHAR(255)		--备注
);

--表名 关键字组
create table keywordgrp
(
	id			INT PRIMARY KEY,	--网页关键字组ID
	name			CHAR(20),		--网页关键字组名称
	enable			BOOL DEFAULT 0,		--是否启用
	comment			VARCHAR(255)		--备注
);

--表名 文件路径
create table filename
(
	filename		VARCHAR(255),		--文件路径
	gid			INT,			--文件路径组ID
	comment			VARCHAR(255)		--备注
);

--表名 文件路径组
create table filenamegrp
(
	id			INT PRIMARY KEY,	--文件路径组ID
	name			CHAR(20),		--文件路径组名称
	enable			BOOL DEFAULT 0,		--是否启用
	comment			VARCHAR(255)		--备注
);

--表名 邮件地址
create table mailaddr
(
	mailaddr		VARCHAR(255),		--邮件地址
	gid			INT,			--邮件地址组ID
	comment			VARCHAR(255)		--备注
);

--表名 邮件地址组
create table mailaddrgrp
(
	id			INT PRIMARY KEY,	--邮件地址组ID
	name			CHAR(20),		--邮件地址组名称
	enable			BOOL DEFAULT 0,		--是否启用
	comment			VARCHAR(255)		--备注
);

--表名 蠕虫特征
create table wormpattern
(
	prot		INT DEFAULT 6,		--协议（TCP UDP ...）
	port		INT DEFAULT 80,		--服务端口
	sig		VARCHAR(255),		--特征数据
	gid		INT,			--蠕虫ID
	comment		VARCHAR(255)		--备注
);
INSERT INTO wormpattern VALUES(6, 80, "\.ida\?", 1, "redcode");
INSERT INTO wormpattern VALUES(6, 8080, "\.ida\?", 1, "redcode");
INSERT INTO wormpattern VALUES(6, 80, "(cmd\.exe)|(root\.exe)", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 8080, "(cmd\.exe)|(root\.exe)", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "\x20\.\x20E\x20M\x20L", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "\x20\.\x20N\x20W\x20S", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "R\x20I\x20C\x20H\x20E\x20D\x202\x200", 2, "nimda");
INSERT INTO wormpattern VALUES(17, 2002, "\x8d\x77\x10\x89\x77\x04\x8d\x4f", 3, "slapper");
INSERT INTO wormpattern VALUES(17, 2002, "\x20\x20\x45\x20\x20\x45\x20\x20\x40\x20", 3, "slapper");
INSERT INTO wormpattern VALUES(17, 1434, "^\x04.*\x90\xeb\x03\x5d\xeb\x05\xe8\xf8.*$", 4, "sqlexp");
INSERT INTO wormpattern VALUES(17, 1434, "^\x04.*\x68\x2E\x64\x6C\x6C\x68\x65\x6C\x33\x32\x68\x6B\x65\x72\x6E.*$", 4, "sqlexp");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\x5c\x20\x5c\x20.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xA0\x01\x20\x20\x20\x20\x20\x20\xC0\x20\x20\x20\x20\x20\x20F.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xB0\x01R\x97\xCAY\xD0\x11\xA8\xD5\x20\xA0\xC9\x0D\x80Q.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\x5c\x20\x5c\x20.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xA0\x01\x20\x20\x20\x20\x20\x20\xC0\x20\x20\x20\x20\x20\x20F.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xB0\x01R\x97\xCAY\xD0\x11\xA8\xD5\x20\xA0\xC9\x0D\x80Q.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 80, "^GET.*asp\x5c.*\x0d\x0aTranslate\x3A f\x0d\x0a.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 8080, "^GET.*asp\x5c.*\x0d\x0aTranslate\x3A f\x0d\x0a.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 445, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 445, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 139, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 139, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 135, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 445, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 445, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 139, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 139, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 8, "zotob");

--表名 蠕虫
create table worm
(
	id			INT PRIMARY KEY,	--蠕虫ID
	name			CHAR(20),		--蠕虫名称
	enable			BOOL,			--是否启用(即是否生效)，0为禁用，1为启用
	comment			VARCHAR(255)		--备注
);
INSERT INTO worm VALUES(1, "redcode", 1, "红色代码");
INSERT INTO worm VALUES(2, "nimda", 1, "Nimda蠕虫");
INSERT INTO worm VALUES(3, "slapper", 1, "Slapper蠕虫");
INSERT INTO worm VALUES(4, "sqlexp", 1, "蠕虫王");
INSERT INTO worm VALUES(5, "blaster", 1, "冲击波");
INSERT INTO worm VALUES(6, "nachi", 1, "冲击波杀手");
INSERT INTO worm VALUES(7, "sasser", 1, "震荡波");
INSERT INTO worm VALUES(8, "zotob", 1, "狙击波");

--表名 服务端口
create table service
(
	type			INT,			--1 预定义 2 自定义
	name			CHAR(20),		--服务名称
	port			INT,			--端口值
	comment			VARCHAR(255)		--备注
);
INSERT INTO service VALUES(2, "http", 80, " ");
INSERT INTO service VALUES(2, "http", 8080, " ");
INSERT INTO service VALUES(2, "ftp", 21, " ");
INSERT INTO service VALUES(2, "smtp", 25, " ");

--表名 运行状态
create table state
(
	id			INT PRIMARY KEY,	--ID
	state			BOOL DEFAULT 0,		--运行状态
	comment			VARCHAR(255)		--备注
);
INSERT INTO state VALUES(1,0," ");

--表名 系统常量
create table constant
(
	dcf_max_service_port		INT DEFAULT 5,		--服务最大端口数
	dcf_policy_max_num		INT DEFAULT 50,		--最大策略数
	dcf_url_max_grpnum		INT DEFAULT 50,		--最大URL组数
	dcf_url_group_max_num		INT DEFAULT 50,		--URL组的最大URL数
	dcf_url_max_len			INT DEFAULT 100,	--URL最大长度
	dcf_keyword_max_grpnum		INT DEFAULT 50,		--最大关键字组数
	dcf_keyword_group_max_num	INT DEFAULT 50,		--关键字组的最大关键字个数
	dcf_keyword_max_num		INT DEFAULT 100,	--关键字最大长度
	dcf_filename_max_grpnum		INT DEFAULT 50,		--最大文件路径组数
	dcf_filename_group_max_num	INT DEFAULT 50,		--文件路径组的最大关键字个数
	dcf_filename_max_len		INT DEFAULT 100,	--文件路径的最大长度
	dcf_mailaddr_max_grpnum		INT DEFAULT 50,		--最大邮件地址组数
	dcf_mailaddr_group_max_num	INT DEFAULT 50,		--邮件地址组的最大关键字个数
	dcf_mailaddr_max_len		INT DEFAULT 100,	--邮件地址的最大长度
	dcf_worm_max_num		INT DEFAULT 50,		--蠕虫的最大个数
	dcf_worm_pattern_max_num	INT DEFAULT 20,		--蠕虫的最大特征个数
	dcf_worm_max_len		INT DEFAULT 100		--蠕虫特征的最大长度
);
INSERT INTO constant VALUES(5, 50, 50, 50, 100, 50, 50, 100, 50, 50, 100, 50, 50, 100, 50, 20, 100);

--表名 统计信息
create table statistics
(
	id			INT PRIMARY KEY,		--ID
	total			INT,				--总的统计信息
	http			INT,				--http过滤
	ftp			INT,				--ftp过滤
	smtp			INT,				--smtp过滤
	worm			INT				--worm过滤
);
INSERT INTO statistics VALUES(1,0,0,0,0,0);

--表名 系统选项
create table option
(
	url_case		BOOL DEFAULT 0		--URL大小写是否敏感
);
INSERT INTO option VALUES(0);

COMMIT;
