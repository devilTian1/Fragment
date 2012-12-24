
create table auth_server_info(
				workmode integer PRIMARY KEY,  --认证方式 1:本地认证|2:ldap|3:radius|4:ad
				ip char(16),                    --代理认证服务器的ip地址
				timeout integer,		    --超时重传时间，3～10秒
				authport integer,                --代理认证服务器的认证端口
				auditport integer,               --代理认证服务器审计端口
				secret char(16),                 -- 共享密钥
				basename char(200),              --基准名
				managername char(50),            --管理员名            
				managersecret char(50),          --管理员口令
				type char(10),                   --认证方式
				dnmode char(200),                --DN模式
				realm char(200),                 --AD域名
				netbios char(50),                --AD服务器的netbios名
				redirecturl char(255),            --重定向url
				localport integer,               --本地认证端口,默认9998
				log integer                      --是否启用日志 1:on，0:off 默认0
);

insert into auth_server_info values(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://10.1.5.254:10008/cgi-bin/webui?op=pcm_auth_check_online',9998,0);



create table auth_config_info(
				forcemodify integer,            --首次登录强制修改密码,1:yes，0:no
				pwdcomplex integer,             --密码复杂度 1:无|2:较弱|3:一般|4:较好|5:很好|6:极佳
				maxloadtimes integer,           --最大尝试登录次数,默认5次
				unlocktime integer,             --自动解锁时间，单位：分钟，默认10
				pwdperiod integer,              --密码有效期，单位：天，0：永久有效 默认0
				pwdremind integer,              --密码到期提醒，默认：7，单位天
				idletime integer                --最大空闲时间,单位：分钟
);

insert into auth_config_info values(0,3,5,10,0,7,0);


