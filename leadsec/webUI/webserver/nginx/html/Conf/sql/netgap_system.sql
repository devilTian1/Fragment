BEGIN TRANSACTION;

create table system
(
	host			CHAR(1),	--'I': in host  'O':out	host
	http_status		CHAR(1),	--0:off 1:on			
	ftp_status		CHAR(1),			
	smtp_status		CHAR(1),
	pop3_status		CHAR(1),
	db_status		CHAR(1),
	ctcp_status		CHAR(1),			
	cgtcp_status		CHAR(1),			
	cudp_status		CHAR(1),
	sync_status		CHAR(1),
	multicast_status       CHAR(1),
	ha_status		CHAR(1),
	lvs_status              CHAR(1),
	db_swap_status CHAR(1), --���ݿ�ͬ������״̬
	fastpass_status		CHAR(1),	--0:off 1:on, ���Ʒ���ģ�����ͨ������(�ڲ�ʹ��)
	ddos_status		CHAR(1),	--0:off 1:on
	in_ip			CHAR(15),
	out_ip			CHAR(15),
	swap_if			CHAR(6),
	fs_new_status CHAR(1),
	mctcp_status		CHAR(1),
	hardware_warning		CHAR(1),  --Ӳ�����汨��
 	mcudp_status		CHAR(1)
);

insert into system values ( "O","0", "0", "0", "0","0", "0","0", "0", "0", "0", "0", "0", "0", "0", "1", "127.1.0.1", "127.1.0.2", "eth6", "0", "0", "0","0");
 
COMMIT;
