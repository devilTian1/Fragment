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
		<label>
			<input type="checkbox" name="fecchk" id="fecchk" value="fe2"/>
			<input type="hidden" name="switch" id="switch" value=''/>
				fe2
		</label>
		</td>
      </tr>
	<tr>
		<td class="tdheader">
			<input type="radio" name="detect" id="detectbyip" onclick="changetoip()"; />
				按 IP 探测:
		</td>
		<td class="tdbody">
        	<input type="text" name="ip" id="serverip" value=''/>
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
				探测到的IP与地此对
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
			<th class="column_20">IP地址</th>
			<th class="column_30">MAC地址</th>
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
	$("#fecchk").click(function(){
		if($(this).attr("checked")){
			$("#switch").val('on');
		}else{
			$("#switch").val('');
		}					   
		})	
	});
	freshTable('Function/appS/addrBind/addrBind.php?tpl=editaddrtpl', $('#accountTable'),'ORDER BY id ASC LIMIT 10');
</script>
