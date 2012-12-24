BEGIN TRANSACTION;

create table anti_attack_table
(
	anti_name	CHAR(20),
	action		CHAR(20)
);
insert into anti_attack_table values('smurf', 'off');
insert into anti_attack_table values('land', 'off');
insert into anti_attack_table values('winnuke', 'off');
insert into anti_attack_table values('queso', 'off');
insert into anti_attack_table values('sf_scan', 'off');
insert into anti_attack_table values('null_scan', 'off');
insert into anti_attack_table values('full_xmas_scan', 'off');
insert into anti_attack_table values('xmas_scan', 'off');
insert into anti_attack_table values('ipspoofing', 'off');
insert into anti_attack_table values('sroute', 'off');


create table anti_arp_table
(
	dev	char(16) PRIMARY KEY,
	ip	char(16),
	mask	char(16),
	action	char(16)
);

create table anti_ipconflict_table
(
	dev	char(16),
	ip	char(16),
	mask	char(16),
	action	char(16)
);

create table anticcstatus
(
	status  INTEGER -- 0: stop, 1: start
 );
insert into anticcstatus values('0');

create table anti_cc_table
(
	id	INTEGER PRIMARY KEY,
	ip	CHAR(20),  
	mask	CHAR(15)         
);

create table anti_ipcheat_table
(
	dev	char(16) PRIMARY KEY,
	action	char(16)
);

create table anti_sync_table
(
	action		char(16),
	interval	integer
);
insert into anti_sync_table values("off", 10);

create table anti_config_table
(
 	anti_name	char(20) PRIMARY KEY,
	action		char(20)
);

insert into anti_config_table values("anti_attack", 'off');
insert into anti_config_table values("anti_cc", 'off');

COMMIT;
