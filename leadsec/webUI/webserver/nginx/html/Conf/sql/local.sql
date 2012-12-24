
-- Use(Create database):
--   #rm local.db
--   #sqlite local.db<local.sql
--   #cp local.db /etc/uas/

BEGIN TRANSACTION;

-- �û���
create table usr_info_tbl
(
    uid             INTEGER,        --�û�ID����Ҫ�ֶΣ����ṩ���û���ʾ�������޸ĺ�ɾ���˺ž����õ���ֵ��
    name            CHAR(16),       --�û����������ݿ����ó���ģ�����һ���ؼ���
    flag            INTEGER,        --Flag�ֶ�(32λ):
                                      --#define UF_ACCOUNT_ACTIVE    0x1   //�˺��Ƿ���Ч        1- ��Ч 0 - ��Ч
                                      --#define UF_POLICY_DEF_USED   0x2    //�Ƿ����˰�ȫ���� 1-  �� 0 - ��
                                      --#define UF_SERV_DEF_USED     0x4    // �Ƿ�������Ȩ���� 1- ��  0 - ��
                                      --#define UF_EXP_TIME_USED     0x8    // �Ƿ������˺�ʧЧʱ��   1 - �� 0 -��
                                      --#define UF_TRAFFIC_LIMITED   0x10   // �Ƿ�������������       1 - �� 0 -��
                                      --#define UF_TIME_LIMITED      0x20    // �Ƿ�����ʱ������       1 - �� 0 -��
                                      --#define UF_CONCUR_LIMITED    0x40   //�Ƿ����˲�������������  1 - �� 0 -��
                                      --#define UF_RESET_TIME_USED   0x80    //�Ƿ��������÷���������ʱ�� 1 - �� 0 -��
                                      --#define UF_COMMENT_USED      0x100   //�Ƿ������˱�ע�ֶ�  1 - �� 0 -��
                                      --#define UF_CHGPWD_SPAN_USED  0x200    //�Ƿ�����Ҫ���޸�������ʱ�� 1���� 0 ��
    grp_count       INTEGER,        --������ĸ���
    used_time       INTEGER,        --�Ѿ�ʹ�õ�ʱ��(��λ: ��)
    used_bytes_in_h INTEGER,        --�Ѿ�ʹ�������ֽ�������32λ��
    used_bytes_in_l INTEGER,        --�Ѿ�ʹ�������ֽ�������32λ��
    used_bytes_out_h    INTEGER,    --�Ѿ�ʹ�������ֽ�������32λ��
    used_bytes_out_l    INTEGER,    --�Ѿ�ʹ�������ֽ�������32λ��
    last_fail_time  INTEGER,        --�ϴ�һ��ʧ�ܵ�½��ʱ�䣬��׼ʱ�䣬time_t���ͣ���localtime()ת��
    last_fail_ip    INTEGER,        --�ϴ�һ��ʧ�ܵ�½��ip��ַ, ��inet_ntoa()ת��
    last_login_time INTEGER,        --�ϴε�½ʱ�䣬��׼ʱ�䣬time_t���ͣ���localtime()ת��
    last_login_ip   INTEGER,        --�ϴε�½ip, ��inet_ntoa()ת��
    last_disconn_time   INTEGER,    --�ϴζϿ�ʱ�䣬��׼ʱ�䣬time_t���ͣ���localtime()ת��
    last_chgwd_time INTEGER,        --�ϴθ�����ʱ�䣬��׼ʱ�䣬time_t���ͣ���localtime()ת��
    last_chgpwd_ip  INTEGER,        --�ϴθ�����ip, ��inet_ntoa()ת��
    succ_connt      INTEGER,        --�ɹ���½����
    fail_connt      INTEGER,        --ʧ�ܵ�½����
    comment         CHAR(64),       --ע��
    PRIMARY KEY(uid)
);

-- �û���
create table grp_info_tbl 
(
    gid             INTEGER,        --�û���id.��Ҫ�ֶΣ����ṩ���û���ʾ�������޸ĺ�ɾ���˺ž����õ���ֵ�������Ǹ���name������
    name            CHAR(16),       --�û�����.�����ݿ����ó���ģ�����һ���ؼ���
    flag            INTEGER,        --��׼λ
                                        --FLAG�ֶ�(32λ):
                                        --#define UF_ACCOUNT_ACTIVE    0x1   //�˺��Ƿ���Ч        1- ��Ч 0 - ��Ч
                                        --#define UF_POLICY_DEF_USED   0x2    //�Ƿ����˰�ȫ���� 1-  �� 0 - ��
                                        --#define UF_SERV_DEF_USED     0x4    // �Ƿ�������Ȩ���� 1- ��  0 - ��
                                        --#define UF_EXP_TIME_USED     0x8    // �Ƿ������˺�ʧЧʱ��   1 - �� 0 -��
                                        --#define UF_TRAFFIC_LIMITED   0x10   // �Ƿ�������������       1 - �� 0 -��
                                        --#define UF_TIME_LIMITED      0x20    // �Ƿ�����ʱ������       1 - �� 0 -��
                                        --#define UF_CONCUR_LIMITED    0x40   //�Ƿ����˲�������������  1 - �� 0 -��
                                        --#define UF_RESET_TIME_USED   0x80    //�Ƿ��������÷���������ʱ�� 1 - �� 0 -��
                                        --#define UF_COMMENT_USED      0x100   //�Ƿ������˱�ע�ֶ�  1 - �� 0 -��
                                        --#define UF_CHGPWD_SPAN_USED  0x200    //�Ƿ�����Ҫ���޸�������ʱ�� 1���� 0 ��
                                        --#define UF_GRP_CONCUR_LIMITED  0x1000     //�Ƿ���������������������
    usr_count       INTEGER,        --�����������û�����
    proto           INTEGER,        --��֤Э��
                                        --#define UT_AUTH_PROTO_KEY 1
                                        --#define UT_AUTH_PROTO_PAP 2
    alloc_bytes     INTEGER,        --�����ֽ���(��λ: k�ֽ�)
    alloc_time      INTEGER,        --����ʱ��(��λ: ����)
    chgpwd_span     INTEGER,        --�޸����������(��λ: ��)
    expire_time     INTEGER,        --��ʱ��ʱ�䣬��׼ʱ�䣬time_t���ͣ���localtime()ת��
    concur_grp      INTEGER,        --������ͬʱ��֤��
    concur_usr      INTEGER,        --�û����ͬʱ��֤��
    reset_time      INTEGER,        --����ʱ��
                                        --//first two bytes: flags indicate which type,to tell the type, use
                                        --//((rest_time >>16) & UF_RESET_TIME_BY_MONTH/WEEK)
                                        --//last two bytes:  week(1--7, MON --- SUN) month(1--31)
                                        --// using: rest_time & 0xFFFF
                                        --#define UF_RESET_TIME_BY_MONTH   0x1 
                                        --#define UF_RESET_TIME_BY_WEEK    0x2
    comment         CHAR(128), 
    PRIMARY KEY(gid)
);


-- ����û���ϵ��
create table gulk_info_tbl
(
    uid             INTEGER,        --�û�id
    gid             INTEGER,        --�û���id
    PRIMARY KEY(uid,gid)
);


-- ��ȫ���Ա�
create table poli_info_tbl
(
    id              INTEGER ,       --����id.�û����������id,ͨ��flag������
    flag            INTEGER ,       --��׼λ
                                        --FLAG: 
                                        --#define  UF_IP_DEF_USED         0x1     //�Ƿ�ʹ����IP��Դ  1- �� 0- ��
                                        --#define  UF_TIME_DEF_USED       0x2    //�Ƿ�ʹ����TIME��Դ  1- �� 0- ��
                                        --#define  UF_ID_TYPE_USR        0x4     //�Ƿ����û�ID  1- �� 0- ��
                                        --#define  UF_ID_TYPE_GRP        0x8     //�Ƿ����û���ID  1- �� 0- ��
    ip_defs         CHAR(16),       --��½�ص�(����Դ��������ϵ)
    time_defs       CHAR(16),       --��½ʱ��(����Դ��������ϵ)
    seq_num         INTEGER,        --���к�(������, ����˳����Ҫ����Ϊ�����������)
    PRIMARY KEY(id,flag,ip_defs,time_defs)
);


-- ��Ȩ�����
create table srv_info_tbl
(
    id              INTEGER,        --����id.�û����������id,ͨ��flag������
    flag            INTEGER,        --��׼λ
                                        --FLAG�ֶΣ�
                                        --#define  UF_IP_DEF_USED         0x1     //�Ƿ�ʹ����IP��Դ  1- �� 0- ��
                                        --#define  UF_TIME_DEF_USED       0x2    //�Ƿ�ʹ����TIME��Դ  1- �� 0- ��
                                        --#define  UF_ID_TYPE_USR        0x4     //�Ƿ����û�ID  1- �� 0- ��
                                        --#define  UF_ID_TYPE_GRP        0x8     //�Ƿ����û���ID  1- �� 0- ��
                                        --#define  UF_PORT_DEF_USED       0x10     //�Ƿ�ʹ����PORT��Դ  1-�� 0-��
    port_defs       CHAR(16),       --�˿ڶ���(����Դ��������ϵ)
    dst_ip_defs     CHAR(16),       --Ŀ��ip����(����Դ��������ϵ)
    time_defs       CHAR(16),       --ʱ�䶨��(����Դ��������ϵ)
-- added by hanhz, begin
    dcf             INTEGER DEFAULT 0,      --��ȹ��˲��ԣ�0Ϊ����
-- added by hanhz, end
    seq_num         INTEGER,        --���к�(������, ����˳����Ҫ����Ϊ�����������)
    PRIMARY KEY(id,flag,port_defs,dst_ip_defs,time_defs)
);


-- �û������
create table upwd_info_tbl
(
    uid             INTEGER PRIMARY KEY,    --�û���
    pwd             CHAR(16),               --�û�����
    enc_mode        INTEGER                 --����ģʽ 0-������(Ŀǰֻ���˲�����), 1-���ܷ���1, 2-���ܷ���2
);



COMMIT;
