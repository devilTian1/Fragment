
-- Use(Create database):
--   #rm netgap_fastpass.db
--   #sqlite netgap_fastpass.db<netgap_fastpass.sql
--   #cp netgap_fastpass.db /usr/local/conf

BEGIN TRANSACTION;

create table fastpass_client_acl 	-- 通道访问客户端访问表 --
(
	id		INTEGER PRIMARY KEY,
	samenet		CHAR(3),	-- yes：网闸内外属同一网段；no：网闸内外不属同一网段。
	sa		CHAR(50),	-- 源地址，形如：any、cip_1…
	sport		CHAR(50),	-- 源端口，形如：0(any,未填时为任意值)、0:65535、1200…
	da		CHAR(50),	-- 目的地址，(当samenet==yes，该字段为网闸地址)，形如：any、sip_1…
	dport		CHAR(50),	-- 目的端口，形如：0(any,未填时为任意值)、0:65535、1200…
	service	 	CHAR(12),	-- 服务类型：TCP/UDP/ICMP/TNS/QQ/P2P/MSN等等 
	usergrp		CHAR(50),				--认证用户组
	time		CHAR(50),
	active		CHAR(4),
	comment		VARCHAR(255),
	log  	       CHAR(1),		--'Y':yes	'N':no
	syn			CHAR(10),
	udp			CHAR(10),
	icmp		CHAR(10),
	ping		CHAR(10)
);

create table fastpass_server_acl 	-- 通道访问服务端访问表 --
(
	id		INTEGER PRIMARY KEY,
	sip		CHAR(50),	-- 服务器IP地址，形如：1.1.1.1
	sport 		CHAR(50),	-- 服务器端口号，形如：1200
	inport		CHAR(5),	-- 公开端口，即：与客户端任务中的目的端口一致
	eip		CHAR(50),	-- 出口地址，形如：1.1.1.1
	service	 	CHAR(12),	-- 服务类型：TCP/UDP/ICMP/TNS/QQ/P2P/MSN等等
	time		CHAR(50),
	active          CHAR(4),
	comment		VARCHAR(255),
	log        	 CHAR(1)	--'Y':yes       'N':no
);

create table fastpass_status 		-- 通道访问服务状态表 --
(
	status		INT		-- 通道访问模块服务运行状态
);
insert into fastpass_status values(0);

create table debug_switch 		-- 调试开关表 --
(
	debug		INT		-- 1：表示打开fpctl命令行调试开关；0：表示关闭fpctl命令行调试开关；
);
insert into debug_switch values(0);

COMMIT;
    
