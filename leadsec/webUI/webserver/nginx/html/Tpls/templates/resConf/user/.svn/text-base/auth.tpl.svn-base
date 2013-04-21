<form action="Function/resConf/user/auth.php?serverConf=1" method="POST" id="serverConfForm">
<table class="column_95">
    <caption>
    认证服务器配置 - 本机认证
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">认证端口:<em class="required">*</em></td>
            <td class="tdbody">
                <input class="port" type="text" name="authPort"
                    value="<{$serverConf.localport|default: 9998}>" id="authPort"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">重定向URL:<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="redirectUrl" 
                    value="<{$serverConf.redirecturl}>" id="redirectUrl"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">记录用户认证连接日志:</td>
            <td class="tdbody">
                <{html_radios class="radio" name="log" label_ids=true
                    output=array('启用', '停止') values=array(1, 0)
                    selected=$serverConf.log|default: 0}>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"
                    id="setServerConfBtn" onClick="setServerConf()">
                确定
                </button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<form action="Function/resConf/user/auth.php?paramsConf=1" method="POST" id="paramsConfForm">
<table class="column_95">
    <caption>
    认证参数配置
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">首次登录强制修改密码:</td>
            <td class="tdbody">
                <input class='floatLeft' type="checkbox" name="forceModify" 
                    <{if $paramsConf.forcemodify eq '1'}>checked="checked"<{/if}> id="forceModify"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">口令复杂度要求:</td>
            <td class="tdbody">
                <{html_options class="select" name="pwdComplex"
                    output=array('无', '较弱', '一般', '较好', '很好', '极佳')
                    values=array(1, 2, 3, 4, 5, 6)
                    selected=$paramsConf.pwdcomplex|default: 3}>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">密码重复次数:<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="maxLoadTimes" 
                    value="<{$paramsConf.maxloadtimes|default: 5}>"
                    id="maxLoadTimes"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">超时解锁时间(单位:分钟):<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="unlockTime" 
                    value="<{$paramsConf.unlocktime|default: 10}>"
                    id="unlockTime"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">密码有效期(单位:天, 0表示永久):<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="pwdPeriod" 
                    value="<{$paramsConf.pwdperiod|default: 0}>"
                    id="pwdPeriod"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">密码到期提醒(单位:天):<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="pwdRemind" 
                    value="<{$paramsConf.pwdremind|default: 7}>"
                    id="pwdRemind"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40">用户IDLE时间(单位:分钟):<em class="required">*</em></td>
            <td class="tdbody">
                <input type="text" name="idleTime" 
                    value="<{$paramsConf.idletime|default: 0}>"
                    id="idleTime"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"
                    id="setParamsConfBtn" onClick="setParamsConf()">
                确定
                </button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<{include file='layout/search.tpl' tableId='authPolicyTable'}>
<table class="column_95 textMid tablesorter" id="authPolicyTable">
    <caption>认证策略</caption>
    <thead>
        <tr>
            <th class="column_10">
                <input type="checkbox" onClick="checkAll()" id="checkAllPolicy"/>全选
            </th>
            <th class="column_10">序号</th>
            <th class="column_20" name="auth_policy_name">策略名称</th>
            <th class="column_20" name="sa_type">源地址</th>
            <th class="column_10" name="ingress">入接口</th>
            <th class="column_10" name="port">目的端口</th>
            <th class="column_10" name="active">是否启用</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan='8'>Loading ...</td></tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAuthPolicyDialog()"
    id="addUserListBtn">新建
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelSpecAuthPolicyDialog()"
    id="DelAllUserListBtn">删除
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelAllAuthPolicyDialog()"
    id="DelSpecUserListBtn">清空
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/auth.php'}>
</div>


<script type="text/javascript" src="Public/js/resConf/user/auth.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/resConf/user/auth.php', $('#authPolicyTable'), 'ORDER BY auth_policy_name ASC LIMIT 10');
    sortTableInit($('#authPolicyTable'), {0: {sorter: false},1: {sorter: false},7: {sorter: false}}, [[1,0]]);
    validateForm($("#serverConfForm"));
    validateForm($("#paramsConfForm"));
});
</script>
