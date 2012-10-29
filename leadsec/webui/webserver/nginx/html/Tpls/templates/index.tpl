<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <{include file='layout/css.tpl'}>
    </head>
    <body>
        <div class="wrapper">
            <!-- HEADER -->
            <div id="header">
            <{include file='layout/header.tpl'}>
            </div>
            <!-- NAV & CONTENT -->
            <div class="content" id="content">
                <div class="secondary">
                    <!-- userinfo -->
                    <div class="userinfo">
                        Welcome,&nbsp;<strong>DavidTian</strong>
                        [<a href="#">Administrator</a>,&nbsp;<a href="index.php?logout=1">logout</a>]
                    </div>
                    <!-- leftmenu -->
                    <div id="leftmenu">
                    <{include file='layout/leftmenu.tpl'}>
                    </div>
                    <!-- switch btn -->
                    <div class="switchpic">
                        <img src="<{$smarty.const.THEME_PATH}>/images/switch_left.gif" title="隐藏左侧导航栏" id="ImgArrow"/>
                    </div>
                </div>
                <!-- content -->
                <div class="primary" id="mainZone">
                    <div id="tab">
                        <{include file="layout/tabs.tpl"}>
                    </div>
                    <div id="mainContent">
                        <{include file='layout/content.tpl'}>
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
<{include file='layout/js.tpl'}>