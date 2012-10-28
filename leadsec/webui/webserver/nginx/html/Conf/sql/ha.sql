-- Use(Create database):
--   #rm ha.db
--   #sqlite ha.db<ha.sql
-- 0. xiaowj 2003/11/04
--     从private.db中移出来


BEGIN TRANSACTION;

-- 表名: 集群
create table ha_heartbeat
(
    ha_id                   INT,        --集群ID, 同一集群要用相同的ID, 1-255
    ip                      CHAR(15),   --选中的HA端口IP
    netmask                 CHAR(15),   --IP对应的mask
    enable                  BOOL,       --启用防火墙集群
    node_id                 INT,        --本机节点号 
    mode                    BOOL,       --工作模式, 1为双机热备，0为负载均衡
    heartbeat               INT,        --心跳周期，毫秒
    deadtime                INT,        --节点离线判断次数
    sync_conf_timeout       INT,        --同步配置超时时间, 以下几项不用配置，为集群模块保留
    sync_load_timeout       INT,        --同步负载超时时间
    sync_nodetable_timeout  INT,        --同步节点表超时时间
    haif_enable             BOOL,       --启用防火墙HA接口
    synstate                BOOL        --是否启用状态同步
);
insert into ha_heartbeat values (0,'','',0,1,0,500,3,2000,1000,1000,0,0);


-- 表名: IP地址探测配置表
create table ha_detectip_conf
(
    threshold               INT,        --定义判断节点失效的所有失败探测的重要性之和的阈值
    interval                INT,        --ARP发送周期
    deadcount               INT         --探测该IP失效的判断次数
);
insert into ha_detectip_conf values (100,1,2);

-- 表名: IP地址探测表
create table ha_detectip
(
    ip                      CHAR(15),   --需要探测的ip 地址
    weight                  INT,        --重要性
    interface               CHAR(20)    --网络接口外部名字
);
-- insert into ha_detectip values ('40.1.1.2',1,'fe1');

-- 表名: 网络接口探测表
create table ha_alertif
(
    interface               CHAR(20),   --需要探测的网络接口外部名字
    alert                   BOOL,       --是否属于HA探测网卡 （1报警、0不报警）
    intername               CHAR(20),   --需要探测的网络接口内部名字
    valid                   BOOL        --网口是否有效
);
insert into ha_alertif values ('fe1',0,'eth0',1);
insert into ha_alertif values ('fe2',0,'eth1',1);
insert into ha_alertif values ('fe3',0,'eth2',1);
insert into ha_alertif values ('fe4',0,'eth3',0);
insert into ha_alertif values ('fe5',0,'eth4',0);
insert into ha_alertif values ('fe6',0,'eth5',0);
insert into ha_alertif values ('fe7',0,'eth6',0);
insert into ha_alertif values ('fe8',0,'eth7',0);
insert into ha_alertif values ('fe9',0,'eth8',0);
insert into ha_alertif values ('fe10',0,'eth9',0);
insert into ha_alertif values ('fe11',0,'eth10',0);
insert into ha_alertif values ('fe12',0,'eth11',0);
insert into ha_alertif values ('fe13',0,'eth12',0);
insert into ha_alertif values ('fe14',0,'eth13',0);
insert into ha_alertif values ('fe15',0,'eth14',0);
insert into ha_alertif values ('fe16',0,'eth15',0);
insert into ha_alertif values ('rd1',0,'bond1',0);
insert into ha_alertif values ('rd2',0,'bond2',0);
insert into ha_alertif values ('rd3',0,'bond3',0);
insert into ha_alertif values ('rd4',0,'bond4',0);
COMMIT;


