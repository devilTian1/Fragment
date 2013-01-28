<!-- mainContent -->
<style type="text/css">
/* zoombox */
a,img{border:0;}
</style>
<table class="floatLeft column_60">
    <caption>
        网口状态图状态
         <!--<a href="#">更多</a>-->
    </caption>
    <tr>
        <td>
  <div class="zoombox">
	<div class="zoompic"></div>
	<div class="sliderbox">
		<div id="btn-left" class="arrow-btn dasabled">
        </div>
		<div class="slider" id="thumbnail">
			<ul>
				<li class="current"><a href="#" id="eth0" rel="1"><img src="<{$smarty.const.THEME_PATH}>/images/eth_active.gif" width="115" height="50" /><div>eth0</div></a></li>
				<li><a href="#" id="eth1" rel="1"><img src="<{$smarty.const.THEME_PATH}>/images/eth_active.gif" width="115" height="50" /><div>eth1</div></a></li>
				<li><a href="#" id="eth2" rel="0"><img src="<{$smarty.const.THEME_PATH}>/images/eth_stop.gif" width="115" height="50" /><div>eth2</div></a></li>
				<li><a href="#" id="eth3" rel="0"><img src="<{$smarty.const.THEME_PATH}>/images/eth_stop.gif" width="115" height="50" /><div>eth3</div></a></li>
				<li><a href="#" id="eth4" rel="1"><img src="<{$smarty.const.THEME_PATH}>/images/eth_active.gif" width="115" height="50" /><div>eth4</div></a></li>
				<li><a href="#" id="eth5" rel="0"><img src="<{$smarty.const.THEME_PATH}>/images/eth_stop.gif" width="115" height="50" /><div>eth5</div></a></li>
				<li><a href="#" id="eth6" rel="0"><img src="<{$smarty.const.THEME_PATH}>/images/eth_stop.gif" width="115" height="50" /><div>eth6</div></a></li>
			</ul>
		</div>
		<div id="btn-right" class="arrow-btn"></div>
	</div>
</div><!--slider end-->
        </td>
    </tr>
</table>
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_45">
    <caption>设备信息</caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th><{$smarty.const.PRODUCT_NAME}>序列号</th>
        <td><{$devinfo.serialnum}></td>
    </tr>
    <tr>
        <th>硬件版本号</th>
        <td><{$devinfo.devnum}></td>
    </tr>
    <tr>
        <th>软件版本号</th>
        <td><{$devinfo.softnum}></td>
    </tr>
    <tr>
        <th><{$smarty.const.PRODUCT_NAME}>名称</th>
        <td><{$devinfo.hostname}></td>
    </tr>
</table>

<table class="floatLeft column_45">
    <caption>
        license
        <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">服务名称</th>
        <th class="column_10 textCenter">状态</th>
        <th class="column_60 textCenter">描述</th>
    </tr>
    <{foreach from=$liceinfo key=myId item=val}>

    <tr>
        <th><{$val.name}></th>
        <td class="textCenter">
        <{if $val.status eq 1}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
        <{else}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
        <{/if}>
        </th>
        <td class="textCenter"><{$val.remark}></td>
    </tr>
    <{/foreach}>
</table>
<br class="clearFloat"/>
<hr/>

  <table class="floatLeft column_45">
    <caption>
        负载均衡状态
         <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
</table>
<table class="floatLeft column_45">
<caption>
        双击热备状态
         <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td></td>
    </tr>
</table>

<br class="clearFloat"/>
<script type="text/javascript" src="Public/js/systemManagement/overview/overview.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.sparkline.min.js"></script>
<script type="text/javascript">
$(document).ready(function (){
		var setTimeout_flag=-1;
		var maxEthNum=6;//网卡数量
		function setSparkLine(eth) {
			var eth=eth
			var mrefreshinterval = 1000; // update display every 500ms
			var mpoints=[],mpoints2=[],mpoints3=[];
			var mpoints_max = 232;
			var mdraw = function() {
				var pps=Math.ceil(100*Math.random()),
				    pps2=20,
					pps3=Math.ceil(100*Math.random());
				mpoints.push(pps);
				mpoints2.push(pps2);
				mpoints3.push(pps3);
				
				if (mpoints.length > mpoints_max){
					mpoints.splice(0,1);
				}
				if (mpoints2.length > mpoints_max){
					mpoints2.splice(0,1);
				}
				if (mpoints3.length > mpoints_max){
					mpoints3.splice(0,1);
				}
				
				$('.zoompic').sparkline(mpoints, {width: mpoints.length*4, 
										   			  height:150,
													  spotRadius:3,
													  fillColor: false, 
													  tooltipPrefix:'网卡:'+eth+'; 当前速度：', 
													  tooltipSuffix: 'kb/s',
													  defaultPixelsPerValue:50,
													  //tooltipChartTitle:'信息提示',
													  tooltipFormat:'<span style="color: {{color}}">&#9679;</span>{{prefix}}{{y}}{{suffix}}</span>'
													 });
				$('.zoompic').sparkline(mpoints2, {   width: mpoints2.length*4, 
										   			  height:150,
													  spotRadius:3,
													  composite: true,
													  fillColor: false, 
													  lineColor: 'yellow',
													  tooltipPrefix:'网卡:'+eth+'; 信息量：', 
													  tooltipSuffix: 'kb/s',
													  defaultPixelsPerValue:50,
													  //tooltipChartTitle:'信息提示',
													  tooltipFormat:'<span style="color: {{color}}">&#9679;</span>{{prefix}}{{y}}{{suffix}}</span>'
													 });
				
				$('.zoompic').sparkline(mpoints3, {   width: mpoints3.length*4, 
										   			  height:150,
													  spotRadius:3,
													  composite: true,
													  fillColor: false, 
													  lineColor: 'red',
													  tooltipPrefix:'网卡:'+eth+'; 信息量2：', 
													  tooltipSuffix: 'kb/s',
													  defaultPixelsPerValue:50,
													  //tooltipChartTitle:'信息提示',
													  tooltipFormat:'<span style="color: {{color}}">&#9679;</span>{{prefix}}{{y}}{{suffix}}</span>'
													 });
				
				setTimeout_flag=setTimeout(mdraw, mrefreshinterval);
			}
			// We could use setInterval instead, but I prefer to do it this way
			setTimeout_flag=setTimeout(mdraw, mrefreshinterval); 
		};
		//setSparkLine("eth0");
	for(var i=0;i<=maxEthNum;i++){
		$("#eth"+i).click(function(){
				var id=$(this).attr("id");
				var flag=$(this).attr("rel");
				$("#thumbnail li.current").removeClass("current");
				$(this).parents("li").addClass("current");
				clearTimeout(setTimeout_flag);	 
				if(flag==1){//有流量控制
					$(".zoompic").removeClass("zoompic_bg");
					setSparkLine(id);	
				}else{
					$(".zoompic").html("");
					$(".zoompic").addClass("zoompic_bg");
				}
			});
	}
	$("#thumbnail li.current a").click();
	//小图片左右滚动
	var $slider = $('.slider ul');
	var $slider_child_l = $('.slider ul li').length;
	var $slider_width = $('.slider ul li').width();
	$slider.width($slider_child_l * $slider_width);
	
	var slider_count = 0;
	
	if ($slider_child_l < 7) {
		$('#btn-right').css({cursor: 'auto'});
		$('#btn-right').removeClass("dasabled");
	}
	
	$('#btn-right').click(function() {
		if ($slider_child_l < 7 || slider_count >= $slider_child_l - 7) {
			return false;
		}
		
		slider_count++;
		$slider.animate({left: '-=' + $slider_width + 'px'}, 'fast');
		slider_pic();
	});
	
	$('#btn-left').click(function() {
		if (slider_count <= 0) {
			return false;
		}
		slider_count--;
		$slider.animate({left: '+=' + $slider_width + 'px'}, 'fast');
		slider_pic();
	});
	
	function slider_pic() {
		if (slider_count >= $slider_child_l - 7) {
			$('#btn-right').css({cursor: 'auto'});
			$('#btn-right').addClass("dasabled");
		}
		else if (slider_count > 0 && slider_count <= $slider_child_l - 7) {
			$('#btn-left').css({cursor: 'pointer'});
			$('#btn-left').removeClass("dasabled");
			$('#btn-right').css({cursor: 'pointer'});
			$('#btn-right').removeClass("dasabled");
		}
		else if (slider_count <= 0) {
			$('#btn-left').css({cursor: 'auto'});
			$('#btn-left').addClass("dasabled");
		}
	}
	
});
</script>