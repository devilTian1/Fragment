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
		<{if ($value.super == '0')}>
	            <a href="#" class="edit" onclick="openEditUserDialog('<{$value["account"]}>')">编辑</a>
		    &nbsp;&nbsp;&nbsp;
		<{/if}>
		    <a href="#" class="delete" onclick="openDelUserDialog('<{$value["account"]}>')">删除</a>
	    </td>
        </tr>
    <{foreachelse}>
        <p>No Accounts</p>
    <{/foreach}>
</table>
<button class="floatLeft button" type="submit" onClick="showNewAccountDialog()" id="add">添加</button>

<div class="hide" id="dialogForm">
    <fieldset>
        <legend>客户端普通访问添加</legend>
        <div>
            <label for="mid">任务号:<em class="required">*</em></label>
            <input type="text" name="mid" id="mid"/>
            <span>(同一端的任务号必须唯一)</span>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="saddr">源地址:</label>
            <select name="saddr" id="saddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="daddr">目的地址:</label>
            <select name="daddr" id="daddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="dport">目的端口:<em class="required">*</em></label>
            <input type="text" name="dport" id="dport" maxlength="5"/>
            <span>(1 - 65535)</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="virusScan">流病毒扫描:</label>
            <span><input class="radio" type="radio" name="virusScan"/>开</span>
            <span><input class="radio" type="radio" name="virusScan"/>关</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="auGroup">认证用户组:</label>
            <select name="auGroup" id="auGroup">
                <option value="1">admin</option>
                <option value="2">wangqi</option>
                <option value="3">RenWinFLy</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="effectivePeriod">生效时段:</label>
            <select name="effectivePeriod" id="effectivePeriod">
                <option value="1">right now</option>
                <option value="2">1 month ago</option>
                <option value="3">1 year ago</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="isStart">是否启动:<em class="required">*</em></label>
            <span><input class="radio" type="radio" name="isStart"/>启动</span>
            <span><input class="radio" type="radio" name="isStart"/>停止</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="remark">备注:</label>
            <input class="remark" type="text" name="remark" id="remark"/>
            <br class="clearFloat"/>
        </div>
    </fieldset>
</div>
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
