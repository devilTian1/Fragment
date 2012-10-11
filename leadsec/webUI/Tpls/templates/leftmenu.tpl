<div class="l1" name="systemManagement">
    <span>系统管理</span>
</div>
<div class="l2" name="systemManagement">
    <ul>
        <li><a href="#" title="overview">系统概览</a></li>
        <li><a href="#" title="quick">快捷配置</a></li>
        <li><a href="#" title="conf">配置</a></li>
        <li><a href="#" title="admin">管理员设置</a></li>
        <li><a href="#" title="maintain">维护</a></li>
    </ul>
</div>
<div class="l1" name="networkManagement">
    <span>网络管理</span>
</div>
<div class="l2" name="networkManagement">
    <ul>
        <li><a href="#" title="interface">网络接口</a></li>
        <li><a href="#" title="basic">基本配置</a></li>
        <li><a href="#" title="HA">高可用性</a></li>
    </ul>
</div>
<div class="l1" name="resConf">
    <span>资源配置</span>
</div>
<div class="l2" name="resConf">
    <ul>
        <li><a href="#" title="addr">地址</a></li>
        <li><a href="#" title="time">时间</a></li>
        <li><a href="#" title="user">用户</a></li>
        <li><a href="#" title="addrBind">地址绑定</a></li>
    </ul>
</div>
<div class="l1" name="client">
    <span>客户端</span>
</div>
<div class="l2" name="client">
    <ul>
        <li><a href="#" title="fileEx">文件交换</a></li>
        <li><a href="#" title="dbSync">数据库同步</a></li>
        <li><a href="#" title="safeBrowse">安全浏览</a></li>
        <li><a href="#" title="ftp">FTP访问</a></li>
        <li><a href="#" title="mail">邮件访问</a></li>
        <li><a href="#" title="db">数据库访问</a></li>
        <li><a href="#" title="customized">定制访问</a></li>
        <li><a href="#" title="safePass">安全通道</a></li>
        <li><a href="#" title="msgTrans">消息传输</a></li>
    </ul>
</div>
<div class="l1" name="server">
    <span>服务端</span>
</div>
<div class="l2" name="server">
    <ul>
        <li><a href="#" title="fileEx">文件交换</a></li>
        <li><a href="#" title="dbSync">数据库同步</a></li>
        <li><a href="#" title="safeBrowse">安全浏览</a></li>
        <li><a href="#" title="ftp">FTP访问</a></li>
        <li><a href="#" title="mail">邮件访问</a></li>
        <li><a href="#" title="db">数据库访问</a></li>
        <li><a href="#" title="customized">定制访问</a></li>
        <li><a href="#" title="safePass">安全通道</a></li>
        <li><a href="#" title="msgTrans">消息传输</a></li>
    </ul>
</div>

<div class="l1" name="appS">
    <span>应用防护</span>
</div>
<div class="l2" name="appS">
    <ul>
        <li><a href="#" title="virusProtection">病毒防护</a></li>
        <li><a href="#" title="ips">入侵防护</a></li>
    </ul>
</div>
<div class="l1" name="statMonitor">
    <span>状态监控</span>
</div>
<div class="l2" name="statMonitor">
    <ul>
        <li><a href="#" title="res">资源状态</a></li>
        <li><a href="#" title="network">网络状态</a></li>
        <li><a href="#" title="user">用户状态</a></li>
        <li><a href="#" title="test">网络测试</a></li>
    </ul>
</div>
<div class="l1" name="log">
    <span>日志与报表</span>
</div>
<div class="l2" name="log">
    <ul>
        <li><a href="#" title="conf">日志配置</a></li>
        <li><a href="#" title="view">日志访问</a></li>
    </ul>
</div>
<script type="text/javascript">
    function showPageByAjax(page) {
        $("#mainZone").html("loading... ...").load("test.php", {
            page : page}, function() {
            var contentH  = $("#mainZone>.mainContent").outerHeight();
            var leftmenuH = $("#leftmenu").outerHeight();
            contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : $("#mainZone>.mainContent").outerHeight(leftmenuH);
            refreshTab();
            $("#clientTcp").tablesorter();
        });
    }
</script>
