<!-- Put 3rd party js libraries first -->
<script type="text/javascript">
//it`s loading, so hide error msg of ie.
    var track_errors = 1;
    function noError() {
        if (track_errors = 1) {
            return true;
        }
    }
    window.onerror = noError;
</script>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tablesorter.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tooltip.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/nicescroll/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="Public/js/tip/msgbox.js"></script>
<script type="text/javascript" src="Public/js/jquery/fishEye/fisheye-iutil.js"></script>
<!-- Put our libraries next -->
<script type="text/javascript" src="Public/js/common.js"></script>
<script type="text/javascript" src="Public/js/localize.js"></script>
<script type="text/javascript" src="Public/js/modStat.js"></script>
<script type="text/javascript" src="Public/js/ui.standard.js"></script>
<script type="text/javascript" src="Public/js/validation.js"></script>
<script type="text/javascript" src="Public/js/tabs.js"></script>
<script type="text/javascript" src="Public/js/search.js"></script>
<script type="text/javascript" src="Public/js/sort.js"></script>
<script type="text/javascript" src="Public/js/header.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/DD_belatedPNG_0.0.8a.js" ></script>
<script type="text/javascript">
    DD_belatedPNG.fix('#header .right_nav .top_icon img,#header .right_nav .top_userinfo,#header .right_nav .top_icon ul li span');
</script>
<![endif]-->
<script>
    function logout() {
        var data = {relogin : '1'}
        $.ajax({type: "GET", url: "Function/common.php", data: data});
    }

    function wireUpEvents() {
        var validNavigation = false;
        window.onbeforeunload = function() {
            if (!validNavigation) {
                logout();
            }
            validNavigation = false;
        }
        $(document).bind('keydown', function(e) {
            if (e.keyCode = 116) {
                validNavigation = true;
            }
        });
        $("form").live('submit', function() {
            validNavigation = true;
        });
        $("button[type='submit']", "input[type='submit']", "a").live('click', function() {
            validNavigation = true;
        });
    }
    $(document).ready(function() {
        wireUpEvents();
        // init layout
        // load content div
        refreshTabs();
        $('#dock2').Fisheye({
            maxWidth: 45, //[TODO] 60
            items: 'a',
            itemsText: 'span',
            container: '.dock-container2',
            itemWidth: 40,
            proximity: 80,
            alignment : 'left',
            valign: 'bottom',
            halign : 'center'
        });
        //set height/width of content_inner
        $("#mainZone").width($("#content").width()-$("#content>.secondary").width()+20);
        var mainZoneWidth = $("#mainZone").width();
        var logoWidth     = $('#header .logo').width();
		$("#header .right_nav").width($(window).innerWidth() - logoWidth);
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
				if (pname != cname) {
				    $(this).removeClass('l1_open_' + cname)
                           .addClass('l1_close_' + cname);	
				}
			});
            $("#leftmenu>.l2").not(l2Dom).slideUp();
            $("#leftmenu li>.l3").slideUp();
            if ( l2Dom.css('display') == 'none' ) {
                l2Dom.slideDown('slow');
            } else {
                l2Dom.slideUp('slow');
            }
            $(this).toggleClass('l1_open_'+pname+' l1_close_'+pname);
        });
        $("#leftmenu span.l2span").click(function() {
            var pname = $(this).attr("name");
            var l3Dom = $("#leftmenu ul.l3[name='" + pname + "']");
			$("#leftmenu span.l2span").not(function() {
		        var cname = $(this).attr("name");
				if (pname != cname) {
				    $(this).removeClass('l1_open_' + cname)
                           .addClass('l1_close_' + cname);	
				}
			});
            $("#leftmenu ul.l3").not(l3Dom).slideUp();
            if ( l3Dom.css('display') == 'none' ) {
                l3Dom.slideDown('slow');
            } else {
                l3Dom.slideUp('slow');
            }
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
                'l1' : $(this).parents("div.l2").attr("name"),
                'l2' : $(this).parents("ul.l3").attr("name"),
                'l3' : $(this).attr('name')
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
			$("#header .right_nav").width(mainZoneWidth-210)
            var cheight = $(window).height() - 250;
            $('#leftmenu').height(cheight + 37);
            $('#mainContent').height(cheight);
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
			var path = {
			    'l1':"statusMonitor",
				'l2':"systemStatus"
			}
			showTabByAjax(path);
		})();
		//beautify scroll html
		$("html").niceScroll({cursorborder:"",cursorcolor:"#4d8fc7",boxzoom:true});
		$("#mainContent").niceScroll({cursorborder:"",cursorcolor:"#4d8fc7",boxzoom:true});
        $('#leftmenu').niceScroll({cursorborder: "", cursorcolor: "#4d8fc7",
                                   boxzoom: true});
        setTimeout(function() {
            var cheight = $(window).height() - 250;
            $('#leftmenu').height(cheight + 37);
            $('#mainContent').height(cheight);
        }, 500);
    });
</script>
