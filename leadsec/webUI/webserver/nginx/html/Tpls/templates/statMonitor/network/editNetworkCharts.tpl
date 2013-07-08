<form action="Function/statMonitor/network/network.php?chart=1" method="POST" id="networkChartForm" onSubmit="return false;">
<input type="hidden" name="externalName" value="<{$externalName}>"/>
<div class="floatRight">
        最近:<{html_options  class="select" name="timeList"
                 output=array('5分钟','30分钟','3小时','一天') values=array(5,30,180,1440) selected=5}>
           <button id="freshButton" class="standard" type="button">刷新</button>
    </div>
    <div class="clearFloat"></div>
    <div class="zoombox">
        <div class="zoompic" id="zoompic"></div>
    </div>
</form>
<script src="Public/js/jquery/Highcharts/highcharts.js"></script>
<script type="text/javascript">
function getInData() {
    // generate an array of random data
    var data = new Array();
    <{foreach $curve as $data}>
        data.push({
            x: <{$data.inline.x}>,
            y: <{$data.inline.y}>
        });
    <{/foreach}>
    return data;
}

function getOutData() {
    // generate an array of random data
    var data = new Array();
    <{foreach $curve as $data}>
        data.push({
            x: <{$data.outline.x}>,
            y: <{$data.outline.y}>
        });
    <{/foreach}>
    return data;
}

function initHighCharts() {
    Highcharts.setOptions({
            global: {
                useUTC: false
            },
            title: {
                text: '网口流量统计图'
            },
            credits:{
                enabled:false
            },
            xAxis: {
                type: 'datetime',
                maxZoom: 1*60*1000,
                tickPixelInterval: 150
            },
            yAxis: {
                min: 0,
                title: {
                    text: '流量'
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
            plotOptions:{
                spline:{
                        marker:{
                                enabled:false
                                }
                        }
            }
        });
}

$(document).ready(function (){
    initHighCharts();
     var chart;
    function setHighcharts(eth){
        	chart = new Highcharts.Chart({
            chart: {
                renderTo: 'zoompic',
                type: 'spline',
                zoomType: 'x',
                marginRight: 10,
                width: 950
            },
            series: [
                    {
                        name: '<{$externalName}>|接收流量',
                        pointInterval: 10*1000,
                        data: getInData()
                    },
                    {
                        name: '<{$externalName}>|发送流量',
                        pointInterval: 10*1000,
                        data: getOutData()
                    }
            ]
        });
    }
    setHighcharts();
    
    function getOtherLinesHide(){
        for (var i in chart.series) {
            if (i === '0') {
                chart.series[i].show();
            } else {
                chart.series[i].hide();
            }
        }
    }
    getOtherLinesHide();
    
    $("#freshButton").bind("click",function() {
        var afterSuccessCallback = function(result, textStatus) {
            chart.destroy();
            var timeInterval = 10*1000;
            var datain=[];
             var dataout=[];
            if($("select[name='timeList'] option:selected").val() == 1440) {    
            // draw one day line            
                timeInterval = 40*10*1000; 
                 
                var sampleIn = new Array();
                var sampleOut = new Array();
                var j = 0;
                for (var i=0; i<result.inline.length ; i++) {
                    if (i%40 == 0) {
                        sampleIn[j] = result.inline[i];
                        sampleOut[j] = result.outline[i];
                        j++;
                    }
                } 
                 for (i=0 ; i<sampleIn.length ; i++) {
                    datain[i] = Number(sampleIn[i].y);
                }
                for (i=0 ; i<sampleOut.length ; i++) {
                    dataout[i] = Number(sampleOut[i].y);
                }
            } else if ($("select[name='timeList'] option:selected").val() == 180) {
            // draw 3 hours line
                timeInterval = 5*10*1000; 
                 
                var sampleIn = new Array();
                var sampleOut = new Array();
                var j = 0;
                for (var i=0; i<result.inline.length ; i++) {
                    if (i%5 == 0) {
                        sampleIn[j] = result.inline[i];
                        sampleOut[j] = result.outline[i];
                        j++;
                    }
                } 
                 for (i=0 ; i<sampleIn.length ; i++) {
                    datain[i] = Number(sampleIn[i].y);
                }
                for (i=0 ; i<sampleOut.length ; i++) {
                    dataout[i] = Number(sampleOut[i].y);
                }
            }  else {
               for (var i=0 ; i<result.inline.length ; i++) {
                    datain[i] = Number(result.inline[i].y);
                }            

                for (i=0 ; i<result.outline.length ; i++) {
                    dataout[i] = Number(result.outline[i].y);
                }
            }
            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'zoompic',
                    type: 'spline',
                    zoomType: 'x',
                    marginRight: 10,
                    width: 950
                },
                series: [
                        { 
                            name: result.name+'|接收流量',
                            pointInterval: timeInterval,
                            pointStart: Number(result.inline[0].x),
                            data:  datain
                        },
                        {
                           name: result.name+'|............',
                           pointInterval: timeInterval,
                            pointStart: Number(result.inline[0].x),
                            data: dataout
                        }
                ]
            }); 
            getOtherLinesHide();
        };
        ajaxSubmitForm($('#networkChartForm'), '结果', undefined, undefined , afterSuccessCallback);
    });   
});   
</script>