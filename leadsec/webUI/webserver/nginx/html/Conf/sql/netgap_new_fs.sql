BEGIN TRANSACTION;


--�ļ������ͻ������ñ�--
create table sync_file_client
(	
	id						INTEGER PRIMARY KEY,		--���
	sa						CHAR(50),								--Դ��ַ����
	lip						CHAR(50),								--������ַ
	lport					INT,										--�����˿�       
	mode					CHAR(1),								--����ģʽ��Q:����ת����B:���ر���
	ssl						CHAR(1),								--�Ƿ����SSL����: 'Y'/'N' 
	commname		VARCHAR(255),			--�Զ�֤�鹲����
	killvirus			CHAR(1),								--�Ƿ��ɨ�財��: 'Y'/'N'
	time					CHAR(50),								--ʱ�����
        ip_ver                      CHAR(10),
	seclevel			INT,
	comment				VARCHAR(255)
);

--�ļ�����ͬ����������ñ�--
create table sync_file_server
(	
	id						INTEGER PRIMARY KEY,		--���
	serverip			CHAR(50),								--���������ⲿ���񣩵�ַ����
	sport					INT,										--���������ⲿ���񣩶˿�	     
	mode					CHAR(1),								--����ģʽ��Q:����ת����B:���ر���
	ssl						CHAR(1),								--�Ƿ����SSL����: 'Y'/'N'   
	commname		VARCHAR(255),			--�Զ�֤�鹲����
        ip_ver                      CHAR(10),
	comment				VARCHAR(255)						--������Ϣ
);

create table basic_configure
(
	bin_file		CHAR(1),	--'A':Allow  'F':Forbid
	blacklist		CHAR(1),	--'Y':on     'N':off
	whitelist		CHAR(1),	--'Y':on     'N':off
	namefilter	CHAR(1),	--'Y':on     'N':off
	syncmode		CHAR(1)		--'B':Both 'R':Recv 'S':Send   
);                                                            

insert into basic_configure (bin_file, blacklist, whitelist, namefilter, syncmode) values ('A','N','N','N','B');

create table allowedfile
(
	id				INT,
	filename	CHAR(64),
	comment		CHAR(255)
);

create table context
(
	id							INT,
	context					CHAR(15),
	allow						BOOL,
	comment         CHAR(255)
);




COMMIT;
