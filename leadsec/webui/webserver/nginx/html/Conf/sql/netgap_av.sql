BEGIN TRANSACTION;


--后台集中扫描引擎服务状态表--
create table av_basic
(
	service_status			CHAR(1)			--服务是否开启 '1'|'0'
);
insert into av_basic (service_status) values ('0');


-- 表名: 病毒库升级历史表
create table upgrade_history
(
    id          INTEGER PRIMARY KEY,    --序号
    up_version  CHAR(50),               --升级后的版本  
    up_time     CHAR(20),               --升级时间, 格式为: YYYY/MM/DD hh:mm:ss
    del_bugs    VARCHAR(255)            --解决的问题
);
INSERT into upgrade_history VALUES(1,'2008.0.0.1','2008-01-01 01:01:01','出厂初始版本');

-- Add for AV update --
create table autoupNew
(
	  upenable  INT,        -- 是否启用自动升级 1启用 0禁用
	  upaddr    char(65),   --升级服务器地址
	  uptype    INT,        --1 2
	  upway     INT,        --1 2 3
	  shour     INT,
	  sday      INT,
	  sweek     INT,
	  swh       INT,
	  upport    char(8)
);
insert into autoupNew values(0,"www.leadsec.com",1,1,1,3,0,3,"21");

-- 表名：病毒列表
create table avlist
(
	id          INT PRIMARY KEY,        --序号
	groupname       CHAR(65),
	name        CHAR(65)
);

create table avlist_userdefine
(
	id INT,
	name char(64),
	sig char(256)
);

COMMIT;
