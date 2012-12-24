--2004/12/24	zhuxp	创建
--域名地址名称和IP地址的对应表
BEGIN TRANSACTION; 
create table domain_ip
(
	name	CHAR(20),		--资源名称
	dynamic	INT,			--手动填写或自动解析
	ip		CHAR(16),		--IP地址
	time	INT,			--最后一次更新时间
	expire	INT				--域名失效时间，单位：秒，0为不失效
);

COMMIT;
