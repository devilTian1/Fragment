BEGIN TRANSACTION;

create table dir_info 
(
	task_id		INT,
	mode		CHAR(1),	--C:client  S:server
	ip		CHAR(15),
	share_name	CHAR(255),
	fs		CHAR(6),	--smbfs  nfs
	user		CHAR(15),
	password	CHAR(15),
	method		CHAR(1),	--'C':ChangeName 'R':Remove 'S':Sync
	subdir		CHAR(1),
	killvirus	CHAR(1),
	interval	INT,
	time		CHAR(15),
	ready_string	CHAR(20),
	complete_string	CHAR(20),
	active		CHAR(1),
	filter		CHAR(30)
);

create table basic_configure
(
	bin_file	CHAR(1),	--'A':Allow  'F':Forbid
	blacklist	CHAR(1),	--'Y':on     'N':off
	whitelist	CHAR(1),	--'Y':on     'N':off
	namefilter	CHAR(1),	--'Y':on     'N':off
	syncmode	CHAR(1),		--'B':Both 'R':Recv 'S':Send
	filestat		CHAR(1)					--'Y':on     'N':off
);

insert into basic_configure (bin_file, blacklist, whitelist, namefilter, syncmode, filestat) values ('A','N','N','N','B','N');

create table allowedfile
(
	id		INT,
	name	char(20),
	filename	text,
	comment		varchar(255)
);

create table context
(
	id		INT,
	name	char(20),
	context		text,
	allow		BOOL,
	comment     varchar(255)
);

--文件属性过滤表--
create table filestat
(
	action		CHAR(1),
	ftype		CHAR(64),
	timemax		CHAR(20),
	timemin		CHAR(20),
	sizemax		INT,
	sizemin		INT,
	userstep	CHAR(20),
	userlen		CHAR(20),
	userkey		CHAR(20)
);

create table filter
(
	id		INT,
	name	char(20),
	filename	char(20),
	blacklist	char(20),
	whitelist	char(20),
	action      CHAR(1),
	ftype       CHAR(64),
	timemax     CHAR(20),
	timemin     CHAR(20),
	sizemax     INT,
	sizemin     INT
);

insert into filestat (action, ftype, timemax, timemin, sizemax, sizemin,userstep,userlen,userkey) values ('F','','','',0,0,'','','');


COMMIT;
