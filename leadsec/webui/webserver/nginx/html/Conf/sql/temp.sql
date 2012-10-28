
-- Use(Create database):
--   #rm temp.db
--   #sqlite temp.db<temp.sql

BEGIN TRANSACTION;

-- 表名: 阻断表
create table block
(
    mode        INT,           --序号
    sip         CHAR(15),      --源IP地址
    mac         CHAR(17),      --源MAC地址
    dip         CHAR(15),      --目的IP地址
    port        INT,           --端口
    protocol    INT,           --协议
    type        INT            --阻断原因
);



COMMIT;


