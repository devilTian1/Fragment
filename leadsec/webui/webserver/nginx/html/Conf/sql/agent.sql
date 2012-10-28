-- History:
-- 	baiyu 2005/01/17 ���Դ���Agent���ݿ����SQL���

-- Use(Create database):
--   #rm agent.db
--   #sqlite agent.db < agent.sql

BEGIN TRANSACTION;

-- ���Դ����
create table policy
(
	id		INTEGER PRIMARY KEY,    	--���
	hostname 	CHAR(64),			--���Է�������ַ
	port		INT,				--���Է������˿ں�
	dev_name	CHAR(100),			--�豸����
	dev_type	CHAR(10),			--�豸���� gateway | client
	dev_ip		CHAR(20),			--�豸IP��ַ
	retry_time	INT,				--�������Դ���
	time_span	INT,				--����ʱ��(����)
	time_out	INT,				--UDP��ʱʱ��(��)
	last_time	INT,				--���һ�λ�ò��Ե�ʱ�� 0-û�л�ȡ������ | >0��ȷ��ȡ���� | <0û����ȷ��ȡ����
	active_flag	INT,				--����/ֹͣ�豸�����־ 0-ֹͣ | 1-����
	getnow_flag	INT,				--���̻�ȡ���Ա�־ 0-�����̻�ȡ | 1-���̻�ȡ
	local_flag	INT,				--�ӱ��ػ�ȡ���Ա�־ 0-ͨ�������ȡ | 1-ͨ�����ػ�ȡ
	des_key		CHAR(20)			--DES����Key
);

INSERT INTO policy VALUES(1, '192.168.1.1', 8585, 'fw', 'gateway', '192.168.1.254', 3, 20, 3, 0, 0, 0, 0, 'admin123');

COMMIT;


