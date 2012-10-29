BEGIN TRANSACTION;

create table system
(
	ftp_pri       CHAR(1),  --L:low M:middle H:high 
	ftp_status    CHAR(1)   --0 or 1
);
insert into system values ("L", "0");

create table ftp_trans_client_acl 
(
	id		INTEGER PRIMARY KEY,
	sa		CHAR(50),
	da		CHAR(50),		
	dport		CHAR(12),	
	usergrp		CHAR(50),
	time		CHAR(50),
	filter		CHAR(15),
	active		CHAR(1),
	comment		VARCHAR(255)
);

create table ftp_comm_client_acl 
(
	id			INTEGER PRIMARY KEY,	--
	sa			CHAR(50),				--
	lip			CHAR(50),				--
	lport		INT,					--
	usergrp		CHAR(50),				--
	time		CHAR(50),				--
	filter      CHAR(15),               
	active      CHAR(1),
	comment		VARCHAR(255)			--
);

create table ftp_comm_server_acl 
(
	id			INTEGER PRIMARY KEY,	--
	serverip	CHAR(50),				--
	sport		INT,					--
	active		CHAR(1),
	comment		VARCHAR(255)			--
);

create table options
(
	id			INT,
	name		CHAR(15),
	user_info	VARCHAR(256),
	user_act	CHAR(1),
	cmd_info	VARCHAR(256),
	cmd_act		CHAR(1),
	down_info	VARCHAR(256),
	down_act	CHAR(1),
	upload_info	VARCHAR(256),
	upload_act	CHAR(1),
	file_size	INT,
	size_act	CHAR(1),
	virus		CHAR(1),
	keepalive	CHAR(1),
	banner_on	CHAR(1),
	banner		VARCHAR(256),
	comment		VARCHAR(256)
);

create table cmd_list
(
	usrcmd	CHAR(10),
	syscmd	CHAR(10)
);

insert into cmd_list (usrcmd, syscmd) values ("dir", "LIST");
insert into cmd_list (usrcmd, syscmd) values ("delete", "DELE");
insert into cmd_list (usrcmd, syscmd) values ("ls", "NLST");
insert into cmd_list (usrcmd, syscmd) values ("cd", "CWD");
insert into cmd_list (usrcmd, syscmd) values ("get", "RETR");
insert into cmd_list (usrcmd, syscmd) values ("put", "STOR");
insert into cmd_list (usrcmd, syscmd) values ("pwd", "XPWD");
--insert into cmd_list (usrcmd, syscmd) values ("bin", "TYPE-I");
--insert into cmd_list (usrcmd, syscmd) values ("ascii", "TYPE-A");
--insert into cmd_list (usrcmd, syscmd) values ("bye", "QUIT");
--insert into cmd_list (usrcmd, syscmd) values ("close", "QUIT");
insert into cmd_list (usrcmd, syscmd) values ("quit", "QUIT");
insert into cmd_list (usrcmd, syscmd) values ("mkdir", "XMKD");
insert into cmd_list (usrcmd, syscmd) values ("rename", "RNFR");
insert into cmd_list (usrcmd, syscmd) values ("rmdir", "XRMD");
insert into cmd_list (usrcmd, syscmd) values ("append", "APPE");
COMMIT;
