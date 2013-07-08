<form action="Function/systemManagement/admin/account.php" method="POST" id="expTimeForm" onSubmit="return false">
<table class="column_95">
    <caption>
    管理员帐号
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">管理员登录超时时间(单位: 秒):</td>
            <td class="tdbody">
                <input type="text" class="width149" name="expTime" value="<{$smarty.const.EXPIRED_TIME}>"
                id="expTimeText"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"
                    id="setExpTimeBtn" onClick="setExpiredTime()">
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
                <input type="text" class="width149" name="limitErrNum" value="<{$smarty.const.LIMITERR_NUM}>"
                id="limitErrNum"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">自动解锁时间(单位:秒):</td>
            <td class="tdbody">
                <input type="text" class="width149" name="limitErrTime" value="<{$smarty.const.LIMITERR_TIME}>"
                id="limitErrTime"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"
                    id="setLimitErrTimeBtn" onClick="setLimitErrTime()">
                确定
                </button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<label>
    <label for="isMultiAdm">
    <input type="checkbox" onClick="multiAdm($(this))" id="isMultiAdm"
        <{$isMultiAdm}>/>
    允许多个管理员同时管理
    </label>
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
    <tbody>
        <tr><td colspan='4'>Loading ...</td></tr>
    </tbody>
</table>
<button class="floatLeft standard" type="button"
    onClick="openNewAccountDialog()" id="add">
添加</button>

<script type="text/javascript" src="Public/js/systemManagement/admin/account.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    freshAccountList();
    renderStandardUi();
    validateForm($("#expTimeForm"));
    validateForm($("#limitErrForm"));
    $('#expTimeText').bind('keyup', function(event){
        if (event.keyCode == '13') {
            setExpiredTime();
            return false;
        }
    });
    $('#limitErrTime, #limitErrNum').bind('keyup', function(event){
        if (event.keyCode == '13') {
            setLimitErrTime();
            return false;
        }
    });
});
</script>
