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
	<div class="zoompic" id="zoompic"></div>
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

<script src="Public/js/jquery/Highcharts/highcharts.js"></script>

<script type="text/javascript">
$(document).ready(function (){
		var setTimeout_flag=-1;
		var setTimeIntval=3000;//多少时间更新一次
		var maxEthNum=6;//网卡数量
/************************************************************************************************************************************/
	   Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        var chart;
		function setHighcharts(eth){
			clearInterval(setTimeout_flag);
			var data_pe=(function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;
    
                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
        	chart = new Highcharts.Chart({
            chart: {
                renderTo: 'zoompic',
                type: 'spline',
                marginRight: 10,
                events: {
                    load: function() {
                        // set up the updating of the chart each second
                        var series0 = this.series[0];
						var series1 = this.series[1];
						var series2 = this.series[2];
                        setTimeout_flag=setInterval(function() {
							$.post("Function/systemManagement/overview/overview.php", {type:'getImgData',eth: eth },
							  function(data){
								  if(document.getElementById("zoompic")==null){
								  	 clearInterval(setTimeout_flag);
								  }
								  if (typeof(JSON) == 'undefined'){  
										 jsondata = eval("("+data+")");  
								  }else{  
										 jsondata = JSON.parse(data);  
								  } 
								  
								  series0.addPoint([jsondata[0].x, jsondata[0].y], true, true);
								  series1.addPoint([jsondata[1].x, jsondata[1].y], true, true);
								  series2.addPoint([jsondata[2].x, jsondata[2].y], true, true);
								  //alert("Data Loaded: " + data);
							  });
                        }, setTimeIntval);
                    }
                }
            },
            title: {
                text: ''
            },
			credits:{
				enabled:false
			},
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: '流量(M/s)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>选项：'+ this.series.name +'</b><br/>时间：'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>数值：'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
				enabled:true,
				layout: 'vertical',
                align: 'left',
                verticalAlign: 'top',
                x: 60,
                y: 0,
                floating: true
               /* backgroundColor: '#FFFFFF',
                borderWidth: 1*/
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'PE0',
                data:data_pe
            },
			{
                name: 'PE1',
                data: data_pe
            },
			{
                name: 'PE2',
                data: data_pe
            }]
        });
  }
		
/************************************************************************************************************************************/
	
	for(var i=0;i<=maxEthNum;i++){
		$("#eth"+i).click(function(){
				var id=$(this).attr("id");
				var flag=$(this).attr("rel");
				$("#thumbnail li.current").removeClass("current");
				$(this).parents("li").addClass("current");
				clearInterval(setTimeout_flag);
				if(flag==1){//有流量控制
					$(".zoompic").removeClass("zoompic_bg");
					//$(".zoompic").html("");
					setHighcharts(id);
					//setCubism(id);
					//setSplotLine(id);
					//setSparkLine(id);	
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