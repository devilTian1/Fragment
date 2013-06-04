<form action="Function/client/customized/udpGeneralVisit.php" method="POST"
    id="editUdpCommClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加UDP普通访问</legend>
        <div class="row">
            <label for="customUdpGeneralId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="customUdpGeneralId" id="customUdpGeneralId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="customUdpGeneralId"" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="active">ip地址类型:</label>
            <{html_radios class="radio" name=ipType label_ids=true
                output=array('ipv4', 'ipv6')
                values=array('ipv4', 'ipv6')
                selected=$data.ip_ver|default: 'ipv4'
                onClick="filterRes()"}>
        </div>
        
        <div class="row">
            <label for="sa">源地址:</label>
            <{html_options class="select sa" name="sa"
                options=$addrOptions selected=$data.sa|default: 'any'}>
        </div>
        
         <div class="row">
            <label for="lip">本机地址:</label>
            <{html_options class="select lip" name="udpGeneralLip" id="udpGeneralLip"
                options=$ifList selected=$data.lip|default: '无'}>
        </div>
        
        <div class="row">
            <label for="udplportReq">本机端口:<em class="required">*</em></label>
            <input class="port" type="text" name="udpGeneralLport" id="udpGeneralLport" value="<{$data.lport}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label>流病毒扫描:</label>
            <{html_radios class="radio" name=killVirus label_ids=true
                values=array('Y', 'N') output=array('开', '关')
                selected=$data.killvirus|default: 'N'
            }>
        </div>

        <div class="row mul">
            <label for="mulMode">通讯模式:</label>
            <{html_radios class="radio" name=mulMode label_ids=true
                values=array('unicast', 'multiv2', 'multicast')
                output=array('单播', '组播', '指定源组播')
                selected=$data.mul_mode|default: 'unicast'
                onClick="toggleMulMode()"}>
        </div>

        <div class="row mul" id="mulIp">
            <label for="mulIp">组播Ip地址:</label>
            <input type="text" name="mulIp" value="<{$data.mul_ip}>"/>
        </div>

        <div class="row mul" id="mulSrc">
            <label for="mulIp">指定源地址:</label>
            <input type="text" name="mulSrc" value="<{$data.mul_src}>"/>
        </div>
        
        <div class="row">
            <label for="usergrp">认证用户组:</label>
            <{html_options class="select usergrp" name="usergrp"
                options=$roleList selected=$data.usergrp|default: '无'}>
        </div>
        
        <div class="row">
            <label for="destip">生效时段:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: '无'}>
            </select>
        </div>
        
        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true
                values=array('Y', 'N') output=array('开', '关')
                selected=$data.active|default: 'Y'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>            
            <input class="comment" name="comment" id="comment" value="<{$data.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        filterRes();
        validateForm($("#editUdpCommClientAclForm"));
        $('label[for^="mulMode_"], label[for^="ipType_"], label[for^="killVirus_"], label[for^="active_"]').addClass('radioLabel');
        toggleMulMode();
    });
</script>
