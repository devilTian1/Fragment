<?php /*%%SmartyHeaderCode:904872469507701c414b161-97009503%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7676b752a8430b855687e5f5e1672c7bfda28a66' => 
    array (
      0 => '/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/index.tpl',
      1 => 1349980855,
      2 => 'file',
    ),
    'a065c36a08db270496920481dd41d46a7bda6af9' => 
    array (
      0 => '/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/header.tpl',
      1 => 1349977593,
      2 => 'file',
    ),
    '5a7cf40e6793def00837b7cd750043a19658ffc8' => 
    array (
      0 => '/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/leftmenu.tpl',
      1 => 1349980847,
      2 => 'file',
    ),
    '6e4d92ca5d6f411f1dfc8450e8dec6eb56fe3b64' => 
    array (
      0 => '/usr/local/apache2/htdocs/git_dt/Fragment/leadsec/webUI/Tpls/templates/content.tpl',
      1 => 1349978617,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '904872469507701c414b161-97009503',
  'cache_lifetime' => 3600,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_507712b9760050_11544581',
  'variables' => 
  array (
    'themePath' => 0,
  ),
  'has_nocache_code' => false,
),true); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_507712b9760050_11544581')) {function content_507712b9760050_11544581($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title></title>
        <link rel="stylesheet" href="Public/default/css/common.css" type="text/css" />
        <link rel="stylesheet" href="Public/default/css/table.css" type="text/css" />
        <link rel="stylesheet" href="Public/default/css/pagination.css" type="text/css" />
        <link rel="stylesheet" href="Public/default/css/form.css" type="text/css" />
        <link rel="stylesheet" href="Public/default/css/tablesorter/style.css" type="text/css" />
        <link rel="stylesheet" href="Public/js/jquery/smoothness/jquery-ui-1.8.23.custom.css" type="text/css" />
        <!--[if IE]>
        <link rel="stylesheet" href="css/ie.css" type="text/css" />
        <![endif]-->
    </head>
    <body>
        <div class="wrapper">
            <!-- HEADER -->
            <div id="header">
            <!-- logo -->
<div class="logo">
    <img src="Public/default/images/man_logo.jpg" alt="leadsec" />
</div>
<!-- rightNav-->
<div class="right_nav">
    <div class="text_left">
        <img src="Public/default/images/direct.gif" width="8" height="21" />
        安全隔离与信息交换系统
    </div>
    <div class="text_right">
        <img src="Public/default/images/return.gif" width="13" height="21" />&nbsp;[
        <a href="#">返回首页</a>&nbsp;|&nbsp;<a href="#">栏目导航</a> ]
   </div>
</div>

            </div>

            <!-- NAV & CONTENT -->
            <div class="content" id="content">
                <div class="secondary">
                    <!-- userinfo -->
                    <div class="userinfo">
                        Welcome,&nbsp;<strong>DavidTian</strong>
                        [<a href="#">Administrator</a>,&nbsp;<a href="#">logout</a>]
                    </div>
                    <!-- leftmenu -->
                    <div id="leftmenu">
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

                    </div>
                    <!-- switch btn -->
                    <div class="switchpic">
                        <img src="Public/default/images/switch_left.gif" title="隐藏左侧导航栏" id="ImgArrow"/>
                    </div>
                </div>
                <!-- content -->
                <div class="primary" id="mainZone">
                <!-- tabs -->
<div class="tabs">
    <ul>
        <li>First</li>
        <li>网络配置</li>
        <li>Second</li>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="Public/default/images/hi.gif" />&nbsp;
    <span id="show_text">headline</span>
</div>

<br class="clearFloat"/>
<!-- mainContent -->
<div class="mainContent">
    <table class="floatLeft column_50">
        <tr>
            <th class="column_30">名称</th>
            <th class="column_70">内容</th>
        </tr>
        <tr>
            <th>安全隔离网闸序列号</th>
            <td>d6757df2b05c23cb</td>
        </tr>
        <tr>
            <th>硬件版本号</th>
            <td>SIS-3000-Z6101</td>
        </tr>
        <tr>
            <th>软件版本号</th>
            <td>1.0.200.31</td>
        </tr>
        <tr>
            <th>安全隔离网闸名称</th>
            <td>NetGap</td>
        </tr>
    </table>
    <br class="clearFloat"/><br/>
    <hr/>
    <table class="floatLeft column_75">
        <caption>
            最近事件
            <a href="#">更多</a>
        </caption>
        <tr>
            <th class="column_30">日期 / 时间</th>
            <th class="column_10 textCenter">级别</th>
            <th class="column_50">详细信息</th>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25 </th>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="error textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
    </table>
</div>

                </div>
            </div>
            <div class="clearFloat"></div>
            <!-- FOOTER -->
            <div class="footer">
                <div class="bottom">@ 2010-2020 北京网御星云信息技术有限公司版权所有</div>
            </div>
        </div>
    </body>
</html>

<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="Public/js/tabs.js"></script>
<script type="text/javascript" src="Public/js/dialog.js"></script>
<script>
    $(document).ready(function() {
        // init layout
        var mainZoneWidth;
        // load content div
        refreshTab();
        //set height/width of content_inner
        $("#mainZone").width($("#content").width()-$("#content>.secondary").width());
        mainZoneWidth = $("#mainZone").width();
        // end init layout

        $("#leftmenu").outerHeight($("#mainZone>.mainContent").outerHeight());
        // fold/unfold level1 of leftmenu
        $("#leftmenu>div:not(.l1)").hide(); // fold all child-menu
        $("#leftmenu>.l1").addClass('l1_close').click(function() {
            var pname = $(this).attr("name");
            var l2Dom = $("#leftmenu>.l2[name='" + pname + "']");
            $("#leftmenu>.l1").not($(this)).removeClass('l1_open').addClass('l1_close');
            $("#leftmenu>.l2").not(l2Dom).slideUp();
            if ( l2Dom.css('display') == 'none' ) {
                l2Dom.slideDown('slow');
            } else {
                l2Dom.slideUp('slow');
            }
            $(this).toggleClass('l1_open l1_close');
        });


        // slide leftmenu div
        var slideWidth = $('#leftmenu').width();
        var arrowImg = $("#ImgArrow");
        var leftArrow = {
            src : "Public/default/images/switch_left.gif",
            title : "隐藏左侧导航栏"
        };
        var rightArrow = {
            src : "Public/default/images/switch_right.gif",
            title : "显示左侧导航栏"
        };
        arrowImg.click(function() {
            $("#content>.secondary").animate({
                "left" : "-=" + slideWidth}, 600, function() {
                slideWidth = -slideWidth;
                if ( slideWidth > 0 ) { // close leftmenu
                    arrowImg.attr("src", leftArrow.src).attr("title", leftArrow.title);
                    $("#mainZone").width(mainZoneWidth);
                } else { // open leftmenu
                    arrowImg.attr("src", rightArrow.src).attr("title", rightArrow.title);
                    $("#mainZone").css("width", "99%");
                }
            });
            if( $(this).offset().left > 195 ) { // close leftmenu
                var mzWidth = "99%";
            } else { // open leftmenu
                var mzWidth = mainZoneWidth + "px";
            }
            $("#mainZone").animate({
                "width" : mzWidth}, 600);
        });
        // end toggle leftmenu div

        // refresh content
        $("#leftmenu a").click(function() {
            var toHref = $(this).attr("title");
            var groupName  = $(this).parents("div.l2").attr("name");
            $("#leftmenu a").removeClass("link");
            $(this).addClass("link");
            showPageByAjax(groupName + '/' + toHref);
            return false;
        });

    });
</script>
<?php }} ?>