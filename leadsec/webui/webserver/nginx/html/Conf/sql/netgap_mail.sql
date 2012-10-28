BEGIN TRANSACTION;

create table mail_system
(
	smtp_status char(1),
	pop3_status char(1)
);
insert into mail_system values("0","0");

--SMTP͸��ģʽ�ͻ��˷��ʱ�--
create table smtp_trans_client_acl 
(
	id			INTEGER PRIMARY KEY,
	sa			CHAR(50),
	da			CHAR(50),		--�ⲿ�ʼ���������ʵ��ַ
	dport		INT,			--�ⲿ�ʼ��������Ķ˿�
	usergrp		CHAR(50),		--��֤�û���
	time		CHAR(50),
	filter	CHAR(12),		--Э����˼�����
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)
);

--insert into smtp_trans_client_acl values(1,"any","any",25,"","","f1","ok","");
--insert into smtp_trans_client_acl values(2,"any","any",25,"","","f2","erro","");

--SMTP��ͨģʽ�ͻ��˷��ʱ�--
create table smtp_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--
	sa			CHAR(50),		--Դ��ַ����
	lip			CHAR(50),		--������ַ
	lport		INT,			--�����˿�
	usergrp		CHAR(50),	--��֤�û���
	time		CHAR(50),		--
	filter	CHAR(12),		--Э����˼�����
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)		--
);

--insert into smtp_comm_client_acl values(1,"any","10.0.0.1",25,"","","f1","ok","");
--insert into smtp_comm_client_acl values(2,"any","10.0.0.1",25,"","","f2","erro","");

--SMTP��ͨģʽ����˷��ʱ�--
create table smtp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--���
	serverip	CHAR(50),				--���������ⲿ���񣩵�ַ����
	sport		INT,					--���������ⲿ���񣩶˿�
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)			--������Ϣ
);
--insert into smtp_comm_server_acl values(1,"10.50.10.10",25,"ok","");
--insert into smtp_comm_server_acl values(2,"10.50.10.10",25,"ok","");

--POP3͸��ģʽ�ͻ��˷��ʱ�--
create table pop3_trans_client_acl 
(
	id			INTEGER PRIMARY KEY,
	sa			CHAR(50),
	da			CHAR(50),		--�ⲿ�ʼ���������ʵ��ַ
	dport		INT,			--�ⲿ�ʼ��������Ķ˿�
	usergrp		CHAR(50),	--��֤�û���
	time		CHAR(50),
	filter	CHAR(12),		--Э����˼�����
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)
);

--POP3��ͨģʽ�ͻ��˷��ʱ�--
create table pop3_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--�����
	sa			CHAR(50),				--Դ��ַ����
	lip			CHAR(50),				--������ַ
	lport		INT,					--�����˿�
	usergrp		CHAR(50),	--��֤�û���
	time		CHAR(50),				--
	filter	CHAR(12),		--Э����˼�����
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)			--
);

--POP3��ͨģʽ����˷��ʱ�--
create table pop3_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--�����
	serverip	CHAR(50),				--���������ⲿ���񣩵�ַ����
	sport		INT,					--���������ⲿ���񣩶˿�
	active CHAR(4),			--��ǰ������ͣ���أ�'1'-ON, '0'-OFF
	comment		VARCHAR(255)			--������Ϣ
);

create table filter
(
        id                      INTEGER PRIMARY KEY,
        name                    char(20),
        protocol                char(4),
        attachmaxsize              char(20),
		allowext                char(20),
        --alert                   char(1),
        --append                  char(1),
        --fetch                   char(1),
       	allowsender             char(20),
		sflag					char(5),
        allowrecv               char(20),
		rflag					char(5),
        --whitesender           char(20),
        --whiterecv             char(20),
        skeyword              	char(20),
        ckeyword              	char(20),
	fileav			char(3),
	bufav			char(3),
        comment                 varchar(255)
);
--insert into filter values(1,"f1","smtp","100","e1","m1","m2","k1","k2","on","off","");
--insert into filter values(2,"f2","pop3","100","e1","m1","m2","k1","k2","off","on","");

create table mailaddr
(
        id                      INTEGER PRIMARY KEY,
        name                    char(20),
        value                   text,
		type			char(10),
		--ftype			char(5),
        comment                 varchar(255)
);
--insert into mailaddr values(1,"m1","test@sina.com.cn,test@163.com","������","ע��");
--insert into mailaddr values(2,"m2","test@sina.com.cn,test@163.com","�ռ���","ע��");

create table keyword
(
        id                      INTEGER PRIMARY KEY,
        name                    char(20),
        value                   text,
		type			char(10),
        comment                 varchar(255)
);
--insert into keyword values(1,"k1","test1,�ܺú�ǿ��","����","ע��");
--insert into keyword values(2,"k2","test1,�ܺú�ǿ��","����","ע��");

create table attach_ext
(
        id                      INTEGER PRIMARY KEY,
        name                    char(20),
        value                   text,
        comment                 varchar(255)
);
--insert into attach_ext values(1,"e1",".doc,.ceb,.jpg","ע��");

COMMIT;
