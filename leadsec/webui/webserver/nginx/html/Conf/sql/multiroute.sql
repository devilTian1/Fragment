-- Use(Create database):
--   #sqlite configs.db<configs.sql

-- History:
-- 1.	2005/08/09	yuzy	创建此DB


BEGIN TRANSACTION;

-- 表名: mrg_node_info 多路由负载均衡路由信息
create table mrg_node_info 
( 
	ip	 	CHAR(15),		--网关ip地址
	ifname 		CHAR(20),		--该路由的本地出口设备名
	ifname_ext	CHAR(20),		--接口外部名
	active		BOOL,			--是否启用该路由
	valid	 	BOOL,			--该路由是否可用
	devstatus 	BOOL,			--设备的启停状态
	weight 		INT			--当前路由的权重
);



-- 表名 ：默认路由负载均衡状态
create table mrg_state 
(
	active 	BOOL,			--网关监测功能是否启动
	freq 	INT,			--监测频率
	running	BOOL			--多路由负载均衡守护进程是否正在运行
);

INSERT INTO mrg_state VALUES(1,1,0);

COMMIT;
