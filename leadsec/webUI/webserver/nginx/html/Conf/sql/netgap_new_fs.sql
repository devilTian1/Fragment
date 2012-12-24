BEGIN TRANSACTION;


--文件交换客户端配置表--
create table sync_file_client
(	
	id						INTEGER PRIMARY KEY,		--序号
	sa						CHAR(50),								--源地址对象
	lip						CHAR(50),								--本机地址
	lport					INT,										--本机端口       
	mode					CHAR(1),								--处理模式：Q:快速转发、B:本地备份
	ssl						CHAR(1),								--是否采用SSL加密: 'Y'/'N' 
	commname		VARCHAR(255),			--对端证书共公名
	killvirus			CHAR(1),								--是否采扫描病毒: 'Y'/'N'
	time					CHAR(50),								--时间对象
        ip_ver                      CHAR(10),
	seclevel			INT,
	comment				VARCHAR(255)
);

--文件交换同步服务端配置表--
create table sync_file_server
(	
	id						INTEGER PRIMARY KEY,		--序号
	serverip			CHAR(50),								--服务器（外部服务）地址对象
	sport					INT,										--服务器（外部服务）端口	     
	mode					CHAR(1),								--处理模式：Q:快速转发、B:本地备份
	ssl						CHAR(1),								--是否采用SSL加密: 'Y'/'N'   
	commname		VARCHAR(255),			--对端证书共公名
        ip_ver                      CHAR(10),
	comment				VARCHAR(255)						--描述信息
);

create table basic_configure
(
	bin_file		CHAR(1),	--'A':Allow  'F':Forbid
	blacklist		CHAR(1),	--'Y':on     'N':off
	whitelist		CHAR(1),	--'Y':on     'N':off
	namefilter	CHAR(1),	--'Y':on     'N':off
	syncmode		CHAR(1)		--'B':Both 'R':Recv 'S':Send   
);                                                            

insert into basic_configure (bin_file, blacklist, whitelist, namefilter, syncmode) values ('A','N','N','N','B');

create table allowedfile
(
	id				INT,
	filename	CHAR(64),
	comment		CHAR(255)
);

create table context
(
	id							INT,
	context					CHAR(15),
	allow						BOOL,
	comment         CHAR(255)
);




COMMIT;
