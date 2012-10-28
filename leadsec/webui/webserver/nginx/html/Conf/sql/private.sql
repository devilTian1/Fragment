
-- Use(Create database):
--   #rm private.db
--   #sqlite private.db<private.sql
-- 3. xiaowj 2003/09/05 
--     据刘天容/刘永锋要求：
--     把cluster/detectip_conf/detectip/detectif从configs.db中移动到private.db中
--     2003/09/08 和刘永锋/刘天容一起，把以上三个表名称、字段做了修改，更合理了。
--history:
--	2006-12-20 zhouxj 在license表添加一个字段operation_cmd,存放该许可证过期后的操作。

BEGIN TRANSACTION;

-- 表名: 升级历史表
create table upgrade_history
(
    id          INTEGER PRIMARY KEY,    --序号
    up_version  CHAR(50),               --升级后的版本  
    up_time     CHAR(20),               --升级时间, 格式为: YYYY/MM/DD hh:mm:ss
    del_bugs    VARCHAR(255)            --解决的问题
);
--INSERT INTO upgrade_history VALUES(1,'1.0.0.1','2008/01/01 01:01:01','');

-- 表名: 硬件版本表
create table hardware
(
    version     CHAR(50)                --硬件版本号
);
INSERT INTO hardware VALUES("HD1.5.5.8");

-- 表名: 许可证表
create table license
(
    application CHAR(20),               --应用程序
    function    CHAR(20),               --功能
    value       INTEGER,                --数值
    start_time  INTEGER,                --启用时间
    stop_time   INTEGER,                --停用时间
    operation_cmd	CHAR(256)			--许可证过期后的操作，即相应的执行命令行
);
--Modified for netgap
--INSERT INTO license VALUES('vpn','vpn',1,0,1794999420);
--INSERT INTO license VALUES('vpnekey','vpnekey',1,0,1794999420);
--INSERT INTO license VALUES('sslvpn','sslvpn',5,0,1794999420);
--INSERT INTO license VALUES('ha','ha',1,0,1794999420);
--INSERT INTO license VALUES('acsc','acsc',10000,0,1794999420);
--INSERT INTO license VALUES('policyagent','policyagent',1,0,1794999420);
--INSERT INTO license VALUES('user_limit','user_limit',25,0,1794999420);

INSERT INTO license VALUES('file_swap','file_swap',0,0,1794999420,"/usr/local/bin/fsctl stop");
INSERT INTO license VALUES('file_swap_new','file_swap_new',0,0,1794999420,"/usr/local/bin/fs2ctl stop");
INSERT INTO license VALUES('mail_swap','mail_swap',0,0,1794999420,"");
INSERT INTO license VALUES('database_swap','database_swap',0,0,1794999420,"/usr/local/bin/dbsctl stop");
INSERT INTO license VALUES('http_access','http_access',0,0,1794999420,"/usr/local/bin/httpctl stop");
INSERT INTO license VALUES('ftp_access','ftp_access',0,0,1794999420,"/usr/local/bin/ftpctl stop");
INSERT INTO license VALUES('mail_access','mail_access',0,0,1794999420,"/usr/local/bin/smtpctl stop;/usr/local/bin/pop3ctl stop");
INSERT INTO license VALUES('database_access','database_access',0,0,1794999420,"/usr/local/bin/dbctl stop");
INSERT INTO license VALUES('fastpass_access','fastpass_access',0,0,1794999420,"/usr/local/bin/fpctl stop"); --added by yusb.2007-12-3 17:28 
INSERT INTO license VALUES('msg_swap','msg_swap',0,0,1794999420,"/usr/local/bin/msgctl stop");
INSERT INTO license VALUES('custom_access','custom_access',1,0,1794999420,"/usr/local/bin/ctcpctl stop;/usr/local/bin/cudpctl stop");
--组播模块
INSERT INTO license VALUES('multicast_access','multicast_access',0,0,1794999420,"/usr/local/bin/multicastctl stop");
INSERT INTO license VALUES('ids','ids',1,0,1794999420,"");
INSERT INTO license VALUES('ha','ha',1,0,1794999420,"");
INSERT INTO license VALUES('anti-virus','anti-virus',0,0,1794999420,"");
--added by wangqi 2010-9-20
INSERT INTO license VALUES('stream_swap','stream_swap',0,0,1794999420,"/usr/local/bin/stctl stop"); 
--added by wangqi 2011-10-12  数据所定制项目--多媒体模块
--INSERT INTO license VALUES('mulmedia','mulmedia',0,0,1794999420,"/usr/local/bin/cmtcpctl stop;/usr/local/bin/cmudpctl stop"); 
--INSERT INTO license VALUES('gamedia','gamedia',0,0,1794999420,"/usr/local/bin/cgtcpctl stop");

-- add for netgap
-- 表名: OS信息
create table os_info
(
    os_name		CHAR(50),               --OS名称
    os_ver		CHAR(50)               	--OS版本
);

INSERT INTO os_info VALUES('LXOS','2.8.3.0');

COMMIT;
