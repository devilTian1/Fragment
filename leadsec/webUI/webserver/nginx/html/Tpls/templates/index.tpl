<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title></title>
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/common.css" type="text/css" />
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/table.css" type="text/css" />
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/pagination.css" type="text/css" />
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/form.css" type="text/css" />
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/tablesorter/style.css" type="text/css" />
        <link rel="stylesheet" href="Public/js/jquery/smoothness/jquery-ui-1.8.23.custom.css" type="text/css" />
        <!--[if IE]>
        <link rel="stylesheet" href="css/ie.css" type="text/css" />
        <![endif]-->
    </head>
    <body>
        <div class="wrapper">
            <!-- HEADER -->
            <div id="header">
            {include file='header.tpl'}
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
                    {include file='leftmenu.tpl'}
                    </div>
                    <!-- switch btn -->
                    <div class="switchpic">
                        <img src="{$smarty.const.THEME_PATH}/images/switch_left.gif" title="隐藏左侧导航栏" id="ImgArrow"/>
                    </div>
                </div>
                <!-- content -->
                <div class="primary" id="mainZone">
                {include file='content.tpl'}
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
<script type="text/javascript" src="Public/js/common.js"></script>
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
            src : "{$smarty.const.THEME_PATH}/images/switch_left.gif",
            title : "隐藏左侧导航栏"
        };
        var rightArrow = {
            src : "{$smarty.const.THEME_PATH}/images/switch_right.gif",
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
            var path = {
                1 : $(this).parents("div.l2").attr("name"),
                2 : $(this).attr("name")
            }
            $("#leftmenu a").removeClass("link");
            $(this).addClass("link");
            showPageByAjax(path);
            return false;
        });
    });
</script>
