BEGIN TRANSACTION;

create table ssluser
(
	account      varchar(20) primary key,
	password  varchar(20),
	enabled   interger,
	virtualip   varchar(20),
	locknum   interger,
	locktime  interger,
	note      varchar(100)
);

create table sslres
(
	name      varchar(20) primary key,
	address   varchar(20),
	sort   	varchar(20),	
	note      varchar(100)
);


create table allowdevice
(
	devicename    varchar(20) primary key
);

insert into allowdevice (devicename) values("fe1");

create table sslconfig
(
	active    		interger primary key,
	listenip  		varchar(20),
	proto     		varchar(10),

	listenport		interger,
	subnet			varchar(200),
	sendbuf         	interger,

	recvbuf        	 	interger,
	servermode     		interger,
	routeaddrspace		varchar(20),

	taportun		interger,
	bridgedev		varchar(20),
	bridgedhcp		interger,

	bridgeaddrspace 	varchar(20),
	iporname		interger,
	ipaddr			varchar(40),

	client2client		interger,
	clientdns		varchar(20),
	clientwins		varchar(20),

	welcomeinfo		varchar(50),
	maxuser			interger,
	float			interger,

	encryptalgid		interger,
	hashalgid		interger,
	compress		interger,

	detectperiod		interger,
	overtime		interger,
	allowping		interger,

	allowadmin		interger,
	lockmax			interger,
	lockperiod		interger,

	mtu			interger
);

insert into sslconfig (active,	listenip,proto,	
	listenport,subnet,sendbuf,
	recvbuf,servermode,routeaddrspace,
	taportun,bridgedev,bridgedhcp,
	bridgeaddrspace,iporname,ipaddr,
	client2client,	clientdns,clientwins,
	welcomeinfo,maxuser,float,
	encryptalgid,hashalgid,compress,
	detectperiod,overtime,	allowping,
	allowadmin,lockmax,lockperiod,
	mtu) 
	values(2,'any','udp',
	2299,'', 65536,
	65536, 1,'',
	2,'',1,
	'',1,'',
	2,'','',
	'欢迎使用联想网御SSLVPN',100,1,
	3,1,2,
	10,60,1,
	2,3,60,
	1300
);

create table encryptalg
(
	algid	interger primary key,
	algname	varchar(20),
	algmemo	varchar(20)
);

insert into encryptalg (algid, algname, algmemo) values (1, 'DES', 'DES-CBC');
insert into encryptalg (algid, algname, algmemo) values (2, '3DES', 'DES-EDE3-CBC');
insert into encryptalg (algid, algname, algmemo) values (3, 'AES128', 'AES-128-CBC');
insert into encryptalg (algid, algname, algmemo) values (4, 'AES192', 'AES-192-CBC');
insert into encryptalg (algid, algname, algmemo) values (5, 'AES256', 'AES-256-CBC');
insert into encryptalg (algid, algname, algmemo) values (6, 'BLOWFISH', 'BF-CBC');

create table hashalg
(
	algid	interger primary key,
	algname	varchar(20),
	algmemo	varchar(20)
);

insert into hashalg (algid, algname, algmemo) values (0, 'md5', 'MD5');
insert into hashalg (algid, algname, algmemo) values (1, 'sha', 'SHA');

create table configfile
(	
	id	interger primary key,
	content	varchar(100),
	type 	interger,
	algmemo	varchar(100)
);

insert into configfile (id, content, type, algmemo) values (0, 'float',1, 'float');
insert into configfile (id, content, type, algmemo) values (1, 'ca /etc/openvpn/ca.crt',1, 'ca');
insert into configfile (id, content, type, algmemo) values (2, 'cert /etc/openvpn/server.crt',1, 'cert');
insert into configfile (id, content, type, algmemo) values (3, 'key /etc/openvpn/server.key',1, 'key');
insert into configfile (id, content, type, algmemo) values (4, 'dh /etc/openvpn/dh1024.pem',1, 'dh');
insert into configfile (id, content, type, algmemo) values (5, 'ifconfig-pool-persist /etc/openvpn/ipp.txt',1, 'ipp');
insert into configfile (id, content, type, algmemo) values (6, 'persist-key',1, 'persist');
insert into configfile (id, content, type, algmemo) values (7, 'persist-tun',1, 'persist');
insert into configfile (id, content, type, algmemo) values (8, 'status /tmp/openvpn/openvpn-status.log 10',1, 'status');
insert into configfile (id, content, type, algmemo) values (9, 'verb 3',1, 'verb');
insert into configfile (id, content, type, algmemo) values (10, 'writepid /var/run/openvpn.pid',1, 'pidfile');
insert into configfile (id, content, type, algmemo) values (11, 'daemon openvpn',1, 'sslvpn');
insert into configfile (id, content, type, algmemo) values (12, 'mode server',1, 'server');
insert into configfile (id, content, type, algmemo) values (13, 'syslog',1, 'syslog');

insert into configfile (id, content, type, algmemo) values (100, 'client',2, 'client');
insert into configfile (id, content, type, algmemo) values (101, 'persist-key',2, 'persist');
insert into configfile (id, content, type, algmemo) values (102, 'persist-tun',2, 'persist');
insert into configfile (id, content, type, algmemo) values (103, 'ca "%SYSTEMROOT%\\leadsecsslvpn\\ca.crt"',2, 'ca');
insert into configfile (id, content, type, algmemo) values (104, 'cert "%SYSTEMROOT%\\leadsecsslvpn\\client.crt"',2, 'cert');
insert into configfile (id, content, type, algmemo) values (105, 'key "%SYSTEMROOT%\\leadsecsslvpn\\client.key"',2, 'key');

insert into configfile (id, content, type, algmemo) values (106, 'verb 3',2, 'verb');
insert into configfile (id, content, type, algmemo) values (107, 'resolv-retry infinite',2, 'resolv-retry infinite');
insert into configfile (id, content, type, algmemo) values (108, 'nobind',2, 'nobind');


create table sslvpn_monitor
(
	name		varchar(20),
	realaddr	varchar(20),
	virtaddr 	varchar(20),
	recv		varchar(100),
	send		varchar(100),
	time		varchar(100)
);

create table ipp
(
	account     	varchar(20) PRIMARY KEY,
	virtualip	varchar(20)
);

COMMIT;
