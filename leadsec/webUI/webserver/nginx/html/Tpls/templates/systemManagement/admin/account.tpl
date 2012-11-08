<form action="Function/systemManagement/admin/account.php" method="POST" id="expTimeForm"
onSubmit="return false;">
<table class="column_95">
    <caption>
    管理员帐号
    </caption>
    <tbody>
        <tr>
            <td class="tdheader">管理员登录超时时间:</td>
            <td class="tdbody">
                <input type="text" name="expTime" value="<{$smarty.const.EXPIRED_TIME}>"
                id="expTimeText"/>秒
		<div style="width: 200px">
	        <span class="formTip" id="expTimeTextTip"></span>
		</div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <input class="inputbtn" type="submit" value="确定" width="50" id="setExpTimeBtn"
                onClick="setExpiredTime()"/>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<label>
    <input type="checkbox" onClick="multiAdm($(this))"/>
    允许多个管理员同时管理
</label>
<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>管理员帐号列表</caption>
    <thead>
        <tr>
            <th class="column_20">账号</th>
            <th class="column_60">账号类型</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <{foreach $accounts as $value }>
        <tr>
            <td><{$value['account']}></td>
	    <td>
	    <{if ($value.super == '1')}>
	        <span class="red">超级管理员</span>&nbsp;
	    <{/if}>
	    <{if ($value.manager == '1')}>
	        配置管理员&nbsp;
	    <{/if}>
	    <{if ($value.policyer == '1')}>
	        策略管理员&nbsp;
	    <{/if}>
	    <{if ($value.auditor == '1')}>
	        审计管理员
	    <{/if}>
	    </td>
        <td>
	        <a href="#" class="edit" onclick="openEditUserDialog('<{$value["account"]}>')">编辑</a>
		<{if ($value.super === '0')}>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelUserDialog('<{$value["account"]}>')">删除</a>
		<{/if}>
	    </td>
        </tr>
    <{foreachelse}>
        <p>No Accounts</p>
    <{/foreach}>
</table>
<button class="floatLeft button" type="submit" onClick="openNewAccountDialog()" id="add">添加</button>

<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
	$.formValidator.initConfig({
	    formID:"expTimeForm",
	    theme:"Default"
	});
	$("#expTimeText").formValidator({onShow:"不能小于60秒或超过86400秒（24小时）",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});

});
</script>
<script type="text/javascript" src="Public/js/systemManagement/admin/account.js"></script>
