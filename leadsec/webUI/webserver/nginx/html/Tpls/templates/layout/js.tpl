<!-- Put 3rd party js libraries first -->
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tablesorter.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tooltip.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/nicescroll/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/fisheye/jquery.fisheye.js"></script>
<script type="text/javascript" src="Public/js/jquery/fisheye/jquery.bubbleup.js"></script>

<script type="text/javascript" src="Public/js/tip/msgbox.js"></script>
<!-- Put our libraries next -->
<script type="text/javascript" src="Public/js/common.js"></script>
<script type="text/javascript" src="Public/js/localize.js"></script>
<script type="text/javascript" src="Public/js/ui.standard.js"></script>
<script type="text/javascript" src="Public/js/validation.js"></script>
<script type="text/javascript" src="Public/js/tabs.js"></script>
<script type="text/javascript" src="Public/js/search.js"></script>
<script type="text/javascript" src="Public/js/sort.js"></script>
<script type="text/javascript" src="Public/js/header.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/DD_belatedPNG_0.0.8a.js" ></script>
<script type="text/javascript">
	//DD_belatedPNG.fix('#header .right_nav .top_icon img,#header .right_nav .top_userinfo,#header .right_nav .top_icon ul li span');
	DD_belatedPNG.fix('#header .right_nav .top_userinfo,#header .right_nav .top_icon ul li span');
</script>
<![endif]-->
<script>
    $(document).ready(function() {
        // init layout
        // load content div
        refreshTabs();
        //set height/width of content_inner
        $("#mainZone").width($("#content").width()-$("#content>.secondary").width()+20);
        var mainZoneWidth = $("#mainZone").width();
		$("#header .right_nav").width(mainZoneWidth-210)
        // end init layout
        //$("#leftmenu").outerHeight($("#mainContent").outerHeight());
		$("#leftmenu").outerHeight($("#mainContent").outerHeight()+21);
        // fold/unfold level1 of leftmenu
        $("#leftmenu>div:not(.l1)").hide(); // fold all child-menu
        $("#leftmenu>.l1").click(function() {
            var pname = $(this).attr("name");
            var l2Dom = $("#leftmenu>.l2[name='" + pname + "']");
			$("#leftmenu>.l1").not(function(){
									var cname=$(this).attr("name");
									if(pname!=cname){
										$(this).removeClass('l1_open_'+cname).addClass('l1_close_'+cname);	
									}
								});
            $("#leftmenu>.l2").not(l2Dom).slideUp();
            if ( l2Dom.css('display') == 'none' ) {
                l2Dom.slideDown('slow');
            } else {
                l2Dom.slideUp('slow');
            }
            $(this).toggleClass('l1_open_'+pname+' l1_close_'+pname);
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
                var mzWidth = "99.5%";
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
			//alert(mainZoneWidth);
			$("#header .right_nav").width(mainZoneWidth-210)
		});
		//init header tip
		$("#header .right_nav .top_icon ul li").mousemove(function() {
            var me=$(this);
			me.children("span").show();
            return false;
        });
		$("#header .right_nav .top_icon ul li").mouseout(function() {
            var me=$(this);
			me.children("span").hide();
            return false;
        });
		
		//init index page
		(function(){
			var path={
				'1':"systemManagement",
				'2':"overview"
					}
			showTabByAjax(path);
		})();
		//beautify scroll html
		$("html").niceScroll({cursorborder:"",cursorcolor:"#4d8fc7",boxzoom:true});
		$("#mainContent").niceScroll({cursorborder:"",cursorcolor:"#4d8fc7",boxzoom:true});
		
		/*$(".top_icon").FishEye({
			fishEyeItemName: ".fishEyeItem",
			maxScalePct: 70,
			scaleStepPct: 20
		});*/
		 $("div.top_icon ul li a img").bubbleup({tooltip: false, scale:50});
		
    });
</script>
