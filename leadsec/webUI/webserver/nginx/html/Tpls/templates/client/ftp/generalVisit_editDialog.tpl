<form action="Function/client/ftp/generalVisit.php" method="POST"
    id="editFtpCommClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <legend>FTP客户端普通访问</legend>
        <div class="row">
            <label for="ftpGeneralId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="ftpGeneralId"
                id="ftpGeneralId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="ftpGeneralId" value="<{$data.id}>"/>
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
            <{html_options class="select lip" name="ftpGeneralLip"
                id="ftpGeneralLip" options=$ifList
                selected=$data.lip|default:current($ifList)}>
        </div>

        <div class="row">
            <label for="lport">本机端口:<em class="required">*</em></label>
            <input class="port" type="text" id="ftpGeneralLport"
                name="ftpGeneralLport" value="<{$data.lport}>" size="5"
                maxlength="5"/>
        </div>
        
        <div class="row">
            <label for="filter">过滤选项:</label>
            <{html_options class="select filter" name="filter" id="filter"
                options=$filterOptions selected=$data.filter|default: '无'}>&nbsp;&nbsp;
            <button style="position: static"
                onclick="openNewFtpFilterOptionsDialog('plug')">添加
            </button>&nbsp;&nbsp;
            <{if $type === 'edit'}>
            	<button style="position: static"
                	onclick="editFtpFilterOptionsDialog($('#filter').val(),'plug')">修改
            	</button>
            <{/if}>
        </div>

        <div class="row">
            <label for="usergrp">认证用户组:</label>
            <{html_options class="select usergrp" name="usergrp"
                options=$roleList selected=$data.usergrp|default: 'empty'}>
        </div>
        
        <div class="row">
            <label for="destip">生效时段:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: 'empty'}>
            </select>
        </div>
        
        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$data.active|default: 'Y'}>
        </div>
        
		<div <{if $killVirusIsUsed eq 'off'}> class="hide"<{/if}>>
			<div class="row">
				<label>文件病毒扫描:</label>
				<{html_radios class="radio" name=killVirus label_ids=true
				output=array('开', '关') values=array('Y', 'N')
				selected=$data.virus|default: 'N'}>
			</div> 
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
        validateForm($("#editFtpCommClientAclForm"));
        $('label[for^="ipType_"], label[for^="active_"], label[for^="killVirus_"]').addClass('radioLabel');
    });
</script>
