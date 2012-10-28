BEGIN TRANSACTION;

create table protocol
(
	id		INT,				--���
	name	CHAR(50) primary key,			--����
	port	CHAR(10),
	protocol	CHAR(50),		--Э��
	packet	CHAR(256)			--��Ԫ��
);

create table packet
(
	id		INT,
	name	CHAR(50) primary key,
	itype    CHAR(50),           --����
	length CHAR(50),           --�汾��
	field    CHAR(256),       --��
	comment VARCHAR(255)
);


create table field
(
	id		INT,
	flags   CHAR(50) primary key,
	name	CHAR(50),			--�ֶ�����
	itype    CHAR(50),           --�ֶ�����
	length CHAR(50),           --�ֶγ���
	icheck    CHAR(50),       --�Ƿ���
	value    CHAR(256)       --��Чֵ
);


--TCP͸��ģʽ�ͻ��˷��ʱ�--
create table tcp_trans_client_acl 
(
	id		INTEGER PRIMARY KEY,
	sa		CHAR(50),
	da		CHAR(50),			--�ⲿ��������ʵ��ַ
	dport		CHAR(12),		--�ⲿ�������Ķ˿�
	usergrp		CHAR(50),		--��֤�û���
	time		CHAR(50),
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	fast_pass 	INTEGER,   --����ͨ�����أ�Added by Yanghong 2007-4-11 10:39
	killvirus	CHAR(1),
	comment		VARCHAR(255)
	
);

--TCP��ͨģʽ�ͻ��˷��ʱ�--
create table tcp_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--
	sa			CHAR(50),				--Դ��ַ����
	lip			CHAR(50),				--������ַ
	lport		INT,					--�����˿�
	usergrp		CHAR(50),				--��֤�û���
	time		CHAR(50),				--
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	killvirus	CHAR(1),
	comment		VARCHAR(255),			--
	source		CHAR(1),			--�Ƿ��Դ��ַ
	s_mode		CHAR(1),				--Դ��ַ��Խģʽ	'1'-auto
	audit		CHAR(1),
	log			CHAR(1),
	protocol	CHAR(255)
);

--TCP��ͨģʽ����˷��ʱ�--
create table tcp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--���
	serverip	CHAR(50),				--���������ⲿ���񣩵�ַ����
	sport		INT,					--���������ⲿ���񣩶˿�
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--������Ϣ
	source		CHAR(1),			--�Ƿ��Դ��ַ
	lip			CHAR(16)
);

--UDP͸��ģʽ�ͻ��˷��ʱ�--
create table udp_trans_client_acl 
(
	id		INTEGER PRIMARY KEY,
	sa		CHAR(50),
	da		CHAR(50),		--�ⲿ��������ʵ��ַ
	dport	CHAR(12),		--�ⲿ�������Ķ˿�
	usergrp		CHAR(50),	--��֤�û���
	time		CHAR(50),
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	fast_pass 	INTEGER,   --����ͨ�����أ�Added by Yanghong 2007-4-19 18:38
	killvirus	CHAR(1),
	comment		VARCHAR(255)
);
--insert into udp_trans_client_acl values(1,'any','any',1234,'','','1',0,'0','comment');
--insert into udp_trans_client_acl values(2,'any','any',1230,'','','0',0,'0','comment');


--multicast��ͨģʽ�ͻ��˷��ʱ�--
create table multicast_comm_client_acl 
(
	id		INTEGER PRIMARY KEY,	--
	sa		CHAR(50),			--Դ��ַ����
	lip		CHAR(50),			--������ַ
	lport		INT,			--�����˿�
	usergrp		CHAR(50),		--��֤�û���
	time		CHAR(50),		--
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	killvirus   CHAR(1),
	comment		VARCHAR(255),	--
	source		CHAR(1),			--�Ƿ��Դ��ַ	'1'-yes		'0'-no
	s_mode		CHAR(1),				--Դ��ַ��Խģʽ	'1'-auto
	t_mode		CHAR(10),
	maddr		CHAR(16),			--�鲥��ַ
	smaddr		CHAR(16),			--�鲥Դ��ַ
	audit		CHAR(1),			--�Ƿ���ýӿ�  1 ���� 0 ������
	log			CHAR(1),
	protocol	CHAR(255)			--Э��
);
--insert into multicast_comm_client_acl values(3,'any','10.0.0.10',1234,'','','1','0','comment');
--insert into multicast_comm_client_acl values(4,'any','10.0.0.10',1230,'','','0','0','comment');

--multicast��ͨģʽ����˷��ʱ�--
create table multicast_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--���
	serverip	CHAR(50),				--���������ⲿ���񣩵�ַ����
	sport		INT,					--���������ⲿ���񣩶˿�
	active		CHAR(1),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255),			--������Ϣ
	source		CHAR(1),
	lip			CHAR(16),
	ttl			CHAR(10),
	srcport		CHAR(10)			--Դ�˿�
);
--insert into multicast_comm_server_acl values(5,'10.1.1.10',1234,'1','comment');
--insert into multicast_comm_server_acl values(6,'10.1.1.10',1230,'0','comment');

COMMIT;
