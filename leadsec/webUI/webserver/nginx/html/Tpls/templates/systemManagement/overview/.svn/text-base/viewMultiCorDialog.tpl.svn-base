<div id="multiCoreUseRatio"></div>

<script type="text/javascript">
$(document).ready(function () {
    var mulCoreUpIntval = 5000;
    var chartx = new Highcharts.Chart({
            chart: {
                renderTo: 'multiCoreUseRatio',
                type: 'gauge',
                plotBorderWidth: 0,
                plotBackgroundColor: null,
                plotBackgroundImage: null,
                plotShadow: false,
                height: 300,
                width: 650,
                events: {
                    load: function() {
                        // set up the updating of the chart each second
                        mulCoreFlag = setInterval(function() {
							$.post("Function/systemManagement/overview/overview.php", {type:'getMulCoreData'}, function(result) {
                                var data = result.msg;
                                if($('#multiCoreUseRatio').length === 0){
								    clearInterval(mulCoreFlag);
                                    return true;
								}
                                for(var i in data) {
                                    var p = chartx.series[i].points[0];
                                    p.update(data[i], false);
                                }
                                chartx.redraw();
                            }, 'json');
                        }, mulCoreUpIntval);
                    }
                }
            },
            title: {
                text: null 
            },
			credits:{
				enabled:false
			},
            pane: [
            <{for $i=1 to $count}>
                {
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
                center: ['<{($i)*30}>%', '55%'],
                size: 170
                }
                <{if $i != $count}>
                ,
                <{/if}>
            <{/for}>
            ],   
            yAxis: [
            <{for $j=1 to $count }>
                {
                    pane: <{$j-1}>,
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
                        text: 'CPU<{$j}>',
                        y: 15
                    }
                }
                <{if $j != $count}>
                ,
                <{/if}>
            <{/for}>
            ],
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
            series: [
            <{foreach $result as $v}>
                {
                    name: 'CPU<{$v@iteration}>',
                    data: [<{$v}>],
                    yAxis: <{$v@index}>,
                    tooltip: {
                        valueSuffix: '%'
                    }
                }
                <{if !$v@last}>
                ,
                <{/if}>
            <{/foreach}>
            ]
        });
});
</script>
