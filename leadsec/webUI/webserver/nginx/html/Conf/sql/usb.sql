BEGIN TRANSACTION;

create table keyinfo
(
	service_status			CHAR(1),		--�����Ƿ��� '1'|'0'
	keyname					CHAR(50)		--keyname
);
insert into keyinfo values ('0',"");

COMMIT;
