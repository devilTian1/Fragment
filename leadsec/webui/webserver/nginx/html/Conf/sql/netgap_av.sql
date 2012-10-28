BEGIN TRANSACTION;


--��̨����ɨ���������״̬��--
create table av_basic
(
	service_status			CHAR(1)			--�����Ƿ��� '1'|'0'
);
insert into av_basic (service_status) values ('0');


-- ����: ������������ʷ��
create table upgrade_history
(
    id          INTEGER PRIMARY KEY,    --���
    up_version  CHAR(50),               --������İ汾  
    up_time     CHAR(20),               --����ʱ��, ��ʽΪ: YYYY/MM/DD hh:mm:ss
    del_bugs    VARCHAR(255)            --���������
);
INSERT into upgrade_history VALUES(1,'2008.0.0.1','2008-01-01 01:01:01','������ʼ�汾');

-- Add for AV update --
create table autoupNew
(
	  upenable  INT,        -- �Ƿ������Զ����� 1���� 0����
	  upaddr    char(65),   --������������ַ
	  uptype    INT,        --1 2
	  upway     INT,        --1 2 3
	  shour     INT,
	  sday      INT,
	  sweek     INT,
	  swh       INT,
	  upport    char(8)
);
insert into autoupNew values(0,"www.leadsec.com",1,1,1,3,0,3,"21");

-- �����������б�
create table avlist
(
	id          INT PRIMARY KEY,        --���
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
