BEGIN TRANSACTION;

create table connect_rule
(
			rule_name     CHAR(256) PRIMARY KEY,	 -- 接入规则的名字
			type 	       INT,                         -- 认证检查类型,1:认证客户端检查，0：没有开启检查
			c_version     TEXT,				 -- 客户端版本号，以逗号分隔
			c_proc_list	TEXT  				 -- 客户端进程检查，进程名字，以逗号分隔
);

create table user
(
 			user_id 		INT,  				--用户ID，唯一标识
			user_name		CHAR(256) PRIMARY KEY,	--用户名
			passwd			CHAR(32),			--MD5加密后密码
			auth_type		INT,				--0: VIP 1: local pwd 2: local cert 4: 2-fa/ cert+pw  5: 2-fa / dyn + pw
			dyn_sn			CHAR(10),			--唯一sn号
			dyn_pass_sn		TEXT,				--sn动态口令
			true_name		CHAR(256),			--真实姓名
			bind_ip4     		CHAR(16),           		--绑定的IP4地址
			bind_ip6     		CHAR(64),             	--绑定的IP6地址
			bind_mac		CHAR(16),			--绑定的MAC地址
			active 		INT,				--启用状态 1: ON 0:OFF
			modify_pwd_allow 	INT,	       	     	--1: ON 0: OFF
			first_change_pwd  	INT,             		--1: ON 0: OFF
			createdate		CHAR(20),			--用户创建时间，格式为2003/07/08
			validtime 		INT,				--账号有效期限设置，单位：天，最大为3650天，0为永久有效
			connect_rule		CHAR(256),		 	--接入检查规则设置
			spassdate		CHAR(20),			--密码创建时间,格式为2003/12/12
			passvaliddate		INT,				--密码有效天数，单位：天，最大为3650天，0为永久有效
			first_load		INT,				--是否第一次登录  1：yes   0：no
			load_fail_times	INT,				--已经登录失败的次数
			locked			INT,				--是否被锁定  0:no ,1: AUTO-LOCK 2: MGR-LOCK
			unlock_time	 	UNSIGNED INT, 		--自动解锁时间，单位秒，0：为永久锁定
			comment 		CHAR(255)			--用户描述
);


create table user_role_map
(
			User_id INT,    --用户ID
			Role_id INT     --角色ID
);


create table vpn_auth_accessorial
(
		ip4		CHAR(16),
		ip6		CHAR(64),  --协商地址
		vpnsig	       INT, 	    --IPSEC SPI OR PPTP ID
		virtual_ip4   CHAR(16), 
		virtual_ip6   CHAR(64),
		tunnel_type	INT        -- 1:IPSEC 2: L2TP 3:PPTP
);

--//内置1级管理员（administrator）
--insert into user values(1,"administrator","leadsec@7766",1,"","","","","","",1,1,0,"-/-/-",0,"","-/-/-",0,1,0,0,0,"系统内置一级管理员用户");
--insert into user_role_map values(1,101);

create table role
(
		role_id 		INT,					--角色id
		role_name 		CHAR(256) PRIMARY KEY,	 	--角色名称
		create_by		CHAR(20),		 		--创建者
		create_time		CHAR(20), 				--创建时间
		time			UNSIGNED INT,  			--分配时间，0 为无限制
		always_online	       INT,			 		--永远在线标识，1：ON 0:OFF
		comment		CHAR(255)      		 	--注释
);

		
--内置系统管理员角色	
--insert into role values(101,"系统管理角色","系统内置","-/-/-","/",0,1,"系统管理员内置角色");

create table auth_policy
(
		auth_policy_id	INT,	                --认证策略ID
		auth_policy_name	CHAR(256) PRIMARY KEY,  --认证策略名称
		rule_num		INT,          --该策略所对应的IPTABLES规则数目
		ingress		CHAR(20),     --流入的网络接口限定,外部名称
		sa_type              INT,          --源地址的类型1:单一IP地址，2：IP/掩码，3：地址段，4：地址定义，5：地址组定义，6：服务器地址
		sa_id     		INT,		--源地址的ID
		ip			CHAR(64),     --IP（低地址）
		netmask		CHAR(16),  	--掩码（高地址）
		port	 		CHAR(100),    --端口列表，最多可输入10个端口，用，分隔
		comment		VARCHAR(255),	--注释
		active      BOOL            --该规则是否生效
);


create table user_online
(
		user_id 	INT,		 --用户ID
		ip		CHAR(64),      --登陆IP
		logon_time 	CHAR(64), 	 --登陆时间
		online_time 	INT	 	 --在线时间, 单位分钟
);

create table user_online_total
(
		total_num INT			--在线用户的数量
);
insert into user_online_total values(0);  -- 初始没有用户在线

CREATE INDEX user_index ON user(user_id,user_name);
CREATE INDEX user_role_index ON user_role_map(User_id,Role_id);
CREATE INDEX role_index ON role(role_id,role_name);
CREATE INDEX user_online_index ON user_online(user_id);

COMMIT;

