-- Use(Create database):
-- #rm acsc.db
-- #sqlite acsc.db < acsc.sql
-- �����2004/09/20 ���� ���ڽ��в����������Ĺ���
BEGIN TRANSACTION; 

--���� ���ӹ���ϵͳ������
create table acsc_option
(
	active 				BOOL,		--ģ�鿪��
	rule_option			BOOL,		--����ѡ����Ч
	session_option		BOOL,		--�Ựͳ�Ʒ�ʽ
	learn				BOOL,		--��̬����ѧϰ����
	maxip				INT,		--֧��ͳ��IP�������Ŀ���û����ɼ�
	def_src_type		INT,		--Ĭ��Դ���Ӽ������
	def_src_threhold	INT,		--Ĭ��Դ������ֵ
	def_dest_type		INT,		--Ĭ��Ŀ�����Ӽ������
	def_dest_threhold	INT,		--Ĭ��Ŀ��������ֵ
	daemon				BOOL,		--�Ƿ��ṩ��������
	daemon_PORT			INT,		--����ǽ����˿�
	admin				CHAR[15],	--��������
	audit				CHAR[15]	--�������
);
insert into acsc_option values(0,0,1,1,10000,1,5000,1,10000,0,2008,'','');

--���� ���ӹ�����������̬���ͱ�
create table acsc_rule
(
	ip					CHAR[15] PRIMARY KEY,	--��ַ
	src_type			INT,		--Դ���Ӽ������
	src_threhold		INT,		--Դ������ֵ
	dest_type			INT,		--Ŀ�����Ӽ������
	dest_threhold		INT,		--Ŀ��������ֵ
	comment				CHAR[20]	--ע��
);
-- insert into acsc_rule values('80.1.1.2',1,100,1,100,'');
COMMIT;