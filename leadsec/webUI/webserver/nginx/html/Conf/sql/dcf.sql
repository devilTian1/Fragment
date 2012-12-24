-- Use(Create database):
-- #rm dcf.db
-- #sqlite dcf.db < dcf.sql

-- History:
-- 1. create hanhz 2005/03/08

BEGIN TRANSACTION;

--��������ȹ��˲���
create table policy
(
	id			INTEGER PRIMARY KEY,	--����ID
	name			CHAR(20),		--��������
	enable			BOOL DEFAULT 0,		--�����Ƿ�����
	http_enable		BOOL DEFAULT 0,		--�Ƿ�����HTTP����
	url_enable		BOOL DEFAULT 0,		--�Ƿ�����URL����
	url_mode		INT DEFAULT 0,		--������"0"��������"1"��������������¼��־2
	url_reassembly		BOOL DEFAULT 0,		--�Ƿ�URL��Ƭ����
	url_log_src		BOOL DEFAULT 0,		--�Ƿ�ͬԴ��־
	url_log			BOOL DEFAULT 0,		--URL�Ƿ��¼��־
	page_keyword_enable	BOOL DEFAULT 0,		--�Ƿ�������ҳ�ؼ��ֹ���
	page_keyword_log	BOOL DEFAULT 0,		--��ҳ�ؼ��ֹ����Ƿ��¼��־
	ftp_enable		BOOL DEFAULT 0,		--�Ƿ�����FTP����
	download_enable		BOOL DEFAULT 0,		--�Ƿ������ļ����ع���
	download_deny		BOOL DEFAULT 0,		--"1"��ֹ����
	download_log		BOOL DEFAULT 0,		--�ļ������Ƿ��¼��־
	upload_enable		BOOL DEFAULT 0,		--�Ƿ������ļ��ϴ�����
	upload_deny		BOOL DEFAULT 0,		--"1"��ֹ�ϴ�
	upload_log		BOOL DEFAULT 0,		--�ļ��ϴ������Ƿ��¼��־
	smtp_enable		BOOL DEFAULT 0,		--�Ƿ�����SMTP����
	send_enable		BOOL DEFAULT 0,		--�Ƿ����÷����˹���
	send_log		BOOL DEFAULT 0,		--�����˹����Ƿ��¼��־
	recv_enable		BOOL DEFAULT 0,		--�Ƿ����÷����˹���
	recv_log		BOOL DEFAULT 0,		--�����˹����Ƿ��¼��־
	subject_enable		BOOL DEFAULT 0,		--�Ƿ������ʼ��������
	subject_log		BOOL DEFAULT 0,		--�ʼ���������Ƿ��¼��־
	antirelay_enable	BOOL DEFAULT 0,		--�Ƿ����÷��ʼ���ת
	antirelay_log		BOOL DEFAULT 0,		--���ʼ���ת�Ƿ��¼��־
	worm_enable		BOOL DEFAULT 0,		--�Ƿ�����������
	worm_log		BOOL DEFAULT 0,		--�������Ƿ��¼��־
	comment			VARCHAR(255)		--��ע
);
INSERT INTO policy VALUES(1, "worm", 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "�����˲���");

--���� ����-URL��ӳ��
create table policy_urlgrp_map
(
	gid			INT,			--URL��ID
	pid			INT,			--����ID
	mod			CHAR(20)		--url
);

--���� ����-�ؼ�����ӳ��
create table policy_keywordgrp_map
(
	gid			INT,			--��ҳ�ؼ�����ID
	pid			INT,			--����ID
	mod			CHAR(20)		--httpkw, mailsubject
);

--���� ����-�ļ�����ӳ��
create table policy_filenamegrp_map
(
	gid			INT,			--�ļ�·����ID
	pid			INT,			--����ID
	mod			CHAR(20)		--download, upload
);

--���� ����-�ʼ���ַ��ӳ��
create table policy_mailaddrgrp_map
(
	gid			INT,			--�ʼ���ַ��ID
	pid			INT,			--����ID
	mod			CHAR(20)		--smtpsend, smtprecv, antirelay
);

--���� ����-���ӳ��
create table policy_worm_map
(
	gid			INT,			--���ID
	pid			INT,			--����ID
	mod			CHAR(20)		--worm
);
INSERT INTO policy_worm_map VALUES(1, 1, "worm");
INSERT INTO policy_worm_map VALUES(2, 1, "worm");
INSERT INTO policy_worm_map VALUES(3, 1, "worm");
INSERT INTO policy_worm_map VALUES(4, 1, "worm");
INSERT INTO policy_worm_map VALUES(5, 1, "worm");
INSERT INTO policy_worm_map VALUES(6, 1, "worm");
INSERT INTO policy_worm_map VALUES(7, 1, "worm");
INSERT INTO policy_worm_map VALUES(8, 1, "worm");

--���� URL
create table url
(
	url			VARCHAR(255),		--url
	gid			INT,			--URL��ID
	comment			VARCHAR(255)		--��ע
);
INSERT INTO url VALUES("%2e.asp", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".asp|3a3a|$data", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".bat?&", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/null.htw?CiWebHitsFile", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/CGImail.exe", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/..%c0%af../", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/..%c1%1c../", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/..%c1%9c../", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/iisadmin", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".asp.", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/iisadmin/bdir.htr", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/ServerVariables_Jscript.asp", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/scripts/|20|", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("scripts/root.exe?", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/../../", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/nessus_is_probing_you_", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".html/......", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/~root/", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/cgitest.exe|0d0a|user", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".js%2570", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".j%2573p", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".%256Asp", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/%3f.jsp", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("readme.eml", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/cgi-bin/console.exe", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/bin/ls", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/bin/ps", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES(".htgroup", 1, "���ּ����,�����޸�");
INSERT INTO url VALUES("/cmd.exe?/c", 1, "���ּ����,�����޸�");

--���� URLGRP
create table urlgrp
(
	id			INT PRIMARY KEY,	--URL��ID
	name			CHAR(20),		--URL������
	enable			BOOL DEFAULT 0,		--�Ƿ�����
	comment			VARCHAR(255)		--��ע
);
INSERT INTO urlgrp VALUES(1, "IDS",1, "���ּ����");

--���� �ؼ���
create table keyword
(
	keyword			VARCHAR(255),		--��ҳ�ؼ���
	gid			INT,			--��ҳ�ؼ�����ID
	comment			VARCHAR(255)		--��ע
);

--���� �ؼ�����
create table keywordgrp
(
	id			INT PRIMARY KEY,	--��ҳ�ؼ�����ID
	name			CHAR(20),		--��ҳ�ؼ���������
	enable			BOOL DEFAULT 0,		--�Ƿ�����
	comment			VARCHAR(255)		--��ע
);

--���� �ļ�·��
create table filename
(
	filename		VARCHAR(255),		--�ļ�·��
	gid			INT,			--�ļ�·����ID
	comment			VARCHAR(255)		--��ע
);

--���� �ļ�·����
create table filenamegrp
(
	id			INT PRIMARY KEY,	--�ļ�·����ID
	name			CHAR(20),		--�ļ�·��������
	enable			BOOL DEFAULT 0,		--�Ƿ�����
	comment			VARCHAR(255)		--��ע
);

--���� �ʼ���ַ
create table mailaddr
(
	mailaddr		VARCHAR(255),		--�ʼ���ַ
	gid			INT,			--�ʼ���ַ��ID
	comment			VARCHAR(255)		--��ע
);

--���� �ʼ���ַ��
create table mailaddrgrp
(
	id			INT PRIMARY KEY,	--�ʼ���ַ��ID
	name			CHAR(20),		--�ʼ���ַ������
	enable			BOOL DEFAULT 0,		--�Ƿ�����
	comment			VARCHAR(255)		--��ע
);

--���� �������
create table wormpattern
(
	prot		INT DEFAULT 6,		--Э�飨TCP UDP ...��
	port		INT DEFAULT 80,		--����˿�
	sig		VARCHAR(255),		--��������
	gid		INT,			--���ID
	comment		VARCHAR(255)		--��ע
);
INSERT INTO wormpattern VALUES(6, 80, "\.ida\?", 1, "redcode");
INSERT INTO wormpattern VALUES(6, 8080, "\.ida\?", 1, "redcode");
INSERT INTO wormpattern VALUES(6, 80, "(cmd\.exe)|(root\.exe)", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 8080, "(cmd\.exe)|(root\.exe)", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "\x20\.\x20E\x20M\x20L", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "\x20\.\x20N\x20W\x20S", 2, "nimda");
INSERT INTO wormpattern VALUES(6, 139, "R\x20I\x20C\x20H\x20E\x20D\x202\x200", 2, "nimda");
INSERT INTO wormpattern VALUES(17, 2002, "\x8d\x77\x10\x89\x77\x04\x8d\x4f", 3, "slapper");
INSERT INTO wormpattern VALUES(17, 2002, "\x20\x20\x45\x20\x20\x45\x20\x20\x40\x20", 3, "slapper");
INSERT INTO wormpattern VALUES(17, 1434, "^\x04.*\x90\xeb\x03\x5d\xeb\x05\xe8\xf8.*$", 4, "sqlexp");
INSERT INTO wormpattern VALUES(17, 1434, "^\x04.*\x68\x2E\x64\x6C\x6C\x68\x65\x6C\x33\x32\x68\x6B\x65\x72\x6E.*$", 4, "sqlexp");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\x5c\x20\x5c\x20.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xA0\x01\x20\x20\x20\x20\x20\x20\xC0\x20\x20\x20\x20\x20\x20F.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xB0\x01R\x97\xCAY\xD0\x11\xA8\xD5\x20\xA0\xC9\x0D\x80Q.*$", 5, "blaster");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\x5c\x20\x5c\x20.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xA0\x01\x20\x20\x20\x20\x20\x20\xC0\x20\x20\x20\x20\x20\x20F.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 135, "^\x05.*\xB0\x01R\x97\xCAY\xD0\x11\xA8\xD5\x20\xA0\xC9\x0D\x80Q.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 80, "^GET.*asp\x5c.*\x0d\x0aTranslate\x3A f\x0d\x0a.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 8080, "^GET.*asp\x5c.*\x0d\x0aTranslate\x3A f\x0d\x0a.*$", 6, "nachi");
INSERT INTO wormpattern VALUES(6, 445, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 445, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 139, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 139, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 135, "j\(\x199\x0C\xB1\xD0\x11\x9B\xA8\x20\xC0O\xD9\.\xF5", 7, "sasser");
INSERT INTO wormpattern VALUES(6, 445, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 445, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 139, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(6, 139, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\x75\x2d\x2f\x73\xa2\x2e\x24\x74", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\@N\x9F\x8D\=\xA0\xCE\x11\x8Fi\x08\x20", 8, "zotob");
INSERT INTO wormpattern VALUES(17, 138, "\x5C\x20P\x20I\x20P\x20E\x20\x5C\x20", 8, "zotob");

--���� ���
create table worm
(
	id			INT PRIMARY KEY,	--���ID
	name			CHAR(20),		--�������
	enable			BOOL,			--�Ƿ�����(���Ƿ���Ч)��0Ϊ���ã�1Ϊ����
	comment			VARCHAR(255)		--��ע
);
INSERT INTO worm VALUES(1, "redcode", 1, "��ɫ����");
INSERT INTO worm VALUES(2, "nimda", 1, "Nimda���");
INSERT INTO worm VALUES(3, "slapper", 1, "Slapper���");
INSERT INTO worm VALUES(4, "sqlexp", 1, "�����");
INSERT INTO worm VALUES(5, "blaster", 1, "�����");
INSERT INTO worm VALUES(6, "nachi", 1, "�����ɱ��");
INSERT INTO worm VALUES(7, "sasser", 1, "�𵴲�");
INSERT INTO worm VALUES(8, "zotob", 1, "�ѻ���");

--���� ����˿�
create table service
(
	type			INT,			--1 Ԥ���� 2 �Զ���
	name			CHAR(20),		--��������
	port			INT,			--�˿�ֵ
	comment			VARCHAR(255)		--��ע
);
INSERT INTO service VALUES(2, "http", 80, " ");
INSERT INTO service VALUES(2, "http", 8080, " ");
INSERT INTO service VALUES(2, "ftp", 21, " ");
INSERT INTO service VALUES(2, "smtp", 25, " ");

--���� ����״̬
create table state
(
	id			INT PRIMARY KEY,	--ID
	state			BOOL DEFAULT 0,		--����״̬
	comment			VARCHAR(255)		--��ע
);
INSERT INTO state VALUES(1,0," ");

--���� ϵͳ����
create table constant
(
	dcf_max_service_port		INT DEFAULT 5,		--�������˿���
	dcf_policy_max_num		INT DEFAULT 50,		--��������
	dcf_url_max_grpnum		INT DEFAULT 50,		--���URL����
	dcf_url_group_max_num		INT DEFAULT 50,		--URL������URL��
	dcf_url_max_len			INT DEFAULT 100,	--URL��󳤶�
	dcf_keyword_max_grpnum		INT DEFAULT 50,		--���ؼ�������
	dcf_keyword_group_max_num	INT DEFAULT 50,		--�ؼ���������ؼ��ָ���
	dcf_keyword_max_num		INT DEFAULT 100,	--�ؼ�����󳤶�
	dcf_filename_max_grpnum		INT DEFAULT 50,		--����ļ�·������
	dcf_filename_group_max_num	INT DEFAULT 50,		--�ļ�·��������ؼ��ָ���
	dcf_filename_max_len		INT DEFAULT 100,	--�ļ�·������󳤶�
	dcf_mailaddr_max_grpnum		INT DEFAULT 50,		--����ʼ���ַ����
	dcf_mailaddr_group_max_num	INT DEFAULT 50,		--�ʼ���ַ������ؼ��ָ���
	dcf_mailaddr_max_len		INT DEFAULT 100,	--�ʼ���ַ����󳤶�
	dcf_worm_max_num		INT DEFAULT 50,		--����������
	dcf_worm_pattern_max_num	INT DEFAULT 20,		--���������������
	dcf_worm_max_len		INT DEFAULT 100		--�����������󳤶�
);
INSERT INTO constant VALUES(5, 50, 50, 50, 100, 50, 50, 100, 50, 50, 100, 50, 50, 100, 50, 20, 100);

--���� ͳ����Ϣ
create table statistics
(
	id			INT PRIMARY KEY,		--ID
	total			INT,				--�ܵ�ͳ����Ϣ
	http			INT,				--http����
	ftp			INT,				--ftp����
	smtp			INT,				--smtp����
	worm			INT				--worm����
);
INSERT INTO statistics VALUES(1,0,0,0,0,0);

--���� ϵͳѡ��
create table option
(
	url_case		BOOL DEFAULT 0		--URL��Сд�Ƿ�����
);
INSERT INTO option VALUES(0);

COMMIT;
