BEGIN TRANSACTION;
create table ha_ip_detect 
(
	ip          CHAR(15) PRIMARY KEY,	--̽��IP		
 	comment     VARCHAR(255)			--ע��	
);
COMMIT;

