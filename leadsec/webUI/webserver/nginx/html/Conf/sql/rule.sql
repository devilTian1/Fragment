
-- Use(Create database):
--   #rm rule.db
--   #sqlite rule.db<rule.sql

-- History:
-- 1. xiaowj 2003/08/15 ����һ����ͼaddrname

BEGIN TRANSACTION;

--����: MAC��ַ��
create table addrbind
(
    id          INTEGER PRIMARY KEY,    --�󶨵�ַ���
    ip          CHAR(15),               --IP��ַ
    mac         CHAR(17),               --Mac��ַ
    eth         CHAR(20),               --����ӿ��ⲿ����
    doubledir   BOOL                    --�Ƿ�˫����,0Ϊ���ã�1Ϊ����
);

--����: ��ַ
create table address
(
    id          INTEGER PRIMARY KEY,    --��ַID  sequence
    name        CHAR(20),               --��ַ��    
    type        INT,                    --��ַ����,1Ϊ����/������ʽ��2Ϊ��ַ����ʽ��3Ϊ����ַ
    ip          CHAR(15),               --��ַ ����͵�ַ�� 
    mask        CHAR(15),               --���� ����ߵ�ַ)
    comment     VARCHAR(255)           --��ע
);

insert into  address values(1,'any',1,'0.0.0.0','0.0.0.0','ȫ����ַ');


--����: ��ַ��
create table addrgrp
(
    id          INTEGER PRIMARY KEY,    --��ַ��ID sequence
    name        CHAR(20),               --��ַ����  
    comment     VARCHAR(255)            --��ַ��˵��    
);

--2005/1/13	zhuxp	���ӵ�ַ����
--����: ��ַ(��ַ��ַ��)��Ӧ��
create table addrmap
(
    addrgrpid   INT,                    --��ַ��ID  
    addrid      INT,                    --��ַID
	type		INT						--��ַ���ͣ�1Ϊ����/������ʽ��2Ϊ��ַ����ʽ��3Ϊ����ַ��8Ϊ������ַ
);

----����: ��������ַ
create table serveraddr
(
    id          INTEGER PRIMARY KEY,    --��������ַID
    name        CHAR(20),               --��������ַ��
    ip1         CHAR(15),               --������1��IP��ַ
    weight1     INT,                    --������1��Ȩ��
    ip2         CHAR(15),               --������2��IP��ַ
    weight2     INT,                    --������2��Ȩ��
    ip3         CHAR(15),               --������3��IP��ַ
    weight3     INT,                    --������3��Ȩ��
    ip4         CHAR(15),               --������4��IP��ַ
    weight4     INT,                    --������4��Ȩ��
    ip5         CHAR(15),               --������5��IP��ַ
    weight5     INT,                    --������5��Ȩ��
    ip6         CHAR(15),               --������6��IP��ַ
    weight6     INT,                    --������6��Ȩ��
    ip7         CHAR(15),               --������7��IP��ַ
    weight7     INT,                    --������7��Ȩ��
    ip8         CHAR(15),               --������8��IP��ַ
    weight8     INT,                    --������8��Ȩ��
    comment     VARCHAR(255)            --ע��
);

--������������ַ
create table domain_property
(
	id			INTEGER PRIMARY KEY,	--������ַID
	name		CHAR(20),				--������ַ����
	type		INT,					--������ַ����8
	domain		CHAR(128),				--����
	auto_resolve	BOOL DEFAULT 0,		--�Ƿ��Զ�����
	primary_dns	CHAR(16),				--��DNS������
	slave_dns	CHAR(16),				--��DNS������
	record_type	INT DEFAULT 1,			--�Զ���������
	max_record	INT DEFAULT 64,			--�Զ�����������¼��
	interval	INT DEFAULT 30,			--�Զ��������,��λ������
	expire		INT DEFAULT 2,			--��ʱʱ��
	comment		VARCHAR(255)			--��ע	
);

--2005/1/13	zhuxp	����
--��ͼ����ַ��������ַ������
CREATE VIEW address_domain AS
SELECT id,name,type FROM address
UNION
SELECT id,name,type FROM domain_property;

--��ͼ: ��ַ�͵�ַ�������
CREATE VIEW addrname AS
SELECT name FROM address
UNION
SELECT name FROM addrgrp
UNION
SELECT name FROM domain_property;

--��ͼ: ��ַ�͵�ַ�������
CREATE VIEW pfaddrname AS
SELECT name FROM address_domain
UNION
SELECT name FROM addrgrp
UNION
SELECT name FROM serveraddr WHERE name NOT LIKE "fp_%s%"
UNION
SELECT name FROM domain_property;

--����: ��ַ��
create table addrpool
(
    id          INTEGER PRIMARY KEY,    --��ַ��ID  sequence
    name        CHAR(20),               --��ַ����
    ip_from     CHAR(15),               --��ʼ��ַ 
    ip_to       CHAR(15),               --��ֹ��ַ  
    comment     VARCHAR(255)            --��ע
);

--����: ���� ����20050503 yangcy
--create table bandwidth
--(
--    id          INTEGER PRIMARY KEY,    --ID��
--    name        Char(20),               --������    
--    priority    INT,                    --���ȼ�    
--    maxbw       INT,                    --������  
--    minbw       INT,                    --��С����
--    comment     VARCHAR(255)            --ע��  
--);

--������������� yangcy 20050503
create table bandwidth_parentclass
(
	id			INT,    				--ID��
	name		Char(20),               --������ 
	minbw		INT,                    --��С��������֤����
	maxbw		INT,                    --������  
	ethout		CHAR(20),               --��������    
	comment		VARCHAR(255)			--ע��  
);

--�������������� yangcy 20050503
create table bandwidth_childclass
(
	id			INT,    				--ID��
	name		Char(20),               --������ 
	minbw		INT,                    --��С��������֤����
	maxbw		INT,                    --������  
	priority	INT,                    --���ȼ�    
	parentid	INT,					--������ID
	ethout		CHAR(20),               --��������    
	comment		VARCHAR(255)			--ע��  
);

--������������Դ�� yangcy 20050503
create table bandwidth_classgrp
(
	id			INT,    				--ID��
	name		Char(20),               --��������     
	comment		VARCHAR(255)			--ע��  
);

--������������Դ����Դ��ӳ��� yangcy 20050503
create table bandwidth_classgrpmap
(
	classgrpid	INT,					--��ַ��ID  
	childclassid	INT,					--����ID
	parentclassid	INT,    				--����ID
	ethout		CHAR(20)				--��������
);

----����: Ԥ�������
create table streamservice
(
    id          INTEGER PRIMARY KEY,    --ID��
    name        CHAR(20),               --Ԥ�����������
    protocol    INT,                    --Э��
    port        INT,                    --�˿ں�
    comment     VARCHAR(255)            --ע��
);
INSERT INTO streamservice VALUES(1,'any',0,-1,'�������');
INSERT INTO streamservice VALUES(4,'http',6,80,"www service");
INSERT INTO streamservice VALUES(5,'tcp_any',6,-1,"tcp service");
INSERT INTO streamservice VALUES(6,'udp_any',17,-1,"udp service");


----����: Ԥ�������
create table defaultservice
(
    id          INTEGER PRIMARY KEY,    --ID��
    name        CHAR(20),               --Ԥ�����������
    protocol    INT,                    --Э��
    port        INT,                    --�˿ں�
    comment     VARCHAR(255)            --ע��
);
INSERT INTO defaultservice VALUES(1,'any',0,-1,'�������');
INSERT INTO defaultservice VALUES(4,'http',6,80,"www service");
INSERT INTO defaultservice VALUES(5,'tcp_any',6,-1,"tcp service");
INSERT INTO defaultservice VALUES(6,'udp_any',17,-1,"udp service");
--INSERT INTO defaultservice VALUES(7,'icmp_any',1,-1,"icmp service");
INSERT INTO defaultservice VALUES(8,'telnet',6,23,"telnet service");
INSERT INTO defaultservice VALUES(9,'smtp',6,25,"smtp service");
INSERT INTO defaultservice VALUES(10,'pop3',6,110,"pop3 service");
INSERT INTO defaultservice VALUES(11,'snmp',17,161,"snmp service");
INSERT INTO defaultservice VALUES(12,'dns',17,53,"dns service");
INSERT INTO defaultservice VALUES(13,'https',6,443,"https service");
INSERT INTO defaultservice VALUES(14,'oicq',17,8000,"oicq service");

--INSERT INTO defaultservice VALUES(15,'IGMP',2,-1,"IGMP");
--INSERT INTO defaultservice VALUES(16,'OSPF',89,-1,"OSPF");
--INSERT INTO defaultservice VALUES(17,'IGRP',88,-1,"IGRP");
--INSERT INTO defaultservice VALUES(18,'GRE',47,-1,"GRE");

INSERT INTO defaultservice VALUES(19,'Syslog',17,514,"Syslog");
INSERT INTO defaultservice VALUES(20,'RemoteDesk',6,3389,"΢��Զ������");



----����: �Զ������(��ͨ)
create table service
(
    id          INTEGER PRIMARY KEY,    --����ID  sequence
    name        CHAR(20),               --������
    slport1     INT,                    --Դ�Ͷ˿�1
    shport1     INT,                    --Դ�߶˿�1
    dlport1     INT,                    --Ŀ��Ͷ˿�1
    dhport1     INT,                    --Ŀ��߶˿�1
    protocol1   INT,                    --Э��1, Э�������
    slport2     INT,                    --Դ�Ͷ˿�2
    shport2     INT,                    --Դ�߶˿�2
    dlport2     INT,                    --Ŀ��Ͷ˿�2
    dhport2     INT,                    --Ŀ��߶˿�2
    protocol2   INT,                    --Э��2
    slport3     INT,                    --Դ�Ͷ˿�3
    shport3     INT,                    --Դ�߶˿�3
    dlport3     INT,                    --Ŀ��Ͷ˿�3
    dhport3     INT,                    --Ŀ��߶˿�3
    protocol3   INT,                    --Э��3
    slport4     INT,                    --Դ�Ͷ˿�4
    shport4     INT,                    --Դ�߶˿�4
    dlport4     INT,                    --Ŀ��Ͷ˿�4
    dhport4     INT,                    --Ŀ��߶˿�4
    protocol4   INT,                    --Э��4
    slport5     INT,                    --Դ�Ͷ˿�5
    shport5     INT,                    --Դ�߶˿�5
    dlport5     INT,                    --Ŀ��Ͷ˿�5
    dhport5     INT,                    --Ŀ��߶˿�5
    protocol5   INT,                    --Э��5
    slport6     INT,                    --Դ�Ͷ˿�6
    shport6     INT,                    --Դ�߶˿�6
    dlport6     INT,                    --Ŀ��Ͷ˿�6
    dhport6     INT,                    --Ŀ��߶˿�6
    protocol6   INT,                    --Э��6
    slport7     INT,                    --Դ�Ͷ˿�7
    shport7     INT,                    --Դ�߶˿�7
    dlport7     INT,                    --Ŀ��Ͷ˿�7
    dhport7     INT,                    --Ŀ��߶˿�7
    protocol7   INT,                    --Э��7
    slport8     INT,                    --Դ�Ͷ˿�8
    shport8     INT,                    --Դ�߶˿�8
    dlport8     INT,                    --Ŀ��Ͷ˿�8
    dhport8     INT,                    --Ŀ��߶˿�8
    protocol8   INT,                    --Э��8
    comment     VARCHAR(255)            --��ע
);

INSERT INTO service VALUES(1,"netbios",0,65535,137,139,6,0,65535,137,139,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"NetBIOS");
INSERT INTO service VALUES(2,"lotusnotes",0,65535,1352,1352,6,0,65535,1352,1352,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Lotus Notes");
INSERT INTO service VALUES(3,"radius",0,65535,1812,1813,6,0,65535,1812,1813,17,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,0,65535,0,65535,256,"Radius");


----����: �Զ������(��̬)
create table dynamic_service
(
    id                INTEGER PRIMARY KEY,    --ID��
    name              CHAR(20),               --��̬Э������
    protocol          INT,                    --����Э��, 1Ϊftp��2Ϊh.323��3Ϊtns,ע�⣺���ﲻ����getprotobynumber()������
    port              VARCHAR(255),           --��̬Э��˿�
    ftp_get           BOOL,                   --ftp��get����, 0Ϊ��ֹ,1Ϊ����
    ftp_put           BOOL,                   --ftp��put����, 0Ϊ��ֹ,1Ϊ����
    ftp_multi_thread  BOOL,                   --ftp�Ķ��߳�, 0Ϊ��ֹ,1Ϊ����
    comment           VARCHAR(255)            --��ע
);

INSERT INTO dynamic_service VALUES(1,'ftp',1,21,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(2,'h323',2,1720,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(3,'tns',3,1521,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(4,'rtsp',5,554,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(5,'tftp',6,69,0,0,0,"default service");
INSERT INTO dynamic_service VALUES(6,'irc',7,6667,0,0,0,"default service");

----����: �Զ������(��̬)
create table dynamic_stream_service
(
    id                INTEGER PRIMARY KEY,    --ID��
    name              CHAR(20),               --��̬Э������
    protocol          INT,                    --����Э��, 1Ϊftp��2Ϊh.323��3Ϊtns,ע�⣺���ﲻ����getprotobynumber()������
    port              VARCHAR(255),           --��̬Э��˿�
    ftp_get           BOOL,                   --ftp��get����, 0Ϊ��ֹ,1Ϊ����
    ftp_put           BOOL,                   --ftp��put����, 0Ϊ��ֹ,1Ϊ����
    ftp_multi_thread  BOOL,                   --ftp�Ķ��߳�, 0Ϊ��ֹ,1Ϊ����
    comment           VARCHAR(255)            --��ע
);

INSERT INTO dynamic_stream_service VALUES(1,'h323',2,1720,0,0,0,"default service");
INSERT INTO dynamic_stream_service VALUES(2,'rtsp',5,554,0,0,0,"default service");

----����: �Զ������(ICMP)
create table icmp_service
(
    id              INTEGER PRIMARY KEY,    -- ID��
    name            CHAR(20),               -- ICMP��̬Э������
    type            INT,                    -- -1��ʾ����type
    code            INT,                    -- -1��ʾ����code
    comment         VARCHAR(255)            -- ��ע
);



----����: ������
create table servicegrp
(
    id              INTEGER PRIMARY KEY,    --������ID sequence
    name            CHAR(20),               --��������  
    comment         VARCHAR(255)            --������˵��
);


----����: �����Ӧ��
create table servicemap
(
    servicegrpid     INT,                   --������ID
    servicetype      INT,                   --��������
                                              --1ΪԤ�������
                                              --2Ϊ�Զ�����񣨶�̬Э�飩
                                              --3Ϊ�Զ������ICMPЭ�飩
                                              --4Ϊ�Զ��������ͨ�Զ������
                                              --(5Ϊ������, �����ﲻ�����)
    serviceid        INT                    --��ַID
);

--��ͼ: ���з���ķ�����
CREATE VIEW servicename AS
SELECT name  FROM   defaultservice
UNION
SELECT name  FROM   service              
UNION
SELECT name  FROM   dynamic_service                
UNION
SELECT name  FROM   icmp_service
UNION
SELECT name  FROM   servicegrp;

--��ͼ: ���з���ķ�����
CREATE VIEW portservicename AS
SELECT name  FROM   defaultservice
UNION
SELECT name  FROM   service              
UNION
SELECT name  FROM   dynamic_service                
UNION
SELECT name  FROM   icmp_service;


--��ͼ: TCP+UDP�ķ�����,���ڶ˿�ӳ�����
CREATE VIEW tudfservice AS
SELECT name, id  FROM   defaultservice where (protocol = 6 or protocol = 17 );

CREATE VIEW tuservice AS
SELECT name, id  FROM   service  where (protocol1 = 6 or protocol1 = 17) and (protocol2 = 6 or protocol2 = 17 or protocol2 = 256) and (protocol3 = 6 or protocol3 = 17 or protocol3 = 256)and (protocol4 = 6 or protocol4 = 17 or protocol4 = 256)and (protocol5 = 6 or protocol5 = 17 or protocol5 = 256)and (protocol6 = 6 or protocol6 = 17 or protocol6 = 256)and (protocol7 = 6 or protocol7 = 17 or protocol7 = 256)and (protocol8 = 6 or protocol8 = 17 or protocol8 = 256);

CREATE VIEW tudyservice AS
SELECT name, id  FROM   dynamic_service;

CREATE VIEW tuservicegrp1 AS
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudfservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 1 and (servicemap.serviceid in (select id from tudfservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudyservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 2 and (servicemap.serviceid in (select id from tudyservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tuservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 4 and (servicemap.serviceid in (select id from tuservice));

CREATE VIEW tuservicegrp2 AS
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudfservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 1 and (servicemap.serviceid not in (select id from tudfservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tudyservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 2 and (servicemap.serviceid not in (select id from tudyservice))
UNION
SELECT DISTINCT(servicegrp.name) AS name FROM servicegrp, servicemap, tuservice where  servicemap.servicegrpid = servicegrp.id and servicemap.servicetype = 4 and (servicemap.serviceid not in (select id from tuservice));


CREATE VIEW tuservicegrp AS
SELECT DISTINCT(name) AS name FROM tuservicegrp1 where  name not in (select name from tuservicegrp2);



CREATE VIEW pnatservicename AS
SELECT name  FROM   tudfservice
UNION
SELECT name  FROM   tuservice              
UNION
SELECT name  FROM   tudyservice                
UNION
SELECT name  FROM   tuservicegrp;




--��ͼ: TCP+UDP�����˿ڵķ�����,���ڴ������
CREATE VIEW proxydfservice AS
SELECT name, id  FROM   defaultservice where ((protocol = 6 or protocol = 17 ) and port != -1) or (protocol != 6 and protocol != 17 and protocol != 0);

CREATE VIEW proxyservice AS
SELECT name, id  FROM   service  where ((protocol1 = 6 or protocol1 = 17) and (dlport1=dhport1)) 
                                   and (protocol2 = 256)
                                   and (protocol3 = 256)
                                   and (protocol4 = 256)
                                   and (protocol5 = 256)
                                   and (protocol6 = 256)
                                   and (protocol7 = 256)
                                   and (protocol8 = 256);

CREATE VIEW proxydyservice AS
SELECT name, id  FROM   dynamic_service where protocol = 1 and port != '' and port != '-1';

CREATE VIEW proxyservicename AS
SELECT name  FROM   proxydfservice
UNION
SELECT name  FROM   proxyservice
UNION
SELECT name  FROM   icmp_service
UNION
SELECT name  FROM   proxydyservice;                

--2005/1/13	zhuxp	����������ַ
----����: ��ȫ����
create table policyinfo
(
    id              INT,                    --��ţ�������ţ���ʾ˳��Ψһ�����Զ��������ɳ����������
    name            CHAR(20),               --������ 
    type            INT,                    --���ͣ�1Ϊpermit��2Ϊdeny��3Ϊproxy��4Ϊnat��5Ϊportmap��6Ϊipmap, 7Ϊauth, 8Ϊmasquerade,9Ϊvpn,10 nataccept,11 portaccept 12 ipaccept
    saddrtype       INT,                    --Դ��ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    saddrid         INT,                    --Դ��ַID
    saddrip         CHAR(15),               --Դ��ַIP
    saddrmask       CHAR(15),               --Դ��ַMASK
    sattype         INT,                    --Դ��ַת������, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�) 5Ϊ��ַ�أ�6Ϊ����ǽ��ַ�� 11/12Ϊ��բ���뿨IP(127.1.0.1/127.1.0.2)(zhouxj-2007-12-03)
    satid           INT,                    --Դ��ַת��ID
    satip           CHAR(15),               --Դ��ַת��IP  //���sattype=6�������Žӿ��ⲿ����
    satmask         CHAR(17),               --Դ��ַת��MASK
    sport           CHAR(128),              --Դ�˿�
    smac            CHAR(17),               --ԴMAC
    satport         CHAR(128),              --Դ�˿�ת��
    daddrtype       INT,                    --Ŀ�ĵ�ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    daddrid         INT,                    --Ŀ�ĵ�ַID
    daddrip         CHAR(15),               --Ŀ�ĵ�ַIP
    daddrmask       CHAR(17),               --Ŀ�ĵ�ַMASK
    pubtype         INT,                    --������ַ����     2Ϊ��ַ����,6Ϊ����ǽ��ַ��21/22/23Ϊ��բ���뿨IP��127.1.0.1/127.1.0.2,127.1.0.0/24��(zhouxj 2007-12-03)
    pubid           CHAR(15),               --������ַID       (��Ӧinterface����ⲿ��ַ)
    innertype       INT,                    --�ڲ���������ַ����, (1ΪIP��ַ/����,�����ﲻ����), (2Ϊ��ַ����, ������)��(3Ϊ��ַ�鶨��, ������)��4��������ַ
    innerid         INT,                    --�ڲ���������ַID
    innerip         CHAR(15),               --�ڲ���ַIP(���ڲ��ã���ֹ�Ժ�Ҫ���ϸ����,ֻ֧��һ���ڲ�������)
    ethin           CHAR(20),                --��������, "any"��ʾ��������ӿ�
    ethout          CHAR(20),                --��������, "any"��ʾ��������ӿ�
    servicetype     INT,                    --��������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������, --6Ϊany
    serviceid       INT,                    --����ID
    pubservicetype  INT,                    --�����������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������
    pubserviceid    INT,                    --�������ID
    innerservicetype    INT,                --�ڲ���������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������
    innerserviceid  INT,                    --�ڲ�����ID
    proxytype       INT,                    --��������, 1Ϊ�̶�����2Ϊ�Զ������
    proxyid         INT,                    --����ID��1Ϊhttp��2Ϊftp,3Ϊtelnet,4Ϊsmtp,5Ϊpop3,6Ϊsocks,7Ϊdns,8Ϊicmp,9Ϊmsn
    timetype        INT,                    --ʱ������, 1Ϊʱ�䶨�壬2Ϊʱ����(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
    timeid          INT,                    --ʱ��ID��(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
    timename        CHAR(20),               --ʱ��������ƣ����ڵĳ���������������ϵ��
--    urlid           INT,                    --URL����ID, 0��ʾ�ޣ�1��ʾ����URL���
    longcon         INT,                   --�Ƿ�֧�ֳ����ӣ�0Ϊ���ã�>0Ϊ����, ��λΪ��
    log             BOOL,                   --�Ƿ��¼������־��0Ϊ���ã�1Ϊ����
--    logurl          BOOL,                   --�Ƿ��¼URL��־��0Ϊ���ã�1Ϊ����
    synflood        INT,                   --�Ƿ�SYN Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    udpflood        INT,                   --�Ƿ�UDP Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    icmpflood       INT,                   --�Ƿ�ICMP Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    pod             BOOL,                   --�Ƿ�Ping of Death������0Ϊ���ã�1Ϊ����
    active          BOOL,                    --�Ƿ�����(���Ƿ���Ч)��0Ϊ���ã�1Ϊ����
--    keycheck        BOOL,                    --�Ƿ�������ҳ�ؼ��ּ�飬0��ʾ�ޣ�1Ϊ����   
    hideinner		BOOL, 					--�Ƿ������ڲ���ַ��˿ڣ����ڶ˿�ӳ���ipӳ��
--    logkey			BOOL					--�Ƿ��¼�ؼ��ּ����־
-- added by hanhz, 2005/06/27, begin
    dcf           INT DEFAULT 0,                      --��ȹ��˲��ԣ�0Ϊ����
    bt							BOOL,											--�Ƿ�����bt��0Ϊ���ã�1Ϊ����
    edk							BOOL,											--�Ƿ�����edk��0Ϊ���ã�1Ϊ����
    btlog							BOOL,									--�Ƿ��¼bt,edk��־
-- added by hanhz, 2005/06/27, end

-- Added by zhouxj, 2008/04/11, for user auth at Kernel.
	username	CHAR(20),				--�û�����
	usergpid	INT,					--�û���id
-- End

    dport	INT,     --for netgap
    toport	INT,     --for netgap
    proto	INT,     --for netgap
	proto_type INT,
	saname VARCHAR(30), --for netgap
	daname VARCHAR(30), --for netgap
    comment	VARCHAR(255),					--ע��

	POLICY_W            INT,                        -- 1 in filter          
	PROXY_INPUT_W       INT,                        -- 2 in filter  
	AUTH_SERVER_W       INT,                        -- 3 in filter  
	AUTH_W              INT,                        -- 4 in filter  
	IPMAP_W             INT,                        -- 5 in nat 
	IPMAPNAT_W          INT,                        -- 6 in nat 
	HIDEIPMAP_W         INT,                        -- 7 in nat 
	PORTMAP_W           INT,                        -- 8 in nat 
	PORTMAPNAT_W        INT,                        -- 9 in nat 
	HIDEPORTMAP_W       INT,                        -- 10 in nat    
	TRANS_PROXY_W       INT,                        -- 11 in nat    
	POSTROUTINGNAT_W    INT,                        -- 12 in nat    
	VPN_POSTROUTING_MANGLE_DROP_W       INT,                -- 13 in mangle 
	APCPOLICY_W         INT,                        -- 14 in filter  tonglr 20081015    
	URLPOLICY_W         INT,                        -- 15 in filter     tonglr 20081015
	NETGAP_W            INT,
	NETGAP_INPUT_W      INT
    
);


----����: ��ȫ�������
create table rule_count
(
    count           INT                     --��ȫ�������
);
INSERT INTO rule_count VALUES(0);

--2005/1/13	zhuxp	����������ַ
----����: ��ȫ����
create table policyinfo6
(
    id              INT,                    --��ţ�������ţ���ʾ˳��Ψһ�����Զ��������ɳ����������
    name            CHAR(20),               --������ 
    type            INT,                    --���ͣ�1Ϊpermit��2Ϊdeny��3Ϊproxy��4Ϊnat��5Ϊportmap��6Ϊipmap, 7Ϊauth, 8Ϊmasquerade,9Ϊvpn,10 nataccept,11 portaccept 12 ipaccept
    saddrtype       INT,                    --Դ��ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    saddrid         INT,                    --Դ��ַID
    saddrip         CHAR(128),               --Դ��ַIP
    saddrmask       CHAR(128),               --Դ��ַMASK
    sattype         INT,                    --Դ��ַת������, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�) 5Ϊ��ַ�أ�6Ϊ����ǽ��ַ�� 11/12Ϊ��բ���뿨IP(127.1.0.1/127.1.0.2)(zhouxj-2007-12-03)
    satid           INT,                    --Դ��ַת��ID
    satip           CHAR(15),               --Դ��ַת��IP  //���sattype=6�������Žӿ��ⲿ����
    satmask         CHAR(17),               --Դ��ַת��MASK
    sport           CHAR(128),              --Դ�˿�
    smac            CHAR(17),               --ԴMAC
    satport         CHAR(128),              --Դ�˿�ת��
    daddrtype       INT,                    --Ŀ�ĵ�ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    daddrid         INT,                    --Ŀ�ĵ�ַID
    daddrip         CHAR(128),               --Ŀ�ĵ�ַIP
    daddrmask       CHAR(128),               --Ŀ�ĵ�ַMASK
    pubtype         INT,                    --������ַ����     2Ϊ��ַ����,6Ϊ����ǽ��ַ��21/22/23Ϊ��բ���뿨IP��127.1.0.1/127.1.0.2,127.1.0.0/24��(zhouxj 2007-12-03)
    pubid           CHAR(15),               --������ַID       (��Ӧinterface����ⲿ��ַ)
    innertype       INT,                    --�ڲ���������ַ����, (1ΪIP��ַ/����,�����ﲻ����), (2Ϊ��ַ����, ������)��(3Ϊ��ַ�鶨��, ������)��4��������ַ
    innerid         INT,                    --�ڲ���������ַID
    innerip         CHAR(15),               --�ڲ���ַIP(���ڲ��ã���ֹ�Ժ�Ҫ���ϸ����,ֻ֧��һ���ڲ�������)
    ethin           CHAR(20),                --��������, "any"��ʾ��������ӿ�
    ethout          CHAR(20),                --��������, "any"��ʾ��������ӿ�
    servicetype     INT,                    --��������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������, --6Ϊany
    serviceid       INT,                    --����ID
    pubservicetype  INT,                    --�����������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������
    pubserviceid    INT,                    --�������ID
    innerservicetype    INT,                --�ڲ���������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������
    innerserviceid  INT,                    --�ڲ�����ID
    proxytype       INT,                    --��������, 1Ϊ�̶�����2Ϊ�Զ������
    proxyid         INT,                    --����ID��1Ϊhttp��2Ϊftp,3Ϊtelnet,4Ϊsmtp,5Ϊpop3,6Ϊsocks,7Ϊdns,8Ϊicmp,9Ϊmsn
    timetype        INT,                    --ʱ������, 1Ϊʱ�䶨�壬2Ϊʱ����(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
    timeid          INT,                    --ʱ��ID��(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
    timename        CHAR(20),               --ʱ��������ƣ����ڵĳ���������������ϵ��
--    urlid           INT,                    --URL����ID, 0��ʾ�ޣ�1��ʾ����URL���
    longcon         INT,                   --�Ƿ�֧�ֳ����ӣ�0Ϊ���ã�>0Ϊ����, ��λΪ��
    log             BOOL,                   --�Ƿ��¼������־��0Ϊ���ã�1Ϊ����
--    logurl          BOOL,                   --�Ƿ��¼URL��־��0Ϊ���ã�1Ϊ����
    synflood        INT,                   --�Ƿ�SYN Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    udpflood        INT,                   --�Ƿ�UDP Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    icmpflood       INT,                   --�Ƿ�ICMP Flood������0Ϊ���ã�>0Ϊ����, ��λΪ��/��
    pod             BOOL,                   --�Ƿ�Ping of Death������0Ϊ���ã�1Ϊ����
    active          BOOL,                    --�Ƿ�����(���Ƿ���Ч)��0Ϊ���ã�1Ϊ����
--    keycheck        BOOL,                    --�Ƿ�������ҳ�ؼ��ּ�飬0��ʾ�ޣ�1Ϊ����   
    hideinner		BOOL, 					--�Ƿ������ڲ���ַ��˿ڣ����ڶ˿�ӳ���ipӳ��
--    logkey			BOOL					--�Ƿ��¼�ؼ��ּ����־
-- added by hanhz, 2005/06/27, begin
    dcf           INT DEFAULT 0,                      --��ȹ��˲��ԣ�0Ϊ����
    bt							BOOL,											--�Ƿ�����bt��0Ϊ���ã�1Ϊ����
    edk							BOOL,											--�Ƿ�����edk��0Ϊ���ã�1Ϊ����
    btlog							BOOL,									--�Ƿ��¼bt,edk��־
-- added by hanhz, 2005/06/27, end

-- Added by zhouxj, 2008/04/11, for user auth at Kernel.
	username	CHAR(20),				--�û�����
	usergpid	INT,					--�û���id
-- End

    dport	INT,     --for netgap
    toport	INT,     --for netgap
    proto	INT,     --for netgap
-- add by caoli 2013/01/08
	proto_type INT,	--IPЭ������ 4 ��6
	saname VARCHAR(30), --for netgap Դ��ַ����
	daname VARCHAR(30), --for netgap Ŀ�ĵ�ַ����
-- End
    comment	VARCHAR(255),					--ע��

	POLICY_W            INT,                        -- 1 in filter          
	PROXY_INPUT_W       INT,                        -- 2 in filter  
	AUTH_SERVER_W       INT,                        -- 3 in filter  
	AUTH_W              INT,                        -- 4 in filter  
	IPMAP_W             INT,                        -- 5 in nat 
	IPMAPNAT_W          INT,                        -- 6 in nat 
	HIDEIPMAP_W         INT,                        -- 7 in nat 
	PORTMAP_W           INT,                        -- 8 in nat 
	PORTMAPNAT_W        INT,                        -- 9 in nat 
	HIDEPORTMAP_W       INT,                        -- 10 in nat    
	TRANS_PROXY_W       INT,                        -- 11 in nat    
	POSTROUTINGNAT_W    INT,                        -- 12 in nat    
	VPN_POSTROUTING_MANGLE_DROP_W       INT,                -- 13 in mangle 
	APCPOLICY_W         INT,                        -- 14 in filter  tonglr 20081015    
	URLPOLICY_W         INT,                        -- 15 in filter     tonglr 20081015
	NETGAP_W            INT,
	NETGAP_INPUT_W      INT
    
);


----����: ��ȫ�������
create table rule_count6
(
    count           INT                     --��ȫ�������
);
INSERT INTO rule_count VALUES(0);

----����������������
----����������������
create table bandwidth_rule
(
    id              INT,                    --��ţ�������ţ���ʾ˳��Ψһ�����Զ��������ɳ����������
    name            CHAR(20),               --������ 
    saddrtype       INT,                    --Դ��ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    saddrid         INT,                    --Դ��ַID
    saddrip         CHAR(15),               --Դ��ַIP
    saddrmask       CHAR(15),               --Դ��ַMASK    
    sport           CHAR(128),              --Դ�˿�    
    daddrtype       INT,                    --Ŀ�ĵ�ַ����, 1ΪIP��ַ/����, 2Ϊ��ַ���壬3Ϊ��ַ�鶨�壬(4��������ַ,�������ﲻ���ֵ�),7Ϊany,8Ϊ������ַ
    daddrid         INT,                    --Ŀ�ĵ�ַID
    daddrip         CHAR(15),               --Ŀ�ĵ�ַIP
    daddrmask       CHAR(17),               --Ŀ�ĵ�ַMASK 
   
    ethin           CHAR(20),                --��������, "any"��ʾ��������ӿ�
    servicetype     INT,                    --��������,  --1ΪԤ�������2Ϊ�Զ�����񣨶�̬Э�飩3Ϊ�Զ������ICMPЭ�飩, 4Ϊ�Զ��������ͨ�Զ������,--5Ϊ������, --6Ϊany
    serviceid       INT,                    --����ID
    
    timetype        INT,                    --ʱ������, 1Ϊʱ�䶨�壬2Ϊʱ����(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
    timeid          INT,                    --ʱ��ID��(�ݲ�ʹ�ø��ֶΣ�Ϊ��չ��׼��)
		timename        CHAR(20),               --ʱ��������ƣ����ڵĳ���������������ϵ��    
		bwid						INT,										--������ԴID
		comment					VARCHAR(255), 						--ע��
		active          BOOL,                    --�Ƿ�����(���Ƿ���Ч)��0Ϊ���ã�1Ϊ���� 		
		locaton					INT,										--1,ת����0,ӳ��ǰ
		 bt							BOOL,											--�Ƿ�����bt��0Ϊ���ã�1Ϊ����
    edk							BOOL											--�Ƿ�����edk��0Ϊ���ã�1Ϊ����
);

-- ����: ������
create table blacklist
(
	id		INTEGER PRIMARY KEY, 	--���
	addrip 	        CHAR(15), 		--��ַ
    	time            INT,                    --���ʱ�䣬��λ�Ƿ���
    	start           CHAR(20),               --��Ͽ�ʼʱ��
	comment		VARCHAR(255) 		--ע��
);


COMMIT;
