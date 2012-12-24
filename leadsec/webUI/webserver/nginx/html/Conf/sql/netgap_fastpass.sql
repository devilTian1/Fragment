
-- Use(Create database):
--   #rm netgap_fastpass.db
--   #sqlite netgap_fastpass.db<netgap_fastpass.sql
--   #cp netgap_fastpass.db /usr/local/conf

BEGIN TRANSACTION;

create table fastpass_client_acl 	-- ͨ�����ʿͻ��˷��ʱ� --
(
	id		INTEGER PRIMARY KEY,
	samenet		CHAR(3),	-- yes����բ������ͬһ���Σ�no����բ���ⲻ��ͬһ���Ρ�
	sa		CHAR(50),	-- Դ��ַ�����磺any��cip_1��
	sport		CHAR(50),	-- Դ�˿ڣ����磺0(any,δ��ʱΪ����ֵ)��0:65535��1200��
	da		CHAR(50),	-- Ŀ�ĵ�ַ��(��samenet==yes�����ֶ�Ϊ��բ��ַ)�����磺any��sip_1��
	dport		CHAR(50),	-- Ŀ�Ķ˿ڣ����磺0(any,δ��ʱΪ����ֵ)��0:65535��1200��
	service	 	CHAR(12),	-- �������ͣ�TCP/UDP/ICMP/TNS/QQ/P2P/MSN�ȵ� 
	usergrp		CHAR(50),				--��֤�û���
	time		CHAR(50),
	active		CHAR(4),
	comment		VARCHAR(255),
	log  	       CHAR(1),		--'Y':yes	'N':no
	syn			CHAR(10),
	udp			CHAR(10),
	icmp		CHAR(10),
	ping		CHAR(10)
);

create table fastpass_server_acl 	-- ͨ�����ʷ���˷��ʱ� --
(
	id		INTEGER PRIMARY KEY,
	sip		CHAR(50),	-- ������IP��ַ�����磺1.1.1.1
	sport 		CHAR(50),	-- �������˿ںţ����磺1200
	inport		CHAR(5),	-- �����˿ڣ�������ͻ��������е�Ŀ�Ķ˿�һ��
	eip		CHAR(50),	-- ���ڵ�ַ�����磺1.1.1.1
	service	 	CHAR(12),	-- �������ͣ�TCP/UDP/ICMP/TNS/QQ/P2P/MSN�ȵ�
	time		CHAR(50),
	active          CHAR(4),
	comment		VARCHAR(255),
	log        	 CHAR(1)	--'Y':yes       'N':no
);

create table fastpass_status 		-- ͨ�����ʷ���״̬�� --
(
	status		INT		-- ͨ������ģ���������״̬
);
insert into fastpass_status values(0);

create table debug_switch 		-- ���Կ��ر� --
(
	debug		INT		-- 1����ʾ��fpctl�����е��Կ��أ�0����ʾ�ر�fpctl�����е��Կ��أ�
);
insert into debug_switch values(0);

COMMIT;
    
