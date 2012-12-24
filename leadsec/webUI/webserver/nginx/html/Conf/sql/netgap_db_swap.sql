BEGIN TRANSACTION;

--���ݿ�ͬ���ͻ��˷��ʱ�--
create table db_swap_client_acl 
(	
	id		INTEGER PRIMARY KEY,		--���
	sa		CHAR(50),								--Դ��ַ����
	lip		CHAR(50),								--������ַ
	lport		INT,									--�����˿� 
	ssl			CHAR(1),								--�Ƿ����SSL����: 'Y'/'N'
	time		CHAR(50),							-- ʱ�����
	killvirus           CHAR(1),
	active 		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	commname		VARCHAR(255),			--�Զ�֤�鹲����
	ip_ver		CHAR(10),
	comment		VARCHAR(255)
);

--���ݿ�ͬ������˷��ʱ�--
create table db_swap_server_acl 
(	
	id			INTEGER PRIMARY KEY,	--���
	serverip	CHAR(50),						--���������ⲿ���񣩵�ַ����
	sport		INT,									--���������ⲿ���񣩶˿�  
	ssl						CHAR(1),				--�Ƿ����SSL����: 'Y'/'N'
	commname		VARCHAR(255),			--�Զ�֤�鹲����
	active 		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	ip_ver		CHAR(10),
	comment		VARCHAR(255)				--������Ϣ
);

--���ݿ�ͬ���û����Ʊ�--
create table db_swap_user_auth
(
	userid		INT,						--�û�ID
	username	CHAR(50),				--�û���
	password	CHAR(50),				--�û�����
	comment	VARCHAR(255),				--������Ϣ
	flag		CHAR(50)					--��ʱ����
);

COMMIT;
