
-- Use(Create database):
--   #sqlite avlist.db<avlist.sql

-- History:
-- 2009/02/23	dingxd	create
-- 病毒库
BEGIN TRANSACTION;

-- 表名：病毒列表
create table avlist
(
	id			INT PRIMARY KEY,    	--序号
	groupname		CHAR(65),
	name		CHAR(65)
);

create table avlist_userdefine
(
	id INT,
	name char(64),
	sig char(256)
);

-- Add for AV update --
-- 升级历史表
create table upgrade_history
(
    id          INTEGER PRIMARY KEY,    --序号
    up_version  CHAR(50),               --升级后的版本  
    up_time     CHAR(20),               --升级时间, 格式为: YYYY/MM/DD hh:mm:ss
    del_bugs    VARCHAR(255)            --解决的问题
);

--升级信息表
create table upgrade_info
(
    name	CHAR(20),		--升级包名称
    type    CHAR(20),		--升级包类型，IPS/ALL
    pa_num	INTEGER,		--升级包编号
    status	INTEGER			--0未升级，1已升级
);

-- Add for AV update --
create table autoupNew
(
  upenable	INT,		-- 是否启用自动升级 1启用 0禁用
  upaddr	char(65),	--升级服务器地址
  uptype	INT,		--1 2
  upway		INT,		--1 2 3
  shour		INT,
  sday		INT,
  sweek		INT,
  swh		INT,
  upport	char(8)
);
insert into autoupNew values(0,"onlineupdate.leadsec.com.cn",1,1,1,3,0,3,"21");

COMMIT;
