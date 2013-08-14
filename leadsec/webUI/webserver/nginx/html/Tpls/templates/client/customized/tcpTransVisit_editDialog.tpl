<form action="Function/client/customized/tcpTransVisit.php" method="POST"
    id="editTcpTransClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加TCP透明访问</legend>
        <div class="row">
            <label for="customTcpTransId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="customTcpTransId" id="customTcpTransId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (定制访问TCP的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="customTcpTransId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="sa">源地址:</label>
            <{html_options class="select sa" name="sa"
                options=$saaddrOptions selected=$data.sa|default: 'any'}>
        </div>
        
         <div class="row">
            <label for="da">目的地址:</label>
            <{html_options class="select da" name="da"
                options=$daaddrOptions selected=$data.da|default: 'any'}>
        </div>
        
        <div class="row">
            <label for="dport">目的端口:<em class="required">*</em></label>
            <input class="port" type="text" name="customtcpTransLport" id="customtcpTransLport" value="<{$data.dport}>" size="5" maxlength="5"/>
        </div>
        
 		<div <{if $killVirusIsUsed eq 'off'}> class="hide"<{/if}>> 
	        <div class="row">
	            <label>流病毒扫描:</label>
	            <{html_radios class="radio" name=killVirus label_ids=true values=array('Y', 'N')
	              output=array('开', '关') selected=$data.killvirus|default: 'N'
	            }>
	        </div>
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
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$data.active|default: 'Y'}>
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
        validateForm($("#editTcpTransClientAclForm"));
        $('label[for^="ipType_"], label[for^="killVirus_"], label[for^="active_"]').addClass('radioLabel');
    });
</script>
