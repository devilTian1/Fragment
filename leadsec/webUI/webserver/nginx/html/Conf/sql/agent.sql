-- History:
-- 	baiyu 2005/01/17 策略代理Agent数据库表创建SQL语句

-- Use(Create database):
--   #rm agent.db
--   #sqlite agent.db < agent.sql

BEGIN TRANSACTION;

-- 策略代理表
create table policy
(
	id		INTEGER PRIMARY KEY,    	--序号
	hostname 	CHAR(64),			--策略服务器地址
	port		INT,				--策略服务器端口号
	dev_name	CHAR(100),			--设备名称
	dev_type	CHAR(10),			--设备类型 gateway | client
	dev_ip		CHAR(20),			--设备IP地址
	retry_time	INT,				--连接重试次数
	time_span	INT,				--挂起时间(分钟)
	time_out	INT,				--UDP超时时间(秒)
	last_time	INT,				--最近一次获得策略的时间 0-没有获取过策略 | >0正确获取策略 | <0没有正确获取策略
	active_flag	INT,				--启动/停止设备代理标志 0-停止 | 1-启动
	getnow_flag	INT,				--立刻获取策略标志 0-不立刻获取 | 1-立刻获取
	local_flag	INT,				--从本地获取策略标志 0-通过网络获取 | 1-通过本地获取
	des_key		CHAR(20)			--DES解密Key
);

INSERT INTO policy VALUES(1, '192.168.1.1', 8585, 'fw', 'gateway', '192.168.1.254', 3, 20, 3, 0, 0, 0, 0, 'admin123');

COMMIT;


