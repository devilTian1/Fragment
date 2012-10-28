
-- Use(Create database):
--   #rm local.db
--   #sqlite local.db<local.sql
--   #cp local.db /etc/uas/

BEGIN TRANSACTION;

-- 用户表
create table usr_info_tbl
(
    uid             INTEGER,        --用户ID。重要字段，不提供给用户显示，但是修改和删除账号均须用到该值。
    name            CHAR(16),       --用户名。在数据库中用程序模拟的又一个关键字
    flag            INTEGER,        --Flag字段(32位):
                                      --#define UF_ACCOUNT_ACTIVE    0x1   //账号是否有效        1- 有效 0 - 无效
                                      --#define UF_POLICY_DEF_USED   0x2    //是否定义了安全策略 1-  有 0 - 无
                                      --#define UF_SERV_DEF_USED     0x4    // 是否定义了授权服务 1- 有  0 - 无
                                      --#define UF_EXP_TIME_USED     0x8    // 是否定义了账号失效时间   1 - 是 0 -无
                                      --#define UF_TRAFFIC_LIMITED   0x10   // 是否定义了流量限制       1 - 是 0 -无
                                      --#define UF_TIME_LIMITED      0x20    // 是否定义了时间限制       1 - 是 0 -无
                                      --#define UF_CONCUR_LIMITED    0x40   //是否定义了并发连接数限制  1 - 是 0 -无
                                      --#define UF_RESET_TIME_USED   0x80    //是否定义了重置分配流量的时间 1 - 是 0 -无
                                      --#define UF_COMMENT_USED      0x100   //是否启用了备注字段  1 - 是 0 -无
                                      --#define UF_CHGPWD_SPAN_USED  0x200    //是否定义了要求修改密码的最长时间 1－是 0 无
    grp_count       INTEGER,        --属于组的个数
    used_time       INTEGER,        --已经使用的时间(单位: 秒)
    used_bytes_in_h INTEGER,        --已经使用流入字节数（高32位）
    used_bytes_in_l INTEGER,        --已经使用流入字节数（低32位）
    used_bytes_out_h    INTEGER,    --已经使用流出字节数（高32位）
    used_bytes_out_l    INTEGER,    --已经使用流出字节数（低32位）
    last_fail_time  INTEGER,        --上次一次失败登陆的时间，标准时间，time_t类型，用localtime()转换
    last_fail_ip    INTEGER,        --上次一次失败登陆的ip地址, 用inet_ntoa()转换
    last_login_time INTEGER,        --上次登陆时间，标准时间，time_t类型，用localtime()转换
    last_login_ip   INTEGER,        --上次登陆ip, 用inet_ntoa()转换
    last_disconn_time   INTEGER,    --上次断开时间，标准时间，time_t类型，用localtime()转换
    last_chgwd_time INTEGER,        --上次改密码时间，标准时间，time_t类型，用localtime()转换
    last_chgpwd_ip  INTEGER,        --上次改密码ip, 用inet_ntoa()转换
    succ_connt      INTEGER,        --成功登陆次数
    fail_connt      INTEGER,        --失败登陆次数
    comment         CHAR(64),       --注释
    PRIMARY KEY(uid)
);

-- 用户组
create table grp_info_tbl 
(
    gid             INTEGER,        --用户组id.重要字段，不提供给用户显示，但是修改和删除账号均须用到该值，而不是根据name来做。
    name            CHAR(16),       --用户组名.在数据库中用程序模拟的又一个关键字
    flag            INTEGER,        --标准位
                                        --FLAG字段(32位):
                                        --#define UF_ACCOUNT_ACTIVE    0x1   //账号是否有效        1- 有效 0 - 无效
                                        --#define UF_POLICY_DEF_USED   0x2    //是否定义了安全策略 1-  有 0 - 无
                                        --#define UF_SERV_DEF_USED     0x4    // 是否定义了授权服务 1- 有  0 - 无
                                        --#define UF_EXP_TIME_USED     0x8    // 是否定义了账号失效时间   1 - 是 0 -无
                                        --#define UF_TRAFFIC_LIMITED   0x10   // 是否定义了流量限制       1 - 是 0 -无
                                        --#define UF_TIME_LIMITED      0x20    // 是否定义了时间限制       1 - 是 0 -无
                                        --#define UF_CONCUR_LIMITED    0x40   //是否定义了并发连接数限制  1 - 是 0 -无
                                        --#define UF_RESET_TIME_USED   0x80    //是否定义了重置分配流量的时间 1 - 是 0 -无
                                        --#define UF_COMMENT_USED      0x100   //是否启用了备注字段  1 - 是 0 -无
                                        --#define UF_CHGPWD_SPAN_USED  0x200    //是否定义了要求修改密码的最长时间 1－是 0 无
                                        --#define UF_GRP_CONCUR_LIMITED  0x1000     //是否定义了组的最大连接数限制
    usr_count       INTEGER,        --这个组包括的用户数量
    proto           INTEGER,        --认证协议
                                        --#define UT_AUTH_PROTO_KEY 1
                                        --#define UT_AUTH_PROTO_PAP 2
    alloc_bytes     INTEGER,        --分配字节数(单位: k字节)
    alloc_time      INTEGER,        --分配时间(单位: 分钟)
    chgpwd_span     INTEGER,        --修改密码的最长间隔(单位: 天)
    expire_time     INTEGER,        --超时的时间，标准时间，time_t类型，用localtime()转换
    concur_grp      INTEGER,        --组的最大同时认证数
    concur_usr      INTEGER,        --用户最大同时认证数
    reset_time      INTEGER,        --重置时间
                                        --//first two bytes: flags indicate which type,to tell the type, use
                                        --//((rest_time >>16) & UF_RESET_TIME_BY_MONTH/WEEK)
                                        --//last two bytes:  week(1--7, MON --- SUN) month(1--31)
                                        --// using: rest_time & 0xFFFF
                                        --#define UF_RESET_TIME_BY_MONTH   0x1 
                                        --#define UF_RESET_TIME_BY_WEEK    0x2
    comment         CHAR(128), 
    PRIMARY KEY(gid)
);


-- 组和用户关系表
create table gulk_info_tbl
(
    uid             INTEGER,        --用户id
    gid             INTEGER,        --用户组id
    PRIMARY KEY(uid,gid)
);


-- 安全策略表
create table poli_info_tbl
(
    id              INTEGER ,       --策略id.用户或者是组的id,通过flag来区别
    flag            INTEGER ,       --标准位
                                        --FLAG: 
                                        --#define  UF_IP_DEF_USED         0x1     //是否使用了IP资源  1- 是 0- 否
                                        --#define  UF_TIME_DEF_USED       0x2    //是否使用了TIME资源  1- 是 0- 否
                                        --#define  UF_ID_TYPE_USR        0x4     //是否是用户ID  1- 是 0- 否
                                        --#define  UF_ID_TYPE_GRP        0x8     //是否是用户组ID  1- 是 0- 否
    ip_defs         CHAR(16),       --登陆地点(和资源用名称联系)
    time_defs       CHAR(16),       --登陆时间(和资源用名称联系)
    seq_num         INTEGER,        --序列号(暂无用, 规则顺序不重要，因为都是允许规则)
    PRIMARY KEY(id,flag,ip_defs,time_defs)
);


-- 授权服务表
create table srv_info_tbl
(
    id              INTEGER,        --服务id.用户或者是组的id,通过flag来区别
    flag            INTEGER,        --标准位
                                        --FLAG字段：
                                        --#define  UF_IP_DEF_USED         0x1     //是否使用了IP资源  1- 是 0- 否
                                        --#define  UF_TIME_DEF_USED       0x2    //是否使用了TIME资源  1- 是 0- 否
                                        --#define  UF_ID_TYPE_USR        0x4     //是否是用户ID  1- 是 0- 否
                                        --#define  UF_ID_TYPE_GRP        0x8     //是否是用户组ID  1- 是 0- 否
                                        --#define  UF_PORT_DEF_USED       0x10     //是否使用了PORT资源  1-是 0-否
    port_defs       CHAR(16),       --端口定义(和资源用名称联系)
    dst_ip_defs     CHAR(16),       --目的ip定义(和资源用名称联系)
    time_defs       CHAR(16),       --时间定义(和资源用名称联系)
-- added by hanhz, begin
    dcf             INTEGER DEFAULT 0,      --深度过滤策略，0为禁用
-- added by hanhz, end
    seq_num         INTEGER,        --序列号(暂无用, 规则顺序不重要，因为都是允许规则)
    PRIMARY KEY(id,flag,port_defs,dst_ip_defs,time_defs)
);


-- 用户密码表
create table upwd_info_tbl
(
    uid             INTEGER PRIMARY KEY,    --用户名
    pwd             CHAR(16),               --用户密码
    enc_mode        INTEGER                 --加密模式 0-不加密(目前只做了不加密), 1-加密方法1, 2-加密方法2
);



COMMIT;
