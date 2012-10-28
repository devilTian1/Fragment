BEGIN TRANSACTION;

create table keyinfo
(
	service_status			CHAR(1),		--服务是否开启 '1'|'0'
	keyname					CHAR(50)		--keyname
);
insert into keyinfo values ('0',"");

COMMIT;
