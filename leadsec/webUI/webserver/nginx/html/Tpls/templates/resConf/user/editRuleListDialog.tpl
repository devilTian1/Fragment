<form action="Function/resConf/user/accessControl.php" method="POST" id="editRuleListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>接入控制列表维护</legend>
        <div class="row">
            <label for="ruleName">接入控制规则名称:<em class="required">*</em></label>
            <input type="text" class="width150" name="ruleName" id="ruleName" value="<{$ruleData.rule_name}>" 
			<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
			 <{if $type ==='edit'}>
                <input type="hidden" name="ruleName" value="<{$ruleData.rule_name}>"/>
            <{/if}>
        </div>
        <br class="clearFloat"/>
		<div class="row">
            <label>版本检查:</label>
            <{html_radios class="radio" name=checkVer label_ids=true
                values=array('1','0') onClick="toggleCNameDiv()"
                output=array('是', '否') selected=$ruleData.type|default: '0'
            }>
        </div>
        <br class="clearFloat"/>
		<div class="row cNameDiv">
            <label for="addver">添加版本:<em class="required">*</em></label>
			<input class="width10em" type="text"  name="txt_gapver" 
				id="txt_gapver" size="15"/>
			<button type="button" class="standard floatLeft addBtn" onClick="addver()">
				添加</button>
        </div>
        <br class="clearFloat"/>
        <div class="row">
			<label for="verList">版本列表:</label>
            <div class="column column_35">
                <{html_options class='multiSelect' size="5" name="verList[]" multiple="multiple" 
					id="verList" output=$ruleData.names values=$ruleData.names}>
            </div>
			<div class="column column_15">
                <button type="button" class="standard floatLeft" onClick="deleteVer()">删除
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft" onClick="cleanAllVer()">清空
                </button>
            </div>
        </div>
		<br class="clearFloat"/>
		<div class="row">
            <label>进程检查:</label>
            <{html_radios class="radio" name=checkProc label_ids=true
                values=array('1','0') onClick="togglePNameDiv()"
                output=array('是', '否') selected=$checkProc|default: '0'
            }>
        </div>
        <br class="clearFloat"/>
		<div class="row" id="procDiv">
            <label for="addProc">添加进程:<em class="required">*</em></label>
				<input class="width10em" type="text"  name="txt_gapProc" 
					id="txt_gapProc" size="15"/>
				<button type="button" class="standard floatLeft addBtn" onClick="addProc()">
			添加</button>
        </div>
        <br class="clearFloat"/>
        <div class="row">
			<label for="procList">进程列表:</label>
            <div class="column column_35">
                <{html_options class='multiSelect' size="5" name="procList[]"
                    multiple="multiple" id="procList"
					output=$ruleData.procs values=$ruleData.procs}>
            </div>
            <div class="column column_15">
                <button type="button" class="standard floatLeft" onClick="deleteProc()">删除</button>
                <br/><br/>
                <button type="button" class="standard floatLeft" onClick="cleanAllProc()">清空</button>
            </div>
        </div>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/resConf/user/accessControl.js"></script>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
	toggleCNameDiv();
	togglePNameDiv();
    validateForm($("#editRuleListForm"));
	$("select[id=verList] option").each(function(){
        	$(this).attr("title",$(this).val());
    })
	$("select[id=procList] option").each(function(){
        	$(this).attr("title",$(this).val());
    })
});
</script>
