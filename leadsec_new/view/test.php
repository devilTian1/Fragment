<?php
    $l3Arr = array(
        'systemManagement/overview' => array(),
        'systemManagement/quick'    => array(),
        'systemManagement/conf'     => array('日期时间',
                                             '系统参数',
                                             '集中管理'),
        'systemManagement/admin'    => array('管理员帐号',
                                             '管理主机',
                                             '管理证书',
                                             '管理方式'),
        'systemManagement/maintain' => array('模块升级',
                                             '备份与恢复',
                                             '模块许可',
                                             '批处理工具'),
        'networkManagement/interface' => array('物理设备',
                                               '别名设备',
                                               '别名设备'),
        'networkManagement/basic'     => array('域名服务器', '静态路由'),
        'networkManagement/HA'        => array('双击热备', '负载均衡'),
        'resConf/addr'     => array(),
        'resConf/time'     => array(),
        'resConf/user'     => array(),
        'resConf/addrBind' => array(),
        'client/fileEx'     => array(),
        'client/dbSync'     => array(),
        'client/safeBrowse' => array(),
        'client/ftp'        => array(),
        'client/mail'       => array(),
        'client/db'         => array(),
        'client/customized' => array(),
        'client/safePass'   => array(),
        'client/msgTrans'   => array(),
        'server/fileEx'     => array(),
        'server/dbSync'     => array(),
        'server/safeBrowse' => array(),
        'server/ftp'        => array(),
        'server/mail'       => array(),
        'server/db'         => array(),
        'server/customized' => array(),
        'server/safePass'   => array(),
        'server/msgTrans'   => array(),
        'appS/virusProtection' => array(),
        'appS/ips'             => array('基本配置',
                                        '策略配置',
                                        '自定义检测',
                                        '扫描检测配置',
                                        '自动响应配置',
                                        '检测结果'),
        'statMonitor/res'     => array(),
        'statMonitor/network' => array(),
        'statMonitor/user'    => array(),
        'statMonitor/test'    => array(),
        'log/conf' => array('日志服务器'),
        'log/view' => array('日志查看')

    );
    $page = $_POST['page'];
    $tabs = $l3Arr[$page];
    if ( empty($tabs) ) {
        array_push($tabs, 'building');
    }
?>
<!-- tabs -->
<div class="tabs">
    <ul>
        <?php
            foreach( $tabs as $key => $tab ) {
                if ( $key == 0 ) {
                    echo "<li class='visitedTab'>";
                } else {
                    echo "<li>";
                }
                echo "$tab</li>\n";
            } 
        ?>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="../images/hi.gif" />&nbsp;
    <span id="show_text">headline</span>
</div>
<br class="clearFloat"/>
<!-- mainContent -->
<div class="mainContent">
    <div class="table">
        <div class="column column_20 colTitle_1">
            名称&nbsp;
        </div>
        <div class="column column_80 colTitle_2">
            内容
        </div>
    
        <br class="clearFloat"/>
        <div class="column column_20 leftTitle_1">
            安全隔离网闸序列号&nbsp;
        </div>
        <div class="column column_75 secCol">
            123
        </div>
        <br class="clearFloat"/>
    </div>
</div>
