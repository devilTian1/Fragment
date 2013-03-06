<style type="text/css">
	#hotstandby{ margin-left:30px;}
	#gapBox1{ width:150px; height:600px; background:#CCC; float:left; position:relative}
	#midBox{ width:600px; height:600px; background:#eee; float:left; position:relative;}
	#gapBox2{ width:150px; height:600px; background:#CCC; float:left; position:relative}
	
	#mainBox{width:100%; height:220px; background:#0C9; position:absolute; top:0;}
	#mainBox .inner_content{border-bottom:2px solid #FC0; height:110px;position:relative;}
	
	/*#mainBox .inner_content span{
	position:absolute;
	left:36px;
	top:11px;
	color:#F00;
	font-size:14px;
	font-weight:bold;
	}*/
	#mainBox .out_content{border-top:2px solid #FC0; height:110px;position:relative;}
	/*#mainBox .out_content span{
		position:absolute;
		left:0px;
		top:0px;color:#F00; font-size:14px; font-weight:bold;
	}*/
	#chongBox{width:100%; height:220px; background:#0C9; position:absolute; bottom:0;}
	#chongBox .inner_content{border-bottom:2px solid #FC0; height:110px; position:relative;}
	#chongBox .out_content{border-top:2px solid #FC0; height:110px; position:relative;}
	/*#chongBox .inner_content span{
		position:absolute;
		left:0px;
		top:0px;color:#F00; font-size:14px; font-weight:bold;
	}
	#chongBox .out_content span{
		position:absolute;
		left:0px;
		top:0px;color:#F00; font-size:14px; font-weight:bold;
	}*/
	
	.netcard{ position:absolute; width:100%; height:40px;  top:50%; padding:0 30px;}
    .netcard .networdcard{ width:20px; height:20px; border:2px solid #09F; float:left; background:#CF3; margin:5px}
	.netcard .networdcard2{ background:#00C;}
.content_con{
	padding:20px 10px;
	position:absolute;
	left:0;
	top:0;
	width: 452px;
	height: 58px;
}
.content_con .logo{ 
	float:left;
	width:40px;
	border:1px solid #C00;
	height:20px;
}
.content_con .name{
	 float:left;
	font-size:16px; font-weight:bold; color:#F00; padding-right:20px;
}
.content_con .status_{
    float:left;
	font-size:14px;
	color:#333;
}
.content_con .status_ span{ font-size:16px; color:#0FF; font-weight:bold}

#leftline{
	position:absolute;
	width:80px;
	height:404px;
	border:#F00 3px solid;
	border-right:none;
	right:0;
	top: 44px;
}
#rightline{
	position:absolute;
	width:80px;
	height:404px;
	border:#F00 3px solid;
	border-left:none;
	left:0;
	top:160px;
}
</style>
<div id="hotstandby">
   <!--左边部分-->
   <div id="gapBox1">
   		<div id="leftline"></div>
   </div>
   <!--中间部分-->
   <div id="midBox">
	<div id="mainBox">
        <div class="inner_content">
        	<div class="content">
                <div class="content_con">
                    <div class="logo">LOGO</div>
                    <div class="name">主(内)</div>
                    <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" />(<span>正常</span>)</div>
                </div>
          </div>
        	<div class="netcard">
                <div class="networdcard"></div>
                <div class="networdcard networdcard2"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
            </div>
        </div>
        <div class="out_content">
        	<div class="content">
                <div class="content_con">
                    <div class="logo">LOGO</div>
                    <div class="name">主(外)</div>
                    <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" />(<span>正常</span>)</div>
                </div>
            </div>
        	<div class="netcard">
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
            </div>
        </div>
    </div>
    <div id="chongBox">
        <div class="inner_content">
            <div class="content">
                <div class="content_con">
                    <div class="logo">LOGO</div>
                    <div class="name">备(内)</div>
                    <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" />(<span>正常</span>)</div>
                </div>
            </div>
            <div class="netcard">
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
            </div>
        </div>
        <div class="out_content">
            <div class="content">
                <div class="content_con">
                    <div class="logo">LOGO</div>
                    <div class="name">备(外)</div>
                    <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" />(<span>正常</span>)</div>
                </div>
            </div>
            <div class="netcard">
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
                <div class="networdcard"></div>
            </div>
        </div>
    </div>
</div>
    <!--右边部分-->
    <div id="gapBox2">
    	<div id="rightline"></div>
   </div>
</div>
<script type="text/javascript">
$(document).ready(function() {

});
</script>