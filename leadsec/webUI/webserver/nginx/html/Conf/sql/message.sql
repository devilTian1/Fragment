
-- Use(Create database):
--   #sqlite message.db < message.sql

-- History:
-- 8. zhuxp	2004/1/31
--	  删除了fwips表，重新填写了interface表的内容
-- 7. liype 2003/12/31
--    导入Themis
-- 6. xiaowj 2003/11/28
--    刘天容替换本库
-- 5. xiaowj 2003/11/27
--    刘天容替换本库
-- 4. xiaowj 2003/11/25
--    刘天容修改本库，增加了一些记录
-- 3. xiaowj 2003/11/18
--    刘天容修改本库，增加了一些记录
-- 2. xiaowj 2003/11/03 
--    刘天容提交全新的数据库，无任何说明，要求替换
-- 1. liutr 2003/09/22 创建


BEGIN TRANSACTION;


-- 表名: public
create table public
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into public values (1, 'Error: invalid keyword "%s"', '错误：无效的关键字"%s"');
insert into public values (2, 'Error: file "%s" does not exist', '错误：文件"%s"不存在');
insert into public values (3, 'Error: network interface "%s" does not exist', '错误：网络接口"%s"不存在');
insert into public values (4, 'Error: network interface "%s" is disabled according to license', '错误：许可证禁用网络接口"%s"');
insert into public values (5, 'Error: database error','错误：数据库错误');
insert into public values (6, 'Error: ip address error','错误：IP地址错误');

-- 表名: address
create table address
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into address values (1, 'Error: address group "%s" already exists', '错误：地址组"%s"已存在');
insert into address values (2, 'Error: address "%s" already exists', '错误：地址"%s"已存在');
insert into address values (3, 'Error: address "%s" does not exist', '错误：地址"%s"不存在');
insert into address values (4, 'Error: address "%s" is in use', '错误：地址"%s"已被使用');
insert into address values (5, 'Error: address "%s" is used in SAT by rule and all the IP addresses in it must be firewall IP address', '错误：地址"%s"已被安全规则的SAT使用，它所包含的IP地址必须都是安全网关的IP地址');

-- 表名: addrgrp
create table addrgrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into addrgrp values (1, 'Error: address "%s" already exists', '错误：地址"%s"已存在');
insert into addrgrp values (2, 'Error: address group "%s" already exists', '错误：地址组"%s"已存在');
insert into addrgrp values (3, 'Error: address group "%s" does not exist', '错误：地址组"%s"不存在');
insert into addrgrp values (4, 'Error: address group "%s" is in use', '错误：地址组"%s"已被使用');
insert into addrgrp values (5, 'Notice: address "%s" does not exist', '注意：地址"%s"不存在');
insert into addrgrp values (6, 'Notice: address "%s" is already a member of address group "%s"', '注意：地址"%s"已是地址组"%s"的成员');
insert into addrgrp values (7, 'Notice: address "%s" is not a member of address group "%s"', '注意：地址"%s"不是地址组"%s"的成员');
insert into addrgrp values (8, 'Notice: address group "%s" is used in SAT by rule and all the IP addresses in it must be firewall IP address, address "%s" is not added', '错误：地址"%s"已被安全规则的SAT使用，它所包含的IP地址必须都是安全网关的IP地址，地址"%s"未被添加');

-- 表名: admacct
create table admacct
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into admacct values (1, 'Error: account "%s" already exists', '错误：账户"%s"已存在');
insert into admacct values (2, 'Error: account "%s" does not exist', '错误：账户"%s"不存在');
insert into admacct values (3, 'Error: account "%s" can not be deleted', '错误：账户"%s"不能被删除');
insert into admacct values (4, 'Error: account "%s" is not available', '错误：账户"%s"不可用');

-- 表名: admcert
create table admcert
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into admcert values (1, 'Error: file "%s" is not a PEM certificate file', '错误：文件"%s"不是PEM证书文件');
insert into admcert values (2, 'Error: certificates are not match', '错误：证书不匹配');
insert into admcert values (3, 'Error: certificate "%s" already exists', '错误：证书"%s"已存在');
insert into admcert values (4, 'Error: certificate "%s" does not exist', '错误：证书"%s"不存在');
insert into admcert values (5, 'Error: certificate "%s" is in use', '错误：证书"%s"已被使用');
insert into admcert values (6, 'Notice: certificate "%s" is already on', '注意：证书"%s"已被启用');
insert into admcert values (7, 'Notice: certificate "%s" is already off', '注意：证书"%s"已被禁用');

-- 表名: admhost
create table admhost
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into admhost values (1, 'Error: administration host IP address "%s" already exists', '错误：管理主机IP地址"%s"已存在');
insert into admhost values (2, 'Error: administration host IP address "%s" does not exist', '错误：管理主机IP地址"%s"不存在');
insert into admhost values (3, 'Error: administration host amount can not exceed %d', '错误：管理主机的数量不能超过%d');

-- 表名: admmode
create table admmode
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into admmode values (1, 'Notice: administration mode PPP is already started', '注意：PPP管理方式已启动');
insert into admmode values (2, 'Notice: administration mode console is already stopped', '注意：控制台管理方式已停止');
insert into admmode values (3, 'Notice: administration mode SSH is already started', '注意：SSH管理方式已启动');
insert into admmode values (4, 'Notice: administration mode SSH is already stopped', '注意：SSH管理方式已停止');
insert into admmode values (5, 'Error: administration mode PPP is enabled', '错误：PPP管理方式已启用');

-- 表名: antiatk
create table antiatk
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into antiatk values (1, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');
insert into antiatk values (2, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');
insert into antiatk values (3, 'Error: SYN speed value must be from 0 to 65535', '错误：SYN包速率必须在0至65535之间');
insert into antiatk values (4, 'Error: ICMP speed value must be from 0 to 65535', '错误：ICMP包速率必须在0至65535之间');
insert into antiatk values (5, 'Error: ICMP length value must be from 0 to 65535', '错误：ICMP包长度必须在0至65535之间');
insert into antiatk values (6, 'Error: UDP speed value must be from 0 to 65535', '错误：UDP包速率必须在0至65535之间');

-- 表名: authserver
create table authserver
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into authserver values (1, 'Notice: local authentication server is already enabled', '注意：本地认证服务器已经启用');
insert into authserver values (2, 'Notice: RADIUS authentication server is already enabled', '注意：RADIUS认证服务器已经启用');

-- 表名: bandwidth
create table bandwidth
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into bandwidth values (0, 'Notice: excution success', '注意：执行成功');
insert into bandwidth values (1, 'Error: command line error','错误：命令行参数错误');
insert into bandwidth values (2, 'Error: database error','错误：操作数据库错误');
insert into bandwidth values (3, 'Error: data does not exist','错误：数据不存在');
insert into bandwidth values (4, 'Error: data exist','错误：数据已经存在');
insert into bandwidth values (5, 'Error: data exceed max limit','错误：数据超过最大限制');
insert into bandwidth values (6, 'Error: memory error','错误：内存出错');
insert into bandwidth values (7, 'Error: logic check error','错误：逻辑检查错误');
insert into bandwidth values (8, 'Error: system command error','错误：系统命令错误');
insert into bandwidth values (10, 'Error: error-> %s','错误：错误在 %s');
insert into bandwidth values (11, 'Error: name %s already exists', '错误：命名%s已存在，请换一个不重复的命名');
insert into bandwidth values (12, 'Error: maximum bandwidth must be equal or larger than minimum bandwidth', '错误：最大带宽必须大于或等于保证带宽');
insert into bandwidth values (13, 'Error: parent minimum bandwidth overflow ', '错误：保证带宽越界');
insert into bandwidth values (14, 'Error: parent maximum bandwidth overflow, exceed network dev bandwidth ', '错误：最大带宽越界，超过网络设备设定的带宽');
insert into bandwidth values (15, 'Error: please input name ', '错误：请输入修改项的名称');
insert into bandwidth values (16, 'Error: bandwidth parent %s does not exist ', '错误：%s 不存在');
insert into bandwidth values (17, 'Error: bandwidth parent %s exceed max child num  ', '错误：%s 拥护子类数量超过最大值');
insert into bandwidth values (18, 'Error: device %s exceed max parent num  ', '错误：设备%s 拥护父类数量超过最大值');
insert into bandwidth values (19, 'Error: bandwidth parent %s is referenced %d, can not be deleted ', '错误：%s 被引用%d处，不能被删除 ');
insert into bandwidth values (20, 'Error: bandwidth group exceed max num !', '错误：带宽资源组超过最大数量');
insert into bandwidth values (21, 'Error: bandwidth group %s does not exist ', '错误：带宽资源组%s不存在');
insert into bandwidth values (22, 'Error: bandwidth group %s add member %s fail, maybe member does not exist ', '错误：带宽资源组%s添加成员%s失败，原因可能是成员不存在');
insert into bandwidth values (23, 'Error: bandwidth group %s del member %s fail, maybe member does not exist ', '错误：带宽资源组%s删除成员%s失败，原因可能是成员不存在');
insert into bandwidth values (24, 'Error: bandwidth group %s is referenced by %d group members, can not be deleted ', '错误：%s 被%d成员引用，不能被删除 ');
insert into bandwidth values (25, 'Error: bandwidth child %s is referenced %d, can not be deleted ', '错误：%s 被引用%d处，不能被删除 ');
insert into bandwidth values (26, 'Error: bandwidth priority value must be 1 - 7 ', '错误：带宽优先级必须为1-7之间的数值');
insert into bandwidth values (27, 'Error: bandwidth group %s is referenced by %d bwrules, can not be deleted ', '错误：%s 被%d条带宽规则引用，不能被删除 ');
insert into bandwidth values (28, 'Error: child minimum bandwidth overflow ', '错误：保证带宽越界');
insert into bandwidth values (29, 'Error: child maximum bandwidth overflow, exceed parent max bandwidth ', '错误：子带宽的最大带宽超过父带宽的最大带宽');
insert into bandwidth values (30, 'Error: sum of childs minimum bandwidth overflow, exceed parent max bandwidth ', '错误：子带宽的保证带宽之和超过父带宽的最大带宽');
insert into bandwidth values (31, 'Error: sum of parent maximum bandwidth overflow, exceed network dev bandwidth ', '错误：同一网络设备的带宽之和越界，超过网络设备设定的带宽');

-- 表名: bw
create table bw
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into bw values (1, 'Error: command line error', '错误：命令行参数错误！');
insert into bw values (3, 'Error: rule set error', '错误：规则维护错误！');
insert into bw values (4, 'Error: db accessing error', '错误：数据库访问错误！');
insert into bw values (5, 'Error: coming interface  illegal', '错误：流入网口不合法！');
insert into bw values (10, 'Error: command line error', '错误：命令行错误！');
insert into bw values (21, 'Error: sport check error', '错误：源端口输入错误！');
insert into bw values (25, 'Error: can not set service as any and sport in the same time', '错误：所选服务不能选源端口！');
insert into bw values (30, 'Error: rule download error', '错误：规则生效错误！');
insert into bw values (31, 'Error: bandwidth rule amount can not exceed %d', '错误：带宽管理规则的数量不能超过%d');

-- 表名: vpnekey
create table vpnekey
(
	id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into vpnekey values (0, 'Notice: excution success', '注意：执行成功');
insert into vpnekey values (1, 'Error: command line error','错误：命令行参数错误');
insert into vpnekey values (2, 'Error: operator database error','错误：操作数据库错误');
insert into vpnekey values (3, 'Error: data does not exist','错误：数据不存在');
insert into vpnekey values (4, 'Error: data exist','错误：数据已经存在');
insert into vpnekey values (5, 'Error: data exceed max limit','错误：数据超过最大限制');
insert into vpnekey values (6, 'Error: memory error','错误：内存出错');
insert into vpnekey values (7, 'Error: logic check error','错误：逻辑检查错误');
insert into vpnekey values (8, 'Error: system command error','错误：系统命令错误');
insert into vpnekey values (9, 'Error: acsc close ','错误：功能已经关闭');
insert into vpnekey values (11,'Error: miss parameter','错误：命令行缺少参数');

insert into vpnekey values (20, 'Error: please use on/off to enable or disable', '错误：请使用on/off来启用或停止某功能');


-- 表名: blacklist
create table blacklist
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into blacklist values (1, 'Error: blacklist amount can not exceed %d', '错误：黑名单的数量不能超过%d');

-- 表名: config
create table config
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into config values (1, 'Please reboot system.', '请重新启动系统');
insert into config values (2, 'Error: malformed file "%s"', '错误：文件"%s"格式错误');
insert into config values (3, 'Error: firewall version mismatch', '错误：安全网关版本不匹配');

-- 表名: controlkw
create table controlkw
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into controlkw values (1, 'Error: control keyword amount can not exceed %d', '错误：网页关键字的数量不能超过%d');



-- 表名: ddns
create table ddns
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into ddns values (1,'Error: username length error or contains illegal character "%s"','错误：用户名长度错误或者包含非法字符 "%s"');
insert into ddns values (2,'Error: password length error or contains illegal character "%s"','错误：密码长度错误或者包含非法字符 "%s"');
insert into ddns values (3,'Error: confirm password error "%s"','错误：确认密码错误 "%s"');
insert into ddns values (4,'Error: password and confirm are not same','错误：密码与确认密码不一致');
insert into ddns values (5,'Error: username,password can not be empty','错误：用户名密码不能为空');

-- 表名：dial
create table dial
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into dial values (1,'Error: parse error','错误：命令格式错误');
insert into dial values (2,'Error: open database error','错误：打开数据库失败');
insert into dial values (3,'Error: select database error','错误：读取数据库失败');
insert into dial values (4,'Error: insert database error','错误：插入数据库失败');
insert into dial values (5,'Error: delete database error','错误：删除数据库失败');
insert into dial values (6,'Error: update database error','错误：更新数据库失败');
insert into dial values (7,'Error: unknown','错误：未知错误');
insert into dial values (8,'Error: param error','错误：命令参数错误');
insert into dial values (9,'Error: dial error','错误：拨号失败，请检查Modem连接配置是否正确');
insert into dial values (10,'Error: stop error','错误：断开失败');
insert into dial values (11,'Error: dial error','错误：拨号失败，请检查Modem连接配置是否正确，用户名口令是否正确。');

-- 表名: ha
create table ha
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into ha values (1, 'Error: HA is started', '错误：集群已经启用');
insert into ha values (2, 'Error: HA is stopped', '错误：集群已经停止');
insert into ha values (3, 'Error: IP address "%s/%s" is invalid', '错误：IP地址"%s/%s"不合法');
insert into ha values (4, 'Error: node must be from 1 to 4', '错误：节点号必须在1至4之间');
insert into ha values (5, 'Error: id must be from 1 to 255', '错误：ID号必须在1至255之间');
insert into ha values (6, 'Error: HA is not set', '错误：集群未设置');
insert into ha values (7, 'Error: IP address "%s/%s" and firewall IP address "%s/%s" are in the same subnet', '错误：IP地址"%s/%s"和安全网关地址"%s/%s"在同一子网');
insert into ha values (8, 'Error: IP address "%s/%s" and SAT address "%s" are in the same subnet', '错误：IP地址"%s/%s"和地址池"%s"在同一子网');
insert into ha values (9, 'Error: network interface "%s" is in broute mode', '错误：网络接口"%s"工作在混合模式');

-- 表名: hadetect
create table hadetect
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into hadetect values (1, 'Error: weight must be from 1 to 100', '错误：权重必须在0至100之间');
insert into hadetect values (2, 'Error: IP address "%s" already exists', '错误：IP地址"%s"已存在');
insert into hadetect values (3, 'Error: IP address "%s" does not exist', '错误：IP地址"%s"不存在');
insert into hadetect values (4, 'Error: threshold must be from 1 to 100', '错误：阈值必须在1至100之间');
insert into hadetect values (5, 'Error: HA is stopped', '错误：集群已经停止');
insert into hadetect values (6, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');

-- 表名: hostname
create table hostname
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into hostname values (1,'Error: hostname error %s','错误：安全网关名称错误');
insert into hostname values (2,'Error: hostname can not be empty','错误：安全网关名称不能为空');

-- 表名: interface
create table interface
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into interface values (1, 'Error: interface name error "%s"', '错误：网络设备名称错误 "%s"');
insert into interface values (2, 'Error: vlan id must be from 0 to 4094', '错误: vlan id 必须在0至4094之间');
insert into interface values (3, 'Error: ip format error "%s"', '错误：IP地址格式错误 "%s"');
insert into interface values (4, 'Error: netmask format error "%s"', '错误：掩码格式错误 "%s"');
insert into interface values (5, 'Error: mac format error "%s"', '错误：MAC地址格式错误 "%s"');
insert into interface values (6, 'Error: please user on/off to enable or disable', '错误：请使用on/off来启用或停止某功能');
insert into interface values (7, 'Error: please set bind device', '错误: 请指定绑定设备');
insert into interface values (8, 'Error: please set vlan id', '错误：请指定VLAN ID');
insert into interface values (9, 'Error: enable device,place set ip/netmask','错误：启用设备，请指定其IP地址和掩码');
insert into interface values (10,'Error: interface_list is comma seperated string,no space,device name can not be duplicated','错误：设备列表是英文逗号分割的字符串,没有空格,设备名不能重复');
insert into interface values (11,'Error: please set device name','错误: 请指定设备名称');
insert into interface values (12,'Error: alias id must be from 0 to 252','错误：别名ID必须在0至252之间');
insert into interface values (13,'Error: please set alias id','错误：请指定ALIAS ID');
insert into interface values (14,'Error: device does not exist','错误：设备不存在');
insert into interface values (15,'Error: linkmode can only be set to auto,full,half','错误：链路模式只能设置为 自适应，全双工，半双工');
insert into interface values (16,'Error: 10,100M device MTU 68-1504; 1000M device MTU 64-16128', '错误：十兆，百兆设备，MTU是68-1504;千兆设备，MTU是64-16128');
insert into interface values (17,'Error: ipaddr type error','错误：IP地址获取类型错误');
insert into interface values (18,'Error: ddns domain name error "%s"','错误：动态注册域名错误 "%s"');
insert into interface values (19,'Error: workmode error','错误：工作模式错误');
insert into interface values (20,'Error: transparent mode can only work with ipaddr_type=static and ip/mask not set','错误：透明模式下，地址获取类型必须是静态指定，并且IP/掩码为空');
insert into interface values (21,'Error: default bridge brg0 can not be deleted','错误：缺省桥接设备brg0不允许被删除');
insert into interface values (22,'Notice: excution success','注意：执行成功');
insert into interface values (23,'Error: command line error','错误：命令行参数错误');
insert into interface values (24,'Error: system error','错误：系统错误');
insert into interface values (25,'Error: database error','错误：数据库错误');
insert into interface values (26,'Error: device already exist','错误：设备已存在');
insert into interface values (27,'Error: device does not exist' ,'错误：设备不存在');
insert into interface values (28,'Error: memory error','错误：内存错误');
insert into interface values (29,'Error: config error,please check config parameters','错误：配置错误，请检查配置参数');
insert into interface values (30,'Error: bind device alreay enable qos "%s"','错误：绑定设备已启用了带宽管理 "%s"');
insert into interface values (31,'Error: device bound on this device already enable qos','错误：绑定此设备的设备已启用了带宽管理');
insert into interface values (32,'Error: this device already binded as vlan device,can not work with trunk','错误：此设备已绑定为VLAN设备，不能再启用TRUNK');
insert into interface values (33,'Error: device type error','错误：设备类型错误');
insert into interface values (34,'Error: physical device and vpn,dial device can not be deleted','错误：物理设备和VPN设备,拨号设备不能被删除');
insert into interface values (35,'Error: device is referenced by "%s",can not be deleted','错误：设备被 "%s" 引用，不能被删除');
insert into interface values (36,'Error: "%s" is active, do not stop "%s"','错误："%s" 处于激活状态，不能停止 "%s"');
insert into interface values (37,'Error: speed can only be set to 10,100,100','错误：设备速度只能设置为10,100,100');
insert into interface values (38,'Error: ip,mask,mac can not be empty in full rd mode','错误：全冗余模式下IP地址，掩码，MAC地址不能为空');
insert into interface values (39,'Error: admin,ping,traceroute, please set ip/netmask','错误：如果允许管理，PING,TRACEROUTE,请设置IP地址/掩码');
insert into interface values (40,'Error: redundency device interface list at least have one bind device','错误:冗余设备绑定设备列表至少有一个绑定设备');
insert into interface values (41,'Error: bind device can not be added multi times','错误：同一绑定设备不能多次加入');
insert into interface values (43,'Error: bind device has no ip','错误：绑定设备没有IP地址');
insert into interface values (44,'Error: ip list duplicated','错误：IP地址重复');
insert into interface values (45,'Error: "%s" does not work in transparent mode','错误："%s"没有工作在透明模式');
insert into interface values (46,'Error: "%s" bind as vpn or dial','错误："%s"被VPN设备或拨号设备绑定');
insert into interface values (47,'Error: device name duplicated','错误：设备名重复');
insert into interface values (48,'Error: vlan bind device should be physical or redundency device','错误：VLAN设备的绑定设备必须是物理设备或冗余设备');
insert into interface values (49,'Error: bind device already trunk,can not be bound as vlan','错误：绑定设备已启用了TRUNK，不能再作为VLAN的绑定设备');
insert into interface values (50,'Error: can not config more than two PPPoE','错误：不能配置多于两个PPPoE');
insert into interface values (51,'Error: device bandwidth error,please set according to device speed,bandwidth can not be 0','错误：设备带宽错误，请根据设备速度设定，带宽不能为0');
insert into interface values (52,'Notice: device is not valid','注意：设备无效');
insert into interface values (53,'Notice: bind device is not valid','注意：绑定设备无效');
insert into interface values (54,'Notice: interface list has invalid device "%s"','注意：设备列表中有无效设备 "%s"');
insert into interface values (55,'Error: bind device is not enabled,this device can not be enabled','错误：绑定设备未启用，不能启用此设备');
insert into interface values (56,'Error: interface list has disabled device "%s"','错误：设备列表中有未启用的设备 "%s"');
insert into interface values (57,'Error: resource "%s" does not exist','错误：资源 "%s" 不存在');
insert into interface values (58,'Error: username length error or contains illegal character "%s"','错误：用户名长度错误或者包含非法字符 "%s"');
insert into interface values (59,'Error: password length error or contains illegal character "%s"','错误：密码长度错误或者包含非法字符 "%s"');
insert into interface values (60,'Error: ip list is comma seperated,not space','错误：IP列表用英文逗号分隔，不能有空格');
insert into interface values (61,'Error: enable dial device,username/password can not be empty','错误：启用拨号设备，用户名密码不能为空');
insert into interface values (62,'Error: alias device ip can not be zero','错误：别名设备的IP地址不能为空');
insert into interface values (63,'Error: switch to transparent mode would make vpn device "%s" unusable,please stop that first','错误：切换到透明模式将导致VPN设备 "%s" 不可用，请先停止它');
insert into interface values (64,'Error: switch to transparent mode would make alias device "%s" unusable,please stop that first','错误：切换到透明模式将导致别名设备 "%s" 不可用，请先停止它');
insert into interface values (65,'Error: switch to transparent mode would make addrpool resource "%s" unusable,please delete that first','错误：切换到透明模式将导致地址池资源 "%s" 不可用，请先删除它');
insert into interface values (66,'Error: set ip address to null would make vpn device "%s" unusable,please stop that first','错误：将IP地址置为空将导致VPN设备 "%s" 不可用，请先停止它');
insert into interface values (67,'Error: alias bind device should be physical,redundency,vlan or bridge device','错误：别名设备的绑定设备必须是物理，冗余，VLAN或桥接设备');
insert into interface values (68,'Error: alias bind device should work in route mode','错误：别名设备的绑定设备必须工作在路由模式下');
insert into interface values (69,'Error: vpn bind device should be physical,redundency,vlan,bridge or dial device','错误：VPN设备的绑定设备必须是物理设备，冗余设备，VLAN设备，桥接设备或拨号设备');
insert into interface values (70,'Error: dial bind device should be physical,redundency device','错误：拨号设备的绑定设备必须是物理设备或冗余设备');
insert into interface values (71,'Error: switch to transparent mode would make redundency device "%s" unusable,please delete that first','错误：切换到透明模式将导致冗余设备"%s"不可用，请先删除它');
insert into interface values (72,'Error: device "%s" work in transparent mode','错误：设备"%s"工作在透明模式');
insert into interface values (73,'Error: device "%s" is already used by ha module','错误：设备"%s"已被HA模块使用');
insert into interface values (74,'Error: device "%s" is already in redundency device','错误：设备"%s"已被冗余设备使用'); 
insert into interface values (75,'Error: bridge device "%s" is not enable','错误：桥设备 "%s" 没有启用');
insert into interface values (76,'Error: this device is bound by redundency device,can not be enabled manually','错误：此设备是冗余设备的绑定设备，不允许手动启用');
insert into interface values (77,'Error: can not add more than 64 vlan devices','错误：添加VLAN设备的数量不能超过64');
insert into interface values (78,'Error: alias bind device amount can not exceed %d', '错误：别名设备的数量不能超过%d');
insert into interface values (79,'Error: alias id must be from 0 to 7','错误：别名ID必须在0至7之间');
insert into interface values (80,'Error: switch to redundency mode would make vpn device "%s" unusable,please stop that first','错误：切换到冗余模式将导致VPN设备 "%s" 不可用，请先停止它');
insert into interface values (81,'Error: switch to redundency mode would make alias device "%s" unusable,please stop that first','错误：切换到冗余模式将导致别名设备 "%s" 不可用，请先停止它');
insert into interface values (82,'Error: redundency mode can only work with ipaddr_type=static and ip/mask not set','错误：冗余模式下，地址获取类型必须是静态指定，并且IP/掩码为空');
insert into interface values (83,'Error: switch to redundency mode would make transparent device "%s" unusable,please delete that first','错误：切换到冗余模式将导致透明设备"%s"不可用，请先删除它');
insert into interface values (84,'Error: switch to redundency mode would make vlan device "%s" unusable,please stop that first','错误：切换到冗余模式将导致VLAN设备 "%s" 不可用，请先停止它');
insert into interface values (85,'Error: device "%s" need work in redundency mode','错误：设备"%s"需要工作在冗余模式');
insert into interface values (86,'Error: redundency device option workmode can only be set to balance-rr,backup,balance-xor,broadcast,802.3ad,balance-tlb,balance-alb','错误：冗余设备的工作模式只能设置为轮循均衡，双口热备，广播，802.3ad，tlb均衡，alb均衡');
insert into interface values (87,'Error: redundency device option linkwatch 100-3000','错误：冗余设备参数linkwatch数值范围为100-3000');
insert into interface values (88,'Error: redundency device option updelay/downdelay must be number,default 0','错误：冗余设备参数updelay/downdelay必须为数字,默认为0');
insert into interface values (89,'Error: please use slow/fast ','错误：请使用关键字 slow/fast');
insert into interface values (90,'Notice: redundency device option change, need reboot system, please save config','注意：冗余设备全局参数变更，系统需要重启才能生效，请在重启前保存配置');
insert into interface values (91,'Error: dhcpclient error','错误：设置dhcpclient发生错误');
insert into interface values (92,'Error: switch to transparent mode would make dial device "%s" unusable,please stop that first','错误：切换到透明模式将导致拨号设备 "%s" 不可用，请先停止它');
insert into interface values (93,'Notice: disable device would make firewall unmanagable,please unset admin value first','注意：停止设备将导致设备不可管理，请先停止设备的允许管理属性');
insert into interface values (94,'Error: bind device work in redundency mode','错误：绑定设备工作在冗余模式');

-- 表名: linkage
create table linkage
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into linkage values (1, 'Error: PUMA service is started', '错误：PUMA服务已经启动');
insert into linkage values (2, 'Error: Venus service is started', '错误："天阗"服务已经启动');
insert into linkage values (3, 'Error: Netpower service is started', '错误："天眼"服务已经启动');
insert into linkage values (4, 'Error: SafeMate service is started', '错误：SafeMate服务已经启动');
insert into linkage values (5, 'Error: PUMA service can not be started', '错误：PUMA服务不能启动');
insert into linkage values (6, 'Error: Venus service can not be started', '错误："天阗"服务不能启动');
insert into linkage values (7, 'Error: Netpower service can not be started', '错误："天眼"服务不能启动');
insert into linkage values (8, 'Error: SafeMate service can not be started', '错误：SafeMate服务不能启动');
insert into linkage values (9, 'Error: too many IP addresses', '错误：IP地址过多');
insert into linkage values (10, 'Error: password must be 9 characters', '错误：密码必须为9个字符');
insert into linkage values (11, 'Error: port "%d" is in use', '错误：端口"%d"已被使用');
insert into linkage values (12, 'Error: malformed key file "%s"', '错误：文件"%s"格式错误');
insert into linkage values (13, 'Error: PUMA service is not set', '错误：PUMA服务未设置');
insert into linkage values (14, 'Error: Venus service is not set', '错误："天阗"服务未设置');
insert into linkage values (15, 'Error: Netpower service is not set', '错误："天眼"服务未设置');
insert into linkage values (16, 'Error: SafeMate service is not set', '错误：SafeMate服务未设置');

-- 表名: macbind
create table macbind
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into macbind values (1, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');
insert into macbind values (2, 'Error: IP address "%s" is already binded with MAC address "%s"', '错误：IP地址"%s"已经与MAC地址"%s"绑定');
insert into macbind values (3, 'Error: uniqueness conflict, MAC address "%s" is already binded with IP address "%s"', '错误：唯一性冲突，MAC地址"%s"已经与IP地址"%s"绑定');
insert into macbind values (4, 'Error: IP address "ip" is not binded', '错误：IP地址"%s"未被绑定');
insert into macbind values (5, 'Error: IP/mac bind amount can not exceed %d', '错误：已绑定IP/MAC对的数量不能超过%d');

-- 表名: mailfilter
create table mailfilter
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into mailfilter values (1, 'Error: too many keywords', '错误：关键字过多');

-- 表名: ntp
create table ntp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into ntp values (1, 'Error: interval must be from 1 to 65535', '错误：时间间隔必须在1至65535之间');
insert into ntp values (2, 'Error: NTP is started', '错误：时间同步已经启用');
insert into ntp values (3, 'Error: NTP is not set', '错误：时间同步未设置');
insert into ntp values (4, 'Error: NTP is stopped', '错误：时间同步已经停止');
insert into ntp values (5, 'Error: NTP sync failed', '错误：时间同步失败');

-- 表名: proxy
create table proxy
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into proxy values (1, 'Error: HTTP proxy is started', '错误：HTTP代理已经启动');
insert into proxy values (2, 'Error: FTP proxy is started', '错误：FTP代理已经启动');
insert into proxy values (3, 'Error: TELNET proxy is started', '错误：TELNET代理已经启动');
insert into proxy values (4, 'Error: SMTP proxy is started', '错误：SMTP代理已经启动');
insert into proxy values (5, 'Error: POP3 proxy is started', '错误：POP3代理已经启动');
insert into proxy values (6, 'Error: SOCKS proxy is started', '错误：SOCKS代理已经启动');
insert into proxy values (7, 'Error: HTTP proxy can not be started', '错误：HTTP代理不能启动');
insert into proxy values (8, 'Error: FTP proxy can not be started', '错误：FTP代理不能启动');
insert into proxy values (9, 'Error: TELNET proxy can not be started', '错误：TELNET代理不能启动');
insert into proxy values (10, 'Error: SMTP proxy can not be started', '错误：SMTP代理不能启动');
insert into proxy values (11, 'Error: POP3 proxy can not be started', '错误：POP3代理不能启动');
insert into proxy values (12, 'Error: SOCKS proxy can not be started', '错误：SOCKS代理不能启动');
insert into proxy values (13, 'Error: default proxy "%s" already exists', '错误：预定义代理"%s"已存在');
insert into proxy values (14, 'Error: custom proxy "%s" already exists', '错误：自定义代理"%s"已存在');
insert into proxy values (15, 'Error: custom proxy "%s" does not exist', '错误：自定义代理"%s"不存在');
insert into proxy values (16, 'Error: custom proxy "%s" is started', '错误：自定义代理"%s"已经启动');
insert into proxy values (17, 'Error: custom proxy "%s" can not be started', '错误：自定义代理"%s"不能启动');
insert into proxy values (18, 'Error: port "%d" is in use', '错误：端口"%d"已被使用');
insert into proxy values (19, 'Error: max length must be from %d to %d', '错误：最大邮件长度必须在%d至%d之间');
insert into proxy values (20, 'Error: max receiver must be from %d to %d', '错误：最多接收人数必须在%d至%d之间');
insert into proxy values (21, 'Error: custom proxy "%s" is in use', '错误：自定义代理"%s"已被使用');

-- 表名: route
create table route
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into route values (1, 'Error: gateway "%s" is unreachable', '错误：网关"%s"不可达');
insert into route values (2, 'Error: source IP address and destination IP address can not be both "any"', '错误：源IP地址和目的IP地址不能都是"any"');
insert into route values (3, 'Error: source IP address route can not be used on the network interface "ha" or "mng"', '错误：不能在网络接口"ha"或"mng"上使用源路由');
insert into route values (4, 'Error: static route already exists', '错误：静态路由已存在');
insert into route values (5, 'Error: source IP address route amount can not exceed %d', '错误：源路由的数量不能超过%d');
insert into route values (6, 'Error: static route does not exist', '错误：静态路由不存在');
insert into route values (7, 'Error: static route amount can not exceed %d', '错误：静态路由的数量不能超过%d');

-- 表名: rule
create table rule
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into rule values (1, 'Error: address "%s" does not exist', '错误：地址"%s"不存在');
insert into rule values (2, 'Error: "%s" is not firewall IP address', '错误："%s"不是安全网关IP地址');
insert into rule values (3, 'Error: SAT address "%s" does not exist', '错误：地址池"%s"不存在');
insert into rule values (4, 'Error: server address "%s" does not exist', '错误：服务器地址"%s"不存在');
insert into rule values (5, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');
insert into rule values (6, 'Error: service "%s" does not exist', '错误：服务"%s"不存在');
insert into rule values (7, 'Error: proxy "%s" does not exist', '错误：代理"%s"不存在');
insert into rule values (8, 'Error: time "%s" does not exist', '错误：时间定义"%s"不存在');
insert into rule values (9, 'Error: bandwidth "%s" does not exist', '错误：带宽定义"%s"不存在');
insert into rule values (10, 'Error: URL rule "%s" does not exist', '错误：URL规则"%s"不存在');
insert into rule values (11, 'Error: service "%s" has non TCP protocol', '错误：服务"%s"包含非TCP协议');
insert into rule values (12, 'Error: destination port must be single port', '错误：目的端口必须是单个端口');
insert into rule values (13, 'Error: when custom proxy be used, destination IP address must be single IP address', '错误：使用用户自定义代理时，目的IP地址必须是单个IP地址');
insert into rule values (14, 'Error: argument "sat" can not be "none" in "nat" rule', '错误：在NAT类型的安全规则中,源地址转换参数不能为"none"');
insert into rule values (15, 'Error: public service and inner service are not match', '错误：对外服务和内部服务不匹配');
insert into rule values (16, 'Error: public service "%s" has non TCP protocol', '错误：对外服务"%s"包含非TCP协议');
insert into rule values (17, 'Error: inner service "%s" has non TCP protocol', '错误：内部服务"%s"包含非TCP协议');
insert into rule values (18, 'Error: rule id "%d" does not exist', '错误：ID为"%d"的安全规则不存在');
insert into rule values (19, 'Error: rule types are not compatible', '错误：安全规则类型不兼容');
insert into rule values (20, 'Error: argument "%s" is not compatible with type "%s"', '错误：参数"%s"与安全规则类型"%s"不兼容');
insert into rule values (21, 'Error: destination port can not be "%d"', '错误：目的端口不能是"%d"');
insert into rule values (22, 'Error: packet filter rule amount can not exceed %d', '错误：包过滤规则的数量不能超过%d');
insert into rule values (23, 'Error: portmap rule amount can not exceed %d', '错误：端口映射规则的数量不能超过%d');
insert into rule values (24, 'Error: ipmap rule amount can not exceed %d', '错误：IP映射规则的数量不能超过%d');
insert into rule values (25, 'Error: nat rule amount can not exceed %d', '错误：NAT规则的数量不能超过%d');
insert into rule values (26, 'Error: proxy rule amount can not exceed %d', '错误：代理规则的数量不能超过%d');

-- 表名: sataddr
create table sataddr
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into sataddr values (1, 'Error: SAT address "%s" already exists', '错误：地址池"%s"已存在');
insert into sataddr values (2, 'Error: no network interface is in broute mode', '错误：没有网络接口工作在混合模式');
insert into sataddr values (3, 'Error: network interface "%s" is in broute mode', '错误：网络接口"%s"工作在混合模式');
insert into sataddr values (4, 'Error: IP address "%s:%s" and HA IP address "%s/%s" are in the same subnet', '错误：IP地址"%s:%s"与集群IP地址"%s/%s"在同一子网');
insert into sataddr values (5, 'Error: SAT address "%s" does not exist', '错误：地址池"%s"不存在');
insert into sataddr values (6, 'Error: IP address "%s" belongs to SAT address "%s"', '错误：IP地址"%s"属于地址池"%s"');
insert into sataddr values (7, 'Error: IP address "%s" is firewall IP address', '错误：IP地址"%s"是安全网关IP地址');
insert into sataddr values (8, 'Error: SAT address "%s" is in use', '错误：地址池"%s"已被使用');
insert into sataddr values (9, 'Error: can not include reserved IP address "%s"', '错误：不能包含保留IP地址"%s"');
insert into sataddr values (10, 'Error: can not include more than %d IP addresses', '错误：IP地址不能超过%d个');
insert into sataddr values (11, 'Error: invalid IP address "%s"', '错误：无效的IP地址"%s"');
insert into sataddr values (12, 'Error: IP address "%s:%s" and firewall IP address "%s/%s" on network interface "%s" are in the same subnet', '错误：IP地址"%s:%s"与安全网关IP地址"%s/%s"(在网络接口"%s"上)在同一子网');
insert into sataddr values (13, 'Error: IP address "%s:%s" and SAT address "%s" on network interface "%s" are in the same subnet', '错误：IP地址"%s:%s"与地址池"%s"(在网络接口"%s"上)在同一子网');
insert into sataddr values (14, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');

-- 表名: serveraddr
create table serveraddr
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into serveraddr values (1, 'Error: server address "%s" already exists', '错误：服务器地址"%s"已存在');
insert into serveraddr values (2, 'Error: server address "%s" does not exist', '错误：服务器地址"%s"不存在');
insert into serveraddr values (3, 'Error: server address amount can not exceed %d', '错误：服务器地址的数量不能超过%d');
insert into serveraddr values (4, 'Error: weight must be from 0 to 65535', '错误：权重必须在0至65535之间');
insert into serveraddr values (5, 'Error: server address "%s" is in use', '错误：服务器地址"%s"已被使用');

-- 表名: servgrp
create table servgrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into servgrp values (1, 'Error: default service "%s" already exists', '错误：预定义服务"%s"已存在');
insert into servgrp values (2, 'Error: custom service "%s" already exists', '错误：自定义服务"%s"已存在');
insert into servgrp values (3, 'Error: service group "%s" already exists', '错误：服务组"%s"已存在');
insert into servgrp values (4, 'Error: service group "%s" does not exist', '错误：服务组"%s"不存在');
insert into servgrp values (5, 'Error: service "%s" does not exist', '错误：服务"%s"不存在');
insert into servgrp values (6, 'Error: service group "%s" is in use', '错误：服务组"%s"已被使用');
insert into servgrp values (7, 'Notice: service "%s" is already a member of serivce group "%s"', '注意：服务"%s"已是服务组"%s"的成员');
insert into servgrp values (8, 'Notice: service "%s" is not a member of serivce group "%s"', '注意：服务"%s"不是服务组"%s"的成员');

-- 表名: service
create table service
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into service values (1, 'Error: default service "%s" already exists', '错误：预定义服务"%s"已存在');
insert into service values (2, 'Error: custom service "%s" already exists', '错误：自定义服务"%s"已存在');
insert into service values (3, 'Error: service group "%s" already exists', '错误：服务组"%s"已存在');
insert into service values (4, 'Error: custom service "%s" does not exist', '错误：自定义服务"%s"不存在');
insert into service values (5, 'Error: service "%s" does not exist', '错误：服务"%s"不存在');
insert into service values (6, 'Error: custom service "%s" is in use', '错误：自定义服务"%s"已被使用');
insert into service values (7, 'Error: protocol number must be from 0 to 255, excluding 1(ICMP), 6(TCP) and 17(UDP)', '错误：协议号必须在0至255之间，不包括1(ICMP)、6(TCP)和17(UDP)');
insert into service values (8, 'Error: custom service type can not be changed', '错误：不能改变自定义服务的类型');

-- 表名: system
create table system
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into system values (1, 'Error: network interface "%s" can not be used', '错误：不能使用网络接口"%s"');

-- 表名: time
create table time
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into time values (1, 'Error: time group "%s" already exists', '错误：时间组"%s"已存在');
insert into time values (2, 'Error: time "%s" already exists', '错误：时间定义"%s"已存在');
insert into time values (3, 'Error: time "%s" does not exist', '错误：时间定义"%s"不存在');
insert into time values (4, 'Error: time "%s" is in use', '错误：时间定义"%s"已被使用');
insert into time values (5, 'Error: time type mismatch', '错误：时间定义类型不匹配');
insert into time values (6, 'Error: start time must be early than stop time', '错误：开始时间必须早于结束时间');

-- 表名: timegrp
create table timegrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into timegrp values (1, 'Error: time "%s" already exists', '错误：时间定义"%s"已存在');
insert into timegrp values (2, 'Error: time group "%s" already exists', '错误：时间组"%s"已存在');
insert into timegrp values (3, 'Error: time group "%s" does not exist', '错误：时间组"%s"不存在');
insert into timegrp values (4, 'Error: time group "%s" is in use', '错误：时间组"%s"已被使用');
insert into timegrp values (5, 'Notice: time "%s" does not exist', '注意：时间定义"%s"不存在');
insert into timegrp values (6, 'Notice: time "%s" is already a member of time group "%s"', '注意：时间定义"%s"已是时间组"%s"的成员');
insert into timegrp values (7, 'Notice: time "%s" is not a member of time group "%s"', '注意：时间定义"%s"不是时间组"%s"的成员');

-- 表名: upgrade
create table upgrade
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into upgrade values (1, 'Upgrade succeeded.', '升级成功');
insert into upgrade values (2, 'Upgrade succeeded, please reboot system.', '升级成功，请重新启动系统');
insert into upgrade values (3, 'Error: malformed file "%s"', '错误：文件"%s"格式错误');
insert into upgrade values (4, 'Error: firewall version mismatch', '错误：安全网关版本不匹配');
insert into upgrade values (5, 'Error: save failed', '错误：保存失败');

-- 表名: url
create table url
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into url values (1, 'Error: URL rule "%s" already exists', '错误：URL规则"%s"已存在');
insert into url values (2, 'Error: URL rule "%s" does not exist', '错误：URL规则"%s"不存在');
insert into url values (3, 'Error: URL rule amount can not exceed %d', '错误：URL规则的数量不能超过%d');
insert into url values (4, 'Error: URL rule "%s" is in use', '错误：URL规则"%s"已被使用');
insert into url values (5, 'Error: too many ports', '错误：端口太多');
insert into url values (6, 'Error: URL keyword amount can not exceed %d', '错误：URL关键字的数量不能超过%d');

-- 表名: user
create table user
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into user values (1, 'Error: user "%s" already exists', '错误：用户"%s"已存在');
insert into user values (2, 'Error: user "%s" does not exist', '错误：用户"%s"不存在');
insert into user values (3, 'Error: user group "%s" does not exist', '错误：用户组"%s"不存在');
insert into user values (4, 'Notice: user "%s" is already a member of user group "%s"', '注意：用户"%s"已是用户组"%s"的成员');
insert into user values (5, 'Notice: user "%s" is not a member of user group "%s"', '注意：用户"%s"不是用户组"%s"的成员');
insert into user values (6, 'Error: address "%s" does not exist', '错误：地址"%s"不存在');
insert into user values (7, 'Error: time "%s" does not exist', '错误：时间定义"%s"不存在');
insert into user values (8, 'Notice: policy already exists', '注意：策略已存在');
insert into user values (9, 'Notice: policy does not exist', '注意：策略不存在');
insert into user values (10, 'Notice: user "%s" is not online', '注意：用户"%s"不在线');
insert into user values (11, 'Notice: user group "%s" is not online', '注意：用户组"%s"不在线');
insert into user values (12, 'Notice: IP address "%s" is not online', '注意：IP地址"%s"不在线');
insert into user values (13, 'Error: user amount can not exceed %d', '错误：用户的数量不能超过%d');

-- 表名: usergrp
create table usergrp
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into usergrp values (1, 'Error: user group "%s" already exists', '错误：用户组"%s"已存在');
insert into usergrp values (2, 'Error: user group "%s" does not exist', '错误：用户组"%s"不存在');
insert into usergrp values (3, 'Error: user "%s" does not exist', '错误：用户"%s"不存在');
insert into usergrp values (4, 'Notice: user "%s" is already a member of user group "%s"', '注意：用户"%s"已是用户组"%s"的成员');
insert into usergrp values (5, 'Notice: user "%s" is not a member of user group "%s"', '注意：用户"%s"不是用户组"%s"的成员');
insert into usergrp values (6, 'Error: address "%s" does not exist', '错误：地址"%s"不存在');
insert into usergrp values (7, 'Error: service "%s" does not exist', '错误：服务"%s"不存在');
insert into usergrp values (8, 'Error: time "%s" does not exist', '错误：时间定义"%s"不存在');
insert into usergrp values (9, 'Notice: policy already exists', '注意：策略已存在');
insert into usergrp values (10, 'Notice: policy does not exist', '注意：策略不存在');
insert into usergrp values (11, 'Notice: service already exists', '注意：服务已存在');
insert into usergrp values (12, 'Notice: service does not exist', '注意：服务不存在');
insert into usergrp values (13, 'Error: flow quota must be from %d to %d', '错误：流量限额必须在%d至%d之间');
insert into usergrp values (14, 'Error: time quota must be from %d to %d', '错误：时间限额必须在%d至%d之间');
insert into usergrp values (15, 'Error: password expiring days must be from %d to %d', '错误：密码过期天数必须在%d至%d之间');
insert into usergrp values (16, 'Error: week day must be from %d to %d', '错误：重置日期必须在%d至%d之间');
insert into usergrp values (17, 'Error: month day must be from %d to %d', '错误：重置日期必须在%d至%d之间');
insert into usergrp values (18, 'Error: user group amount can not exceed %d', '错误：用户组的数量不能超过%d');

-- 表名: acsc
create table acsc
(
	id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into acsc values (0, 'Notice: excution success', '注意：执行成功');
insert into acsc values (1, 'Error: command line error','错误：命令行参数错误');
insert into acsc values (2, 'Error: operator database error','错误：操作数据库错误');
insert into acsc values (3, 'Error: data does not exist','错误：数据不存在');
insert into acsc values (4, 'Error: data exist','错误：数据已经存在');
insert into acsc values (5, 'Error: data exceed max limit','错误：数据超过最大限制');
insert into acsc values (6, 'Error: memory error','错误：内存出错');
insert into acsc values (7, 'Error: logic check error','错误：逻辑检查错误');
insert into acsc values (8, 'Error: system command error','错误：系统命令错误');
insert into acsc values (9, 'Error: acsc close ','错误：功能已经关闭');
insert into acsc values (11,'Error: miss parameter','错误：命令行缺少参数');
insert into acsc values (12,'Error: all check type is NO, at least one is not NO ','错误：所有检查类型是NO，至少有一个为非NO类型');
insert into acsc values (20, 'Error: please use on/off to enable or disable', '错误：请使用on/off来启用或停止某功能');
insert into acsc values (21, 'Error: please use no/chk/exlog/exdrop/exdroplog keyword ', '错误：请使用no/chk/exlog/exdrop/exdroplog，做为检查类型的关键字');
insert into acsc values (22, 'Error: please use number', '错误：请使用数字');
insert into acsc values (23, 'Error: ip format error "%s"', '错误：IP地址格式错误 "%s"');
insert into acsc values (24, 'Error: comment max length is 20', '错误：注释说明最长20个英文字符');
insert into acsc values (25, 'Error: add rule exist', '错误：添加的规则已存在');
insert into acsc values (26, 'Error: add rule exceed max limit', '错误：超过规则最大数限制');
insert into acsc values (27, 'Error: rule not exist', '错误：规则不存在');
insert into acsc values (28, 'Error: need same net', '错误：需要是同一网段');
insert into acsc values (29, 'Error: operator please use ls/le/eq/ge/gt keyword', '错误：操作符请用 ls/le/eq/ge/gt');
insert into acsc values (30, 'Error: logic operator please use and/or keyword', '错误：逻辑操符请用 and/or');

-- 表名: vpn
create table vpn
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into vpn values (1, 'Error: remote VPN amount can not exceed %d', '错误：远程VPN的数量不能超过%d');
insert into vpn values (2, 'Error: vpn tunnel amount can not exceed %d', '错误：VPN隧道的数量不能超过%d');
insert into vpn values (3, 'Error: remote dial user amount can not exceed %d', '错误：远程拨号用户的数量不能超过%d');

-- 表名: domain
create table domain
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into domain values (0, 'Notice: excution success', '注意：执行成功');
insert into domain values (1, 'Error: command line error %s','错误：命令行参数错误 %s');
insert into domain values (2, 'Error: static ip exceed limit','错误：静态IP超出限制');
insert into domain values (3, 'Error: %s is referenced by %s module,cannot be deleted','错误：%s被%s模块引用，不能删除');

-- 表名: dcf
create table dcf
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into dcf values (0, 'Notice: excution success', '注意：执行成功');
insert into dcf values (1, 'Error: command line error','错误：命令格式错误');
insert into dcf values (2, 'Error: system command error','错误：系统命令错误');
insert into dcf values (3, 'Error: database error','错误：数据库错误');
insert into dcf values (4, 'Error: command line parameter "%s" error','错误：命令行参数"%s"错误');
insert into dcf values (5, 'Error: keyword "%s" already exists', '错误：关键字"%s"已存在');
insert into dcf values (6, 'Error: keyword "%s" does not exist', '错误：关键字"%s"不存在');
insert into dcf values (7, 'Error: keyword "%s" is in use', '错误：关键字"%s"已被使用');
insert into dcf values (8, 'Error: keyword "%s" length exceed', '错误：关键字"%s"字符数超过限制');
insert into dcf values (9, 'Error: group "%s" already exists', '错误：组"%s"已存在');
insert into dcf values (10, 'Error: group "%s" does not exist', '错误：组"%s"不存在');
insert into dcf values (11, 'Error: group "%s" is in use', '错误：组"%s"已被使用');
insert into dcf values (12, 'Error: group nums exceed', '错误：组数超过限制');
insert into dcf values (13, 'Error: group "%s" members exceed', '错误：组"%s"关键字数超过限制');
insert into dcf values (14, 'Error: policy "%s" already exists', '错误：策略"%s"已存在');
insert into dcf values (15, 'Error: policy "%s" does not exist', '错误：策略"%s"不存在');
insert into dcf values (16, 'Error: policy "%s" is in use', '错误：策略"%s"已被使用');
insert into dcf values (17, 'Error: policy group "%s" already exist', '错误：策略组"%s"已存在');
insert into dcf values (18, 'Error: policy group "%s" does not exist', '错误：策略组"%s"不存在');
insert into dcf values (19, 'Error: policy group "%s" is in use', '错误：策略组"%s"已被使用');
insert into dcf values (20, 'Error: policy module "%s" is not enabled', '错误：策略模块"%s"未启用');
insert into dcf values (21, 'Error: policy nums exceed', '错误：策略数超过限制');
insert into dcf values (22, 'Error: service "%s" already exists', '错误：服务"%s"已存在');
insert into dcf values (23, 'Error: service "%s" does not exist', '错误：服务"%s"不存在');
insert into dcf values (24, 'Error: service "%s" is in use', '错误：服务"%s"已被使用');
insert into dcf values (25, 'Error: service "%s" nums exceed', '错误：服务"%s"端口数超过限制');

-- 表名: portsyn
-- Created by zhangming 2005/02/17
create table portsyn
(
    id                INTEGER PRIMARY KEY,    --ID  sequence
    en_US             VARCHAR(255),           --英文（美国）信息格式字符串
    zh_CN             VARCHAR(255)            --中文（中国）信息格式字符串
);
insert into portsyn values (0, 'Error: psyn parameter invalid','错误: 命令行参数');
insert into portsyn values (1, 'Notice: no portsyn need startup','提示: rungroup中没有可执行的记录');
insert into portsyn values (2, 'DB Error: open portsyn database', '错误: 打开数据库portsyn');
insert into portsyn values (3, 'DB Error: no rungroup info', '错误: rungroup表中没有相应运行组信息');
insert into portsyn values (4, 'DB Error: no portgroup info', '错误: portgroup表中没有相应端口组信息');
insert into portsyn values (5, 'DB Error: no port info', '错误: ports表中没有相应端口信息');
insert into portsyn values (6, 'Error: show group state', '错误: 该组没有被同步程序选择执行');
insert into portsyn values (7, 'Error: Group id invalid', '错误: 组id无效');
insert into portsyn values (8, 'Error: port invalid', '错误: 配置端口无效');
insert into portsyn values (9, 'Error: action invalid', '错误: 配置无效action属性');
insert into portsyn values (10, 'Error: decision invalid', '错误: 配置无效decision属性');
insert into portsyn values (11, 'DB Error: operate database', '错误: 表操作');
insert into portsyn values (12, 'Error: rungroup id', '错误: 配置无效rungroup id');
insert into portsyn values (13, 'Error: group string', '错误: 配置无效group string');
insert into portsyn values (14, 'Error: rungroup active', '错误: 配置无效rungroup active');
insert into portsyn values (15, 'Error: alloc memory', '错误: 分配内存');
insert into portsyn values (16, 'DB Error: no config info', '错误: config表中没有相应配置信息');
insert into portsyn values (17, 'DB Error: key field', '错误: 表键值');
insert into portsyn values (18, 'DB Error: duplicate rungroup', '错误:　重复定义rungroup');

--create by lintao 2005/07/22
create table gwmail
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);
insert into gwmail values (0,'Error: please input value!','请输入正确的内容');
insert into gwmail values (1,'Error: SMTP server unreachable!','SMTP服务器地址不可达');
insert into gwmail values (2,'Error: Please set mail parameter!','请正确设置参数');
insert into gwmail values (3,'Error: Please turn on mail function!','请先启用邮件功能');

create table licensestatus
(
	id     INTERGER PRIMARY KEY,
	en_US  VARCHAR(255),
	zh_CN  VARCHAR(255)
);

insert into licensestatus values(1, 'Error: Too few parameter','Error: 缺少参数');
insert into licensestatus values(2, 'valid','有效');
insert into licensestatus values(3, 'invalid','无效');
insert into licensestatus values(4, 'Error: Bad parameter','Error: 参数错误');


create table gwarp
(
	id     INTERGER PRIMARY KEY,
	en_US  VARCHAR(255),
	zh_CN  VARCHAR(255)
);

insert into gwarp values(1, 'GWARP Error: program error','GWARP Error: 程序错误');
insert into gwarp values(2, 'GWARP Error: too few parameter','GWARP Error: 缺少参数');
insert into gwarp values(3, 'GWARP Error: wrong interface name','GWARP Error: 接口错误');
insert into gwarp values(4, 'GWARP Error: cmdline too long','GWARP Error: 命令行太长');
insert into gwarp values(5, 'GWARP Error: invalid parameter','GWARP Error: 无效参数');

create table sslvpn
(
	id   	 interger primary key,
	en_US	 varchar(255),
	zh_CN    varchar(255)
);
insert into sslvpn values(0, 'SSLVPN: success!', 'SSLVPN: 成功!');
insert into sslvpn values(1, 'SSLVPN: too few argument!', 'SSLVPN:缺少参数!');
insert into sslvpn values(2, 'SSLVPN: bad parameter!', 'SSLVPN: 错误参数!');
insert into sslvpn values(3, 'SSLVPN: database error!','SSLVPN: 数据库错误!');
insert into sslvpn values(4, 'SSLVPN: set module debug error!', 'SSLVPN: 调试模块错误!');
insert into sslvpn values(5, 'SSLVPN: file operating error!', 'SSLVPN: 文件操作错误!');
insert into sslvpn values(6, 'SSLVPN: system error!', 'SSLVPN: 系统错误!');

insert into sslvpn values(7, 'SSLVPN: invalid active!', 'SSLVPN: 参数active有错误!');
insert into sslvpn values(8, 'SSLVPN: invalid listenip!', 'SSLVPN: 参数listenip 有错误!');
insert into sslvpn values(9, 'SSLVPN: invalid proto!', 'SSLVPN: 参数proto有错误!');

insert into sslvpn values(10, 'SSLVPN: invalid listenport!', 'SSLVPN: 参数listenport有错误!');
insert into sslvpn values(11, 'SSLVPN: invalid subnet!', 'SSLVPN: 参数subnet有错误!');
insert into sslvpn values(12, 'SSLVPN: invalid sendbuf!', 'SSLVPN: 参数sendbuf有错误!');

insert into sslvpn values(13, 'SSLVPN: invalid recvbuf!', 'SSLVPN: 参数recvbuf有错误!');
insert into sslvpn values(14, 'SSLVPN: invalid servermode!', 'SSLVPN: 参数servermode有错误!');
insert into sslvpn values(15, 'SSLVPN: invalid routeaddrspace!', 'SSLVPN: 参数routeaddrspace 有错误!');

insert into sslvpn values(16, 'SSLVPN: invalid taportun!', 'SSLVPN: 参数taportun有错误!');
insert into sslvpn values(17, 'SSLVPN: invalid bridgedev!', 'SSLVPN: 参数bridgedev有错误!');
insert into sslvpn values(18, 'SSLVPN: invalid bridgedhcp!', 'SSLVPN: 参数bridgedhcp有错误!');

insert into sslvpn values(19, 'SSLVPN: invalid bridgeaddrspace!', 'SSLVPN: 参数bridgeaddrspace有错误!');
insert into sslvpn values(20, 'SSLVPN: invalid iporname!', 'SSLVPN: 参数iporname有错误!');
insert into sslvpn values(21, 'SSLVPN: invalid ipaddr!', 'SSLVPN: 参数ipaddr有错误!');

insert into sslvpn values(22, 'SSLVPN: invalid client2client!', 'SSLVPN: 参数client2client有错误!');
insert into sslvpn values(23, 'SSLVPN: invalid clientdns!', 'SSLVPN: 参数clientdns有错误!');
insert into sslvpn values(24, 'SSLVPN: invalid clientwins!', 'SSLVPN: 参数clientwins 有错误!');

insert into sslvpn values(25, 'SSLVPN: invalid welcomeinfo!', 'SSLVPN: 参数welcomeinfo 有错误!');
insert into sslvpn values(26, 'SSLVPN: invalid maxuser!', 'SSLVPN: 参数maxuser有错误!');
insert into sslvpn values(27, 'SSLVPN: invalid float!', 'SSLVPN: 参数float有错误!');

insert into sslvpn values(28, 'SSLVPN: invalid encryptalgid!', 'SSLVPN: 参数encryptalgid有错误!');
insert into sslvpn values(29, 'SSLVPN: invalid hashalgid!', 'SSLVPN: 参数hashalgid有错误!');
insert into sslvpn values(30, 'SSLVPN: invalid compress!', 'SSLVPN: 参数compress有错误!');

insert into sslvpn values(31, 'SSLVPN: invalid detectperiod!', 'SSLVPN:参数detectperiod有错误!');
insert into sslvpn values(32, 'SSLVPN: invalid overtime!', 'SSLVPN: 参数overtime有错误!');
insert into sslvpn values(33, 'SSLVPN: invalid allowping!', 'SSLVPN: 参数allowping 有错误!');

insert into sslvpn values(34, 'SSLVPN: invalid allowadmin!', 'SSLVPN: 参数allowadmin有错误!');
insert into sslvpn values(35, 'SSLVPN: invalid lockmax!', 'SSLVPN: 参数lockmax有错误!');
insert into sslvpn values(36, 'SSLVPN: invalid lockperiod!', 'SSLVPN: 参数lockperiod有错误!');

insert into sslvpn values(37, 'SSLVPN: invalid mtu!', 'SSLVPN: 参数mtu有错误!');
insert into sslvpn values(38, 'SSLVPN: invalid allowdev!', 'SSLVPN: 参数allowdev有错误!');

insert into sslvpn values(39, 'SSLVPN: invalid account!', 'SSLVPN: 参数account有错误!');

insert into sslvpn values(40, 'SSLVPN: invalid password!', 'SSLVPN: 参数password有错误!');
insert into sslvpn values(41, 'SSLVPN: invalid enabled!', 'SSLVPN: 参数enabled有错误!');
insert into sslvpn values(42, 'SSLVPN: invalid virtualip!', 'SSLVPN: 参数virtualip有错误!');

insert into sslvpn values(43, 'SSLVPN: invalid locknum!', 'SSLVPN: 参数locknum有错误!');
insert into sslvpn values(44, 'SSLVPN: invalid locktime!', 'SSLVPN: 参数locktime有错误!');

insert into sslvpn values(45, 'SSLVPN: invalid name!', 'SSLVPN: 参数name有错误!');
insert into sslvpn values(46, 'SSLVPN: invalid address!', 'SSLVPN: 参数address有错误!');
insert into sslvpn values(47, 'SSLVPN: invalid sort!', 'SSLVPN: 参数sort有错误!');
insert into sslvpn values(48, 'SSLVPN: invalid note!', 'SSLVPN: 参数note有错误!');



--表名：multiroute
--create by yuzy 2005/08/22
create table multiroute
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);

insert into multiroute values (0, 'Notice: execution success!', '注意：执行成功！');
insert into multiroute values (1, 'Error: DataBase process failed!', '错误：数据库操作失败！');
insert into multiroute values (2, 'Error: default route exist!', '错误：该默认路由已经存在！');
insert into multiroute values (3, 'Error: need same net!','错误：输入的ip地址与网络接口ip不在同一网段！');
insert into multiroute values (4, 'Error: command line parameter error!', '错误：命令行参数错误！');
insert into multiroute values (5, 'Error: system call failed!', '错误：系统调用失败！');
insert into multiroute values (6, 'Error: invalid ip address!','错误：无效的ip地址！');
insert into multiroute values (7, 'Error: invalid interface name!','错误：无效的网络设备接口名！');
insert into multiroute values (8, 'Error: invalid weight value (1-255)!','错误：无效的权重值，该值应该在(1-255)之间！');
insert into multiroute values (9, 'Error: cannot get local interface ip address!','错误：不能获取本地网络接口ip地址！');
insert into multiroute values (10, 'Error: invalid active parameter!','错误：无效的状态参数！');
insert into multiroute values (11, 'Error: invalid frequency value!','错误：无效的频率参数值！');
insert into multiroute values (12, 'Error: programe running!','错误：程序已经在运行中！');
insert into multiroute values (13, 'Error: programe stopped!','错误：程序没有启用！');
insert into multiroute values (14, 'Error: net interface invalid!','错误：对应的网络接口被禁用或不存在！');



--表名：neightab
--create by yuzy 2005/09/21
create table neightab
(
    id               INTEGER PRIMARY KEY,
    en_US            VARCHAR(255),
    zh_CN            VARCHAR(255)
);

insert into neightab values (0, 'Notice: execution success!', '注意：执行成功！');
insert into neightab values (1, 'Error: DataBase process failed!', '错误：数据库操作失败！');
insert into neightab values (2, 'Error: command line parameter error!', '错误：命令行参数错误！');
insert into neightab values (3, 'Error: system call failed!', '错误：系统调用失败！');
insert into neightab values (4, 'Error: invalid number!','错误：无效的数字！');


COMMIT;



