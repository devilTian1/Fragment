
-- Use(Create database):
--   #sqlite shell.db<shell.sql

-- History:

BEGIN TRANSACTION;

-- 表名：地址列表ipset命令表
create table ipset_addr_list
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(255)
);
INSERT INTO "ipset_addr_list" VALUES(1,'/usr/local/sbin/ipset create any_ipv4 hash:net;/usr/local/sbin/ipset add any_ipv4 0.0.0.0/1;/usr/local/sbin/ipset add any_ipv4 128.0.0.0/1');
INSERT INTO "ipset_addr_list" VALUES(2,'/usr/local/sbin/ipset create any_ipv6 hash:net family inet6;/usr/local/sbin/ipset add any_ipv6 ::/1;/usr/local/sbin/ipset add any_ipv6 8000::0/1');

-- 表名：地址组ipset命令表
create table ipset_addr_grp
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(255)
);

COMMIT;


