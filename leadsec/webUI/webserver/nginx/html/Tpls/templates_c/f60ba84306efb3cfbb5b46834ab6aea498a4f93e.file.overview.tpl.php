<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 10:57:57
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\systemManagement\overview\overview.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2913551da9b35ce8296-22355631%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f60ba84306efb3cfbb5b46834ab6aea498a4f93e' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\systemManagement\\overview\\overview.tpl',
      1 => 1373253614,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2913551da9b35ce8296-22355631',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'devinfo' => 0,
    'lvsinfo' => 0,
    'hainfo' => 0,
    'status' => 0,
    'liceinfo' => 0,
    'count' => 0,
    'val' => 0,
    'curStampTime' => 0,
    'ifsName' => 0,
    'ifName' => 0,
    'cpuUsed' => 0,
    'memUsed' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b35f3b613_40746541',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b35f3b613_40746541')) {function content_51da9b35f3b613_40746541($_smarty_tpl) {?><!-- mainContent -->
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
    <caption>设备[<?php echo @PRODUCT_NAME;?>
]信息</caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>序列号</th>
        <td><?php echo $_smarty_tpl->tpl_vars['devinfo']->value['serialnum'];?>
</td>
    </tr>
    <tr>
        <th>硬件版本号</th>
        <td><?php echo $_smarty_tpl->tpl_vars['devinfo']->value['devnum'];?>
</td>
    </tr>
    <tr>
        <th>软件版本号</th>
        <td><?php echo $_smarty_tpl->tpl_vars['devinfo']->value['softnum'];?>
</td>
    </tr>
    <tr>
        <th>名称</th>
        <td><?php echo $_smarty_tpl->tpl_vars['devinfo']->value['hostname'];?>
</td>
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
		<td><?php echo $_smarty_tpl->tpl_vars['lvsinfo']->value['role_name'];?>
</td>
	</tr>
	<tr>
		<th>工作状态</th>
		<td><?php echo $_smarty_tpl->tpl_vars['lvsinfo']->value['lvs_type'];?>
</td>
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
        <td><?php echo $_smarty_tpl->tpl_vars['hainfo']->value['role_name'];?>
</td>
    </tr>
    <tr>
        <th>服务状态</th>
        <td><?php echo $_smarty_tpl->tpl_vars['hainfo']->value['ha_type'];?>
</td>
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
           <?php if ($_smarty_tpl->tpl_vars['status']->value['tcp']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>安全浏览</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['http']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
    </tr>
    <tr>
        <th>定制服务(udp)</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['udp']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>消息传输</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['msg']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
    </tr>
    <tr>
        <th>数据库访问</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['db']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>邮件服务(SMTP)</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['smtp']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
    </tr>
    <tr>
        <th>数据库同步</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['dbswap']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>邮件服务(pop3)</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['pop3']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
    </tr>
    <tr>
        <th>文件同步</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['fswap']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>FTP访问</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['ftp']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
    </tr>
    <tr>
        <th>文件交换</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['sync']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
        </td>
        <th>安全通道</th>
        <td>
           <?php if ($_smarty_tpl->tpl_vars['status']->value['pass']==1){?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/select.png" width="16" height="16" />
           <?php }else{ ?>
             <img src="<?php echo @THEME_PATH;?>
/images/icon/stop.png" width="16" height="16" />
           <?php }?>
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
    <?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_smarty_tpl->tpl_vars['count'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['liceinfo']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['count']->value = $_smarty_tpl->tpl_vars['val']->key;
?>
	<?php if (!($_smarty_tpl->tpl_vars['count']->value % 2)){?><tr>
	<?php }?>
	<th><?php echo $_smarty_tpl->tpl_vars['val']->value['ch_name'];?>
</th>
    <td><?php echo $_smarty_tpl->tpl_vars['val']->value['status'];?>
</td>
	<?php if (!(($_smarty_tpl->tpl_vars['count']->value+1) % 2)){?></tr><?php }?>
	<?php if ($_smarty_tpl->tpl_vars['count']->value==11){?>
	<?php break 1?>
	<?php }?>
    <?php } ?>
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
            x: <?php echo $_smarty_tpl->tpl_vars['curStampTime']->value*1000;?>
 + i * 1000,
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
                <?php  $_smarty_tpl->tpl_vars['ifName'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['ifName']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['ifsName']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['ifName']->total= $_smarty_tpl->_count($_from);
 $_smarty_tpl->tpl_vars['ifName']->iteration=0;
foreach ($_from as $_smarty_tpl->tpl_vars['ifName']->key => $_smarty_tpl->tpl_vars['ifName']->value){
$_smarty_tpl->tpl_vars['ifName']->_loop = true;
 $_smarty_tpl->tpl_vars['ifName']->iteration++;
 $_smarty_tpl->tpl_vars['ifName']->last = $_smarty_tpl->tpl_vars['ifName']->iteration === $_smarty_tpl->tpl_vars['ifName']->total;
?>
                    {
                        name: '<?php echo $_smarty_tpl->tpl_vars['ifName']->value;?>
|in',
                        data: getInitData(setTimeIntval)
                    },
                    {
                        name: '<?php echo $_smarty_tpl->tpl_vars['ifName']->value;?>
|out',
                        data: getInitData(setTimeIntval)
                    }
                    <?php if (!$_smarty_tpl->tpl_vars['ifName']->last){?>
                    ,
                    <?php }?>
                <?php }
if (!$_smarty_tpl->tpl_vars['ifName']->_loop) {
?>
                    {}
                <?php } ?>
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
                data: [<?php echo $_smarty_tpl->tpl_vars['cpuUsed']->value;?>
],
                yAxis: 0,
                tooltip: {
                    valueSuffix: '%'
                }
            }, {
                name: getMessage('Mem Used'),
                data: [<?php echo $_smarty_tpl->tpl_vars['memUsed']->value;?>
],
                yAxis: 1,
                tooltip: {
                    valueSuffix: '%'
                }
            }]
        });
	//IE6下面滚动条优化
	if($.browser.msie&&($.browser.version == "6.0")&&!$.support.style){
        //设定z-index遮盖vml
        $("#mainContent").css({"position": "relative"});
        $("#mainContent").css({"z-index": "8"});
        $(".footer").css({"position": "relative"});
        $(".footer").css({"z-index": "8"});
	}
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
<?php }} ?>