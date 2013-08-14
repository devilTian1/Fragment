<form action="Function/appS/addrBind/addrBind.php?reconf=1" method="POST" id="ipmacServiceForm">
<table class="column_95">
    <input type="hidden" name="switch_serveice" id="switch_serveice" value='<{if $status eq 'on'}>off<{else}>on<{/if}>'/>
    <caption>服务管理</caption>
    <tbody>
    <tr>
        <td class="tdheader column_40">当前服务状态:</td>
        <td class="tdbody"><span id="status">
           <{if $status eq 'on'}>
                启动
           <{else}>
                停止
           <{/if}></span>
        </td>
    </tr>

    <tr>
        <td class="tdheader"></td>
        <td class="tdbody">
            <button type="button" name="buttonOn" class="inputbtn standard" onclick="setServiceForm('on')"
                <{if $status eq 'on'}> disabled="disabled"<{/if}>>启动服务</button>
            <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm('off')"
                <{if $status eq 'off'}> disabled="disabled"<{/if}>>停止服务</button>
        </td>
    </tr>
    </tbody>
</table>
</form>
<br/><br/>
<form action="Function/appS/addrBind/addrBind.php" method="POST" id="addrBindForm"
	onSubmit="return false;">
	<table class="column_95">
    <caption>
		主动探测IP/MAC对
    </caption>
    <tbody>
	<tr>
		<td width="200" class="tdheader">
		<label>
			<input type="radio" name="detect" id="detectbyfec" onclick="changetofec()"/>
				按网口探测:
		</label>
		</td>
		<td class="tdbody">
			<!--<input type="checkbox" name="fecchk" id="fecchk" value="fe2"/>-->
			<{foreach $ifnames as $key=>$value}>
				<input type="checkbox" name="ifname" id="fecchk_<{$value}>" value="<{$value}>"
				onclick="selectOne(this)"/>
				<{$value}>
			<{/foreach}>
			<input type="hidden" name="switch" id="switch" value=''/>
		</td>
      </tr>
	<tr>
		<td class="tdheader">
			<input type="radio" name="detect" id="detectbyip" onclick="changetoip()"; />
				按 IP 探测:
		</td>
		<td class="tdbody">
        	<input type="text" class="width149" name="ip" id="serverip" value=''/>
			<input type="hidden" name="switchbyip" id="switchbyip" value=''/>

		</td>
    </tr>
	<tr>
		<td class="tdheader">
		</td>
		<td>
			<button class="inputbtn standard" type="button" onclick="detectall()">
				探测
			</button>
			<button class="inputbtn standard" type="button" onclick="detectResultShow()">
				探测到的IP/MAC对
			</button>
		</td>
	</tr>
    </tbody>
	</table>
</form>

  
<br/>

<{include file='layout/search.tpl' tableId='accountTable'}>

<table class="column_95 textMid tablesorter" id="accountTable">
	<caption>
		已绑定IP/MAC对
	</caption>
	<thead>
		<tr>
			<th class="column_5"><input type="checkbox" onClick="checkAllIp()" title="全选" id="checkAllIp"/></th>
			<th class="column_20" name = "ip">IP地址</th>
			<th class="column_30" name = "mac">MAC地址</th>
			<th class="column_30">唯一性检查</th>
			<th class="column_20">操作</th>
		</tr>
	</thead>
	<tdbody>
        <tr>
            <td colspan='5'>Loading ... ...</td>
        </tr>
	</tdbody>
</table>

<button class="standard floatLeft" style="position: static" onClick="openNewAccountDialog()">
	添加
</button>

<button class="standard floatLeft" style="position: static" onClick="openDelAllIpDialog()">
	删除全部记录
</button>

<button class="standard floatLeft" style="position: static" onclick="openDelSpecIpListDialog()">
	删除已选记录
</button>

<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/appS/addrBind/addrBind.php'}>
</div>

<script type="text/javascript" src="Public/js/appS/addrBind/addrBind.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	init();
	renderStandardUi();
	validateForm($("#addrBindForm"));
	$("input:checkbox[id^='fecchk']").click(function(){
		if($(this).attr("checked")){
			$("#switch").val('on');
		}else{
			$("#switch").val('');
		}					   
		})	
	});
	
	freshTable('Function/appS/addrBind/addrBind.php?tpl=editaddrtpl', $('#accountTable'),'ORDER BY id ASC LIMIT 10');
</script>
