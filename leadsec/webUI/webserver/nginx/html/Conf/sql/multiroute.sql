-- Use(Create database):
--   #sqlite configs.db<configs.sql

-- History:
-- 1.	2005/08/09	yuzy	������DB


BEGIN TRANSACTION;

-- ����: mrg_node_info ��·�ɸ��ؾ���·����Ϣ
create table mrg_node_info 
( 
	ip	 	CHAR(15),		--����ip��ַ
	ifname 		CHAR(20),		--��·�ɵı��س����豸��
	ifname_ext	CHAR(20),		--�ӿ��ⲿ��
	active		BOOL,			--�Ƿ����ø�·��
	valid	 	BOOL,			--��·���Ƿ����
	devstatus 	BOOL,			--�豸����ͣ״̬
	weight 		INT			--��ǰ·�ɵ�Ȩ��
);



-- ���� ��Ĭ��·�ɸ��ؾ���״̬
create table mrg_state 
(
	active 	BOOL,			--���ؼ�⹦���Ƿ�����
	freq 	INT,			--���Ƶ��
	running	BOOL			--��·�ɸ��ؾ����ػ������Ƿ���������
);

INSERT INTO mrg_state VALUES(1,1,0);

COMMIT;
