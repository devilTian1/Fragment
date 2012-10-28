
-- Use(Create database):
--   #rm vpn.db
--   #sqlite vpn.db<vpn.sql

BEGIN TRANSACTION;

--表名：vpn系统参数表，vpn_system_parameter
create table vpn_system_parameter
(
	version          varchar(10),                --版本信息
	ipsecif  	 varchar(15),                 --本地vpn物理接口ppp0,eth0,fwbr0
	crtconffile	int				--在隧道被修改或者增加时，是否立即生成配置文件。1表示是，2表示否。供测试并发隧道时批量加入隧道使用
);

insert into vpn_system_parameter values('version 3.0','ipsec0=eth0','1');

-- 表名: vpn缺省参数表，vpn_default_parameter
create table vpn_default_parameter
(
    ipaddr		 varchar(15),                --缺省本地vpn对外ip地址	
    domainname           varchar(50),                --缺省本地vpn域名
    nexthop              varchar(15),                --缺省本地下一跳地址
    ikelifetime          varchar(5),                 --缺省ike sa的生存周期  
    ipseclifetime        varchar(5),                 --缺省ipsec sa的生存周期
    prekey               varchar(128),               --缺省预共享密钥（8－128）
    certid               varchar(50),                --缺省本地证书id    //暂不使用
    cert                 varchar(20),                 --缺省本地证书名称
    dhcpoveripsec	int,			-- 是否启用dhcpoveripsec	
    dhcprelayip		varchar(15),		-- dhcp中继ip地址
    dhcprelaydevice	varchar(10)		-- dhcp中继设备
);

insert into vpn_default_parameter values('10.0.0.1','','','28800','3600','TypeYourPrekey','','','0','','');

--表名：vpn远程网关表，vpn_remotegateway
create table vpn_remotegateway
(
    name                 varchar(20) primary key,    --远程网关名字，唯一标识，符合命名规则
    addrtype    	 int,                        --地址类型，1表示固定ip地址，2表示域名
    ipaddr               varchar(15),                --远程网关ip地址
    domainname           varchar(50),                --远程网关域名
    authtype             int,                        --认证类型,1表示预共享密钥，2表示证书  
    prekey               varchar(128),               --预共享密钥（8－128）    
    localcert            varchar(20),                --本地证书
    cert                 varchar(20),                --远端网关证书名称   
    type                 int,                         --远程网关类型，1表示网关，2表示客户端
    ike                  varchar(15),                 --ike算法组件  × 3des-md5，3des-sha，aes128-md5，aes128-sha中的一个，默认取3des-md5
    p1dhgroup            varchar(20),                 --第一阶段交换群×
    ikelifetime          varchar(5),                  --ike生命周期 ×
    p1mode		 int,                         --隧道认证方式,1表示主模式(default)main,2表示野蛮模式 aggressive*
    localid              varchar(20),                 -- 野蛮模式本地身份标识符
    remoteid             varchar(20),                 -- 野蛮模式远程身份标识符
    xauth		 int			      -- 1表示不启用，2表示启用
    
);

--表名：vpn隧道表，vpn_tunnel
create table vpn_tunnel
(
    number               integer primary key,         --隧道索引号
    name                 varchar(20),		      --隧道名称，不许重复，符合命名规则
    localip		 varchar(15),		      --本地网关IP地址
    localdn		 varchar(50),                 --本地网关域名
    localcertid          varchar(50),                 --本地证书id     
    localcert            varchar(20),                 --本地证书名称,与上一个字段互斥
    localnexthop         varchar(15),                 --本地下一跳地址
    localsubnet          varchar(15),                 --本地保护子网
    localsubnetmask      varchar(15),                 --本地保护子网掩码
    remotename           varchar(20),                 --远程网关或客户端名称
    remoteip		 varchar(15),		      --远端IP地址
    remotedn		 varchar(50),                 --远端域名
    remotecertid         varchar(50),                 --远端网关证书id   
    remotecert           varchar(20),                 --远端网关证书名称
    remotesubnet         varchar(15),                 --远端保护子网
    remotesubnetmask     varchar(15),                 --远端保护子网掩码
    ike                  varchar(15),                 --ike算法组件  ×
    ipsec                varchar(15),                 --ipsec算法组件 3des-md5|3des-sha1|aes128-md5|aes128-sha1,默认取3des-md5  增加四种 null-md5,null-sha1,hz-md5,hz-sha1 
    pfs                  int,                         --是否完美向前保密，1表示yes，2表示no,默认yes
    auth                 int,                         --数据包封装形式，1表示esp，2表示ah,缺省esp
    compress             int,                         --数据包是否压缩，1表示压缩，2表示不压缩,缺省no
    p1dhgroup            varchar(20),                 --第一阶段交换群×
    p2dhgroup            varchar(20),                 --第二阶段交换群
    ikelifetime          varchar(5),                  --ike生命周期 ×
    ipseclifetime        varchar(5),                  --ipsec生命周期
    authtype             int,                         --认证类型,1表示预共享密钥，2表示证书  
    defaultaction        int,                         --隧道的缺省防火墙规则，1表示pass,2表示deny,默认是pass
    p1mode		 int,                         --隧道认证方式,1表示主模式(default),2表示野蛮模式    *  //暂时不使用
    type                 int,                         --隧道类型，1表示网关，2表示客户端
    active               int,                          --隧道是否启动，1表示启动，2表示停止,默认启动
    dpddelay		int,			-- dpd delaytime(s)
    dpdtimeout		int,                   -- dpd time out(s)
    initiator		int                     -- 是否作为initiator，1表示yes，2表示no,默认yes
);

--表名：vpn证书表，vpn_cert
create table vpn_cert
(
   name                  varchar(20) primary key,      --证书名称      
   type	                 int,  			       --证书类型，1表示ca证书，2表示客户端证书，3表示本地证书,4表示usb ca证书，5表示usb 本地证书 
   issuer		 varchar(255),		       --颁发者		 
   subject		 varchar(255),		       --主题
   startdate             varchar(50),	               --开始日期
   enddate               varchar(50),                  --结束日期
   method		 int			       --1表示导入证书,2表示主题方式(对等网关);1表示导入,2表示本地生成(本地证书)
);

insert into vpn_cert values ('ekeyca',4,'caissuer','casub','2005/7/8 18:00:00','2007/7/8 18:00:00',1);
insert into vpn_cert values ('ekeylocal',5,'localissuer','localsub','2005/7/8 18:00:00','2007/7/8 18:00:00',1);

--表名：vpn_USB证书表，vpn_usbcert
create table vpn_usbcert
(
   active			BOOL,					--是否启用点子钥匙，1为启用，0为禁用
   pin				varchar(50),  --点子钥匙pin码
   status			int					--是否在线，0为正常,1为不在线，2为密码不正确，3为钥匙被锁定,4为ekey异常,5为没有启用电子钥匙,可扩展  
);
insert into vpn_usbcert values (0,'123456',5);

--表名：vpn拨号用户表，vpn_dialuser
create table vpn_dialuser
(
   name                  varchar(20) primary key,       --用户名称
   password              varchar(15),                   --密码
   userip		 varchar(20),
   memo			 varchar(100)                   --备注
);

--表名：pptp/l2tp服务表 vpn_dialserver
create table vpn_dialserver
(
   protocol              varchar(20) primary key,        --通讯协议
   ipaddr                varchar(30),                    --ip地址范围
   encrydegree           varchar(20),                    --加密程度   // low,high其中之一
   authprotocol          varchar(20),                    --认证协议    //格式为长度为3的字符串，每一位是0或者1，表示是否有该协议，三种协议为：chap,chapms,chapms-v2.
   active                int                             --是否启动，1表示启动，2表示停止
);

insert into vpn_dialserver values ('p1','10.10.10.1 10.10.10.100','low','111',2);

--表名：策略请求表 vpn_policy_quest
create table vpn_policy_quest
(
   ifactive               int,       --是否启动策略请求，1表示启动，2表示停止
   addrtype              int,        --地址类型，1表示IP地址，2表示域名
   ipaddr               varchar(15),                --网关ip地址
   domainname           varchar(50),                --网关域名
   gatename              varchar(31),       --网关名称
   gatepassw             varchar(31),       --网关密码
   regist           int,                    --是否注册，1表示注册，2表示不注册
   registip          varchar(20),                    --注册接口号
   getintime                int,                             --是否启动定时，1表示启动，2表示停止
   timeinterval               varchar(5),                                --定时时间间隔
   serverport           int,
   questport            int
);
insert into vpn_policy_quest values (2,'1','','','','admin123',2,'',2,'15',8585,8584);

--表名：策略服务表 vpn_policy_server
create table vpn_policy_server
(
   ifactive               int,       --是否启动策略服务，1表示启动，2表示停止
   servername              varchar(31),        --策略服务器名称
   gatepassw             varchar(31),       --策略服务器密码
   policydist           int                    --是否启动策略分发，1表示启动，2表示停止
);
insert into vpn_policy_server values (2,'admin123','admin123',2);

COMMIT;
