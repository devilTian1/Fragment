<div id="multiCoreUseRatio"></div>

<script type="text/javascript">
$(document).ready(function () {
    var dw=dh=cd=ch=0;
    <{if $count == 0}>
        dw = 400, dh = 300;
        cd = 350, ch = 190;
    <{elseif $count == 1}>
        dw = 400, dh = 300;
        cd = 350, ch = 190;
    <{elseif $count == 2}>
        dw = 500, dh = 300;
        cd = 450, ch = 190;
    <{elseif $count == 3}>
        dw = 650, dh = 300;
        cd = 600, ch = 190;
    <{elseif $count == 4}>
        dw = 850, dh = 300;
        cd = 800, ch = 190;
    <{elseif $count > 4}>
        dw = 850, dh = 560;
        cd = 800, ch = 450;
    <{/if}>
    parent.setConOption(dw, dh);
    var mulCoreUpIntval = 5000;
    var chartx = new Highcharts.Chart({
            chart: {
                renderTo: 'multiCoreUseRatio',
                type: 'gauge',
                plotBorderWidth: 0,
                plotBackgroundColor: null,
                plotBackgroundImage: null,
                plotShadow: false,
                height: ch,
                width: cd,
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
                <{if $i <= 4 and $count == 1}>
                    center: [<{($i-1)*200+165}>, 85],
                <{elseif $i <= 4 and $count == 2}>
                    center: [<{($i-1)*200+120}>, 85],
                <{elseif $i <= 4 and $count == 3}>
                    center: [<{($i-1)*200+95}>, 85],
                <{elseif $i <= 4 and $count == 4}>
                    center: [<{($i-1)*200+90}>, 85],
                <{elseif $i <= 4 and $count > 4}>
                    center: [<{($i-1)*200+90}>, 100],
                <{else}>
                    center: [<{($i-5)*200+90}>, 300],
                <{/if}>
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
