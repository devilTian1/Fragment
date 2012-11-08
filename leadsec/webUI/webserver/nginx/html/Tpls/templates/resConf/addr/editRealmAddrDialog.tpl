<form action="Function/resConf/addr/realmAddr.php" method="POST" id="editRealmAddrForm"
    onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>域名地址维护</legend>
        <div class="row">
            <label for="addrName">名称:<em class="required">*</em></label>
            <input type="text" name="addrName" maxlength="15" value="<{$realmAddr.name}>"
            <{if $type === 'edit'}>readonly="readonly"<{/if}> id="addrName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="domainName">域名:<em class="required">*</em></label>
            <input type="text" name="domainName" value="<{$realmAddr.domainName}>"
            	id="domainName"/>
        </div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="addStaticAddr">添加静态IP:</label>
	    <div class="column column_30">
                <input type="text" id="addStaticAddr"/>
	    </div>
	    <div class="column column_25">
                <button class="standard floatLeft" onClick="addStaticAddr()">添加</button>
	    </div>
        </div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="staticAddrList">静态IP列表:<em class="required">*</em></label>
	    <div class="column column_30">
                <{html_options class='multiSelect' size="5" name="staticAddrList[]"
		    multiple="multiple" id="staticAddrList"
                    output=$staticAddrList values=$staticAddrList}>
	    </div>
	    <div class="column column_25">
                <button class="standard floatLeft" onClick="deleteStaticAddr()">删除</button>
                <br/><br/>
                <button class="standard floatLeft" onClick="cleanAllStaticAddr()">清空</button>
	    </div>
            <br class="clearFloat"/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="autoParse">自动解析:<em class="required">*</em></label>
            <input class="checkbox" type="checkbox" name="autoParse" id="autoParse"/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label>解析记录:<em class="required">*</em></label>
	    <div class="column column_30">
		<input class="checkbox" type="checkbox"/>
                <label class="checkboxLabel">A</label>
                <input class="checkbox" type="checkbox"/>
                <label class="checkboxLabel">MX</label>
	    </div>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="maxRecordNum">最大记录数:<em class="required">*</em></label>
            <input type="text" name="maxRecordNum" id="maxRecordNum" value="64"/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="autoParseInterval">自动解析间隔(单位:分钟):<em class="required">*</em></label>
	    <input type="text" name="autoParseInterval" id="autoParseInterval" value="30"/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="autoParseErrInterval">自动解析记录失效间隔:<em class="required">*</em></label>
	    <input type="text" name="autoParseErrInterval" id="autoParseErrInterval" value="2"/>
	    （是自动解析间隔的多少倍）
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="primaryDns">主DNS服务器:<em class="required">*</em></label>
	    <input type="text" name="primaryDns" id="primaryDns" value=""/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="secondaryDns">次DNS服务器:<em class="required">*</em></label>
	    <input type="text" name="secondaryDns" id="secondaryDns" value=""/>
	</div>
        <br class="clearFloat"/>
	<div class="row">
            <label for="DynamicAddrList">动态IP列表:<em class="required">*</em></label>
	    <{html_options class='multiSelect' size="5" name="DynamicAddrList[]"
	        multiple="multiple" id="DynamicAddrList"
    	        output=array() values=array()}>
	</div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$realmAddr.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        renderStandardUi();
        validateForm($("#editRealmAddrForm"));
    });
</script>
