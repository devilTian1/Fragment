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
                    正在加载中, 请稍后... ...
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
        <th>设备名称</th>
        <td><{$devinfo.hostname}></td>
    </tr>
</table>
<table class="floatLeft column_45">
    <caption>
        资源利用率
        <a href='#' onClick="openAllCpuDialog()">详细信息</a>
    </caption>
    <tr>
        <th id="useRatio">正在加载中, 请稍后。</th>
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
		<th>服务状态</th>
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
        <th>定制访问(tcp)</th>
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
        <th>定制访问(udp)</th>
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
        <th>邮件访问(SMTP)</th>
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
        <th>邮件访问(pop3)</th>
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
	<{if $count is div by 2}>
		<tr>
	<{/if}>
		<th><{$val.ch_name}></th>
		<td><{$val.status}></td>
	<{if ($count+1) is div by 2}>
		</tr>
	<{/if}>
    <{/foreach}>
</table>
<br class="clearFloat"/>
<script type="text/javascript" src="Public/js/systemManagement/overview/overview.js"></script>
<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts.js"></script>
<script type="text/javascript" src="Public/js/jquery/Highcharts/highcharts-more.js"></script>
<p id="script"></p>
<script type="text/javascript">
$(document).ready(function () {
    //动态改变宽度
	$(window).resize(function(){
		var widbox = $(".dev_info_table").width();
		 	$("#zoompic div").width(widbox*2-40);
			$("#useRatio div").width(widbox-40);
	})
	$.post('Function/systemManagement/overview/overview.php', {action: 'viewProcMonitor'}, function(result) {$('#script').html(result);});
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
});
</script>
