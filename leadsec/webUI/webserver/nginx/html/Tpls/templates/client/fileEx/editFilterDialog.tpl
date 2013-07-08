<form action="Function/client/fileEx/filter.php" method="POST"
    id="editFilterForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <{if $type === 'edit'}>
        <input type="hidden" name="id" value="<{$data.id}>"/>
        <input type="hidden" name="ename" value="<{$data.name}>"/>
    <{/if}>
    <fieldset>
        <legend>文件属性控制</legend>
        <div class="row">
            <label for="FEfilterName">名称:<em class="required">*</em></label>
            <input class="width10em" type="text" name="FEfilterName" value="<{$data.name}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="FEfilterName"    
                    value="<{$data.name}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="allowedFile">允许文件名组:</label>
            <{html_options class='contentCtlSelect' name="allowedFile"
                id="allowedFile" options=$allowedFile selected=$data.filename}>
        </div>

        <div class="row">
            <label for="blacklist">内容黑名单组:</label>
            <{html_options class='contentCtlSelect' name="blacklist"
                id="blacklist" options=$blacklist selected=$data.blacklist}>
        </div>

        <div class="row">
            <label for="whitelist">内容白名单组:</label>
            <{html_options class='contentCtlSelect' name="whitelist"
                id="whitelist" options=$whitelist selected=$data.whitelist}>
        </div>

        <div class="row">
            <label for="fileType">文件类型:</label>
            <div class="column column_70">
                <{html_checkboxes class="radio" name=fileType label_ids=true
                    output=array('EXE', 'PDF', 'RAR', 'ZIP', 'MSO', 'ELF', 'JPG', 'TGZ')
                    values=array('EXE', 'PDF', 'RAR', 'ZIP', 'MSO', 'ELF', 'JPG', 'TGZ')
                    checked=$data.fileType}>
                <br class="clearFloat"/>所有微软office文件均属于MSO类
            </div>
        </div>

        <div class="row">
            <label for="action">类型过滤动作:</label>
            <{html_radios class="radio" name=action label_ids=true
                output=array('允许', '禁止') values=array('A', 'F')
                selected=$data.action|default: 'F'}>
        </div>

        <div class="row">
            <label for="sizemin">文件大小:</label>
            <label class="simpleLabel" for="sizemin">下限:</label>
            <input class="filesize" type="text" name="sizemin" id="sizemin" size="6"
                maxlength="6" value="<{$data.sizemin}>" onkeyup="$('#editFilterForm').validate().element($('#sizemax'));"/>
            <label class="simpleLabel">K</label>
        </div>
        <div class="row">
            <label for="sizemax">&nbsp;</label>
            <label class="simpleLabel" for="sizemax">上限:</label>
            <input class="filesize" type="text" name="sizemax" id="sizemax" size="6" 
                maxlength="6" value="<{$data.sizemax}>" onkeyup="$('#editFilterForm').validate().element($('#sizemin'));"/>
            <label class="simpleLabel">K</label>
        </div>

        <div class="row">
            <label for="timemin">文件修改时间:</label>
            <label class="simpleLabel" for="timemin">下限:</label>
            <input class="width12em" type="text" name="timemin" id="timemin"
                value="<{$data.timemin}>" onkeyup="$('#editFilterForm').validate().element($('#timemax'));"/>
        </div>
        <div class="row">
            <label for="timemax">&nbsp;</label>
            <label class="simpleLabel" for="timemax">上限:</label>
            <input class="width12em" type="text" name="timemax" id="timemax"
                value="<{$data.timemax}>" onkeyup="$('#editFilterForm').validate().element($('#timemin'));"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editFilterForm"));
        $('label[for^="action_"]').addClass('radioLabel');
    });
</script>
