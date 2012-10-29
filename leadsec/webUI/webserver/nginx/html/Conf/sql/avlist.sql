
-- Use(Create database):
--   #sqlite avlist.db<avlist.sql

-- History:
-- 2009/02/23	dingxd	create
-- ������
BEGIN TRANSACTION;

-- �����������б�
create table avlist
(
	id			INT PRIMARY KEY,    	--���
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
-- ������ʷ��
create table upgrade_history
(
    id          INTEGER PRIMARY KEY,    --���
    up_version  CHAR(50),               --������İ汾  
    up_time     CHAR(20),               --����ʱ��, ��ʽΪ: YYYY/MM/DD hh:mm:ss
    del_bugs    VARCHAR(255)            --���������
);

--������Ϣ��
create table upgrade_info
(
    name	CHAR(20),		--����������
    type    CHAR(20),		--���������ͣ�IPS/ALL
    pa_num	INTEGER,		--���������
    status	INTEGER			--0δ������1������
);

-- Add for AV update --
create table autoupNew
(
  upenable	INT,		-- �Ƿ������Զ����� 1���� 0����
  upaddr	char(65),	--������������ַ
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
