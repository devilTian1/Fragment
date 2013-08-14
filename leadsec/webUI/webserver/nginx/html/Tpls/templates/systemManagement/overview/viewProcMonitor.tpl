<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts.js"></script>
<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts-more.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    //动态改变宽度
    var widbox = $("#zoomboxtd").width();
    $(".zoombox").width(widbox);
    $("#zoompoc").width(widbox);

		var setTimeIntval   = 3000;//多少时间更新一次
	    Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });
        var chart, chart1;
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
                                    updateUsedStatus(result.msg.cpuUsed, result.msg.memUsed, chart1);
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
                    text: '流量(Mbps)'
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
                        '<br/>数值：'+Highcharts.numberFormat(this.y, 2) + 'Mb';
                }
            },
            exporting: {
                enabled: false
            },
            series: [
                <{foreach $ifsName as $ifName}>
                    {
                        name: '<{$ifName}>|in',
                        data: getInitData(setTimeIntval, <{$curStampTime}>)
                    },
                    {
                        name: '<{$ifName}>|out',
                        data: getInitData(setTimeIntval, <{$curStampTime}>)
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

    /*******************************利用率*********************************/
    chart1 = new Highcharts.Chart({
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
