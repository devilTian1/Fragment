
create table auth_server_info(
				workmode integer PRIMARY KEY,  --��֤��ʽ 1:������֤|2:ldap|3:radius|4:ad
				ip char(16),                    --������֤��������ip��ַ
				timeout integer,		    --��ʱ�ش�ʱ�䣬3��10��
				authport integer,                --������֤����������֤�˿�
				auditport integer,               --������֤��������ƶ˿�
				secret char(16),                 -- ������Կ
				basename char(200),              --��׼��
				managername char(50),            --����Ա��            
				managersecret char(50),          --����Ա����
				type char(10),                   --��֤��ʽ
				dnmode char(200),                --DNģʽ
				realm char(200),                 --AD����
				netbios char(50),                --AD��������netbios��
				redirecturl char(255),            --�ض���url
				localport integer,               --������֤�˿�,Ĭ��9998
				log integer                      --�Ƿ�������־ 1:on��0:off Ĭ��0
);

insert into auth_server_info values(1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://10.1.5.254:10008/cgi-bin/webui?op=pcm_auth_check_online',9998,0);



create table auth_config_info(
				forcemodify integer,            --�״ε�¼ǿ���޸�����,1:yes��0:no
				pwdcomplex integer,             --���븴�Ӷ� 1:��|2:����|3:һ��|4:�Ϻ�|5:�ܺ�|6:����
				maxloadtimes integer,           --����Ե�¼����,Ĭ��5��
				unlocktime integer,             --�Զ�����ʱ�䣬��λ�����ӣ�Ĭ��10
				pwdperiod integer,              --������Ч�ڣ���λ���죬0��������Ч Ĭ��0
				pwdremind integer,              --���뵽�����ѣ�Ĭ�ϣ�7����λ��
				idletime integer                --������ʱ��,��λ������
);

insert into auth_config_info values(0,3,5,10,0,7,0);


