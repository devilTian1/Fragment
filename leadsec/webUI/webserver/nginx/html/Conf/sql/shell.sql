
-- Use(Create database):
--   #sqlite shell.db<shell.sql

-- History:

BEGIN TRANSACTION;

-- 表名：地址列表ipset命令表
create table ipset_addr_list
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(20)
);

-- 表名：地址组ipset命令表
create table ipset_addr_grp
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(20)
);

COMMIT;


