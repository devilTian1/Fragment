<!-- mainContent -->
<style type="text/css">
/* zoombox */
a, img{border:0;}
</style>
<table class="floatLeft column_90">
    <caption>
        流量监控图
    </caption>
    <tr>
        <td id="zoomboxtd">
  <div class="zoombox">
	<div class="zoompic" id="zoompic">
    </div>
</div><!--slider end-->
        </td>
    </tr>
</table>
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_45 dev_info_table">
    <caption>设备[<{$smarty.const.PRODUCT_NAME}>]信息</caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>序列号</th>
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
        <th>名称</th>
        <td><{$devinfo.hostname}></td>
    </tr>
</table>
<table class="floatLeft column_45">
    <caption>
        资源利用率
        <a href='#' onClick="openAllCpuDialog()">详细信息</a>
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
</table>
<table class="floatLeft column_45">
	<caption>
        双机热备状态
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
        <th>服务状态</th>
        <td><{$hainfo.ha_type}></td>
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
	<th><{$val.ch_name}></th>
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
	$(window).resize(function(){
		var widbox = $(".dev_info_table").width();
		 	$("#zoompic div").width(widbox*2-40);
			$("#useRatio div").width(widbox-40);
	})
	
		var setTimeout_flag = -1;
		var setTimeIntval   = 3000;//多少时间更新一次
	    Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        var chart;
		function setHighcharts() {
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
                                        return;
								    }
                                    var j = 0;
                                    for (var i in data) {
                                        series[j++].addPoint([data[i].inKb.x, data[i].inKb.y], true, true);
                                        series[j++].addPoint([data[i].outKb.x, data[i].outKb.y], true, true);
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
            plotOptions: {
                series: {
                    lineWidth: 1
                }
            },
            tooltip: {
                formatter: function() {
                        return '<b>选项：'+ this.series.name +'</b><br/>时间：'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +
                        '<br/>数值：'+Highcharts.numberFormat(this.y, 2) + 'KB';
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
                plotBorderWidth: 0,
                plotBackgroundColor: null,
                plotBackgroundImage: null,
                plotShadow: false,
                height: 175
            },
            title: {
                text: null 
            },
			credits:{
				enabled:false
			},
            pane: [{
                startAngle: -150,
                endAngle: 150,
                background: [{
                    backgorundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#FFF'], [1, '#333']
                        ]},
                    borderWidth: 0,
                    outerRadius: '109%'
                }, {
                    backgorundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#333'], [1, '#FFF']
                        ]},
                    borderWidth: 1,
                    outerRadius: '107%'
                }, {
                    // default background
                }, {
                    backgorundColor: '#DDD',
                    borderWidth: 0,
                    outerRadius: '105%',
                    innerRadius: '103%'
                }],
                center: ['25%', '55%'],
                size: 170
            }, {
                startAngle: -150,
                endAngle: 150,
                background: [{
                    backgorundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#FFF'], [1, '#333']
                        ]},
                    borderWidth: 0,
                    outerRadius: '109%'
                }, {
                    backgorundColor: {
                        linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, '#333'], [1, '#FFF']
                        ]},
                    borderWidth: 1,
                    outerRadius: '107%'
                }, {
                    // default background
                }, {
                    backgorundColor: '#DDD',
                    borderWidth: 0,
                    outerRadius: '105%',
                    innerRadius: '103%'
                }],
                center: ['75%', '55%'],
                size: 170
            }],   
            yAxis: [{
                pane: 0,
                min: 0,
                max: 100,
                minorTickInterval: 'auto',
                minorTickWidth: 1,
                minorTickLength: 10,
                minorTickPosition: 'inside',
                minorTickColor: '#666',

                tickPixelInterval: 30,
                tickWidth: 2,
                tickPosition: 'inside',
                tickLength: 10,
                tickColor: '#666',
                labels: {
                    rotation: 'auto',
                    step: 2
                },
                plotBands: [{
                    from: 0,
                    to: 50,
                    color: '#55BF3B'
                }, {
                    from: 50,
                    to: 80,
                    color: '#DDDF0D'
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353'
                }],
                title: {
                    text: getMessage('CPU Used'),
                    y: 15
                }
            }, {
                pane: 1,
                min: 0,
                max: 100,
                minorTickInterval: 'auto',
                minorTickWidth: 1,
                minorTickLength: 10,
                minorTickPosition: 'inside',
                minorTickColor: '#666',

                tickPixelInterval: 30,
                tickWidth: 2,
                tickPosition: 'inside',
                tickLength: 10,
                tickColor: '#666',
                labels: {
                    rotation: 'auto',
                    step: 2
                },
                plotBands: [{
                    from: 0,
                    to: 50,
                    color: '#55BF3B'
                }, {
                    from: 50,
                    to: 80,
                    color: '#DDDF0D'
                }, {
                    from: 80,
                    to: 100,
                    color: '#DF5353'
                }],
                title: {
                    text: getMessage('Mem Used'),
                    y: 15
                }
            }],
            plotOptions: {
                gauge: {
                    dataLabels: {
                        formatter: function() {
                            return this.y + '%';
                        },
                        y: 25
                    }
                }
            },
            series: [{
                name: getMessage('CPU Used'),
                data: [<{$cpuUsed}>],
                yAxis: 0,
                tooltip: {
                    valueSuffix: '%'
                }
            }, {
                name: getMessage('Mem Used'),
                data: [<{$memUsed}>],
                yAxis: 1,
                tooltip: {
                    valueSuffix: '%'
                }
            }]
        });
	/*$("#mainContent").css({"position": "relative"});
	$("#mainContent").css({"z-index": "8"});
	$(".footer").css({"position": "relative"});
	$(".footer").css({"z-index": "8"});*/
	//IE6下面滚动条优化
	/*if($.browser.msie&&($.browser.version == "6.0")&&!$.support.style){
        //设定z-index遮盖vml
        $("#mainContent").css({"position": "relative"});
        $("#mainContent").css({"z-index": "8"});
        $(".footer").css({"position": "relative"});
        $(".footer").css({"z-index": "8"});
	}*/
/******************************************************************************/
    setHighcharts();
    for (var i in chart.series) {
        if (i === '0') {
            chart.series[i].show();
        } else {
            chart.series[i].hide();
		}
	}
	
});
</script>
