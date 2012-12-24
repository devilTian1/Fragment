
-- Use(Create database):
--   #sqlite configs.db<configs.sql

-- History:
-- 2004/1/8	zhuxp	ȥ����fwips,antiatk
-- 2004/1/11	zhuxp	�����tbl_ddns_user���޸ı�interface�����붯̬����

BEGIN TRANSACTION;

-- ����������ǽ����
create table hostname
(
	hostname		  CHAR(20)
);
insert into hostname values("NetGap");

-- ��������̬DNSע���û���������
create table ddns_info
(
	username		  CHAR(32),			--�û���
	password		  CHAR(32)			--����
);
insert into ddns_info values('','');

--����ǰ��Ĭ�ϵĹ����豸��fe1
--������ Ĭ�ϵĹ����豸��fe2
--Ĭ�ϵĹ���IP��10.0.0.1,Ĭ�ϵĹ�������IP��10.0.0.200
--Ĭ������brg0�豸
--Ĭ�ϲ�����ipsec0�豸
--��������豸��HAģ��ʹ�ã���Ҫ����,Ĭ�ϵ�HA�豸��fe2
--���Ӳ����豸
-- ����: ����ӿ�
create table interface
(
    external_name     CHAR(20),         --����ӿ��ⲿ���� 
    internal_name     CHAR(20),         --����ӿ��ڲ�����, ���������ã����������޸�
    mac_address       CHAR(17),         --MAC��ַ
    linkmode          INT,              --0:�Զ���� 1:ȫ˫�� 2:��˫��
    mtu               INT,              --MTU size 
    trunk             BOOL,             --�Ƿ���Trunk��,ֻ�������������豸��
	device_type		  INT,				--0:δָ�� 1:��̫�������豸 2:VLAN�豸 3:�����豸 4:VPN�豸 5:�����豸 6:�����豸 7�������豸
	network_type	  INT,				--0:δָ�� 1:���� 2:DMZ 3:���� 4:HA��(���ڶ���������)
	interface_list	  CHAR(255),		--����������豸�������豸��������ʵ�豸�����б������豸�������Լ����������豸
	phy_device		  CHAR(20),			--����Ǳ�����VLAN,VPN�豸,������Ӧ����ʵ�豸����,����Ϊ��
    vlan_id           INT,              --�����VLAN�豸������VLAN ID(���������Զ����ɣ������޸�)
	alias_id	  	  INT,				--����Ǳ����豸,����ID��(���������Զ����ɣ������޸�)
	ipaddr_type		  INT,				--0:δָ�� 1:��̬IP��ַ 2:��Ч 3: ʹ��DHCP���IP��ַ,ֻ������̫�������豸 
    qos_enable		  BOOL,				--���ô������
    qos_device_bw	  INT,				--�豸����
    dhcp_relay		  BOOL,				--����DHCP�м̣�ֻ������̫�������豸
    stp_enable		  BOOL,				--��������STP
    enable			  BOOL,				--�Ƿ������豸
    ip                CHAR(15),         --�ӿ�IP��ַ
    mask              CHAR(15),         --�ӿ�IP��ַ����
    admin             BOOL,             --�ӿ��Ƿ����ڹ���
    ping              BOOL,             --�ӿ��Ƿ���Ա�PING
    traceroute        BOOL,             --�ӿ��Ƿ���Ա�TRACEROUTE	
    workmode		  INT,				--�����豸�Ĺ���ģʽ 0:δָ�� 1:·��ģʽ(Ĭ��) 2:͸��ģʽ 3:�����豸ģʽ
    rd_mode			  INT,				--�����豸�Ĺ���ģʽ 0:��ȫ(��?)���� 1:ȫ����(Ĭ��) 
	dns_enable		  BOOL,				--���ö�̬����ע��
	domain_name		  CHAR(255),		--��������
	ha_enable		  BOOL,				--HA�豸
	valid			  BOOL,				--����ӿ��Ƿ���Ч��Ĭ������Ч����ϵͳ����ʱ��Ⲣ�������ݿ�
	speed			  INT,				--����ӿڵ��ٶȣ�eth0-eth3�̶�Ϊ���ף�eth4-eth7��Ҫ��ϵͳ����ʱ��Ⲣ�������ݿ�
	dhcpserver		  CHAR(255),		--DHCP�м������õ�DHCP�����������Կո�ָ��IP��ַ�б�
	ipmac_check		  INT,				--MAC��ַ�󶨼�� 0������飨Ĭ�ϣ��� 1�����
	ipmac_check_policy INT,				--δ�󶨵�ַ�Ĳ��� 0����ͨ���� 1��ͨ����Ĭ�ϣ�
	antispoof		  INT,				--��ַ��ƭ��� 0������飨Ĭ�ϣ� 1�����
    if_property       INT ,				--�豸����: 0:δָ��  1:HA�ӿ�  2:����ӿ�  3:����ӿ�  4:������չ��
    ipv6              CHAR(50),         --IPv6
    ipv6_mask         CHAR(15)         --IPv6
);
insert into interface values('fe1','eth0','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",1,1,100,"",0,1,0,1,"","");
insert into interface values('fe2','eth1','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.0.1","255.255.255.0",1,1,1,1,0,0,"",0,1,100,"",0,1,0,2,"","");
insert into interface values('fe3','eth2','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.1.1","255.255.255.0",0,0,0,1,0,0,"",0,1,100,"",0,1,0,3,"","");
insert into interface values('fe4','eth3','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe5','eth4','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe6','eth5','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,1,"10.0.2.1","255.255.255.0",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe7','eth6','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,100,"",0,1,0,4,"","");
insert into interface values('fe8','eth7','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe9','eth8','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe10','eth9','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe11','eth10','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe12','eth11','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe13','eth12','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe14','eth13','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
insert into interface values('fe15','eth14','',0,1500,0,1,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,0,0,"",0,1,0,4,"","");
--insert into interface values('brg0','brg0',0,'',0,1500,0,3,1,"","",-1,-1,1,0,0,0,1,1,"10.1.5.254","255.255.255.0",1,1,1,1,0,0,"",0,1,0,"",0,1,0);
--insert into interface values('ipsec0','ipsec0',0,'',0,1500,0,4,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,0,"",0,1,0);
--insert into interface values('dial0','ppp0',0,'',0,1500,0,7,1,"","",-1,-1,1,0,0,0,0,0,"","",0,0,0,1,0,0,"",0,1,10,"",0,1,0);


--�����������豸����
--2004/11/23 yangcy	�����������豸�������豸�Ĳ���
create table redevice_option
(
	version		INT,				--�����豸�����汾�������ݿ��ʽ�����ı����޸�
	max_devices	INT,				--���֧�ֵ������豸����4��Ĭ��Ϊ5������bond0�豸������HA�������������豸ʹ��
	work_mode	INT,				--�����豸������ģʽ0-6��Ĭ��Ϊ0
	link_watch	INT,				--���ʱ�䣬��λΪ����
	updelay		INT,				--up�ӳ�ʱ�䣬ֵΪwatch_time�ı���
	downdelay	INT,				--down�ӳ�ʱ�䣬ֵΪwatch_time�ı���
	lacp_rate	INT,				--802.3adģʽ����0��1
	usr_carries	INT					--Ĭ��Ϊ1
);
insert into redevice_option values(1,5,0,300,0,0,0,1);

--�����������豸����
create table dial
(
	name		CHAR(20),				--�����豸�ⲿ���ƣ�Ŀǰֻ֧��һ�������豸
	interface	CHAR(20),				--�����豸�İ��豸���ⲿ��
	protocol	INT,					--����Э�飬1��PPPoE
	username	CHAR(64),				--�����û���
	passwd		CHAR(64),				--��������
	startup		BOOL,					--ϵͳ����ʱ����
	auto		BOOL,					--�Զ�����
	time		CHAR(20)				--ʱ����Դ����
);
insert into dial values('dial0',"",1,"","",0,1,"");

--������TRUNK
create table trunk
(
	crossvlan  INT
);
insert into trunk values('0');

-- ����: upnp�ӿ�
create table upnp_if
(
    exif_name     CHAR(20),         --�ⲿ����ӿ�����//interface���ⲿ����
    inif_name     CHAR(20),         --�ڲ�����ӿ�����//interface���ⲿ����
    active		  INT				--0:δ���� 1:����
);
insert into upnp_if values('','',0);

-- ����: upnp����
create table upnp_rule
(
    id			  INTEGER PRIMARY KEY, --ID  sequence
    name			CHAR(20),            --����
    ip              CHAR(45),            --IP
    mask            CHAR(15),                 --����
    comment         VARCHAR(255)            --������ע    
);
-- ������ARP��
create table arp_static
(
	id              INTEGER PRIMARY KEY,    --ID��
	ip              CHAR(45),               --��ַ
	mac             CHAR(17),               --MAC��ַ
	interface       CHAR(20),               --���ʱд�룬�豸���ⲿ����
	active          INT                     --�Ƿ�����1������ 0��������
);

-- ������ȱʡ·��
create table defaultroute
(
	defaultroute	CHAR(15)
);
insert into defaultroute values ("");


-- ����: ��̬·��
create table route_static
(
    id              INTEGER PRIMARY KEY,    --ID��, Ĭ��·�ɷ����ڵ�һ����¼ id = 1, ����ɾ��  
    destip          CHAR(45),               --Ŀ�ĵ�ַ   
    destmask        CHAR(15),               --Ŀ�ĵ�ַ����         
    nexthopip       CHAR(45),               --��һ����ַ
    interface		CHAR(20),               --���ʱд�룬��interface���е�����ͬʱ�ǽӿڱ��еĽӿ��ڲ����������޸ĺ�ɾ����
    active 			INT 					--�Ƿ�����1������ 0��������
);

-- ����: ����·��
create table route_policy
(
    id              INTEGER PRIMARY KEY,    --ID��, Ĭ��·�ɷ����ڵ�һ����¼ id = 1, ����ɾ��
    sourceip        CHAR(45),               --Դ��ַ
    destip          CHAR(45),               --Ŀ�ĵ�ַ
    sourcemask      CHAR(15),               --Դ��ַ����
    destmask        CHAR(15),               --Ŀ�ĵ�ַ����         
    nexthopip       CHAR(45),               --��һ����ַ
    interface		CHAR(20),               --���ʱд�룬��interface���е�����ͬʱ�ǽӿڱ��еĽӿ��ڲ����������޸ĺ�ɾ����
    active 			INT, 					--�Ƿ�����1������ 0��������
	tableid			INT,					--��Ӧ�ı�ID
	priority		INT 					--�������ȼ�
);

------����: ���й���
create table snmp
(
    ip              CHAR(255),              --���й�������IP,���ip����"|"�ָ�����һ����֧��16��ip   
    adminname       CHAR(20),               --����������    
    adminphone      CHAR(30),               --�����˵绰    
    cpu             INT  default 85,        --CPU�����ʷ�ֵ
    mem             INT  default 85,        --�ڴ������ʷ�ֵ
    file            INT  default 85,        --�ļ�ϵͳ�����ʷ�ֵ
    comment         VARCHAR(255),           --������ע    
    rcomm           CHAR(64) default 'public',  --ֻ�����崮
    wcomm           CHAR(64) default 'private', --��д���崮
    trapcomm        CHAR(64) default 'public',  --trap���崮
    comm2sec        CHAR(4)  default 'on'       --whether or not use community to security
);
insert into snmp (ip) values (NULL);


--snmp v3֧��
create table snmpusm
(
    --id              INTEGER PRIMARY KEY, 
    username    CHAR(64) default 'leadsec',       --security name
    seclevel    CHAR(6) default 'noauth',  --security level
    authproto   CHAR(8) default 'MD5',     --authentication protocol (MD5|SHA)
    authphrase  CHAR(32),                  --authentication protocol pass phrase
    privproto   CHAR(8) default 'DES',     --privacy protocol (DES | AES)
    privphrase  CHAR(32),                  --privacy protocol pass phrase
    v3usm       CHAR(4) default 'off'       --whether or not use SNMPv3 USM 
);
INSERT INTO snmpusm (v3usm) VALUES('off');


-- ����: ��������
--create table adminips
--(
--    id              INTEGER PRIMARY KEY,    --���
--    ip              CHAR(15),               --IP��ַ
--    comment         VARCHAR(255)            --����
--);
--INSERT INTO adminips VALUES(1,'10.0.0.200','��������1');
--modified for netgap
--INSERT INTO adminips VALUES(2,'10.1.5.49','PPP���Ź�������');
create table adminips
(
    id              INTEGER PRIMARY KEY,    --���
    ip              CHAR(45),               --IP��ַ
    netmask	    		CHAR(15),		    				--��������	
    comment         VARCHAR(255)            --����
);
INSERT INTO adminips VALUES(1,'0.0.0.0','0.0.0.0','��������1');

-- ����: ��������
create table mailbox 
(
    mailbox         CHAR(64),           --��������
    smtp            CHAR(64),           --SMTP��ַ
    port            INT,                --SMTP �˿�
    sender          CHAR(64),
    receiver1       CHAR(64),
    receiver2       CHAR(64),
    receiver3       CHAR(64),
    gwmail_smtp     CHAR(64),
    gwmail_port     INT,
    passwd          CHAR(20),
    power           CHAR(1),
    log_power       CHAR(1)
);
INSERT INTO mailbox VALUES('','',25,'','','','','',25,'','','');

create table gwmail
(
    sender          CHAR(64),
    receiver1       CHAR(64),
    receiver2       CHAR(64),
    receiver3       CHAR(64),
    gwmail_smtp     CHAR(64),
    gwmail_port     INT,
    passwd          CHAR(20),
    power           INT,
    log_power       INT,
    accessory_name  CHAR(64),
    now_subject     CHAR(100),
    now_content     CHAR(1000),
    now_signature   CHAR(100)
);
INSERT INTO gwmail VALUES('','','','','',25,'','1','1','','','','');

-- ����: ��־�����������   add by caixc 2012-11-22
create table log_basic
(
    sendother  BOOL,    --�Ƿ�����־���Զ�����
    tcp_enable     BOOL,    --�Ƿ���rsyslogd��tcp�����˿�
    udp_enable     BOOL,    --�Ƿ���rsyslogd��udp�����˿�
    sizelimit      INT      --��־�ļ��Ĵ�С����(��λM)
);
INSERT INTO log_basic VALUES(0,1,1,20);

-- ����: ��־������
create table logsrv
(
    --sourceip        CHAR(45),           --Դ��ַ��������־IP��
    logsrv          CHAR(45),           --��־������IP��ַ    
    protocol        CHAR(5),            --Э���    
    port            INT,                --�˿�    
    comment         VARCHAR(255)        --����
);

--����: ���ý���־���͵��趨��ftp������
create table log_ftpsrv
(
    ftpsrv      CHAR(45),       --FTP������IP��ַ
    user        CHAR(25),       --ftp�û���
    pass        CHAR(25),       --ftp�û�����
    passive     BOOL           --����ģʽ��1���� 0������
);

create table logupload
(
    minute      INT,            --����ÿСʱ�Ķ��ٷ����Զ��ϴ�,0��ʾ�����Ч������ֵ1-59
    hour        INT,            --����ÿ��ļ����Զ��ϴ���0��ʾ�����Ч������ֵ1-23
    day         INT,            --����ÿ�µ������Զ��ϴ���0��ʾ�����Ч������ֵ1-31
    enable      BOOL            --1������־�Զ��ϴ����ܣ�0�ر���־�Զ��ϴ�
);
INSERT INTO logupload VALUES(0,0,0,0);


-- ����: ����ʽ
create table admin_style
(
    use_ssh                 BOOL,       --����Զ��SSH
    use_ppp                 BOOL        --֧�ֲ���PPP����
);
INSERT INTO admin_style VALUES(0,0);

-- ����: ����Ա�ʺ�
create table accounts
(
    account     CHAR(20) PRIMARY KEY,   --����Ա�˺�
    super       BOOL,                   --��������ԱȨ��
    manager     BOOL,                   --���ù���ԱȨ��
    policyer    BOOL,                   --���Թ���ԱȨ��
    auditor     BOOL,                   --���ԱȨ��
    passwd      VARCHAR(255),           --����
    locktime   intergaer               --�˺ű���ʱ��
);
INSERT INTO accounts VALUES('administrator',1,1,1,1,'administrator',0);
INSERT INTO accounts VALUES('admin',0,1,1,1,'admin123',0);



-- ����: ����Ա����
create table allow_multiple
(
    allow       BOOL            --��������Ա
);
INSERT INTO allow_multiple VALUES(1);

-- �����������¼ʧ�ܴ���
create table allow_failure
(
	times       interger,
    expiration  interger
);
INSERT INTO allow_failure VALUES(3,5);


-- ����: ����������
create table dnssrv
(
    dnssrv      CHAR(45),       --����������1 IP��ַ
    dnssrv2     CHAR(45)       --����������2 IP��ַ
);
INSERT INTO dnssrv VALUES('','');



-- ����: ʱ�������
create table timeserver
(
    enable_time_server      BOOL,       --�Ƿ�����ʱ�������
    server_ip               CHAR(45),   --������IP��ַ
    syninterval             INT         --ͬ��ʱ����
);
INSERT INTO timeserver VALUES(0,'',300);



-- ����: IDS����
create table ids
(
    puma        BOOL,                   --����ͨ�ð�ȫЭ������0Ϊ���ã�1Ϊ����
    puma_ip     VARCHAR(255),           --����ͨ�ð�ȫЭ��IP
    puma_port   INT,                    --����ͨ�ð�ȫЭ��˿�    
    puma_passwd VARCHAR(255),           --����ͨ�ð�ȫЭ�����
    tian        BOOL,                   --����"����"IDS0Ϊ���ã�1Ϊ����
    tian_ip     VARCHAR(256),           -- "����"����IP
    tian_port   INT,                    --"����"�����˿�
    yan         BOOL,                   --����"����"IDS0Ϊ���ã�1Ϊ����
    yan_ip      VARCHAR(256),           -- "����"����IP
    yan_port    INT,                    --"����"�����˿�
    safemate    BOOL,                   -- ����SafeMate IDS 0Ϊ���ã�1Ϊ����
    safemate_ip VARCHAR(256),           --SafeMate����IP
    safemate_port     INT,              --safeMate �˿� ��Ĭ��UDP2001��
    iplist      VARCHAR(1024)           -- ������ϵ�IP��ַ
);
INSERT INTO ids VALUES(0,'',5000,'',0,'',2000,0,'',4000,0,'',2001,'');



-- ����: �������
create table proxy
(
    http            BOOL,               --�Ƿ�����HTTP����
    http_port       INT,                --HTTP�������˿�
    http_java       BOOL,               --�Ƿ����Java, 0Ϊdeny��1Ϊallow
    http_javascript BOOL,               --�Ƿ����JavaScript, 0Ϊdeny��1Ϊallow
    http_activex    BOOL,               --�Ƿ����ActiveX, 0Ϊdeny��1Ϊallow
    ftp             BOOL,               --�Ƿ�����FTP����, 0Ϊoff��1Ϊon
    ftp_port        INT,                --FTP�������˿�
    ftp_controlcnt  BOOL,               --�Ƿ���ƶ��߳�, 0Ϊoff��1Ϊon
    ftp_get         BOOL,               --�Ƿ���ʹ��get����
    ftp_put         BOOL,               --�Ƿ���ʹ��put����
    telnet          BOOL,               --�Ƿ�����TELNET����
    telnet_port     INT,                --TELNET�������˿�
    smtp            BOOL,               --�Ƿ�����SMTP����
    smtp_port       INT,                --SMTP�������˿�
    smtp_dns        VARCHAR(255),       --�����б�
    smtp_srv        VARCHAR(255),       --����ǽ��ʵ����
    smtp_inmail     VARCHAR(255),       --�ڲ��ʼ�����
    smtp_insrv      VARCHAR(255),       --�ڲ��ʼ�������
    smtp_max_length INT,                --SMTP�ʼ���󳤶�
    max_accepter    INT,                --����������
    pop3            BOOL,               --�Ƿ�����POP3����
    pop3_port       INT,                --POP3�������˿�
    pop3_srv        VARCHAR(255),       --POP3�������б�
    pop3_max_length INT,                --POP3�ʼ���󳤶�
    socks           BOOL,               --�Ƿ�����SOCKS����
    socks_port      INT,                --SOCKS�������˿�
    dns             BOOL,               --�Ƿ�����DNS����   
    dns_server      VARCHAR(255),       --DNS�������������
    ping            BOOL,               --�Ƿ�����ICMP����
    msn             BOOL,               --�Ƿ�����MSN����
    smtp_span		INT,                --SMTP����ʱ��������λΪ����
    smtp_count		INT                 --SMTP����ʱ�������ʼ���Ŀ
);
insert into proxy values(1,80,1,1,1,1,21,1,1,1,1,23,0,25,'dns.leadsec.com','smtp.leadsec.com','dns.leadsec.com','192.168.1.10',2048,5,0,110,'pop3.leadsec.com',20480,0,1080,0,'',0,0,600,100);



-- ����: �Զ������
create table proxy_custom
(
    id              INTEGER PRIMARY KEY, --���
    name            CHAR(20),            --������
    port            INT,                 --�˿�
    protocol        INT,                 --Э��, ��getprotobynumber()��ʵ�ֽ���
    enable          BOOL                 --�Ƿ�����
);


-- ����: �ʼ�����
create table mail_filter
(
    smtp_sender         BOOL,           --�Ƿ���˷����ˡ������˵�ַ
    smtp_sender_list    VARCHAR(255),   --�����ˡ������˵�ַ�б�
    smtp_receiver       BOOL,           --�Ƿ���������ˡ������˵�ַ
    smtp_receiver_list  VARCHAR(255),   --�����ˡ������˵�ַ�б�
    smtp_subject        BOOL,           --�Ƿ�����ʼ�����
    smtp_subject_list   VARCHAR(255),   --�ʼ������б�
    smtp_content        INT,            --�Ƿ�����ʼ����丽������, 0���ã�1�ؼ���ƥ�䣬2���ܹ���
    smtp_content_list   VARCHAR(255),   --�ؼ����б�
    smtp_attach         BOOL,           --�Ƿ���˸����ļ���
    smtp_attach_list    VARCHAR(255),   --�����ļ����б�
    pop3_sender         BOOL,           --�Ƿ���˷����ˡ������˵�ַ
    pop3_sender_list    VARCHAR(255),   --�����ˡ������˵�ַ�б�
    pop3_receiver       BOOL,           --�Ƿ���������ˡ������˵�ַ
    pop3_receiver_list  VARCHAR(255),   --�����ˡ������˵�ַ�б�
    pop3_subject        BOOL,           --�Ƿ�����ʼ�����
    pop3_subject_list   VARCHAR(255),   --�ʼ������б�
    pop3_content        INT,            --�Ƿ�����ʼ����丽������, 0���ã�1�ؼ���ƥ�䣬2���ܹ���
    pop3_content_list   VARCHAR(255),   --�ؼ����б�
    pop3_attach         BOOL,           --�Ƿ���˸����ļ���
    pop3_attach_list    VARCHAR(255)    --�����ļ����б�
);
INSERT INTO mail_filter VALUES(0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

-- added by liype for DHCP Server configuration 2003.12.08 begin
create table dhcpserver_domain
(
	id		INTEGER PRIMARY KEY,
	interface	CHAR(20),
	network		CHAR(15),
	netmask		CHAR(15),
	gateway		CHAR(15),
	domainname	CHAR(64),
	dns		CHAR(128),
	range		CHAR(20),
	comment		VARCHAR(255),
	is_vpnclient	CHAR(8),
	vpnclient_netmask 	CHAR(15)
);
create table dhcpserver_static
(
	id		INTEGER PRIMARY KEY,
	hostname	CHAR(64),
	mac		CHAR(17),
	ip		CHAR(45),
	comment		VARCHAR(255)
);
create table dhcpserver_startup
(
	startup		BOOL
);
insert into dhcpserver_startup values(0);
-- added by liype for DHCP Server configuration 2003.12.08 end

-- added by liype for DHCP Client configuration 2003.12.10 begin
create table dhcpclient
(
	interface	CHAR(20)
);
-- added by liype for DHCP Client configuration 2003.12.10 end

-- added by liype for DHCP relay configuration 2003.12.13 begin
create table dhcprelay
(
	interface	CHAR(20),
	servers		CHAR(255)
);
-- added by liype for DHCP relay configuration 2003.12.10 end

-- added by liype for ADSL configuration 2003.12.12 begin
create table adsl
(
	interface	CHAR(16),
	username	CHAR(16),
	passwd		CHAR(16),
	autodown	INT,
	startup		BOOL
);
create table adsl_auto
(
	auto		BOOL
);
insert into adsl_auto values (0);
-- added by liype for ADSL configuration 2003.12.12 end

-- added by yuzy for neight table 2005.09.21 begin
create table neightab
(
	thresh1		INT,
	thresh2		INT,
	thresh3		INT
);
insert into neightab values (128,512,1024);
-- added by yuzy for neight table 2005.09.21 end


COMMIT;


