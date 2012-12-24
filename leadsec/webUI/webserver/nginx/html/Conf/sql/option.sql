
-- Use(Create database):
--   #rm option.db
--   #sqlite option.db<option.sql

-- ����
-- 1. ��� 2003/12/09 

BEGIN TRANSACTION;

-- ����: ��ȫѡ��
create table security_option
(
    anti_ipspoofing    BOOL,             --��IP spoofing����
    anti_teardrop      BOOL,             --��TEAR DROP
    anti_sourseroute   BOOL,             --��Filter IP Source Route Option���� 
    anti_smurf         BOOL,             --��smurf 
    anti_land          BOOL,             --��Land����
    anti_winnuke       BOOL,             --��WinNuke����  
    anti_queso         BOOL,             --��Queso����  
    anti_sfscan        BOOL,             --��sf_scan����  
    anti_nullscan      BOOL,             --��null_scan����  
    anti_fillxmasscan  BOOL,             --��full_xmas_scan����  
    anti_xmasscan      BOOL,             --��xmas_scan����  
    ipmac_check        BOOL,             --IP/MAC ��鿪��
    ipmac_policy       BOOL,             --IP/MAC ���δͨ��ʱ���Ƿ�����Ĳ��Կ��� (ʧЧ��2005/6/19 zhuxp)
    filter_policy      BOOL,             --������ȱʡ����
    state_check        BOOL,             --�ϸ��TCP״̬���
    rule_first         BOOL,             --�¹���������Ч
    fast_mode          BOOL              --����ģʽ
);
insert into security_option values(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0);


-- ����: ��ȫѡ��
create table eth_pro
(
    id              INTEGER PRIMARY KEY,    --ID��
    name 	    CHAR(20),               --����
    protocol	    INT,                    --Э���
    policy          BOOL                    --�Ƿ�����, 0Ϊdrop, 1Ϊaccept
);
insert into eth_pro values(1,'LOOP',96,0);
insert into eth_pro values(2,'PUP',512,0);
insert into eth_pro values(3,'PUPAT',513,0);
insert into eth_pro values(4,'IP',2048,1);
insert into eth_pro values(5,'X25',2053,0);
insert into eth_pro values(6,'ARP',2054,1);
insert into eth_pro values(7,'BPQ',2303,0);
insert into eth_pro values(8,'IEEEPUP',2560,0);
insert into eth_pro values(9,'IEEEPUPAT',2561,0);
insert into eth_pro values(10,'DEC',24576,0);
insert into eth_pro values(11,'DNA_DL',24577,0);
insert into eth_pro values(12,'DNA_RC',24578,0);
insert into eth_pro values(13,'DNA_RT',24579,0);
insert into eth_pro values(14,'LAT',24580,0);
insert into eth_pro values(15,'DIAG',24581,0);
insert into eth_pro values(16,'CUST',24582,0);
insert into eth_pro values(17,'SCA',24583,0);
insert into eth_pro values(18,'RARP',32821,0);
insert into eth_pro values(19,'ATALK',32923,0);
insert into eth_pro values(20,'AARP',33011,0);
insert into eth_pro values(21,'8021Q',33024,0);
insert into eth_pro values(22,'IPX',33079,0);
insert into eth_pro values(23,'IPV6',34525,0);
insert into eth_pro values(24,'PPP_DISC',34915,0);
insert into eth_pro values(25,'PPP_SES',34916,0);
insert into eth_pro values(26,'ATMMPOA',34892,0);
insert into eth_pro values(27,'ATMFATE',34948,0);
insert into eth_pro values(28,'EDP2',34978,0);
insert into eth_pro values(29,'802_3',1,0);
insert into eth_pro values(30,'AX25',2,0);
insert into eth_pro values(31,'802_2',4,0);
insert into eth_pro values(32,'SNAP',5,0);
insert into eth_pro values(33,'DDCMP',6,0);
insert into eth_pro values(34,'WAN_PPP',7,0);
insert into eth_pro values(35,'PPP_MP',8,0);
insert into eth_pro values(36,'LOCALTALK',9,0);
insert into eth_pro values(37,'PPPTALK',16,0);
insert into eth_pro values(38,'TR_802_2',17,0);
insert into eth_pro values(39,'MOBITEX',21,0);
insert into eth_pro values(40,'CONTROL',22,0);
insert into eth_pro values(41,'IRDA',23,0);
insert into eth_pro values(42,'ECONET',24,0);
insert into eth_pro values(43,'HDLC',25,0);

insert into eth_pro values(44,'',0,0);
insert into eth_pro values(45,'',0,0);
insert into eth_pro values(46,'',0,0);
insert into eth_pro values(47,'',0,0);
insert into eth_pro values(48,'',0,0);

insert into eth_pro values(49,'OTHER',3,0);
insert into eth_pro values(50,'ALL',3,1);

--Ĭ�ϲ���������Ӱ������
--������ϵͳ���
create table monitor
(
    id	INTEGER PRIMARY KEY,    --ID��
    name	CHAR(20),			--ģ������
    active	BOOL,				--ģ���Ƿ�����
    start	CHAR(128),			--ģ��������������
    stop	CHAR(128)			--ģ��ֹͣ��������
);
insert into monitor values(1,'interfacemon',0,'/usr/local/bin/interfacemon -d','/usr/local/bin/interfacemon -k');
insert into monitor values(2,'sysmon',0,'/usr/local/bin/sysmon -d','/usr/bin/killall -9 sysmon');
insert into monitor values(3,'domain',0,'/usr/local/bin/domain_monitor -s','/usr/bin/killall domain_monitor');

--ϵͳ���Կ���
create table debug
(
	module	CHAR(32),			--ģ������,all��������ģ��
	debug	BOOL,				--���Կ���
	facility	INT				--������Ϣ����豸,1:����̨��2:��־
);

insert into debug values("all",0,1);
insert into debug values("acsc",0,1);
insert into debug values("address",0,1);
insert into debug values("addrgrp",0,1);
insert into debug values("admacct",0,1);
insert into debug values("admcert",0,1);
insert into debug values("admhost",0,1);
insert into debug values("admmode",0,1);
insert into debug values("adsl",0,1);
insert into debug values("alertmail",0,1);
insert into debug values("authserver",0,1);
insert into debug values("bandwidth",0,1);
insert into debug values("blacklist",0,1);
insert into debug values("block",0,1);
insert into debug values("bw",0,1);
insert into debug values("cleardb",0,1);
insert into debug values("cli",0,1);
insert into debug values("clock",0,1);
insert into debug values("conn_query",0,1);
insert into debug values("controlkw",0,1);
insert into debug values("ddns",0,1);
insert into debug values("debug",0,1);
insert into debug values("dhcpclient",0,1);
insert into debug values("dhcprelay",0,1);
insert into debug values("dhcpserver",0,1);
insert into debug values("domain",0,1);
insert into debug values("exportdb",0,1);
insert into debug values("fwarp",0,1);
insert into debug values("fwping",0,1);
insert into debug values("fwroute",0,1);
insert into debug values("fwtcpdump",0,1);
insert into debug values("fwtraceroute",0,1);
insert into debug values("ha",0,1);
insert into debug values("hadetect",0,1);
insert into debug values("hostname",0,1);
insert into debug values("ids",0,1);
insert into debug values("interface",0,1);
insert into debug values("linkage",0,1);
insert into debug values("log",0,1);
insert into debug values("logserver",0,1);
insert into debug values("macbind",0,1);
insert into debug values("mailfilter",0,1);
insert into debug values("monitor",0,1);
insert into debug values("newconfig",0,1);
insert into debug values("ntp",0,1);
insert into debug values("option",0,1);
insert into debug values("proxy",0,1);
insert into debug values("route",0,1);
insert into debug values("rule",0,1);
insert into debug values("sarp",0,1);
insert into debug values("sataddr",0,1);
insert into debug values("serveraddr",0,1);
insert into debug values("servgrp",0,1);
insert into debug values("service",0,1);
insert into debug values("setdb",0,1);
insert into debug values("snmp",0,1);
insert into debug values("system",0,1);
insert into debug values("time",0,1);
insert into debug values("upgrade",0,1);
insert into debug values("upnp",0,1);
insert into debug values("url",0,1);
insert into debug values("user",0,1);
insert into debug values("usergrp",0,1);
insert into debug values("usernum",0,1);
insert into debug values("vlanid",0,1);
insert into debug values("vpn",0,1);
insert into debug values("vpnpolicy",0,1);

-- ����: SOHO����ѡ��
create table soho_parameter
(
    bridge_num    int,             --�����豸��
    alias_num    int,             --�����豸��
    route_num    int,             --��̬·����
    portmap_num    int,             --�˿�ӳ�������
    ipmap_num    int,             --IPӳ�������
    pf_num    int,             --�����˹�����
    nat_num    int,             --NAT������
    macbind_num    int,             --��ַ�󶨹�����
    bw_num    int,             --������������
    blacklist_num    int,             --��������
    remotevpn_num    int,             --Զ��VPN������
    vpntunnel_num    int,             --VPN�����
    vpnuser_num    int,             --VPNԶ�̲����û���
    user_num    int,             --�û��б���
    userg_num    int,             --�û�����
    bandwidth_num    int,             --������Դ��
    urlfilter_num    int,             --URL���˹ؼ�����
    webkey_num    int             --��ҳ���˹ؼ�����  
);

insert into soho_parameter values(1,8,20,50,50,300,300,100,50,50,100,100,50,50,50,40,64,64);

COMMIT;
