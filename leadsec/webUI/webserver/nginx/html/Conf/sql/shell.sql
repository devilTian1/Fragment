
-- Use(Create database):
--   #sqlite shell.db<shell.sql

-- History:

BEGIN TRANSACTION;

-- ��������ַ�б�ipset�����
create table ipset_addr_list
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(20)
);

-- ��������ַ��ipset�����
create table ipset_addr_grp
(
	id				INTEGER PRIMARY KEY,
	cmd		  CHAR(20)
);

COMMIT;


