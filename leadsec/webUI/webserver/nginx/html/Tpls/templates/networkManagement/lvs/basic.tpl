<form action="Function/networkManagement/lvs/basic.php?r=1" method="POST" id="roleForm">
<table class="column_95">
    <caption>
    基本配置
    </caption>
    <tbody>
        <tr>
            <td class="tdheader column_40">负载均衡工作角色:</td>
            <td class="tdbody">
                <{html_radios class="radio" name=role label_ids=true values=array('D', 'N')
                    output=array('调度器', '节点')
                    selected=$role onClick="ajaxSubmitForm($('#roleForm'), '设置工作角色');"}>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/><br/>
<form action="Function/networkManagement/lvs/basic.php?s=1" method="POST" id="statusForm">
<table class="column_95">
    <input type="hidden" name="switch" id="switch" value='<{if $status eq 'on'}>off<{else}>on<{/if}>'/>
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
<script type="text/javascript" src="Public/js/networkManagement/lvs/basic.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>
