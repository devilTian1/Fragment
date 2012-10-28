-- Use(Create database):
--   #rm ha.db
--   #sqlite ha.db<ha.sql
-- 0. xiaowj 2003/11/04
--     ��private.db���Ƴ���


BEGIN TRANSACTION;

-- ����: ��Ⱥ
create table ha_heartbeat
(
    ha_id                   INT,        --��ȺID, ͬһ��ȺҪ����ͬ��ID, 1-255
    ip                      CHAR(15),   --ѡ�е�HA�˿�IP
    netmask                 CHAR(15),   --IP��Ӧ��mask
    enable                  BOOL,       --���÷���ǽ��Ⱥ
    node_id                 INT,        --�����ڵ�� 
    mode                    BOOL,       --����ģʽ, 1Ϊ˫���ȱ���0Ϊ���ؾ���
    heartbeat               INT,        --�������ڣ�����
    deadtime                INT,        --�ڵ������жϴ���
    sync_conf_timeout       INT,        --ͬ�����ó�ʱʱ��, ���¼�������ã�Ϊ��Ⱥģ�鱣��
    sync_load_timeout       INT,        --ͬ�����س�ʱʱ��
    sync_nodetable_timeout  INT,        --ͬ���ڵ��ʱʱ��
    haif_enable             BOOL,       --���÷���ǽHA�ӿ�
    synstate                BOOL        --�Ƿ�����״̬ͬ��
);
insert into ha_heartbeat values (0,'','',0,1,0,500,3,2000,1000,1000,0,0);


-- ����: IP��ַ̽�����ñ�
create table ha_detectip_conf
(
    threshold               INT,        --�����жϽڵ�ʧЧ������ʧ��̽�����Ҫ��֮�͵���ֵ
    interval                INT,        --ARP��������
    deadcount               INT         --̽���IPʧЧ���жϴ���
);
insert into ha_detectip_conf values (100,1,2);

-- ����: IP��ַ̽���
create table ha_detectip
(
    ip                      CHAR(15),   --��Ҫ̽���ip ��ַ
    weight                  INT,        --��Ҫ��
    interface               CHAR(20)    --����ӿ��ⲿ����
);
-- insert into ha_detectip values ('40.1.1.2',1,'fe1');

-- ����: ����ӿ�̽���
create table ha_alertif
(
    interface               CHAR(20),   --��Ҫ̽�������ӿ��ⲿ����
    alert                   BOOL,       --�Ƿ�����HA̽������ ��1������0��������
    intername               CHAR(20),   --��Ҫ̽�������ӿ��ڲ�����
    valid                   BOOL        --�����Ƿ���Ч
);
insert into ha_alertif values ('fe1',0,'eth0',1);
insert into ha_alertif values ('fe2',0,'eth1',1);
insert into ha_alertif values ('fe3',0,'eth2',1);
insert into ha_alertif values ('fe4',0,'eth3',0);
insert into ha_alertif values ('fe5',0,'eth4',0);
insert into ha_alertif values ('fe6',0,'eth5',0);
insert into ha_alertif values ('fe7',0,'eth6',0);
insert into ha_alertif values ('fe8',0,'eth7',0);
insert into ha_alertif values ('fe9',0,'eth8',0);
insert into ha_alertif values ('fe10',0,'eth9',0);
insert into ha_alertif values ('fe11',0,'eth10',0);
insert into ha_alertif values ('fe12',0,'eth11',0);
insert into ha_alertif values ('fe13',0,'eth12',0);
insert into ha_alertif values ('fe14',0,'eth13',0);
insert into ha_alertif values ('fe15',0,'eth14',0);
insert into ha_alertif values ('fe16',0,'eth15',0);
insert into ha_alertif values ('rd1',0,'bond1',0);
insert into ha_alertif values ('rd2',0,'bond2',0);
insert into ha_alertif values ('rd3',0,'bond3',0);
insert into ha_alertif values ('rd4',0,'bond4',0);
COMMIT;


