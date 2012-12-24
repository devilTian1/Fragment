BEGIN TRANSACTION;


create table basic_configure
(
	role			CHAR(1),  --'M':master 'S':slave 'N':node
	mode			CHAR(1),  --'P':preempt mode 'N':nonpreempt mode
	ifcfg			CHAR(1),  --'D':disable physical net work device 'E':not disable
	peer_ha_ip		CHAR(15), --peer gap ha ip address
	peer_ha_port	INT,		  --peer gap ha port number
    interval        INT
);

insert into basic_configure (role, mode, ifcfg, peer_ha_ip, peer_ha_port) values ('M', 'P', 'E', '0.0.0.0',8000);

create table lvs_basic
(
	role			CHAR(1)  --'D':director 'N':node
);

insert into lvs_basic (role) values ('D');

create table haif 
(
	ifname	CHAR(15)	--network interface alias name
);

create table service 
(
	id					INT,
	virtual_ip	CHAR(15),
	virtual_port	INT,
	real_ip		CHAR(15),
	real_port	INT
);	

COMMIT;
