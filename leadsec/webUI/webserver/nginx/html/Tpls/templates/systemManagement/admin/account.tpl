<form action="Function/systemManagement/admin/account.php" method="POST" id="expTimeForm"
onSubmit="return false;">
<table class="column_95">
    <caption>
    管理员帐号
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">管理员登录超时时间(单位: 秒):</td>
            <td class="tdbody">
                <input type="text" name="expTime" value="<{$smarty.const.EXPIRED_TIME}>"
                id="expTimeText"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" id="setExpTimeBtn"
                    onClick="setExpiredTime()">
                确定
                </button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<form action="Function/systemManagement/admin/account.php" method="POST" id="limitErrForm"
onSubmit="return false;">
<table class="column_95">
    <caption>
    登录错误次数限制
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">限制次数:</td>
            <td class="tdbody">
                <input type="text" name="limitErrNum" value="<{$smarty.const.LIMITERR_NUM}>"
                id="limitErrNum"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">间隔时间(单位:秒):</td>
            <td class="tdbody">
                <input type="text" name="limitErrTime" value="<{$smarty.const.LIMITERR_TIME}>"
                id="limitErrTime"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard"
                    id="setLimitErrTimeBtn"
                    onClick="setLimitErrTime()">
                确定
                </button>
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
<table class="column_95 textMid tablesorter" id="accountTable">
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
        <tr><td colspan='3'>No Accounts</td></tr>
    <{/foreach}>
</table>
<button class="floatLeft standard"
    onClick="openNewAccountDialog()" id="add">
添加</button>

<script type="text/javascript" src="Public/js/systemManagement/admin/account.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#expTimeForm"))
    validateForm($("#limitErrForm"))
});
</script>
