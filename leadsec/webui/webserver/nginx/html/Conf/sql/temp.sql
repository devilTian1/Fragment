
-- Use(Create database):
--   #rm temp.db
--   #sqlite temp.db<temp.sql

BEGIN TRANSACTION;

-- ����: ��ϱ�
create table block
(
    mode        INT,           --���
    sip         CHAR(15),      --ԴIP��ַ
    mac         CHAR(17),      --ԴMAC��ַ
    dip         CHAR(15),      --Ŀ��IP��ַ
    port        INT,           --�˿�
    protocol    INT,           --Э��
    type        INT            --���ԭ��
);



COMMIT;


