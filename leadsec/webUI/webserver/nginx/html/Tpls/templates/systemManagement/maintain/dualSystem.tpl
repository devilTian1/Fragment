<table class="column_95 textMid version" id="systemStatus">
    <caption>系统状态图</caption>
    <thead>
        <tr>
            <td class="column_30" > systemA</td>
            <td class="column_30">systemB</td>
            <td class="column_30">备份系统</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td <{if $curOs === 'systemA'}>class="select"<{/if}>><{$versionA}></td>
            <td <{if $curOs === 'systemB'}>class="select"<{/if}>><{$versionB}></td>
            <td><{$backupOs}></td>
        </tr>           
    </tbody>
</table>
<br>

<form action="Function/systemManagement/maintain/dualSystem.php" method="POST" id="dualSystemForm" 
    onSubmit="return false">
    <table class="column_95 textMid">
        <caption>默认启动系统</caption>
        <tbody>
            <tr>
                <td><input type="radio" name="defaultStart" value="systemA"/>systemA</td>
                <td><input type="radio" name="defaultStart" value="systemB"/>systemB</td>
            </tr>
            <tr>
                <td colspan="2">
                    <button class="inputbtn standard" type="button" onclick="setDefaultSystem()">
                        确定</button>	
                </td>
	    </tr>
        </tbody>
    </table>
</form>
<br>

<form action="Function/systemManagement/maintain/dualSystem.php?b=1" method="POST" id="backupForm">
    <table class="column_95 textMid">
        <caption>备份系统</caption>
	<tbody>
            <tr>
                <td class="tdbody">备份当前系统(<{$curOs}>[<{$curVersion}>])至备份系统</td>                
            </tr>
            <tr>
                <td class="tdbody">
                    <button class="inputbtn standard" type="button" onClick="submitBackupForm($('#backupForm'))">
                        备份</button>	
                </td>
	    </tr>
	</tbody>
    </table>
</form>
<br>

<form action="Function/systemManagement/maintain/dualSystem.php" method="POST" id="recoverForm">
    <table class="column_95 textMid">
        <caption>提示</caption>
	<tbody>
            <tr>
                <td class="tdbody column_40">将备份系统(<{$backupOs}>)恢复至</td>
                <td>
                    <div class="column column_80">
                        <div class="column column_50"><input type="radio" name="recoverSystem" value="systemA" checked="checked"/>systemA</div>
                        <input type="radio" name="recoverSystem" value="systemB"/>systemB
                    </div>
                </td>
            </tr>            
	    <tr>
                <td colspan="2">
                    <button class="inputbtn standard" type="button" onClick="submitRecoverForm($('#recoverForm'))">恢复</button>
                </td>
	    </tr>
	</tbody>
    </table>
</form>

<script type="text/javascript" src="Public/js/systemManagement/maintain/dualSystem.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        init();
    });
    
    function init() {
        var systemaObj = $("input:radio[name='defaultStart']:eq(0)");
        var systembObj = $("input:radio[name='defaultStart']:eq(1)");
        if(systemaObj.val() == '<{$default_os}>') {
            systemaObj.attr("checked",'checked');
        } else {
            systembObj.attr("checked",'checked');
        }
    }
</script>
