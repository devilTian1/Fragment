<form action="Function/statMonitor/res/res.php?cpu=1" method="POST" id="CPUChartForm" onSubmit="return false;">
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
    <{foreach $curve.inline as $data}>
        data.push(<{$data}>);
    <{/foreach}>
    return data;
}

function initHighCharts() {
    Highcharts.setOptions({
            global: {
                useUTC: false
            },
            title: {
                text: 'CPU利用率统计图'
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
                    text: 'CPU利用率'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }],
                labels: {
                        formatter: function() {
                            return this.value+'%'
                        }
                }
            },
            tooltip: {
                formatter: function() {
                        return '<b>选项：'+ this.series.name +'</b><br/>时间：'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>数值：'+
                        Highcharts.numberFormat(this.y, 2)+'%';
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
                        name: 'CPU利用率',
                        pointInterval: 10*1000,
                        pointStart: Number(<{$curve.starttime}>),
                        data: getInData()
                    }
            ]
        });
    }
    setHighcharts();
    
    $("#freshButton").bind("click",function() {
        var successCallback = function(result, textStatus) {
            chart.destroy();
            var timeInterval = 10*1000;
            var datain=[];             
            if($("select[name='timeList'] option:selected").val() == 1440) {    
            // draw one day line            
                timeInterval = 40*10*1000; 
                var sampleIn = new Array(); 
                var j = 0;
                for (var i=0; i<result.inline.length ; i++) {
                    if (i%40 == 0) {
                        sampleIn[j] = result.inline[i];
                        j++;
                    }
                } 
                for (i=0 ; i<sampleIn.length ; i++) {
                    datain[i] = Number(sampleIn[i]);
                }
            } else if ($("select[name='timeList'] option:selected").val() == 180) {
            // draw 3 hours line
                timeInterval = 5*10*1000; 
                var sampleIn = new Array(); 
                var j = 0;
                for (var i=0; i<result.inline.length ; i++) {
                    if (i%5 == 0) {
                        sampleIn[j] = result.inline[i];
                        j++;
                    }
                }
                for (i=0 ; i<sampleIn.length ; i++) {
                    datain[i] = Number(sampleIn[i]);
                }
            }  else {
               for (var i=0 ; i<result.inline.length ; i++) {
                    datain[i] = Number(result.inline[i]);
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
                            name: 'CPU利用率',
                            pointInterval: timeInterval,
                        pointStart: Number(result.starttime),
                            data:  datain
                        }
                ]
            }); 
        };
        ajaxSubmitForm($('#CPUChartForm'), '结果',undefined,undefined,
                successCallback);
    });   
});   
</script>
