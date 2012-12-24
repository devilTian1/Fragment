
-- Use(Create database):
--   #sqlite message.db < message.sql

-- History:
-- 8. zhuxp	2004/1/31
--	  ɾ����fwips��������д��interface�������
-- 7. liype 2003/12/31
--    ����Themis
-- 6. xiaowj 2003/11/28
--    �������滻����
-- 5. xiaowj 2003/11/27
--    �������滻����
-- 4. xiaowj 2003/11/25
--    �������޸ı��⣬������һЩ��¼
-- 3. xiaowj 2003/11/18
--    �������޸ı��⣬������һЩ��¼
-- 2. xiaowj 2003/11/03 
--    �������ύȫ�µ����ݿ⣬���κ�˵����Ҫ���滻
-- 1. liutr 2003/09/22 ����


BEGIN TRANSACTION;


-- ����: public
create table public
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into public values (1, 'Error: invalid keyword "%s"', '������Ч�Ĺؼ���"%s"');
insert into public values (2, 'Error: file "%s" does not exist', '�����ļ�"%s"������');
insert into public values (3, 'Error: network interface "%s" does not exist', '��������ӿ�"%s"������');
insert into public values (4, 'Error: network interface "%s" is disabled according to license', '�������֤��������ӿ�"%s"');
insert into public values (5, 'Error: database error','�������ݿ����');
insert into public values (6, 'Error: ip address error','����IP��ַ����');

-- ����: address
create table address
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into address values (1, 'Error: address group "%s" already exists', '���󣺵�ַ��"%s"�Ѵ���');
insert into address values (2, 'Error: address "%s" already exists', '���󣺵�ַ"%s"�Ѵ���');
insert into address values (3, 'Error: address "%s" does not exist', '���󣺵�ַ"%s"������');
insert into address values (4, 'Error: address "%s" is in use', '���󣺵�ַ"%s"�ѱ�ʹ��');
insert into address values (5, 'Error: address "%s" is used in SAT by rule and all the IP addresses in it must be firewall IP address', '���󣺵�ַ"%s"�ѱ���ȫ�����SATʹ�ã�����������IP��ַ���붼�ǰ�ȫ���ص�IP��ַ');

-- ����: addrgrp
create table addrgrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into addrgrp values (1, 'Error: address "%s" already exists', '���󣺵�ַ"%s"�Ѵ���');
insert into addrgrp values (2, 'Error: address group "%s" already exists', '���󣺵�ַ��"%s"�Ѵ���');
insert into addrgrp values (3, 'Error: address group "%s" does not exist', '���󣺵�ַ��"%s"������');
insert into addrgrp values (4, 'Error: address group "%s" is in use', '���󣺵�ַ��"%s"�ѱ�ʹ��');
insert into addrgrp values (5, 'Notice: address "%s" does not exist', 'ע�⣺��ַ"%s"������');
insert into addrgrp values (6, 'Notice: address "%s" is already a member of address group "%s"', 'ע�⣺��ַ"%s"���ǵ�ַ��"%s"�ĳ�Ա');
insert into addrgrp values (7, 'Notice: address "%s" is not a member of address group "%s"', 'ע�⣺��ַ"%s"���ǵ�ַ��"%s"�ĳ�Ա');
insert into addrgrp values (8, 'Notice: address group "%s" is used in SAT by rule and all the IP addresses in it must be firewall IP address, address "%s" is not added', '���󣺵�ַ"%s"�ѱ���ȫ�����SATʹ�ã�����������IP��ַ���붼�ǰ�ȫ���ص�IP��ַ����ַ"%s"δ�����');

-- ����: admacct
create table admacct
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into admacct values (1, 'Error: account "%s" already exists', '�����˻�"%s"�Ѵ���');
insert into admacct values (2, 'Error: account "%s" does not exist', '�����˻�"%s"������');
insert into admacct values (3, 'Error: account "%s" can not be deleted', '�����˻�"%s"���ܱ�ɾ��');
insert into admacct values (4, 'Error: account "%s" is not available', '�����˻�"%s"������');

-- ����: admcert
create table admcert
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into admcert values (1, 'Error: file "%s" is not a PEM certificate file', '�����ļ�"%s"����PEM֤���ļ�');
insert into admcert values (2, 'Error: certificates are not match', '����֤�鲻ƥ��');
insert into admcert values (3, 'Error: certificate "%s" already exists', '����֤��"%s"�Ѵ���');
insert into admcert values (4, 'Error: certificate "%s" does not exist', '����֤��"%s"������');
insert into admcert values (5, 'Error: certificate "%s" is in use', '����֤��"%s"�ѱ�ʹ��');
insert into admcert values (6, 'Notice: certificate "%s" is already on', 'ע�⣺֤��"%s"�ѱ�����');
insert into admcert values (7, 'Notice: certificate "%s" is already off', 'ע�⣺֤��"%s"�ѱ�����');

-- ����: admhost
create table admhost
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into admhost values (1, 'Error: administration host IP address "%s" already exists', '���󣺹�������IP��ַ"%s"�Ѵ���');
insert into admhost values (2, 'Error: administration host IP address "%s" does not exist', '���󣺹�������IP��ַ"%s"������');
insert into admhost values (3, 'Error: administration host amount can not exceed %d', '���󣺹����������������ܳ���%d');

-- ����: admmode
create table admmode
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into admmode values (1, 'Notice: administration mode PPP is already started', 'ע�⣺PPP����ʽ������');
insert into admmode values (2, 'Notice: administration mode console is already stopped', 'ע�⣺����̨����ʽ��ֹͣ');
insert into admmode values (3, 'Notice: administration mode SSH is already started', 'ע�⣺SSH����ʽ������');
insert into admmode values (4, 'Notice: administration mode SSH is already stopped', 'ע�⣺SSH����ʽ��ֹͣ');
insert into admmode values (5, 'Error: administration mode PPP is enabled', '����PPP����ʽ������');

-- ����: antiatk
create table antiatk
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into antiatk values (1, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');
insert into antiatk values (2, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');
insert into antiatk values (3, 'Error: SYN speed value must be from 0 to 65535', '����SYN�����ʱ�����0��65535֮��');
insert into antiatk values (4, 'Error: ICMP speed value must be from 0 to 65535', '����ICMP�����ʱ�����0��65535֮��');
insert into antiatk values (5, 'Error: ICMP length value must be from 0 to 65535', '����ICMP�����ȱ�����0��65535֮��');
insert into antiatk values (6, 'Error: UDP speed value must be from 0 to 65535', '����UDP�����ʱ�����0��65535֮��');

-- ����: authserver
create table authserver
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into authserver values (1, 'Notice: local authentication server is already enabled', 'ע�⣺������֤�������Ѿ�����');
insert into authserver values (2, 'Notice: RADIUS authentication server is already enabled', 'ע�⣺RADIUS��֤�������Ѿ�����');

-- ����: bandwidth
create table bandwidth
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into bandwidth values (0, 'Notice: excution success', 'ע�⣺ִ�гɹ�');
insert into bandwidth values (1, 'Error: command line error','���������в�������');
insert into bandwidth values (2, 'Error: database error','���󣺲������ݿ����');
insert into bandwidth values (3, 'Error: data does not exist','�������ݲ�����');
insert into bandwidth values (4, 'Error: data exist','���������Ѿ�����');
insert into bandwidth values (5, 'Error: data exceed max limit','�������ݳ����������');
insert into bandwidth values (6, 'Error: memory error','�����ڴ����');
insert into bandwidth values (7, 'Error: logic check error','�����߼�������');
insert into bandwidth values (8, 'Error: system command error','����ϵͳ�������');
insert into bandwidth values (10, 'Error: error-> %s','���󣺴����� %s');
insert into bandwidth values (11, 'Error: name %s already exists', '��������%s�Ѵ��ڣ��뻻һ�����ظ�������');
insert into bandwidth values (12, 'Error: maximum bandwidth must be equal or larger than minimum bandwidth', '���������������ڻ���ڱ�֤����');
insert into bandwidth values (13, 'Error: parent minimum bandwidth overflow ', '���󣺱�֤����Խ��');
insert into bandwidth values (14, 'Error: parent maximum bandwidth overflow, exceed network dev bandwidth ', '����������Խ�磬���������豸�趨�Ĵ���');
insert into bandwidth values (15, 'Error: please input name ', '�����������޸��������');
insert into bandwidth values (16, 'Error: bandwidth parent %s does not exist ', '����%s ������');
insert into bandwidth values (17, 'Error: bandwidth parent %s exceed max child num  ', '����%s ӵ�����������������ֵ');
insert into bandwidth values (18, 'Error: device %s exceed max parent num  ', '�����豸%s ӵ�����������������ֵ');
insert into bandwidth values (19, 'Error: bandwidth parent %s is referenced %d, can not be deleted ', '����%s ������%d�������ܱ�ɾ�� ');
insert into bandwidth values (20, 'Error: bandwidth group exceed max num !', '���󣺴�����Դ�鳬���������');
insert into bandwidth values (21, 'Error: bandwidth group %s does not exist ', '���󣺴�����Դ��%s������');
insert into bandwidth values (22, 'Error: bandwidth group %s add member %s fail, maybe member does not exist ', '���󣺴�����Դ��%s��ӳ�Ա%sʧ�ܣ�ԭ������ǳ�Ա������');
insert into bandwidth values (23, 'Error: bandwidth group %s del member %s fail, maybe member does not exist ', '���󣺴�����Դ��%sɾ����Ա%sʧ�ܣ�ԭ������ǳ�Ա������');
insert into bandwidth values (24, 'Error: bandwidth group %s is referenced by %d group members, can not be deleted ', '����%s ��%d��Ա���ã����ܱ�ɾ�� ');
insert into bandwidth values (25, 'Error: bandwidth child %s is referenced %d, can not be deleted ', '����%s ������%d�������ܱ�ɾ�� ');
insert into bandwidth values (26, 'Error: bandwidth priority value must be 1 - 7 ', '���󣺴������ȼ�����Ϊ1-7֮�����ֵ');
insert into bandwidth values (27, 'Error: bandwidth group %s is referenced by %d bwrules, can not be deleted ', '����%s ��%d������������ã����ܱ�ɾ�� ');
insert into bandwidth values (28, 'Error: child minimum bandwidth overflow ', '���󣺱�֤����Խ��');
insert into bandwidth values (29, 'Error: child maximum bandwidth overflow, exceed parent max bandwidth ', '�����Ӵ�������������������������');
insert into bandwidth values (30, 'Error: sum of childs minimum bandwidth overflow, exceed parent max bandwidth ', '�����Ӵ���ı�֤����֮�ͳ����������������');
insert into bandwidth values (31, 'Error: sum of parent maximum bandwidth overflow, exceed network dev bandwidth ', '����ͬһ�����豸�Ĵ���֮��Խ�磬���������豸�趨�Ĵ���');

-- ����: bw
create table bw
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into bw values (1, 'Error: command line error', '���������в�������');
insert into bw values (3, 'Error: rule set error', '���󣺹���ά������');
insert into bw values (4, 'Error: db accessing error', '�������ݿ���ʴ���');
insert into bw values (5, 'Error: coming interface  illegal', '�����������ڲ��Ϸ���');
insert into bw values (10, 'Error: command line error', '���������д���');
insert into bw values (21, 'Error: sport check error', '����Դ�˿��������');
insert into bw values (25, 'Error: can not set service as any and sport in the same time', '������ѡ������ѡԴ�˿ڣ�');
insert into bw values (30, 'Error: rule download error', '���󣺹�����Ч����');
insert into bw values (31, 'Error: bandwidth rule amount can not exceed %d', '���󣺴�����������������ܳ���%d');

-- ����: vpnekey
create table vpnekey
(
	id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into vpnekey values (0, 'Notice: excution success', 'ע�⣺ִ�гɹ�');
insert into vpnekey values (1, 'Error: command line error','���������в�������');
insert into vpnekey values (2, 'Error: operator database error','���󣺲������ݿ����');
insert into vpnekey values (3, 'Error: data does not exist','�������ݲ�����');
insert into vpnekey values (4, 'Error: data exist','���������Ѿ�����');
insert into vpnekey values (5, 'Error: data exceed max limit','�������ݳ����������');
insert into vpnekey values (6, 'Error: memory error','�����ڴ����');
insert into vpnekey values (7, 'Error: logic check error','�����߼�������');
insert into vpnekey values (8, 'Error: system command error','����ϵͳ�������');
insert into vpnekey values (9, 'Error: acsc close ','���󣺹����Ѿ��ر�');
insert into vpnekey values (11,'Error: miss parameter','����������ȱ�ٲ���');

insert into vpnekey values (20, 'Error: please use on/off to enable or disable', '������ʹ��on/off�����û�ֹͣĳ����');


-- ����: blacklist
create table blacklist
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into blacklist values (1, 'Error: blacklist amount can not exceed %d', '���󣺺��������������ܳ���%d');

-- ����: config
create table config
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into config values (1, 'Please reboot system.', '����������ϵͳ');
insert into config values (2, 'Error: malformed file "%s"', '�����ļ�"%s"��ʽ����');
insert into config values (3, 'Error: firewall version mismatch', '���󣺰�ȫ���ذ汾��ƥ��');

-- ����: controlkw
create table controlkw
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into controlkw values (1, 'Error: control keyword amount can not exceed %d', '������ҳ�ؼ��ֵ��������ܳ���%d');



-- ����: ddns
create table ddns
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into ddns values (1,'Error: username length error or contains illegal character "%s"','�����û������ȴ�����߰����Ƿ��ַ� "%s"');
insert into ddns values (2,'Error: password length error or contains illegal character "%s"','�������볤�ȴ�����߰����Ƿ��ַ� "%s"');
insert into ddns values (3,'Error: confirm password error "%s"','����ȷ��������� "%s"');
insert into ddns values (4,'Error: password and confirm are not same','����������ȷ�����벻һ��');
insert into ddns values (5,'Error: username,password can not be empty','�����û������벻��Ϊ��');

-- ������dial
create table dial
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into dial values (1,'Error: parse error','���������ʽ����');
insert into dial values (2,'Error: open database error','���󣺴����ݿ�ʧ��');
insert into dial values (3,'Error: select database error','���󣺶�ȡ���ݿ�ʧ��');
insert into dial values (4,'Error: insert database error','���󣺲������ݿ�ʧ��');
insert into dial values (5,'Error: delete database error','����ɾ�����ݿ�ʧ��');
insert into dial values (6,'Error: update database error','���󣺸������ݿ�ʧ��');
insert into dial values (7,'Error: unknown','����δ֪����');
insert into dial values (8,'Error: param error','���������������');
insert into dial values (9,'Error: dial error','���󣺲���ʧ�ܣ�����Modem���������Ƿ���ȷ');
insert into dial values (10,'Error: stop error','���󣺶Ͽ�ʧ��');
insert into dial values (11,'Error: dial error','���󣺲���ʧ�ܣ�����Modem���������Ƿ���ȷ���û��������Ƿ���ȷ��');

-- ����: ha
create table ha
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into ha values (1, 'Error: HA is started', '���󣺼�Ⱥ�Ѿ�����');
insert into ha values (2, 'Error: HA is stopped', '���󣺼�Ⱥ�Ѿ�ֹͣ');
insert into ha values (3, 'Error: IP address "%s/%s" is invalid', '����IP��ַ"%s/%s"���Ϸ�');
insert into ha values (4, 'Error: node must be from 1 to 4', '���󣺽ڵ�ű�����1��4֮��');
insert into ha values (5, 'Error: id must be from 1 to 255', '����ID�ű�����1��255֮��');
insert into ha values (6, 'Error: HA is not set', '���󣺼�Ⱥδ����');
insert into ha values (7, 'Error: IP address "%s/%s" and firewall IP address "%s/%s" are in the same subnet', '����IP��ַ"%s/%s"�Ͱ�ȫ���ص�ַ"%s/%s"��ͬһ����');
insert into ha values (8, 'Error: IP address "%s/%s" and SAT address "%s" are in the same subnet', '����IP��ַ"%s/%s"�͵�ַ��"%s"��ͬһ����');
insert into ha values (9, 'Error: network interface "%s" is in broute mode', '��������ӿ�"%s"�����ڻ��ģʽ');

-- ����: hadetect
create table hadetect
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into hadetect values (1, 'Error: weight must be from 1 to 100', '����Ȩ�ر�����0��100֮��');
insert into hadetect values (2, 'Error: IP address "%s" already exists', '����IP��ַ"%s"�Ѵ���');
insert into hadetect values (3, 'Error: IP address "%s" does not exist', '����IP��ַ"%s"������');
insert into hadetect values (4, 'Error: threshold must be from 1 to 100', '������ֵ������1��100֮��');
insert into hadetect values (5, 'Error: HA is stopped', '���󣺼�Ⱥ�Ѿ�ֹͣ');
insert into hadetect values (6, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');

-- ����: hostname
create table hostname
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into hostname values (1,'Error: hostname error %s','���󣺰�ȫ�������ƴ���');
insert into hostname values (2,'Error: hostname can not be empty','���󣺰�ȫ�������Ʋ���Ϊ��');

-- ����: interface
create table interface
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into interface values (1, 'Error: interface name error "%s"', '���������豸���ƴ��� "%s"');
insert into interface values (2, 'Error: vlan id must be from 0 to 4094', '����: vlan id ������0��4094֮��');
insert into interface values (3, 'Error: ip format error "%s"', '����IP��ַ��ʽ���� "%s"');
insert into interface values (4, 'Error: netmask format error "%s"', '���������ʽ���� "%s"');
insert into interface values (5, 'Error: mac format error "%s"', '����MAC��ַ��ʽ���� "%s"');
insert into interface values (6, 'Error: please user on/off to enable or disable', '������ʹ��on/off�����û�ֹͣĳ����');
insert into interface values (7, 'Error: please set bind device', '����: ��ָ�����豸');
insert into interface values (8, 'Error: please set vlan id', '������ָ��VLAN ID');
insert into interface values (9, 'Error: enable device,place set ip/netmask','���������豸����ָ����IP��ַ������');
insert into interface values (10,'Error: interface_list is comma seperated string,no space,device name can not be duplicated','�����豸�б���Ӣ�Ķ��ŷָ���ַ���,û�пո�,�豸�������ظ�');
insert into interface values (11,'Error: please set device name','����: ��ָ���豸����');
insert into interface values (12,'Error: alias id must be from 0 to 252','���󣺱���ID������0��252֮��');
insert into interface values (13,'Error: please set alias id','������ָ��ALIAS ID');
insert into interface values (14,'Error: device does not exist','�����豸������');
insert into interface values (15,'Error: linkmode can only be set to auto,full,half','������·ģʽֻ������Ϊ ����Ӧ��ȫ˫������˫��');
insert into interface values (16,'Error: 10,100M device MTU 68-1504; 1000M device MTU 64-16128', '����ʮ�ף������豸��MTU��68-1504;ǧ���豸��MTU��64-16128');
insert into interface values (17,'Error: ipaddr type error','����IP��ַ��ȡ���ʹ���');
insert into interface values (18,'Error: ddns domain name error "%s"','���󣺶�̬ע���������� "%s"');
insert into interface values (19,'Error: workmode error','���󣺹���ģʽ����');
insert into interface values (20,'Error: transparent mode can only work with ipaddr_type=static and ip/mask not set','����͸��ģʽ�£���ַ��ȡ���ͱ����Ǿ�ָ̬��������IP/����Ϊ��');
insert into interface values (21,'Error: default bridge brg0 can not be deleted','����ȱʡ�Ž��豸brg0������ɾ��');
insert into interface values (22,'Notice: excution success','ע�⣺ִ�гɹ�');
insert into interface values (23,'Error: command line error','���������в�������');
insert into interface values (24,'Error: system error','����ϵͳ����');
insert into interface values (25,'Error: database error','�������ݿ����');
insert into interface values (26,'Error: device already exist','�����豸�Ѵ���');
insert into interface values (27,'Error: device does not exist' ,'�����豸������');
insert into interface values (28,'Error: memory error','�����ڴ����');
insert into interface values (29,'Error: config error,please check config parameters','�������ô����������ò���');
insert into interface values (30,'Error: bind device alreay enable qos "%s"','���󣺰��豸�������˴������ "%s"');
insert into interface values (31,'Error: device bound on this device already enable qos','���󣺰󶨴��豸���豸�������˴������');
insert into interface values (32,'Error: this device already binded as vlan device,can not work with trunk','���󣺴��豸�Ѱ�ΪVLAN�豸������������TRUNK');
insert into interface values (33,'Error: device type error','�����豸���ʹ���');
insert into interface values (34,'Error: physical device and vpn,dial device can not be deleted','���������豸��VPN�豸,�����豸���ܱ�ɾ��');
insert into interface values (35,'Error: device is referenced by "%s",can not be deleted','�����豸�� "%s" ���ã����ܱ�ɾ��');
insert into interface values (36,'Error: "%s" is active, do not stop "%s"','����"%s" ���ڼ���״̬������ֹͣ "%s"');
insert into interface values (37,'Error: speed can only be set to 10,100,100','�����豸�ٶ�ֻ������Ϊ10,100,100');
insert into interface values (38,'Error: ip,mask,mac can not be empty in full rd mode','����ȫ����ģʽ��IP��ַ�����룬MAC��ַ����Ϊ��');
insert into interface values (39,'Error: admin,ping,traceroute, please set ip/netmask','��������������PING,TRACEROUTE,������IP��ַ/����');
insert into interface values (40,'Error: redundency device interface list at least have one bind device','����:�����豸���豸�б�������һ�����豸');
insert into interface values (41,'Error: bind device can not be added multi times','����ͬһ���豸���ܶ�μ���');
insert into interface values (43,'Error: bind device has no ip','���󣺰��豸û��IP��ַ');
insert into interface values (44,'Error: ip list duplicated','����IP��ַ�ظ�');
insert into interface values (45,'Error: "%s" does not work in transparent mode','����"%s"û�й�����͸��ģʽ');
insert into interface values (46,'Error: "%s" bind as vpn or dial','����"%s"��VPN�豸�򲦺��豸��');
insert into interface values (47,'Error: device name duplicated','�����豸���ظ�');
insert into interface values (48,'Error: vlan bind device should be physical or redundency device','����VLAN�豸�İ��豸�����������豸�������豸');
insert into interface values (49,'Error: bind device already trunk,can not be bound as vlan','���󣺰��豸��������TRUNK����������ΪVLAN�İ��豸');
insert into interface values (50,'Error: can not config more than two PPPoE','���󣺲������ö�������PPPoE');
insert into interface values (51,'Error: device bandwidth error,please set according to device speed,bandwidth can not be 0','�����豸�������������豸�ٶ��趨��������Ϊ0');
insert into interface values (52,'Notice: device is not valid','ע�⣺�豸��Ч');
insert into interface values (53,'Notice: bind device is not valid','ע�⣺���豸��Ч');
insert into interface values (54,'Notice: interface list has invalid device "%s"','ע�⣺�豸�б�������Ч�豸 "%s"');
insert into interface values (55,'Error: bind device is not enabled,this device can not be enabled','���󣺰��豸δ���ã��������ô��豸');
insert into interface values (56,'Error: interface list has disabled device "%s"','�����豸�б�����δ���õ��豸 "%s"');
insert into interface values (57,'Error: resource "%s" does not exist','������Դ "%s" ������');
insert into interface values (58,'Error: username length error or contains illegal character "%s"','�����û������ȴ�����߰����Ƿ��ַ� "%s"');
insert into interface values (59,'Error: password length error or contains illegal character "%s"','�������볤�ȴ�����߰����Ƿ��ַ� "%s"');
insert into interface values (60,'Error: ip list is comma seperated,not space','����IP�б���Ӣ�Ķ��ŷָ��������пո�');
insert into interface values (61,'Error: enable dial device,username/password can not be empty','�������ò����豸���û������벻��Ϊ��');
insert into interface values (62,'Error: alias device ip can not be zero','���󣺱����豸��IP��ַ����Ϊ��');
insert into interface values (63,'Error: switch to transparent mode would make vpn device "%s" unusable,please stop that first','�����л���͸��ģʽ������VPN�豸 "%s" �����ã�����ֹͣ��');
insert into interface values (64,'Error: switch to transparent mode would make alias device "%s" unusable,please stop that first','�����л���͸��ģʽ�����±����豸 "%s" �����ã�����ֹͣ��');
insert into interface values (65,'Error: switch to transparent mode would make addrpool resource "%s" unusable,please delete that first','�����л���͸��ģʽ�����µ�ַ����Դ "%s" �����ã�����ɾ����');
insert into interface values (66,'Error: set ip address to null would make vpn device "%s" unusable,please stop that first','���󣺽�IP��ַ��Ϊ�ս�����VPN�豸 "%s" �����ã�����ֹͣ��');
insert into interface values (67,'Error: alias bind device should be physical,redundency,vlan or bridge device','���󣺱����豸�İ��豸�������������࣬VLAN���Ž��豸');
insert into interface values (68,'Error: alias bind device should work in route mode','���󣺱����豸�İ��豸���빤����·��ģʽ��');
insert into interface values (69,'Error: vpn bind device should be physical,redundency,vlan,bridge or dial device','����VPN�豸�İ��豸�����������豸�������豸��VLAN�豸���Ž��豸�򲦺��豸');
insert into interface values (70,'Error: dial bind device should be physical,redundency device','���󣺲����豸�İ��豸�����������豸�������豸');
insert into interface values (71,'Error: switch to transparent mode would make redundency device "%s" unusable,please delete that first','�����л���͸��ģʽ�����������豸"%s"�����ã�����ɾ����');
insert into interface values (72,'Error: device "%s" work in transparent mode','�����豸"%s"������͸��ģʽ');
insert into interface values (73,'Error: device "%s" is already used by ha module','�����豸"%s"�ѱ�HAģ��ʹ��');
insert into interface values (74,'Error: device "%s" is already in redundency device','�����豸"%s"�ѱ������豸ʹ��'); 
insert into interface values (75,'Error: bridge device "%s" is not enable','�������豸 "%s" û������');
insert into interface values (76,'Error: this device is bound by redundency device,can not be enabled manually','���󣺴��豸�������豸�İ��豸���������ֶ�����');
insert into interface values (77,'Error: can not add more than 64 vlan devices','�������VLAN�豸���������ܳ���64');
insert into interface values (78,'Error: alias bind device amount can not exceed %d', '���󣺱����豸���������ܳ���%d');
insert into interface values (79,'Error: alias id must be from 0 to 7','���󣺱���ID������0��7֮��');
insert into interface values (80,'Error: switch to redundency mode would make vpn device "%s" unusable,please stop that first','�����л�������ģʽ������VPN�豸 "%s" �����ã�����ֹͣ��');
insert into interface values (81,'Error: switch to redundency mode would make alias device "%s" unusable,please stop that first','�����л�������ģʽ�����±����豸 "%s" �����ã�����ֹͣ��');
insert into interface values (82,'Error: redundency mode can only work with ipaddr_type=static and ip/mask not set','��������ģʽ�£���ַ��ȡ���ͱ����Ǿ�ָ̬��������IP/����Ϊ��');
insert into interface values (83,'Error: switch to redundency mode would make transparent device "%s" unusable,please delete that first','�����л�������ģʽ������͸���豸"%s"�����ã�����ɾ����');
insert into interface values (84,'Error: switch to redundency mode would make vlan device "%s" unusable,please stop that first','�����л�������ģʽ������VLAN�豸 "%s" �����ã�����ֹͣ��');
insert into interface values (85,'Error: device "%s" need work in redundency mode','�����豸"%s"��Ҫ����������ģʽ');
insert into interface values (86,'Error: redundency device option workmode can only be set to balance-rr,backup,balance-xor,broadcast,802.3ad,balance-tlb,balance-alb','���������豸�Ĺ���ģʽֻ������Ϊ��ѭ���⣬˫���ȱ����㲥��802.3ad��tlb���⣬alb����');
insert into interface values (87,'Error: redundency device option linkwatch 100-3000','���������豸����linkwatch��ֵ��ΧΪ100-3000');
insert into interface values (88,'Error: redundency device option updelay/downdelay must be number,default 0','���������豸����updelay/downdelay����Ϊ����,Ĭ��Ϊ0');
insert into interface values (89,'Error: please use slow/fast ','������ʹ�ùؼ��� slow/fast');
insert into interface values (90,'Notice: redundency device option change, need reboot system, please save config','ע�⣺�����豸ȫ�ֲ��������ϵͳ��Ҫ����������Ч����������ǰ��������');
insert into interface values (91,'Error: dhcpclient error','��������dhcpclient��������');
insert into interface values (92,'Error: switch to transparent mode would make dial device "%s" unusable,please stop that first','�����л���͸��ģʽ�����²����豸 "%s" �����ã�����ֹͣ��');
insert into interface values (93,'Notice: disable device would make firewall unmanagable,please unset admin value first','ע�⣺ֹͣ�豸�������豸���ɹ�������ֹͣ�豸�������������');
insert into interface values (94,'Error: bind device work in redundency mode','���󣺰��豸����������ģʽ');

-- ����: linkage
create table linkage
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into linkage values (1, 'Error: PUMA service is started', '����PUMA�����Ѿ�����');
insert into linkage values (2, 'Error: Venus service is started', '����"����"�����Ѿ�����');
insert into linkage values (3, 'Error: Netpower service is started', '����"����"�����Ѿ�����');
insert into linkage values (4, 'Error: SafeMate service is started', '����SafeMate�����Ѿ�����');
insert into linkage values (5, 'Error: PUMA service can not be started', '����PUMA����������');
insert into linkage values (6, 'Error: Venus service can not be started', '����"����"����������');
insert into linkage values (7, 'Error: Netpower service can not be started', '����"����"����������');
insert into linkage values (8, 'Error: SafeMate service can not be started', '����SafeMate����������');
insert into linkage values (9, 'Error: too many IP addresses', '����IP��ַ����');
insert into linkage values (10, 'Error: password must be 9 characters', '�����������Ϊ9���ַ�');
insert into linkage values (11, 'Error: port "%d" is in use', '���󣺶˿�"%d"�ѱ�ʹ��');
insert into linkage values (12, 'Error: malformed key file "%s"', '�����ļ�"%s"��ʽ����');
insert into linkage values (13, 'Error: PUMA service is not set', '����PUMA����δ����');
insert into linkage values (14, 'Error: Venus service is not set', '����"����"����δ����');
insert into linkage values (15, 'Error: Netpower service is not set', '����"����"����δ����');
insert into linkage values (16, 'Error: SafeMate service is not set', '����SafeMate����δ����');

-- ����: macbind
create table macbind
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into macbind values (1, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');
insert into macbind values (2, 'Error: IP address "%s" is already binded with MAC address "%s"', '����IP��ַ"%s"�Ѿ���MAC��ַ"%s"��');
insert into macbind values (3, 'Error: uniqueness conflict, MAC address "%s" is already binded with IP address "%s"', '����Ψһ�Գ�ͻ��MAC��ַ"%s"�Ѿ���IP��ַ"%s"��');
insert into macbind values (4, 'Error: IP address "ip" is not binded', '����IP��ַ"%s"δ����');
insert into macbind values (5, 'Error: IP/mac bind amount can not exceed %d', '�����Ѱ�IP/MAC�Ե��������ܳ���%d');

-- ����: mailfilter
create table mailfilter
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into mailfilter values (1, 'Error: too many keywords', '���󣺹ؼ��ֹ���');

-- ����: ntp
create table ntp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into ntp values (1, 'Error: interval must be from 1 to 65535', '����ʱ����������1��65535֮��');
insert into ntp values (2, 'Error: NTP is started', '����ʱ��ͬ���Ѿ�����');
insert into ntp values (3, 'Error: NTP is not set', '����ʱ��ͬ��δ����');
insert into ntp values (4, 'Error: NTP is stopped', '����ʱ��ͬ���Ѿ�ֹͣ');
insert into ntp values (5, 'Error: NTP sync failed', '����ʱ��ͬ��ʧ��');

-- ����: proxy
create table proxy
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into proxy values (1, 'Error: HTTP proxy is started', '����HTTP�����Ѿ�����');
insert into proxy values (2, 'Error: FTP proxy is started', '����FTP�����Ѿ�����');
insert into proxy values (3, 'Error: TELNET proxy is started', '����TELNET�����Ѿ�����');
insert into proxy values (4, 'Error: SMTP proxy is started', '����SMTP�����Ѿ�����');
insert into proxy values (5, 'Error: POP3 proxy is started', '����POP3�����Ѿ�����');
insert into proxy values (6, 'Error: SOCKS proxy is started', '����SOCKS�����Ѿ�����');
insert into proxy values (7, 'Error: HTTP proxy can not be started', '����HTTP����������');
insert into proxy values (8, 'Error: FTP proxy can not be started', '����FTP����������');
insert into proxy values (9, 'Error: TELNET proxy can not be started', '����TELNET����������');
insert into proxy values (10, 'Error: SMTP proxy can not be started', '����SMTP����������');
insert into proxy values (11, 'Error: POP3 proxy can not be started', '����POP3����������');
insert into proxy values (12, 'Error: SOCKS proxy can not be started', '����SOCKS����������');
insert into proxy values (13, 'Error: default proxy "%s" already exists', '����Ԥ�������"%s"�Ѵ���');
insert into proxy values (14, 'Error: custom proxy "%s" already exists', '�����Զ������"%s"�Ѵ���');
insert into proxy values (15, 'Error: custom proxy "%s" does not exist', '�����Զ������"%s"������');
insert into proxy values (16, 'Error: custom proxy "%s" is started', '�����Զ������"%s"�Ѿ�����');
insert into proxy values (17, 'Error: custom proxy "%s" can not be started', '�����Զ������"%s"��������');
insert into proxy values (18, 'Error: port "%d" is in use', '���󣺶˿�"%d"�ѱ�ʹ��');
insert into proxy values (19, 'Error: max length must be from %d to %d', '��������ʼ����ȱ�����%d��%d֮��');
insert into proxy values (20, 'Error: max receiver must be from %d to %d', '��������������������%d��%d֮��');
insert into proxy values (21, 'Error: custom proxy "%s" is in use', '�����Զ������"%s"�ѱ�ʹ��');

-- ����: route
create table route
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into route values (1, 'Error: gateway "%s" is unreachable', '��������"%s"���ɴ�');
insert into route values (2, 'Error: source IP address and destination IP address can not be both "any"', '����ԴIP��ַ��Ŀ��IP��ַ���ܶ���"any"');
insert into route values (3, 'Error: source IP address route can not be used on the network interface "ha" or "mng"', '���󣺲���������ӿ�"ha"��"mng"��ʹ��Դ·��');
insert into route values (4, 'Error: static route already exists', '���󣺾�̬·���Ѵ���');
insert into route values (5, 'Error: source IP address route amount can not exceed %d', '����Դ·�ɵ��������ܳ���%d');
insert into route values (6, 'Error: static route does not exist', '���󣺾�̬·�ɲ�����');
insert into route values (7, 'Error: static route amount can not exceed %d', '���󣺾�̬·�ɵ��������ܳ���%d');

-- ����: rule
create table rule
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into rule values (1, 'Error: address "%s" does not exist', '���󣺵�ַ"%s"������');
insert into rule values (2, 'Error: "%s" is not firewall IP address', '����"%s"���ǰ�ȫ����IP��ַ');
insert into rule values (3, 'Error: SAT address "%s" does not exist', '���󣺵�ַ��"%s"������');
insert into rule values (4, 'Error: server address "%s" does not exist', '���󣺷�������ַ"%s"������');
insert into rule values (5, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');
insert into rule values (6, 'Error: service "%s" does not exist', '���󣺷���"%s"������');
insert into rule values (7, 'Error: proxy "%s" does not exist', '���󣺴���"%s"������');
insert into rule values (8, 'Error: time "%s" does not exist', '����ʱ�䶨��"%s"������');
insert into rule values (9, 'Error: bandwidth "%s" does not exist', '���󣺴�����"%s"������');
insert into rule values (10, 'Error: URL rule "%s" does not exist', '����URL����"%s"������');
insert into rule values (11, 'Error: service "%s" has non TCP protocol', '���󣺷���"%s"������TCPЭ��');
insert into rule values (12, 'Error: destination port must be single port', '����Ŀ�Ķ˿ڱ����ǵ����˿�');
insert into rule values (13, 'Error: when custom proxy be used, destination IP address must be single IP address', '����ʹ���û��Զ������ʱ��Ŀ��IP��ַ�����ǵ���IP��ַ');
insert into rule values (14, 'Error: argument "sat" can not be "none" in "nat" rule', '������NAT���͵İ�ȫ������,Դ��ַת����������Ϊ"none"');
insert into rule values (15, 'Error: public service and inner service are not match', '���󣺶��������ڲ�����ƥ��');
insert into rule values (16, 'Error: public service "%s" has non TCP protocol', '���󣺶������"%s"������TCPЭ��');
insert into rule values (17, 'Error: inner service "%s" has non TCP protocol', '�����ڲ�����"%s"������TCPЭ��');
insert into rule values (18, 'Error: rule id "%d" does not exist', '����IDΪ"%d"�İ�ȫ���򲻴���');
insert into rule values (19, 'Error: rule types are not compatible', '���󣺰�ȫ�������Ͳ�����');
insert into rule values (20, 'Error: argument "%s" is not compatible with type "%s"', '���󣺲���"%s"�밲ȫ��������"%s"������');
insert into rule values (21, 'Error: destination port can not be "%d"', '����Ŀ�Ķ˿ڲ�����"%d"');
insert into rule values (22, 'Error: packet filter rule amount can not exceed %d', '���󣺰����˹�����������ܳ���%d');
insert into rule values (23, 'Error: portmap rule amount can not exceed %d', '���󣺶˿�ӳ�������������ܳ���%d');
insert into rule values (24, 'Error: ipmap rule amount can not exceed %d', '����IPӳ�������������ܳ���%d');
insert into rule values (25, 'Error: nat rule amount can not exceed %d', '����NAT������������ܳ���%d');
insert into rule values (26, 'Error: proxy rule amount can not exceed %d', '���󣺴��������������ܳ���%d');

-- ����: sataddr
create table sataddr
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into sataddr values (1, 'Error: SAT address "%s" already exists', '���󣺵�ַ��"%s"�Ѵ���');
insert into sataddr values (2, 'Error: no network interface is in broute mode', '����û������ӿڹ����ڻ��ģʽ');
insert into sataddr values (3, 'Error: network interface "%s" is in broute mode', '��������ӿ�"%s"�����ڻ��ģʽ');
insert into sataddr values (4, 'Error: IP address "%s:%s" and HA IP address "%s/%s" are in the same subnet', '����IP��ַ"%s:%s"�뼯ȺIP��ַ"%s/%s"��ͬһ����');
insert into sataddr values (5, 'Error: SAT address "%s" does not exist', '���󣺵�ַ��"%s"������');
insert into sataddr values (6, 'Error: IP address "%s" belongs to SAT address "%s"', '����IP��ַ"%s"���ڵ�ַ��"%s"');
insert into sataddr values (7, 'Error: IP address "%s" is firewall IP address', '����IP��ַ"%s"�ǰ�ȫ����IP��ַ');
insert into sataddr values (8, 'Error: SAT address "%s" is in use', '���󣺵�ַ��"%s"�ѱ�ʹ��');
insert into sataddr values (9, 'Error: can not include reserved IP address "%s"', '���󣺲��ܰ�������IP��ַ"%s"');
insert into sataddr values (10, 'Error: can not include more than %d IP addresses', '����IP��ַ���ܳ���%d��');
insert into sataddr values (11, 'Error: invalid IP address "%s"', '������Ч��IP��ַ"%s"');
insert into sataddr values (12, 'Error: IP address "%s:%s" and firewall IP address "%s/%s" on network interface "%s" are in the same subnet', '����IP��ַ"%s:%s"�밲ȫ����IP��ַ"%s/%s"(������ӿ�"%s"��)��ͬһ����');
insert into sataddr values (13, 'Error: IP address "%s:%s" and SAT address "%s" on network interface "%s" are in the same subnet', '����IP��ַ"%s:%s"���ַ��"%s"(������ӿ�"%s"��)��ͬһ����');
insert into sataddr values (14, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');

-- ����: serveraddr
create table serveraddr
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into serveraddr values (1, 'Error: server address "%s" already exists', '���󣺷�������ַ"%s"�Ѵ���');
insert into serveraddr values (2, 'Error: server address "%s" does not exist', '���󣺷�������ַ"%s"������');
insert into serveraddr values (3, 'Error: server address amount can not exceed %d', '���󣺷�������ַ���������ܳ���%d');
insert into serveraddr values (4, 'Error: weight must be from 0 to 65535', '����Ȩ�ر�����0��65535֮��');
insert into serveraddr values (5, 'Error: server address "%s" is in use', '���󣺷�������ַ"%s"�ѱ�ʹ��');

-- ����: servgrp
create table servgrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into servgrp values (1, 'Error: default service "%s" already exists', '����Ԥ�������"%s"�Ѵ���');
insert into servgrp values (2, 'Error: custom service "%s" already exists', '�����Զ������"%s"�Ѵ���');
insert into servgrp values (3, 'Error: service group "%s" already exists', '���󣺷�����"%s"�Ѵ���');
insert into servgrp values (4, 'Error: service group "%s" does not exist', '���󣺷�����"%s"������');
insert into servgrp values (5, 'Error: service "%s" does not exist', '���󣺷���"%s"������');
insert into servgrp values (6, 'Error: service group "%s" is in use', '���󣺷�����"%s"�ѱ�ʹ��');
insert into servgrp values (7, 'Notice: service "%s" is already a member of serivce group "%s"', 'ע�⣺����"%s"���Ƿ�����"%s"�ĳ�Ա');
insert into servgrp values (8, 'Notice: service "%s" is not a member of serivce group "%s"', 'ע�⣺����"%s"���Ƿ�����"%s"�ĳ�Ա');

-- ����: service
create table service
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into service values (1, 'Error: default service "%s" already exists', '����Ԥ�������"%s"�Ѵ���');
insert into service values (2, 'Error: custom service "%s" already exists', '�����Զ������"%s"�Ѵ���');
insert into service values (3, 'Error: service group "%s" already exists', '���󣺷�����"%s"�Ѵ���');
insert into service values (4, 'Error: custom service "%s" does not exist', '�����Զ������"%s"������');
insert into service values (5, 'Error: service "%s" does not exist', '���󣺷���"%s"������');
insert into service values (6, 'Error: custom service "%s" is in use', '�����Զ������"%s"�ѱ�ʹ��');
insert into service values (7, 'Error: protocol number must be from 0 to 255, excluding 1(ICMP), 6(TCP) and 17(UDP)', '����Э��ű�����0��255֮�䣬������1(ICMP)��6(TCP)��17(UDP)');
insert into service values (8, 'Error: custom service type can not be changed', '���󣺲��ܸı��Զ�����������');

-- ����: system
create table system
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into system values (1, 'Error: network interface "%s" can not be used', '���󣺲���ʹ������ӿ�"%s"');

-- ����: time
create table time
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into time values (1, 'Error: time group "%s" already exists', '����ʱ����"%s"�Ѵ���');
insert into time values (2, 'Error: time "%s" already exists', '����ʱ�䶨��"%s"�Ѵ���');
insert into time values (3, 'Error: time "%s" does not exist', '����ʱ�䶨��"%s"������');
insert into time values (4, 'Error: time "%s" is in use', '����ʱ�䶨��"%s"�ѱ�ʹ��');
insert into time values (5, 'Error: time type mismatch', '����ʱ�䶨�����Ͳ�ƥ��');
insert into time values (6, 'Error: start time must be early than stop time', '���󣺿�ʼʱ��������ڽ���ʱ��');

-- ����: timegrp
create table timegrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into timegrp values (1, 'Error: time "%s" already exists', '����ʱ�䶨��"%s"�Ѵ���');
insert into timegrp values (2, 'Error: time group "%s" already exists', '����ʱ����"%s"�Ѵ���');
insert into timegrp values (3, 'Error: time group "%s" does not exist', '����ʱ����"%s"������');
insert into timegrp values (4, 'Error: time group "%s" is in use', '����ʱ����"%s"�ѱ�ʹ��');
insert into timegrp values (5, 'Notice: time "%s" does not exist', 'ע�⣺ʱ�䶨��"%s"������');
insert into timegrp values (6, 'Notice: time "%s" is already a member of time group "%s"', 'ע�⣺ʱ�䶨��"%s"����ʱ����"%s"�ĳ�Ա');
insert into timegrp values (7, 'Notice: time "%s" is not a member of time group "%s"', 'ע�⣺ʱ�䶨��"%s"����ʱ����"%s"�ĳ�Ա');

-- ����: upgrade
create table upgrade
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into upgrade values (1, 'Upgrade succeeded.', '�����ɹ�');
insert into upgrade values (2, 'Upgrade succeeded, please reboot system.', '�����ɹ�������������ϵͳ');
insert into upgrade values (3, 'Error: malformed file "%s"', '�����ļ�"%s"��ʽ����');
insert into upgrade values (4, 'Error: firewall version mismatch', '���󣺰�ȫ���ذ汾��ƥ��');
insert into upgrade values (5, 'Error: save failed', '���󣺱���ʧ��');

-- ����: url
create table url
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into url values (1, 'Error: URL rule "%s" already exists', '����URL����"%s"�Ѵ���');
insert into url values (2, 'Error: URL rule "%s" does not exist', '����URL����"%s"������');
insert into url values (3, 'Error: URL rule amount can not exceed %d', '����URL������������ܳ���%d');
insert into url values (4, 'Error: URL rule "%s" is in use', '����URL����"%s"�ѱ�ʹ��');
insert into url values (5, 'Error: too many ports', '���󣺶˿�̫��');
insert into url values (6, 'Error: URL keyword amount can not exceed %d', '����URL�ؼ��ֵ��������ܳ���%d');

-- ����: user
create table user
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into user values (1, 'Error: user "%s" already exists', '�����û�"%s"�Ѵ���');
insert into user values (2, 'Error: user "%s" does not exist', '�����û�"%s"������');
insert into user values (3, 'Error: user group "%s" does not exist', '�����û���"%s"������');
insert into user values (4, 'Notice: user "%s" is already a member of user group "%s"', 'ע�⣺�û�"%s"�����û���"%s"�ĳ�Ա');
insert into user values (5, 'Notice: user "%s" is not a member of user group "%s"', 'ע�⣺�û�"%s"�����û���"%s"�ĳ�Ա');
insert into user values (6, 'Error: address "%s" does not exist', '���󣺵�ַ"%s"������');
insert into user values (7, 'Error: time "%s" does not exist', '����ʱ�䶨��"%s"������');
insert into user values (8, 'Notice: policy already exists', 'ע�⣺�����Ѵ���');
insert into user values (9, 'Notice: policy does not exist', 'ע�⣺���Բ�����');
insert into user values (10, 'Notice: user "%s" is not online', 'ע�⣺�û�"%s"������');
insert into user values (11, 'Notice: user group "%s" is not online', 'ע�⣺�û���"%s"������');
insert into user values (12, 'Notice: IP address "%s" is not online', 'ע�⣺IP��ַ"%s"������');
insert into user values (13, 'Error: user amount can not exceed %d', '�����û����������ܳ���%d');

-- ����: usergrp
create table usergrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into usergrp values (1, 'Error: user group "%s" already exists', '�����û���"%s"�Ѵ���');
insert into usergrp values (2, 'Error: user group "%s" does not exist', '�����û���"%s"������');
insert into usergrp values (3, 'Error: user "%s" does not exist', '�����û�"%s"������');
insert into usergrp values (4, 'Notice: user "%s" is already a member of user group "%s"', 'ע�⣺�û�"%s"�����û���"%s"�ĳ�Ա');
insert into usergrp values (5, 'Notice: user "%s" is not a member of user group "%s"', 'ע�⣺�û�"%s"�����û���"%s"�ĳ�Ա');
insert into usergrp values (6, 'Error: address "%s" does not exist', '���󣺵�ַ"%s"������');
insert into usergrp values (7, 'Error: service "%s" does not exist', '���󣺷���"%s"������');
insert into usergrp values (8, 'Error: time "%s" does not exist', '����ʱ�䶨��"%s"������');
insert into usergrp values (9, 'Notice: policy already exists', 'ע�⣺�����Ѵ���');
insert into usergrp values (10, 'Notice: policy does not exist', 'ע�⣺���Բ�����');
insert into usergrp values (11, 'Notice: service already exists', 'ע�⣺�����Ѵ���');
insert into usergrp values (12, 'Notice: service does not exist', 'ע�⣺���񲻴���');
insert into usergrp values (13, 'Error: flow quota must be from %d to %d', '���������޶������%d��%d֮��');
insert into usergrp values (14, 'Error: time quota must be from %d to %d', '����ʱ���޶������%d��%d֮��');
insert into usergrp values (15, 'Error: password expiring days must be from %d to %d', '���������������������%d��%d֮��');
insert into usergrp values (16, 'Error: week day must be from %d to %d', '�����������ڱ�����%d��%d֮��');
insert into usergrp values (17, 'Error: month day must be from %d to %d', '�����������ڱ�����%d��%d֮��');
insert into usergrp values (18, 'Error: user group amount can not exceed %d', '�����û�����������ܳ���%d');

-- ����: acsc
create table acsc
(
	id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into acsc values (0, 'Notice: excution success', 'ע�⣺ִ�гɹ�');
insert into acsc values (1, 'Error: command line error','���������в�������');
insert into acsc values (2, 'Error: operator database error','���󣺲������ݿ����');
insert into acsc values (3, 'Error: data does not exist','�������ݲ�����');
insert into acsc values (4, 'Error: data exist','���������Ѿ�����');
insert into acsc values (5, 'Error: data exceed max limit','�������ݳ����������');
insert into acsc values (6, 'Error: memory error','�����ڴ����');
insert into acsc values (7, 'Error: logic check error','�����߼�������');
insert into acsc values (8, 'Error: system command error','����ϵͳ�������');
insert into acsc values (9, 'Error: acsc close ','���󣺹����Ѿ��ر�');
insert into acsc values (11,'Error: miss parameter','����������ȱ�ٲ���');
insert into acsc values (12,'Error: all check type is NO, at least one is not NO ','�������м��������NO��������һ��Ϊ��NO����');
insert into acsc values (20, 'Error: please use on/off to enable or disable', '������ʹ��on/off�����û�ֹͣĳ����');
insert into acsc values (21, 'Error: please use no/chk/exlog/exdrop/exdroplog keyword ', '������ʹ��no/chk/exlog/exdrop/exdroplog����Ϊ������͵Ĺؼ���');
insert into acsc values (22, 'Error: please use number', '������ʹ������');
insert into acsc values (23, 'Error: ip format error "%s"', '����IP��ַ��ʽ���� "%s"');
insert into acsc values (24, 'Error: comment max length is 20', '����ע��˵���20��Ӣ���ַ�');
insert into acsc values (25, 'Error: add rule exist', '������ӵĹ����Ѵ���');
insert into acsc values (26, 'Error: add rule exceed max limit', '���󣺳����������������');
insert into acsc values (27, 'Error: rule not exist', '���󣺹��򲻴���');
insert into acsc values (28, 'Error: need same net', '������Ҫ��ͬһ����');
insert into acsc values (29, 'Error: operator please use ls/le/eq/ge/gt keyword', '���󣺲��������� ls/le/eq/ge/gt');
insert into acsc values (30, 'Error: logic operator please use and/or keyword', '�����߼��ٷ����� and/or');

-- ����: vpn
create table vpn
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into vpn values (1, 'Error: remote VPN amount can not exceed %d', '����Զ��VPN���������ܳ���%d');
insert into vpn values (2, 'Error: vpn tunnel amount can not exceed %d', '����VPN������������ܳ���%d');
insert into vpn values (3, 'Error: remote dial user amount can not exceed %d', '����Զ�̲����û����������ܳ���%d');

-- ����: domain
create table domain
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into domain values (0, 'Notice: excution success', 'ע�⣺ִ�гɹ�');
insert into domain values (1, 'Error: command line error %s','���������в������� %s');
insert into domain values (2, 'Error: static ip exceed limit','���󣺾�̬IP��������');
insert into domain values (3, 'Error: %s is referenced by %s module,cannot be deleted','����%s��%sģ�����ã�����ɾ��');

-- ����: dcf
create table dcf
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into dcf values (0, 'Notice: excution success', 'ע�⣺ִ�гɹ�');
insert into dcf values (1, 'Error: command line error','���������ʽ����');
insert into dcf values (2, 'Error: system command error','����ϵͳ�������');
insert into dcf values (3, 'Error: database error','�������ݿ����');
insert into dcf values (4, 'Error: command line parameter "%s" error','���������в���"%s"����');
insert into dcf values (5, 'Error: keyword "%s" already exists', '���󣺹ؼ���"%s"�Ѵ���');
insert into dcf values (6, 'Error: keyword "%s" does not exist', '���󣺹ؼ���"%s"������');
insert into dcf values (7, 'Error: keyword "%s" is in use', '���󣺹ؼ���"%s"�ѱ�ʹ��');
insert into dcf values (8, 'Error: keyword "%s" length exceed', '���󣺹ؼ���"%s"�ַ�����������');
insert into dcf values (9, 'Error: group "%s" already exists', '������"%s"�Ѵ���');
insert into dcf values (10, 'Error: group "%s" does not exist', '������"%s"������');
insert into dcf values (11, 'Error: group "%s" is in use', '������"%s"�ѱ�ʹ��');
insert into dcf values (12, 'Error: group nums exceed', '����������������');
insert into dcf values (13, 'Error: group "%s" members exceed', '������"%s"�ؼ�������������');
insert into dcf values (14, 'Error: policy "%s" already exists', '���󣺲���"%s"�Ѵ���');
insert into dcf values (15, 'Error: policy "%s" does not exist', '���󣺲���"%s"������');
insert into dcf values (16, 'Error: policy "%s" is in use', '���󣺲���"%s"�ѱ�ʹ��');
insert into dcf values (17, 'Error: policy group "%s" already exist', '���󣺲�����"%s"�Ѵ���');
insert into dcf values (18, 'Error: policy group "%s" does not exist', '���󣺲�����"%s"������');
insert into dcf values (19, 'Error: policy group "%s" is in use', '���󣺲�����"%s"�ѱ�ʹ��');
insert into dcf values (20, 'Error: policy module "%s" is not enabled', '���󣺲���ģ��"%s"δ����');
insert into dcf values (21, 'Error: policy nums exceed', '���󣺲�������������');
insert into dcf values (22, 'Error: service "%s" already exists', '���󣺷���"%s"�Ѵ���');
insert into dcf values (23, 'Error: service "%s" does not exist', '���󣺷���"%s"������');
insert into dcf values (24, 'Error: service "%s" is in use', '���󣺷���"%s"�ѱ�ʹ��');
insert into dcf values (25, 'Error: service "%s" nums exceed', '���󣺷���"%s"�˿�����������');

-- ����: portsyn
-- Created by zhangming 2005/02/17
create table portsyn
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --Ӣ�ģ���������Ϣ��ʽ�ַ���
    zh_CN             VARCHAR(255)            --���ģ��й�����Ϣ��ʽ�ַ���
);
insert into portsyn values (0, 'Error: psyn parameter invalid','����: �����в���');
insert into portsyn values (1, 'Notice: no portsyn need startup','��ʾ: rungroup��û�п�ִ�еļ�¼');
insert into portsyn values (2, 'DB Error: open portsyn database', '����: �����ݿ�portsyn');
insert into portsyn values (3, 'DB Error: no rungroup info', '����: rungroup����û����Ӧ��������Ϣ');
insert into portsyn values (4, 'DB Error: no portgroup info', '����: portgroup����û����Ӧ�˿�����Ϣ');
insert into portsyn values (5, 'DB Error: no port info', '����: ports����û����Ӧ�˿���Ϣ');
insert into portsyn values (6, 'Error: show group state', '����: ����û�б�ͬ������ѡ��ִ��');
insert into portsyn values (7, 'Error: Group id invalid', '����: ��id��Ч');
insert into portsyn values (8, 'Error: port invalid', '����: ���ö˿���Ч');
insert into portsyn values (9, 'Error: action invalid', '����: ������Чaction����');
insert into portsyn values (10, 'Error: decision invalid', '����: ������Чdecision����');
insert into portsyn values (11, 'DB Error: operate database', '����: �����');
insert into portsyn values (12, 'Error: rungroup id', '����: ������Чrungroup id');
insert into portsyn values (13, 'Error: group string', '����: ������Чgroup string');
insert into portsyn values (14, 'Error: rungroup active', '����: ������Чrungroup active');
insert into portsyn values (15, 'Error: alloc memory', '����: �����ڴ�');
insert into portsyn values (16, 'DB Error: no config info', '����: config����û����Ӧ������Ϣ');
insert into portsyn values (17, 'DB Error: key field', '����: ���ֵ');
insert into portsyn values (18, 'DB Error: duplicate rungroup', '����:���ظ�����rungroup');

--create by lintao 2005/07/22
create table gwmail
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);
insert into gwmail values (0,'Error: please input value!','��������ȷ������');
insert into gwmail values (1,'Error: SMTP server unreachable!','SMTP��������ַ���ɴ�');
insert into gwmail values (2,'Error: Please set mail parameter!','����ȷ���ò���');
insert into gwmail values (3,'Error: Please turn on mail function!','���������ʼ�����');

create table licensestatus
(
	id     INTERGER PRIMARY KEY,
	en_US  VARCHAR(255),
	zh_CN  VARCHAR(255)
);

insert into licensestatus values(1, 'Error: Too few parameter','Error: ȱ�ٲ���');
insert into licensestatus values(2, 'valid','��Ч');
insert into licensestatus values(3, 'invalid','��Ч');
insert into licensestatus values(4, 'Error: Bad parameter','Error: ��������');


create table gwarp
(
	id     INTERGER PRIMARY KEY,
	en_US  VARCHAR(255),
	zh_CN  VARCHAR(255)
);

insert into gwarp values(1, 'GWARP Error: program error','GWARP Error: �������');
insert into gwarp values(2, 'GWARP Error: too few parameter','GWARP Error: ȱ�ٲ���');
insert into gwarp values(3, 'GWARP Error: wrong interface name','GWARP Error: �ӿڴ���');
insert into gwarp values(4, 'GWARP Error: cmdline too long','GWARP Error: ������̫��');
insert into gwarp values(5, 'GWARP Error: invalid parameter','GWARP Error: ��Ч����');

create table sslvpn
(
	id   	 interger primary key,
	en_US	 varchar(255),
	zh_CN    varchar(255)
);
insert into sslvpn values(0, 'SSLVPN: success!', 'SSLVPN: �ɹ�!');
insert into sslvpn values(1, 'SSLVPN: too few argument!', 'SSLVPN:ȱ�ٲ���!');
insert into sslvpn values(2, 'SSLVPN: bad parameter!', 'SSLVPN: �������!');
insert into sslvpn values(3, 'SSLVPN: database error!','SSLVPN: ���ݿ����!');
insert into sslvpn values(4, 'SSLVPN: set module debug error!', 'SSLVPN: ����ģ�����!');
insert into sslvpn values(5, 'SSLVPN: file operating error!', 'SSLVPN: �ļ���������!');
insert into sslvpn values(6, 'SSLVPN: system error!', 'SSLVPN: ϵͳ����!');

insert into sslvpn values(7, 'SSLVPN: invalid active!', 'SSLVPN: ����active�д���!');
insert into sslvpn values(8, 'SSLVPN: invalid listenip!', 'SSLVPN: ����listenip �д���!');
insert into sslvpn values(9, 'SSLVPN: invalid proto!', 'SSLVPN: ����proto�д���!');

insert into sslvpn values(10, 'SSLVPN: invalid listenport!', 'SSLVPN: ����listenport�д���!');
insert into sslvpn values(11, 'SSLVPN: invalid subnet!', 'SSLVPN: ����subnet�д���!');
insert into sslvpn values(12, 'SSLVPN: invalid sendbuf!', 'SSLVPN: ����sendbuf�д���!');

insert into sslvpn values(13, 'SSLVPN: invalid recvbuf!', 'SSLVPN: ����recvbuf�д���!');
insert into sslvpn values(14, 'SSLVPN: invalid servermode!', 'SSLVPN: ����servermode�д���!');
insert into sslvpn values(15, 'SSLVPN: invalid routeaddrspace!', 'SSLVPN: ����routeaddrspace �д���!');

insert into sslvpn values(16, 'SSLVPN: invalid taportun!', 'SSLVPN: ����taportun�д���!');
insert into sslvpn values(17, 'SSLVPN: invalid bridgedev!', 'SSLVPN: ����bridgedev�д���!');
insert into sslvpn values(18, 'SSLVPN: invalid bridgedhcp!', 'SSLVPN: ����bridgedhcp�д���!');

insert into sslvpn values(19, 'SSLVPN: invalid bridgeaddrspace!', 'SSLVPN: ����bridgeaddrspace�д���!');
insert into sslvpn values(20, 'SSLVPN: invalid iporname!', 'SSLVPN: ����iporname�д���!');
insert into sslvpn values(21, 'SSLVPN: invalid ipaddr!', 'SSLVPN: ����ipaddr�д���!');

insert into sslvpn values(22, 'SSLVPN: invalid client2client!', 'SSLVPN: ����client2client�д���!');
insert into sslvpn values(23, 'SSLVPN: invalid clientdns!', 'SSLVPN: ����clientdns�д���!');
insert into sslvpn values(24, 'SSLVPN: invalid clientwins!', 'SSLVPN: ����clientwins �д���!');

insert into sslvpn values(25, 'SSLVPN: invalid welcomeinfo!', 'SSLVPN: ����welcomeinfo �д���!');
insert into sslvpn values(26, 'SSLVPN: invalid maxuser!', 'SSLVPN: ����maxuser�д���!');
insert into sslvpn values(27, 'SSLVPN: invalid float!', 'SSLVPN: ����float�д���!');

insert into sslvpn values(28, 'SSLVPN: invalid encryptalgid!', 'SSLVPN: ����encryptalgid�д���!');
insert into sslvpn values(29, 'SSLVPN: invalid hashalgid!', 'SSLVPN: ����hashalgid�д���!');
insert into sslvpn values(30, 'SSLVPN: invalid compress!', 'SSLVPN: ����compress�д���!');

insert into sslvpn values(31, 'SSLVPN: invalid detectperiod!', 'SSLVPN:����detectperiod�д���!');
insert into sslvpn values(32, 'SSLVPN: invalid overtime!', 'SSLVPN: ����overtime�д���!');
insert into sslvpn values(33, 'SSLVPN: invalid allowping!', 'SSLVPN: ����allowping �д���!');

insert into sslvpn values(34, 'SSLVPN: invalid allowadmin!', 'SSLVPN: ����allowadmin�д���!');
insert into sslvpn values(35, 'SSLVPN: invalid lockmax!', 'SSLVPN: ����lockmax�д���!');
insert into sslvpn values(36, 'SSLVPN: invalid lockperiod!', 'SSLVPN: ����lockperiod�д���!');

insert into sslvpn values(37, 'SSLVPN: invalid mtu!', 'SSLVPN: ����mtu�д���!');
insert into sslvpn values(38, 'SSLVPN: invalid allowdev!', 'SSLVPN: ����allowdev�д���!');

insert into sslvpn values(39, 'SSLVPN: invalid account!', 'SSLVPN: ����account�д���!');

insert into sslvpn values(40, 'SSLVPN: invalid password!', 'SSLVPN: ����password�д���!');
insert into sslvpn values(41, 'SSLVPN: invalid enabled!', 'SSLVPN: ����enabled�д���!');
insert into sslvpn values(42, 'SSLVPN: invalid virtualip!', 'SSLVPN: ����virtualip�д���!');

insert into sslvpn values(43, 'SSLVPN: invalid locknum!', 'SSLVPN: ����locknum�д���!');
insert into sslvpn values(44, 'SSLVPN: invalid locktime!', 'SSLVPN: ����locktime�д���!');

insert into sslvpn values(45, 'SSLVPN: invalid name!', 'SSLVPN: ����name�д���!');
insert into sslvpn values(46, 'SSLVPN: invalid address!', 'SSLVPN: ����address�д���!');
insert into sslvpn values(47, 'SSLVPN: invalid sort!', 'SSLVPN: ����sort�д���!');
insert into sslvpn values(48, 'SSLVPN: invalid note!', 'SSLVPN: ����note�д���!');



--������multiroute
--create by yuzy 2005/08/22
create table multiroute
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);

insert into multiroute values (0, 'Notice: execution success!', 'ע�⣺ִ�гɹ���');
insert into multiroute values (1, 'Error: DataBase process failed!', '�������ݿ����ʧ�ܣ�');
insert into multiroute values (2, 'Error: default route exist!', '���󣺸�Ĭ��·���Ѿ����ڣ�');
insert into multiroute values (3, 'Error: need same net!','���������ip��ַ������ӿ�ip����ͬһ���Σ�');
insert into multiroute values (4, 'Error: command line parameter error!', '���������в�������');
insert into multiroute values (5, 'Error: system call failed!', '����ϵͳ����ʧ�ܣ�');
insert into multiroute values (6, 'Error: invalid ip address!','������Ч��ip��ַ��');
insert into multiroute values (7, 'Error: invalid interface name!','������Ч�������豸�ӿ�����');
insert into multiroute values (8, 'Error: invalid weight value (1-255)!','������Ч��Ȩ��ֵ����ֵӦ����(1-255)֮�䣡');
insert into multiroute values (9, 'Error: cannot get local interface ip address!','���󣺲��ܻ�ȡ��������ӿ�ip��ַ��');
insert into multiroute values (10, 'Error: invalid active parameter!','������Ч��״̬������');
insert into multiroute values (11, 'Error: invalid frequency value!','������Ч��Ƶ�ʲ���ֵ��');
insert into multiroute values (12, 'Error: programe running!','���󣺳����Ѿ��������У�');
insert into multiroute values (13, 'Error: programe stopped!','���󣺳���û�����ã�');
insert into multiroute values (14, 'Error: net interface invalid!','���󣺶�Ӧ������ӿڱ����û򲻴��ڣ�');



--������neightab
--create by yuzy 2005/09/21
create table neightab
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);

insert into neightab values (0, 'Notice: execution success!', 'ע�⣺ִ�гɹ���');
insert into neightab values (1, 'Error: DataBase process failed!', '�������ݿ����ʧ�ܣ�');
insert into neightab values (2, 'Error: command line parameter error!', '���������в�������');
insert into neightab values (3, 'Error: system call failed!', '����ϵͳ����ʧ�ܣ�');
insert into neightab values (4, 'Error: invalid number!','������Ч�����֣�');


COMMIT;



