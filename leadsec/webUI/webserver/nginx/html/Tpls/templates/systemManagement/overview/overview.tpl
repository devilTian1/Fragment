<!-- mainContent -->
<style type="text/css">
/* zoombox */
a,img{border:0;}
</style>
<table class="floatLeft column_90">
    <caption>
        网口状态图状态
    </caption>
    <tr>
        <td id="zoomboxtd">
  <div class="zoombox">
	<div class="zoompic" id="zoompic"></div>
	
</div><!--slider end-->
        </td>
    </tr>
</table>
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_45 dev_info_table">
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
        利用率
    </caption>
    <tr>
        <th id="useRatio"></th>
    </tr>
</table>
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_45">
<caption>
	负载均衡状态
</caption>
	<tr>
		<th class="column_30">名称</th>
		<th class="column_70">内容</th>
	</tr>
	<tr>
		<th>工作角色</th>
		<td><{$lvsinfo.role_name}></td>
	</tr>
	<tr>
		<th>工作状态</th>
		<td><{$lvsinfo.lvs_type}></td>
	</tr>
	<tr>
		<th>&nbsp;</th>
		<td>&nbsp;</td>
	</tr>
</table>
<table class="floatLeft column_45">
	<caption>
        双击热备状态
	</caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>工作角色</th>
        <td><{$hainfo.role_name}></td>
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
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_45">
    <caption>
          服务状态       
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_20">状态</th>
        <th class="column_30">名称</th>
        <th class="column_20">状态</th>
    </tr>
    <tr>
        <th>定制服务(tcp)</th>
        <td>
           <{if $status.tcp eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>安全浏览</th>
        <td>
           <{if $status.http eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
    <tr>
        <th>定制服务(udp)</th>
        <td>
           <{if $status.udp eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>消息传输</th>
        <td>
           <{if $status.msg eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
    <tr>
        <th>数据库访问</th>
        <td>
           <{if $status.db eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>邮件服务(SMTP)</th>
        <td>
           <{if $status.smtp eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
    <tr>
        <th>数据库同步</th>
        <td>
           <{if $status.dbswap eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>邮件服务(pop3)</th>
        <td>
           <{if $status.pop3 eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
    <tr>
        <th>文件同步</th>
        <td>
           <{if $status.fswap eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>FTP访问</th>
        <td>
           <{if $status.ftp eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
    <tr>
        <th>文件交换</th>
        <td>
           <{if $status.sync eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
        <th>安全通道</th>
        <td>
           <{if $status.pass eq 1}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
           <{else}>
             <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
           <{/if}>
        </td>
    </tr>
</table>
<table class="floatLeft column_45">
    <caption>
		license
    </caption>
    <tr>
       <th class="column_30">名称</th>
       <th class="column_20">状态</th>
       <th class="column_30">名称</th>
       <th class="column_20">状态</th>
    </tr>
    <{foreach from=$liceinfo key=count item=val}>
	<{if $count is div by 2}><tr>
	<{/if}>
	<th><{$val.name}></th>
    <td><{$val.status}></td>
	<{if ($count +1) is div by 2}></tr><{/if}>
	<{if $count eq 11}>
	<{break}>
	<{/if}>
    <{/foreach}>
</table>
<br class="clearFloat"/>
<script type="text/javascript" src="Public/js/systemManagement/overview/overview.js"></script>

<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts.js"></script>
<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts-more.js"></script>

<script type="text/javascript">

function getInitData(intval) {
    // generate an array of random data
    intval /= 1000;
    var data = [], i;
    for (i = -20; i < intval; i+=intval) {
        data.push({
            x: <{$curStampTime * 1000}> + i * 1000,
            y: 0
        });
    }
    return data;
}

$(document).ready(function () {
    //动态改变宽度
    var widbox = $("#zoomboxtd").width();
    $(".zoombox").width(widbox);
    $("#zoompoc").width(widbox);

		var setTimeout_flag = -1;
		var setTimeIntval   = 3000;//多少时间更新一次
	    Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        var chart;
		function setHighcharts(eth){
			clearInterval(setTimeout_flag);
        	chart = new Highcharts.Chart({
            chart: {
                renderTo: 'zoompic',
                type: 'spline',
                marginRight: 10,
                events: {
                    load: function() {
                        // set up the updating of the chart each second
                        var series = this.series;
                        setTimeout_flag=setInterval(function() {
							$.post("Function/systemManagement/overview/overview.php", {type:'getImgData'},
							    function(result) {
                                    var data = result.msg.ifData;
								    if(document.getElementById("zoompic")==null){
								        clearInterval(setTimeout_flag);
								    }
                                    var j = 0;
                                    for (var i in data) {
                                        series[j++].addPoint([data[i].inKb.x, data[i].inKb.y], true, false);
                                        series[j++].addPoint([data[i].outKb.x, data[i].outKb.y], true, false);
                                    }
                                    updateUsedStatus(result.msg.cpuUsed, result.msg.memUsed);
							    }, 'json');
                        }, setTimeIntval);
                    }
                }
            },
            title: {
                text: '网口流量状态监控图'
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
                    text: '流量(KB/s)'
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
            exporting: {
                enabled: false
            },
            series: [
                <{foreach $ifsName as $ifName}>
                    {
                        name: '<{$ifName}>|in',
                        data: getInitData(setTimeIntval)
                    },
                    {
                        name: '<{$ifName}>|out',
                        data: getInitData(setTimeIntval)
                    }
                    <{if !$ifName@last}>
                    ,
                    <{/if}>
                <{foreachelse}>
                    {}
                <{/foreach}>
            ]
        });
    }
    function updateUsedStatus(cpuUsed, memUsed) {
        var left  = chart1.series[0].points[0];
        var right = chart1.series[1].points[0];
        left.update(cpuUsed, false);
        right.update(memUsed, false);
        chart1.redraw();
    }
    /*******************************利用率*********************************/
    var chart1 = new Highcharts.Chart({
            chart: {
                renderTo: 'useRatio',
                type: 'gauge',
                plotBorderWidth: 1,
                plotBackgroundColor: {
                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                    stops: [
                        [0, '#FFF4C6'],
                        [0.3, '#FFFFFF'],
                        [1, '#FFF4C6']
                    ]
                },
                plotBackgroundImage: null,
                height: 175
            },
            title: {
                text: null 
            },
			credits:{
				enabled:false
			},
            pane: [{
                startAngle: -40,
                endAngle: 40,
                background: null,
                center: ['25%', '145%'],
                size: 300
            }, {
                startAngle: -40,
                endAngle: 40,
                background: null,
                center: ['75%', '145%'],
                size: 300
            }],	    		        
        
            yAxis: [{
                min: 0,
                max: 100,
                minorTickLength: 10,
                minorTickPosition: 'outside',
                tickPosition: 'outside',
                labels: {
                    rotation: 'auto',
                    distance: 20
                },
                plotBands: [{
                    from: 0,
                    to: 50,
                    color: '#55BF3B',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }, {
                    from: 50,
                    to: 80,
                    color: '#DDDF0D',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }],
                pane: 0,
                title: {
                    text: getMessage('CPU Used'),
                    y: -40
                },
                credits:{
                    enabled:false
                }
            }, {
                min: 0,
                max: 100,
                minorTickPosition: 'outside',
                tickPosition: 'outside',
                labels: {
                    rotation: 'auto',
                    distance: 20
                },
                plotBands: [{
                    from: 0,
                    to: 50,
                    color: '#55BF3B',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }, {
                    from: 50,
                    to: 80,
                    color: '#DDDF0D',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353',
                    innerRadius: '100%',
                    outerRadius: '105%'
                }],
                pane: 1,
                title: {
                    text: getMessage('Mem Used'),
                    y: -40
                },
                credits:{
                    enabled:false
                }
            }],
            
            plotOptions: {
                gauge: {
                    dataLabels: {
                        enabled: false
                    },
                    dial: {
                        radius: '100%'
                    }
                }
            },
            series: [{
                data: [<{$cpuUsed}>],
                yAxis: 0
            }, {
                data: [<{$memUsed}>],
                yAxis: 1
            }]
        });
	//IE6下面滚动条优化
	if($.browser.msie&&($.browser.version == "6.0")&&!$.support.style){
		 $("#mainContent").scroll(function(){
			//利用率
			var top=$("#useRatio").offset().top-$("#useRatio div").offset().top;
			$("#useRatio div").css({"top":top+"px"});
			$("useRatio div").css({"top":"0px"});
		
			//网口状态图状态 
			var top1=$("#zoomboxtd").offset().top-$(".zoombox").offset().top;
			$(".sliderbox").css({"top":top1+"px"});
			$(".sliderbox").css({"top":"0px"});
			$("#zoompic").css({"top":top1+"px"});
			$("#zoompic div").css({"top":top1+"px"});
			$("#zoompic div").css({"top":"0px"});
		 })
	}
/************************************************************************************************************************************/


    setHighcharts();
    for (var i in chart.series) {
        if (i === '0') {
            chart.series[i].show();
        } else {
            chart.series[i].hide();
        }
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
