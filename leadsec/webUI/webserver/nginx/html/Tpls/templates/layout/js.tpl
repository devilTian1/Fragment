<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/ui.standard.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="Public/js/formvalidator/formValidator-4.1.3.min.js"></script>
<script type="text/javascript" src="Public/js/formvalidator/formValidatorRegex.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="Public/js/validation.js"></script>
<script type="text/javascript" src="Public/js/tip/msgbox.js"></script>
<script type="text/javascript" src="Public/js/common.js"></script>
<script type="text/javascript" src="Public/js/tabs.js"></script>
<script>
    $(document).ready(function() {
        // init layout
        var mainZoneWidth;
        // load content div
        refreshTabs();
        //set height/width of content_inner
        $("#mainZone").width($("#content").width()-$("#content>.secondary").width());
        mainZoneWidth = $("#mainZone").width();
        // end init layout

        $("#leftmenu").outerHeight($("#mainContent").outerHeight());
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
		var arrowImgFlag=1;//open，close flag 1:open,0:close
        var leftArrow = {
            src : "<{$smarty.const.THEME_PATH}>/images/switch_left.gif",
            title : "隐藏左侧导航栏"
        };
        var rightArrow = {
            src : "<{$smarty.const.THEME_PATH}>/images/switch_right.gif",
            title : "显示左侧导航栏"
        };
        arrowImg.click(function() {
            $("#content>.secondary").animate({"left" : "-=" + slideWidth},
                600, function() { 
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
				arrowImgFlag=0;
                var mzWidth = "99%";
            } else { // open leftmenu
				arrowImgFlag=1;
                var mzWidth = mainZoneWidth + "px";
            }
            $("#mainZone").animate({"width" : mzWidth}, 600);
        });
        // end toggle leftmenu div

        // refresh content
        $("#leftmenu a").click(function() {
            var path = {
                '1' : $(this).parents("div.l2").attr("name"),
                '2' : $(this).attr("name")
            }
            $("#leftmenu a").removeClass("link");
            $(this).addClass("link");
            showTabByAjax(path);
            return false;
        });
		$(window).resize(function(){
			$("#mainZone").width($("#content").width()-$("#content>.secondary").width());
			mainZoneWidth = $("#mainZone").width();
			if( arrowImgFlag==0 ) { // close leftmenu
                var mzWidth = "99%";
            } else if(arrowImgFlag==1){ // open leftmenu
                var mzWidth = mainZoneWidth + "px";
            }
			$("#mainZone").width(mzWidth);
		});
    });
</script>
