<style type="text/css">
	#hotstandby{ margin-left:30px;}
	#mainBox{ position:relative; width:300px; height:220px; float:left; border-left:none}
	#mainBox .netcard{position:absolute; left:0; width:20px; height:100%;}
	#mainBox .netcard .networdcard{ width:15px; height:15px; border:1px solid #000; float:right; border-right:none; margin:5px 0}
	#mainBox .netcard .tip{
	position:absolute;
	left: -21px;
	width: 17px;
	top: 49px;
	height: 86px;
}
	#mainBox .content{position:absolute; left:20px; width:200px; border:1px solid #000;height:100%}

	#mainBox .inner_content{position:absolute; border:1px solid #000; border-left:none; height:110px; left:220px; width:80px;}
	#mainBox .inner_content span{
	position:absolute;
	left:22px;
	top:36px
}
	#mainBox .out_content span{
	position:absolute;
	left:20px;
	top:42px
}
	#mainBox .out_content{position:absolute; border:1px solid #000; border-left:none; border-top:none; height:111px; top:110px; left:220px; width:80px;}
	
	#gapBox{ width:100px; height:200px; float:left; position:relative;}
	#gapBox .inner_path{ background:#000; width:100%; height:2px; position:absolute; top:20px;}
	#gapBox .out_path{ background:#000; width:100%; height:2px; position:absolute; bottom:20px;}
	#gapBox .txt1{position:absolute; top:30px; left: 24px;}
	#gapBox .txt2{position:absolute; bottom:30px; left: 23px;}
	
	#chongBox{ position:relative; width:300px; height:220px; float:left}
	#chongBox .netcard{position:absolute;right:0; width:20px; height:100%;}
	#chongBox .netcard .networdcard{ width:15px; height:15px; border:1px solid #000; float:left; border-left:none; margin:5px 0}
	#chongBox .netcard .tip{
	position:absolute;
	left: 28px;
	width: 17px;
	top: 49px;
	height: 86px;
}

	#chongBox .content{position:absolute;right:20px; width:200px; border:1px solid #000; height:100%}
	#chongBox .inner_content{position:absolute; border:1px solid #000; border-right:none; height:110px; right:220px; width:80px;}
	#chongBox .out_content{position:absolute;border:1px solid #000; border-right:none; border-top:none; height:111px; top:110px; right:220px; width:80px;}
	#chongBox .inner_content span{
	position:absolute;
	left:22px;
	top:36px
}
	#chongBox .out_content span{
	position:absolute;
	left:22px;
	top:155px
}

.content_con{ padding:20px 10px;}
.content_con .logo{ width:160px; border:1px solid #0F0; height:30px;}
.content_con .name{ font-size:14px; padding:8px }
.content_con .name span{ font-size:16px; font-weight:bold; color:#F00}
.content_con .status_{ font-size:14px; padding:8px;}
.content_con .status_ span{ font-size:16px; color:#0FF; font-weight:bold}
</style>
<div id="hotstandby">
	<div id="mainBox">
    	<div class="netcard">
       	  <div class="tip">以太网卡</div>
        	<div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
      </div>
        <div class="content">
        	<div class="content_con">
            	<div class="logo">LOGO</div>
                <div class="name">网闸(<span>主</span>)</div>
                <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" /><span>正常</span></div>
            </div>
        </div>
        <div class="inner_content"><span>内网</span></div>
        <div class="out_content"><span>外网</span></div>
    </div>
    
    <div id="gapBox">
    	<span class="txt1">心跳线</span>
    	<div class="inner_path"></div>
      <div class="out_path"></div>
        <span class="txt2">心跳线</span>
  </div>
    
    <div id="chongBox">
    	<div class="netcard">
        	<div class="tip">以太网卡</div>
        	<div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
            <div class="networdcard"></div>
      </div>
        <div class="content">
        	<div class="content_con">
            	<div class="logo">LOGO</div>
                <div class="name">网闸(<span>从</span>)</div>
                <div class="status_">状态：<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="18" /><span>正常</span></div>
            </div>
        </div>
        <div class="inner_content"><span>内网</span></div>
        <div class="out_content"><span>外网</span></div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {

});
</script>