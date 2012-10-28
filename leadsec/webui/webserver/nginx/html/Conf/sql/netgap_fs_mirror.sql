BEGIN TRANSACTION;

create table system
(
	fs_mirror_status    CHAR(1)
);

insert into system values ( "0" );

create table fs_mirror_task 
(
 task_id		INT,
 cip			CHAR(15),
 cshare			CHAR(255),
 cname			CHAR(15),
 cpasswd		CHAR(15),
 sip			CHAR(15),
 sshare			CHAR(255),
 sname			CHAR(15),
 spasswd		CHAR(15),
 interval		INT
);

COMMIT;
