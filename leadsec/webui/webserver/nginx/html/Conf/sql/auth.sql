BEGIN TRANSACTION;

--�û���
create table user
(
		user_name	CHAR(20) PRIMARY KEY,								--�û���
		passwd		CHAR(32),								--����
		permit		BOOL,										--�Ƿ������¼
		time			UNSIGNED INT,						--����ʱ��
		flux			UNSIGNED INT,						--��������
		createdate			CHAR(32),					--��ʼʱ�䣬��ʽΪ2003/07/08/17
		screatedate			UNSIGNED INT,			--��ʼʱ�䣬��1900��epoch��ʼ������
		
		validday	UNSIGNED INT,						--����Ч���������Ϊ3650��
    is_bind_ip BOOL,									--�Ƿ��IP 
    bind_ip   CHAR(16),               --�󶨵�IP��ַ
    netmask   CHAR(16),               --��������
    is_check_version  BOOL,					  --�Ƿ���汾
    nversion  CHAR(6),                 --�汾��
   	--add by tonglr 20080222
		spassdate			UNSIGNED LONG,			--���봴��ʱ�䣬��1900��epoch��ʼ������
		passvaliddate			UNSIGNED LONG,			--������Ч���������Ϊ3650��
		--end by tonglr 20080222
		passwdm		CHAR(32)
);

--�û����
create table groups
(
		group_name	CHAR(20) PRIMARY KEY,							--����
		group_id	UNSIGNED SMALLINT,			--��id���ں��ã�
		time		UNSIGNED INT,							--���ʱ��
		flux		UNSIGNED INT,							--�������
		user_num	UNSIGNED SMALLINT,			--�����û���
		is_proc_check		BOOL,							--�ͻ����Ƿ������
		proc_rule				BOOL,							--�ͻ��˽��̼�����
		proc_list				TEXT,							--�ͻ��˽�����ʾ��Ϣ
		users		TEXT											--�����û������ϣ��м���;����
);

--��բ��
create table wangzha
(
		workmode	UNSIGNED INT
);

insert into wangzha values(0);

--��־��¼��
create table log
(
		log	UNSIGNED INT
);

insert into log values(0);

--��׼����ʱ������
create table other
(
		alivetime	UNSIGNED INT
);

insert into other values(120); -- 2���ӣ��ͻ��˳�ʱʱ��

--������server
create table server
(
	localport		UNSIGNED SMALLINT,		--�����˿�
	workmode		UNSIGNED SMALLINT,		--����ģʽ1Ϊlocal��2Ϊradius
	ip					CHAR(20),							--IP��ַ
	timeout			UNSIGNED SMALLINT,		--����ʱ��
	authport		UNSIGNED SMALLINT,		--��֤�˿�
	auditport		UNSIGNED SMALLINT,		--�ƷѶ˿�
	secret			CHAR(21)							--������Կ
);
insert into server values(9998,1,"10.50.10.18",3,1812,1813,"leadsec");

COMMIT;

