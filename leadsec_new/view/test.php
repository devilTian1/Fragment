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
        'client/customized' => array('TCP访问', 'UDP访问'),
        'client/safePass'   => array(),
        'client/msgTrans'   => array(),
        'server/fileEx'     => array(),
        'server/dbSync'     => array(),
        'server/safeBrowse' => array(),
        'server/ftp'        => array(),
        'server/mail'       => array(),
        'server/db'         => array(),
        'server/customized' => array('TCP访问', 'UDP访问'),
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
    <table class="column_95 textMid tablesorter" id="clientTcp">
        <caption>
            客户端TCP访问表
        </caption>
        <thead><tr>
            <th class="column_10">访问类型</th>
            <th class="column_10">任务号</th>
            <th class="column_10">源地址</th>
            <th class="column_10">目的地址</th>
            <th class="column_10">目的端口</th>
            <th class="column_15">生效时段</th>
            <th class="column_10">是否启动</th>
            <th class="column_10">备注</th>
            <th class="column_10">操作</th>
        </tr></thead>
        <tr>
            <td>透明</td>
            <td>111</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 00:36:19</td>
            <td>Yes</td>
            <td>++++</td>
            <td>----</td>
        </tr>
        <tr>
            <td>普通</td>
            <td>112</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 12:31:12</td>
            <td>No</td>
            <td>++++</td>
            <td>----</td>
        </tr>
        <tr>
            <td>透明</td>
            <td>113</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 00:36:19</td>
            <td>Yes</td>
            <td>++++</td>
            <td>----</td>
        </tr>
        <tr>
            <td>普通</td>
            <td>114</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 12:31:12</td>
            <td>No</td>
            <td>++++</td>
            <td>----</td>
        </tr>
        <tr>
            <td>透明</td>
            <td>115</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 00:36:19</td>
            <td>Yes</td>
            <td>++++</td>
            <td>----</td>
        </tr>
        <tr>
            <td>普通</td>
            <td>116</td>
            <td>255.255.255.255</td>
            <td>255.255.255.255</td>
            <td>eth0</td>
            <td>Sep 2 12:31:12</td>
            <td>No</td>
            <td>++++</td>
            <td>----</td>
        </tr>
    </table>
    <ol class="pagination floatRight">
        <li><a href="#?page=1" rel="prev">Prev</a></li>
        <li><a href="#?page=1" rel="prev">1</a></li>
        <li class="selected">2</li>
        <li><a href="#?page=3">3</a></li>
        <li><a href="#?page=4">4</a></li>
        <li><a href="#?page=5">5</a></li>
        <li><a href="#?page=3" rel="next">Next</a></li>
    </ol>
    <button class="floatLeft" type="submit" onClick="openDialog()" id="add">添加</button>
</div>

<div class="hide" id="dialogForm">
    <fieldset>
        <legend>客户端普通访问添加</legend>
        <div>
            <label for="mid">任务号:<em class="required">*</em></label>
            <input type="text" name="mid" id="mid"/>
            <span>(同一端的任务号必须唯一)</span>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="saddr">源地址:</label>
            <select name="saddr" id="saddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="daddr">目的地址:</label>
            <select name="daddr" id="daddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="dport">目的端口:<em class="required">*</em></label>
            <input type="text" name="dport" id="dport" maxlength="5"/>
            <span>(1 - 65535)</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="virusScan">流病毒扫描:</label>
            <span><input class="radio" type="radio" name="virusScan"/>开</span>
            <span><input class="radio" type="radio" name="virusScan"/>关</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="auGroup">认证用户组:</label>
            <select name="auGroup" id="auGroup">
                <option value="1">admin</option>
                <option value="2">wangqi</option>
                <option value="3">RenWinFLy</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="effectivePeriod">生效时段:</label>
            <select name="effectivePeriod" id="effectivePeriod">
                <option value="1">right now</option>
                <option value="2">1 month ago</option>
                <option value="3">1 year ago</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="isStart">是否启动:<em class="required">*</em></label>
            <span><input class="radio" type="radio" name="isStart"/>启动</span>
            <span><input class="radio" type="radio" name="isStart"/>停止</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="remark">备注:</label>
            <input class="remark" type="text" name="remark" id="remark"/>
            <br class="clearFloat"/>
        </div>
    </fieldset>
</div>
<script type="text/javascript">
    $("#add").button();
</script>
