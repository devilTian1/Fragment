BEGIN TRANSACTION;

--͸��ģʽ�ͻ��˷��ʱ�--
create table db_trans_client_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, �������ʱ��뱣��Ψһ��
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	sa			CHAR(50),
	da			CHAR(50),				--�ⲿ��������ʵ��ַ
	dport		INT,					--�ⲿ�������Ķ˿�
	usergrp		CHAR(50),				--��֤�û���,added at 2008-3-8
	time		CHAR(50),
	filter		CHAR(20),		--Э����˼�����
	active 		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)
);
--insert into db_trans_client_acl values(2,'oracle','any','any','1000','','','filter01','0','aaaaa');

--��ͨģʽ�ͻ��˷��ʱ�--
create table db_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, �������ʱ��뱣��Ψһ��
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	sa			CHAR(50),				--Դ��ַ����
	lip			CHAR(50),				--������ַ
	lport		INT,					--�����˿�
	usergrp		CHAR(50),				--��֤�û���,added at 2008-3-8
	time		CHAR(50),				--
	filter		CHAR(20),				--Э����˼�����
	active 		CHAR(1),				--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
        ip_ver           CHAR(10),
	comment		VARCHAR(255)			--
);
--insert into db_comm_client_acl values(12,'oracle','any','10.0.0.1','1000','','','filter01','1','aaaaa');
--insert into db_comm_client_acl values(13,'oracle','any','10.0.0.1','1000','','','filter01','0','aaaaa');

--��ͨģʽ����˷��ʱ�--
create table db_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--taskID, �������ʱ��뱣��Ψһ��
	dbtype		CHAR(15),				--oracle sqlserver mysql sybase access unknown
	serverip	CHAR(50),				--���������ⲿ���񣩵�ַ����
	sport		INT,					--���������ⲿ���񣩶˿�
	active 		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
        ip_ver           CHAR(10),
	comment		VARCHAR(255)			--������Ϣ
);
--insert into db_comm_server_acl values(5,'oracle','10.1.1.1','1521','1','aaaaa');
--insert into db_comm_server_acl values(6,'oracle','10.1.1.1','1521','0','aaaaa');

create table db_option_list
(
  	id				INTEGER PRIMARY KEY,	--���
	name	    	CHAR(20),				--����ѡ������
	usergrp      	CHAR(20),               --URL��������
	sqlgrp     		CHAR(20),               --MIME����
	bufav       	CHAR(1),                --��ģʽ�������: '1'��ʾɨ��,'0'��ʾ��ɨ��
	comment			VARCHAR(255)			--������Ϣ
);
--insert into db_option_list values(1,'filter01','usergrp01','','1','aaaaa');


--�û����ʿ��Ʊ�--
create table  db_user_filter
(
	id				INTEGER PRIMARY KEY,	--���
	name		CHAR(15),			--�û�����ѡ���������
	allow		CHAR(1),			--'A': allow    'F': forbidden
	usrnamelist	VARCHAR(1024),		--�û���֮��ķָ���ţ�����(Ĭ��)��ո��\t
	comment		VARCHAR(255)			--������Ϣ
);
--insert into db_user_filter values('usergrp01','A','abc,aaa,user','comment');
--insert into db_user_filter values('usergrp02','F','sa','this is test');

--SQL���Ʊ�--
create table  db_sql_filter
(
  	id				INTEGER PRIMARY KEY,	--���
	name		CHAR(15),			--SQL�������ѡ���������
	allow		CHAR(1),			--'A': allow    'F': forbidden
	sqllist		VARCHAR(1024),		--SQL���֮��ķָ���ţ�����(Ĭ��)
	comment		VARCHAR(255)		--������Ϣ
);
--insert into db_sql_filter values('sql01','A','SELECT,UPDATE','comment');

--ȫ�ֲ������ñ�--
create table  db_option
(
	default_allow	CHAR(1)			--���ʿ��Ʋ���ȫ��ƥ��ʱ��Ĭ��ͨ����ʽ��'1'-allow    '0'-forbidden
);
insert into db_option values('1');	--default: allow

--Oracle ����ͨ��IP��ַ--
create table oracle_dataip
(
	dataip		CHAR(15)			--Oracle���ݿ������ͨ��IP��ַ,��������ݿ����ģ���е�oracle͸���ͻ���
);
insert into oracle_dataip values('10.0.0.1'); --��ӳ���Ĭ�ϵ�����ͨ��IP����ֵͬfe1��ֵ

--���ݿ����ͱ�--
create table  db_type
(
	type		CHAR(15)			--���ݿ�����
);
insert into db_type values('oracle');
insert into db_type values('sqlserver2000');
insert into db_type values('sqlserver2005');
insert into db_type values('mysql');
insert into db_type values('DB2');
insert into db_type values('sybase');
--insert into db_type values('access');

COMMIT;
