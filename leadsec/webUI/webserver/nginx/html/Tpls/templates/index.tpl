<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <{include file='css.tpl'}>
    </head>
    <body>
        <div class="wrapper">
            <!-- HEADER -->
            <div id="header">
            <{include file='header.tpl'}>
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
                    <{include file='leftmenu.tpl'}>
                    </div>
                    <!-- switch btn -->
                    <div class="switchpic">
                        <img src="<{$smarty.const.THEME_PATH}>/images/switch_left.gif" title="隐藏左侧导航栏" id="ImgArrow"/>
                    </div>
                </div>
                <!-- content -->
                <div class="primary" id="mainZone">
                <{include file="tabs.tpl"}>
                <{include file='content.tpl'}>
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
<{include file='js.tpl'}>
