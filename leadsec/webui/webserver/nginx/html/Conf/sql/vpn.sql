
-- Use(Create database):
--   #rm vpn.db
--   #sqlite vpn.db<vpn.sql

BEGIN TRANSACTION;

--������vpnϵͳ������vpn_system_parameter
create table vpn_system_parameter
(
	version          varchar(10),                --�汾��Ϣ
	ipsecif  	 varchar(15),                 --����vpn����ӿ�ppp0,eth0,fwbr0
	crtconffile	int				--��������޸Ļ�������ʱ���Ƿ��������������ļ���1��ʾ�ǣ�2��ʾ�񡣹����Բ������ʱ�����������ʹ��
);

insert into vpn_system_parameter values('version 3.0','ipsec0=eth0','1');

-- ����: vpnȱʡ������vpn_default_parameter
create table vpn_default_parameter
(
    ipaddr		 varchar(15),                --ȱʡ����vpn����ip��ַ	
    domainname           varchar(50),                --ȱʡ����vpn����
    nexthop              varchar(15),                --ȱʡ������һ����ַ
    ikelifetime          varchar(5),                 --ȱʡike sa����������  
    ipseclifetime        varchar(5),                 --ȱʡipsec sa����������
    prekey               varchar(128),               --ȱʡԤ������Կ��8��128��
    certid               varchar(50),                --ȱʡ����֤��id    //�ݲ�ʹ��
    cert                 varchar(20),                 --ȱʡ����֤������
    dhcpoveripsec	int,			-- �Ƿ�����dhcpoveripsec	
    dhcprelayip		varchar(15),		-- dhcp�м�ip��ַ
    dhcprelaydevice	varchar(10)		-- dhcp�м��豸
);

insert into vpn_default_parameter values('10.0.0.1','','','28800','3600','TypeYourPrekey','','','0','','');

--������vpnԶ�����ر�vpn_remotegateway
create table vpn_remotegateway
(
    name                 varchar(20) primary key,    --Զ���������֣�Ψһ��ʶ��������������
    addrtype    	 int,                        --��ַ���ͣ�1��ʾ�̶�ip��ַ��2��ʾ����
    ipaddr               varchar(15),                --Զ������ip��ַ
    domainname           varchar(50),                --Զ����������
    authtype             int,                        --��֤����,1��ʾԤ������Կ��2��ʾ֤��  
    prekey               varchar(128),               --Ԥ������Կ��8��128��    
    localcert            varchar(20),                --����֤��
    cert                 varchar(20),                --Զ������֤������   
    type                 int,                         --Զ���������ͣ�1��ʾ���أ�2��ʾ�ͻ���
    ike                  varchar(15),                 --ike�㷨���  �� 3des-md5��3des-sha��aes128-md5��aes128-sha�е�һ����Ĭ��ȡ3des-md5
    p1dhgroup            varchar(20),                 --��һ�׶ν���Ⱥ��
    ikelifetime          varchar(5),                  --ike�������� ��
    p1mode		 int,                         --�����֤��ʽ,1��ʾ��ģʽ(default)main,2��ʾҰ��ģʽ aggressive*
    localid              varchar(20),                 -- Ұ��ģʽ������ݱ�ʶ��
    remoteid             varchar(20),                 -- Ұ��ģʽԶ����ݱ�ʶ��
    xauth		 int			      -- 1��ʾ�����ã�2��ʾ����
    
);

--������vpn�����vpn_tunnel
create table vpn_tunnel
(
    number               integer primary key,         --���������
    name                 varchar(20),		      --������ƣ������ظ���������������
    localip		 varchar(15),		      --��������IP��ַ
    localdn		 varchar(50),                 --������������
    localcertid          varchar(50),                 --����֤��id     
    localcert            varchar(20),                 --����֤������,����һ���ֶλ���
    localnexthop         varchar(15),                 --������һ����ַ
    localsubnet          varchar(15),                 --���ر�������
    localsubnetmask      varchar(15),                 --���ر�����������
    remotename           varchar(20),                 --Զ�����ػ�ͻ�������
    remoteip		 varchar(15),		      --Զ��IP��ַ
    remotedn		 varchar(50),                 --Զ������
    remotecertid         varchar(50),                 --Զ������֤��id   
    remotecert           varchar(20),                 --Զ������֤������
    remotesubnet         varchar(15),                 --Զ�˱�������
    remotesubnetmask     varchar(15),                 --Զ�˱�����������
    ike                  varchar(15),                 --ike�㷨���  ��
    ipsec                varchar(15),                 --ipsec�㷨��� 3des-md5|3des-sha1|aes128-md5|aes128-sha1,Ĭ��ȡ3des-md5  �������� null-md5,null-sha1,hz-md5,hz-sha1 
    pfs                  int,                         --�Ƿ�������ǰ���ܣ�1��ʾyes��2��ʾno,Ĭ��yes
    auth                 int,                         --���ݰ���װ��ʽ��1��ʾesp��2��ʾah,ȱʡesp
    compress             int,                         --���ݰ��Ƿ�ѹ����1��ʾѹ����2��ʾ��ѹ��,ȱʡno
    p1dhgroup            varchar(20),                 --��һ�׶ν���Ⱥ��
    p2dhgroup            varchar(20),                 --�ڶ��׶ν���Ⱥ
    ikelifetime          varchar(5),                  --ike�������� ��
    ipseclifetime        varchar(5),                  --ipsec��������
    authtype             int,                         --��֤����,1��ʾԤ������Կ��2��ʾ֤��  
    defaultaction        int,                         --�����ȱʡ����ǽ����1��ʾpass,2��ʾdeny,Ĭ����pass
    p1mode		 int,                         --�����֤��ʽ,1��ʾ��ģʽ(default),2��ʾҰ��ģʽ    *  //��ʱ��ʹ��
    type                 int,                         --������ͣ�1��ʾ���أ�2��ʾ�ͻ���
    active               int,                          --����Ƿ�������1��ʾ������2��ʾֹͣ,Ĭ������
    dpddelay		int,			-- dpd delaytime(s)
    dpdtimeout		int,                   -- dpd time out(s)
    initiator		int                     -- �Ƿ���Ϊinitiator��1��ʾyes��2��ʾno,Ĭ��yes
);

--������vpn֤���vpn_cert
create table vpn_cert
(
   name                  varchar(20) primary key,      --֤������      
   type	                 int,  			       --֤�����ͣ�1��ʾca֤�飬2��ʾ�ͻ���֤�飬3��ʾ����֤��,4��ʾusb ca֤�飬5��ʾusb ����֤�� 
   issuer		 varchar(255),		       --�䷢��		 
   subject		 varchar(255),		       --����
   startdate             varchar(50),	               --��ʼ����
   enddate               varchar(50),                  --��������
   method		 int			       --1��ʾ����֤��,2��ʾ���ⷽʽ(�Ե�����);1��ʾ����,2��ʾ��������(����֤��)
);

insert into vpn_cert values ('ekeyca',4,'caissuer','casub','2005/7/8 18:00:00','2007/7/8 18:00:00',1);
insert into vpn_cert values ('ekeylocal',5,'localissuer','localsub','2005/7/8 18:00:00','2007/7/8 18:00:00',1);

--������vpn_USB֤���vpn_usbcert
create table vpn_usbcert
(
   active			BOOL,					--�Ƿ����õ���Կ�ף�1Ϊ���ã�0Ϊ����
   pin				varchar(50),  --����Կ��pin��
   status			int					--�Ƿ����ߣ�0Ϊ����,1Ϊ�����ߣ�2Ϊ���벻��ȷ��3ΪԿ�ױ�����,4Ϊekey�쳣,5Ϊû�����õ���Կ��,����չ  
);
insert into vpn_usbcert values (0,'123456',5);

--������vpn�����û���vpn_dialuser
create table vpn_dialuser
(
   name                  varchar(20) primary key,       --�û�����
   password              varchar(15),                   --����
   userip		 varchar(20),
   memo			 varchar(100)                   --��ע
);

--������pptp/l2tp����� vpn_dialserver
create table vpn_dialserver
(
   protocol              varchar(20) primary key,        --ͨѶЭ��
   ipaddr                varchar(30),                    --ip��ַ��Χ
   encrydegree           varchar(20),                    --���̶ܳ�   // low,high����֮һ
   authprotocol          varchar(20),                    --��֤Э��    //��ʽΪ����Ϊ3���ַ�����ÿһλ��0����1����ʾ�Ƿ��и�Э�飬����Э��Ϊ��chap,chapms,chapms-v2.
   active                int                             --�Ƿ�������1��ʾ������2��ʾֹͣ
);

insert into vpn_dialserver values ('p1','10.10.10.1 10.10.10.100','low','111',2);

--��������������� vpn_policy_quest
create table vpn_policy_quest
(
   ifactive               int,       --�Ƿ�������������1��ʾ������2��ʾֹͣ
   addrtype              int,        --��ַ���ͣ�1��ʾIP��ַ��2��ʾ����
   ipaddr               varchar(15),                --����ip��ַ
   domainname           varchar(50),                --��������
   gatename              varchar(31),       --��������
   gatepassw             varchar(31),       --��������
   regist           int,                    --�Ƿ�ע�ᣬ1��ʾע�ᣬ2��ʾ��ע��
   registip          varchar(20),                    --ע��ӿں�
   getintime                int,                             --�Ƿ�������ʱ��1��ʾ������2��ʾֹͣ
   timeinterval               varchar(5),                                --��ʱʱ����
   serverport           int,
   questport            int
);
insert into vpn_policy_quest values (2,'1','','','','admin123',2,'',2,'15',8585,8584);

--���������Է���� vpn_policy_server
create table vpn_policy_server
(
   ifactive               int,       --�Ƿ��������Է���1��ʾ������2��ʾֹͣ
   servername              varchar(31),        --���Է���������
   gatepassw             varchar(31),       --���Է���������
   policydist           int                    --�Ƿ��������Էַ���1��ʾ������2��ʾֹͣ
);
insert into vpn_policy_server values (2,'admin123','admin123',2);

COMMIT;
