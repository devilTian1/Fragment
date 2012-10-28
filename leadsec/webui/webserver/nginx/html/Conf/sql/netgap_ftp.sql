BEGIN TRANSACTION;

create table basic_configure 
(
	service_ip	CHAR(15),
	service_port	INT,
	trans_mode	CHAR(1),        --N:no-trans P:passive-->active
					--A:active-->passive
	cn_file_valid	BOOL,		--if allow chinese file name
	little_port_valid	BOOL	--if allow data connection port<1024  
);

insert into basic_configure values ("novalue", 21, "N", 1, 1);

create table acl 
(
	id	INT,
	sip	CHAR(15),
	dip	CHAR(15),
	port	INT,
	usergrp		CHAR(50),	--认证用户组,added at 2008-3-7
	alias	CHAR(20),
	rip		CHAR(15),
	rport	INT,
	time	CHAR(15),
	transparent	BOOL,
	comment	VARCHAR(255)
);

create table cf_info
(
	user_mode	CHAR(1),	--F:full forbid. A:full allow.
	cmd_mode	CHAR(1),	--F:full forbid. A:full allow.
	upload_mode	CHAR(1),	--F:full forbid. A:full allow.
	download_mode	CHAR(1)		--F:full forbid. A:full allow.
);

insert into cf_info values ("A", "A", "A", "A");

create table ftp_cmd 
(
	name	CHAR(15),
	allow	BOOL,
	ischeck	BOOL
);

insert into ftp_cmd (name, allow, ischeck) values ("PORT", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PASV", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ABOR", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("USER", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PASS", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ACCT", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("CWD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("CDUP", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SMNT", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("QUIT", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("REIN", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("TYPE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STRU", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MODE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RETR", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STOR", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STOU", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("APPE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ALLO", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("REST", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RNFR", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RNTO", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("DELE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RMD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MKD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PWD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("LIST", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NLST", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SITE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SYST", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STAT", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("HELP", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NOOP", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SIZE", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MDTM", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MLFL", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MAIL", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MSND", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MSOM", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NSAM", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MRSQ", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MRCP", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XCWD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XMKD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XRMD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XPWD", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XCUP", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("APSV", 1, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PORT", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PASV", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ABOR", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("USER", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PASS", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ACCT", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("CWD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("CDUP", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SMNT", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("QUIT", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("REIN", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("TYPE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STRU", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MODE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RETR", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STOR", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STOU", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("APPE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("ALLO", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("REST", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RNFR", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RNTO", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("DELE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("RMD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MKD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("PWD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("LIST", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NLST", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SITE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SYST", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("STAT", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("HELP", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NOOP", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("SIZE", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MDTM", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MLFL", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MAIL", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MSND", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MSOM", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("NSAM", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MRSQ", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("MRCP", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XCWD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XMKD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XRMD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XPWD", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("XCUP", 0, 0);
insert into ftp_cmd (name, allow, ischeck) values ("APSV", 0, 0);

create table user
(
	name	CHAR(15),
	allow	BOOL
);

create table postfix
(
	name	CHAR(15),
	direction	CHAR(1),	--'U':Upload   'D':Download
	allow	BOOL
);

COMMIT;

