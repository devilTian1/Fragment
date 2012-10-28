BEGIN TRANSACTION;

--��Ϣģ��ͻ��������--
create table msg_client_task 
(
	id					INTEGER PRIMARY KEY,		--�����ʶ����Ҫ�����˵�����ű���һ��
	sa					CHAR(15), 							--ԴIP��ַ
	lip					CHAR(15),		  					--����IP��ַ
	lport				CHAR(5),	 							--�����˿ں�
	ssl					CHAR(1),	 							--�Ƿ���ܴ���
	scanvirus		CHAR(1),								--�Ƿ�ɨ�財��
	backup			CHAR(1),	 							--�Ƿ���б��ر���
	time				CHAR(50),								--��Ϣ�����ִ��ʱ�ζ���
	active			CHAR(4),
	comment			VARCHAR(255)						--��ע
);

--��Ϣģ�����˷��ʱ�--
create table msg_server_task 
(
	id				INTEGER PRIMARY KEY,		--�����ʶ
	serip			CHAR(15), 							--���տͻ���IP��ַ
	serport		CHAR(5),  							--���տͻ��˶˿ں�
	ssl				CHAR(1),								--�Ƿ���ܴ���
	backup		CHAR(1),	 							--�Ƿ���б��ر���
	time			CHAR(50),								--��Ϣ�����ִ��ʱ�ζ���
	active			CHAR(4),
	comment		VARCHAR(255)						--��ע
);

--��Ϣģ�����״̬��--
create table msg_ctl_status
(
	service_status				CHAR(1),			--�����Ƿ��� 'Y'|'N'
	blacklist_status			CHAR(1),			--'Y':on     'N':off
	whitelist_status			CHAR(1),			--'Y':on     'N':off
	namefilter_status			CHAR(1),			--'Y':on     'N':off
	bin_file_status				CHAR(1)				--'A':Allow  'F':Forbid
);

insert into msg_ctl_status (service_status, blacklist_status, whitelist_status, namefilter_status, bin_file_status) values ('N','N','N','N','F');

--��Ϣģ���ļ������˱�--
create table msg_filter_filename 
(
	filename				CHAR(128) PRIMARY KEY				--������ļ���
);

--��Ϣģ����������ñ�--
create table msg_filter_blacklist
(
	blacklist 	 		VARCHAR(64) PRIMARY KEY			--����������
);

--��Ϣģ����������ñ�--
create table msg_filter_whitelist
(
	whitelist				VARCHAR(64) PRIMARY KEY			--����������
);

--��Ϣģ���û�Ȩ�����ñ�--
create table msg_user_privilege
(
	username		VARCHAR(16) PRIMARY KEY,		--�û���
	password		CHAR(32),										--�û�����
	send_pri		CHAR(1),										--�Ƿ�ӵ�з���Ȩ�� 'Y'|'N'
	recv_pri		CHAR(1)		 									--�Ƿ�ӵ�н���Ȩ�� 'Y'|'N'
);

--��Ϣģ���û���֤���ñ�--
create table msg_user_auth
(
	username		VARCHAR(16)	PRIMARY KEY,		--�û���
	password		CHAR(32)				--�û�����
);

COMMIT;
