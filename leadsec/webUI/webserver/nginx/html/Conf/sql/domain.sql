--2004/12/24	zhuxp	����
--������ַ���ƺ�IP��ַ�Ķ�Ӧ��
BEGIN TRANSACTION; 
create table domain_ip
(
	name	CHAR(20),		--��Դ����
	dynamic	INT,			--�ֶ���д���Զ�����
	ip		CHAR(16),		--IP��ַ
	time	INT,			--���һ�θ���ʱ��
	expire	INT				--����ʧЧʱ�䣬��λ���룬0Ϊ��ʧЧ
);

COMMIT;
