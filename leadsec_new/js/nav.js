// 导航栏配置文件
var outlookbar=new outlook();
var t;
t=outlookbar.addtitle('基本设置','系统配置',1)
outlookbar.additem('系统参数',t,'modules/xtpz/xtcs.html')
outlookbar.additem('日期时间',t,'modules/xtpz/rqsj.html')
outlookbar.additem('双统配置',t,'modules/xtpz/stpz.html')
outlookbar.additem('产口许可证',t,'modules/xtpz/cpxkz.html')

t=outlookbar.addtitle('系统更新','系统配置',1)
outlookbar.additem('模块升级',t,'modules/xtpz/mksj.html')
outlookbar.additem('导入导出',t,'modules/xtpz/drdc.html')

t=outlookbar.addtitle('管理配置','系统配置',1)
outlookbar.additem('管理主机',t,'modules/xtpz/glzj.html')
outlookbar.additem('管理员帐号',t,'modules/xtpz/glyzh.html')
outlookbar.additem('管理员证书',t,'modules/xtpz/glyzs.html')
outlookbar.additem('管理方式',t,'modules/xtpz/glfs.html')

t=outlookbar.addtitle('报告设置','系统配置',1)
outlookbar.additem('日志服务器',t,'modules/xtpz/rzhfq.html')
outlookbar.additem('集中管理',t,'modules/xtpz/jzgl.html')

/******************************************************************************/

t=outlookbar.addtitle('基本设置','网络配置',1)
outlookbar.additem('网络设备',t,'modules/wlpz/wlsb.html')
outlookbar.additem('域名服务器',t,'modules/wlpz/ymhfq.html')
outlookbar.additem('静态路由',t,'modules/wlpz/jtly.html')
outlookbar.additem('地此绑定',t,'modules/wlpz/dzbd.html')

t=outlookbar.addtitle('高可靠性','网络配置',1)
outlookbar.additem('基本配置',t,'modules/wlpz/jbpz.html')
outlookbar.additem('IP探测',t,'modules/wlpz/iptc.html')
outlookbar.additem('虚拟地此',t,'modules/wlpz/xndz.html')
outlookbar.additem('负载均衡',t,'modules/wlpz/fzjh.html')


/******************************************************************************/

t=outlookbar.addtitle('地此管理','资源定义',1)
outlookbar.additem('地此列表',t,'modules/zydy/dzlb.html')
outlookbar.additem('地此组',t,'modules/zydy/dzz.html')
outlookbar.additem('域名地此',t,'modules/zydy/ymdz.html')

t=outlookbar.addtitle('用户管理','资源定义',1)
outlookbar.additem('用户列表',t,'modules/zydy/yhlb.html')
outlookbar.additem('用户组',t,'modules/zydy/yhz.html')


t=outlookbar.addtitle('时间管理','资源定义',1)
outlookbar.additem('时间列表',t,'modules/zydy/sjlb.html')
outlookbar.additem('时间组',t,'modules/zydy/sjz.html')


/******************************************************************************/
t=outlookbar.addtitle('T C P访问','定制访问',1)
outlookbar.additem('基本配置',t,'modules/dzfw/tcpjbpz.html')
outlookbar.additem('客户端透明访问',t,'modules/dzfw/tcpclienttmfw.html')
outlookbar.additem('客户端普通访问',t,'modules/dzfw/tcpclientptfw.html')
outlookbar.additem('服务器普通访问',t,'modules/dzfw/tcpserverptfw.html')

t=outlookbar.addtitle('U D P访问','定制访问',1)
outlookbar.additem('基本配置',t,'modules/dzfw/udpjbpz.html')
outlookbar.additem('客户端透明访问',t,'modules/dzfw/udpclienttmfw.html')
outlookbar.additem('客户端普通访问',t,'modules/dzfw/udpclientptfw.html')
outlookbar.additem('服务器普通访问',t,'modules/dzfw/udpserverptfw.html')


/******************************************************************************/
t=outlookbar.addtitle('基本设置','抗攻击设置',1)
outlookbar.additem('抗DDos攻击',t,'modules/kgjsz/kddosgj.html')

t=outlookbar.addtitle('入侵检测','抗攻击设置',1)
outlookbar.additem('基本配置',t,'modules/kgjsz/jbpz.html')
outlookbar.additem('策略配置',t,'modules/kgjsz/clpz.html')
outlookbar.additem('自定义检测',t,'modules/kgjsz/zdyjc.html')
outlookbar.additem('扫描检测配置',t,'modules/kgjsz/smjcpz.html')
outlookbar.additem('自动响应配置',t,'modules/kgjsz/zdxypz.html')
outlookbar.additem('显示检测结果',t,'modules/kgjsz/xsjcjg.html')

/******************************************************************************/
t=outlookbar.addtitle('基本设置','系统监控',1)
outlookbar.additem('网络设备',t,'modules/xtjk/wlsb.html')
outlookbar.additem('日志信息',t,'modules/xtjk/rzxx.html')
outlookbar.additem('用户信息',t,'modules/xtjk/yhxx.html')
outlookbar.additem('网络调试工具',t,'modules/xtjk/wltsgj.html')
outlookbar.additem('批处理工具',t,'modules/xtjk/pclgj.html')

/******************************************************************************/
t=outlookbar.addtitle('基本设置','病毒防护',1)
outlookbar.additem('引擎管理',t,'modules/bdfh/yqgl.html')
outlookbar.additem('病毒库升级',t,'modules/bdfh/bdksj.html')

/******************************************************************************/
t=outlookbar.addtitle('基本设置','数据库同步',1)
outlookbar.additem('基本配置',t,'modules/sjktb/jbpz.html')
outlookbar.additem('服务端',t,'modules/sjktb/fhd.html')
outlookbar.additem('客户端',t,'modules/sjktb/khd.html')

/******************************************************************************/
t=outlookbar.addtitle('基本设置','安全浏览',1)
outlookbar.additem('基本配置',t,'modules/aqll/jbpz.html')

t=outlookbar.addtitle('过滤选项','安全浏览',1)
outlookbar.additem('URL过滤',t,'modules/aqll/urlgl.html')
outlookbar.additem('MIME类型过滤',t,'modules/aqll/mimegl.html')
outlookbar.additem('文件扩展名过滤',t,'modules/aqll/wjkzmgl.html')
outlookbar.additem('过滤选项集',t,'modules/aqll/glxxj.html')

t=outlookbar.addtitle('客户端','安全浏览',1)
outlookbar.additem('透明访问',t,'modules/aqll/clienttmfw.html')
outlookbar.additem('普通访问',t,'modules/aqll/clientptfw.html')

t=outlookbar.addtitle('服务端','安全浏览',1)
outlookbar.additem('普通访问',t,'modules/aqll/servertmfw.html')