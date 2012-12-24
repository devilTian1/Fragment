BEGIN TRANSACTION;
create table ha_ip_detect 
(
	ip          CHAR(15) PRIMARY KEY,	--Ì½²âIP		
 	comment     VARCHAR(255)			--×¢ÊÍ	
);
COMMIT;

