BEGIN TRANSACTION;
create table psynconfig
(
	keepalive  INT,
	recheck	  INT,
	log	  BOOL
);
insert into psynconfig values(1,0,1);

create table psynrungroup
(
	rungroupid	INT,
	gid1		INT,
	gid2		INT,
	startup		BOOL
);

create table psyngroup
(
	groupid 	INT,
	decision	B00L,
	action		BOOL
);

create table psynports
(
	portname	CHAR(20),
	groupid		INT
);
COMMIT;
