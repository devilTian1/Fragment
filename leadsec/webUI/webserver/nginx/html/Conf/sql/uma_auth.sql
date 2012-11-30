BEGIN TRANSACTION;

create table connect_rule
(
			rule_name     CHAR(256) PRIMARY KEY,	 -- ������������
			type 	       INT,                         -- ��֤�������,1:��֤�ͻ��˼�飬0��û�п������
			c_version     TEXT,				 -- �ͻ��˰汾�ţ��Զ��ŷָ�
			c_proc_list	TEXT  				 -- �ͻ��˽��̼�飬�������֣��Զ��ŷָ�
);

create table user
(
 			user_id 		INT,  				--�û�ID��Ψһ��ʶ
			user_name		CHAR(256) PRIMARY KEY,	--�û���
			passwd			CHAR(32),			--MD5���ܺ�����
			auth_type		INT,				--0: VIP 1: local pwd 2: local cert 4: 2-fa/ cert+pw  5: 2-fa / dyn + pw
			dyn_sn			CHAR(10),			--Ψһsn��
			dyn_pass_sn		TEXT,				--sn��̬����
			true_name		CHAR(256),			--��ʵ����
			bind_ip4     		CHAR(16),           		--�󶨵�IP4��ַ
			bind_ip6     		CHAR(64),             	--�󶨵�IP6��ַ
			bind_mac		CHAR(16),			--�󶨵�MAC��ַ
			active 		INT,				--����״̬ 1: ON 0:OFF
			modify_pwd_allow 	INT,	       	     	--1: ON 0: OFF
			first_change_pwd  	INT,             		--1: ON 0: OFF
			createdate		CHAR(20),			--�û�����ʱ�䣬��ʽΪ2003/07/08
			validtime 		INT,				--�˺���Ч�������ã���λ���죬���Ϊ3650�죬0Ϊ������Ч
			connect_rule		CHAR(256),		 	--�������������
			spassdate		CHAR(20),			--���봴��ʱ��,��ʽΪ2003/12/12
			passvaliddate		INT,				--������Ч��������λ���죬���Ϊ3650�죬0Ϊ������Ч
			first_load		INT,				--�Ƿ��һ�ε�¼  1��yes   0��no
			load_fail_times	INT,				--�Ѿ���¼ʧ�ܵĴ���
			locked			INT,				--�Ƿ�����  0:no ,1: AUTO-LOCK 2: MGR-LOCK
			unlock_time	 	UNSIGNED INT, 		--�Զ�����ʱ�䣬��λ�룬0��Ϊ��������
			comment 		CHAR(255)			--�û�����
);


create table user_role_map
(
			User_id INT,    --�û�ID
			Role_id INT     --��ɫID
);


create table vpn_auth_accessorial
(
		ip4		CHAR(16),
		ip6		CHAR(64),  --Э�̵�ַ
		vpnsig	       INT, 	    --IPSEC SPI OR PPTP ID
		virtual_ip4   CHAR(16), 
		virtual_ip6   CHAR(64),
		tunnel_type	INT        -- 1:IPSEC 2: L2TP 3:PPTP
);

--//����1������Ա��administrator��
--insert into user values(1,"administrator","leadsec@7766",1,"","","","","","",1,1,0,"-/-/-",0,"","-/-/-",0,1,0,0,0,"ϵͳ����һ������Ա�û�");
--insert into user_role_map values(1,101);

create table role
(
		role_id 		INT,					--��ɫid
		role_name 		CHAR(256) PRIMARY KEY,	 	--��ɫ����
		create_by		CHAR(20),		 		--������
		create_time		CHAR(20), 				--����ʱ��
		time			UNSIGNED INT,  			--����ʱ�䣬0 Ϊ������
		always_online	       INT,			 		--��Զ���߱�ʶ��1��ON 0:OFF
		comment		CHAR(255)      		 	--ע��
);

		
--����ϵͳ����Ա��ɫ	
--insert into role values(101,"ϵͳ�����ɫ","ϵͳ����","-/-/-","/",0,1,"ϵͳ����Ա���ý�ɫ");

create table auth_policy
(
		auth_policy_id	INT,	                --��֤����ID
		auth_policy_name	CHAR(256) PRIMARY KEY,  --��֤��������
		rule_num		INT,          --�ò�������Ӧ��IPTABLES������Ŀ
		ingress		CHAR(20),     --���������ӿ��޶�,�ⲿ����
		sa_type              INT,          --Դ��ַ������1:��һIP��ַ��2��IP/���룬3����ַ�Σ�4����ַ���壬5����ַ�鶨�壬6����������ַ
		sa_id     		INT,		--Դ��ַ��ID
		ip			CHAR(64),     --IP���͵�ַ��
		netmask		CHAR(16),  	--���루�ߵ�ַ��
		port	 		CHAR(100),    --�˿��б���������10���˿ڣ��ã��ָ�
		comment		VARCHAR(255),	--ע��
		active      BOOL            --�ù����Ƿ���Ч
);


create table user_online
(
		user_id 	INT,		 --�û�ID
		ip		CHAR(64),      --��½IP
		logon_time 	CHAR(64), 	 --��½ʱ��
		online_time 	INT	 	 --����ʱ��, ��λ����
);

create table user_online_total
(
		total_num INT			--�����û�������
);
insert into user_online_total values(0);  -- ��ʼû���û�����

CREATE INDEX user_index ON user(user_id,user_name);
CREATE INDEX user_role_index ON user_role_map(User_id,Role_id);
CREATE INDEX role_index ON role(role_id,role_name);
CREATE INDEX user_online_index ON user_online(user_id);

COMMIT;

