<form action="Function/networkManagement/interface/redundance.php" method="POST" id="editWorkModeForm" onSubmit="return false;">
    <input type="hidden" name="setWorkMode" value='1'/>
    <fieldset>
        <legend>修改冗余设备高级设置</legend>
		<div class="row">
            <label>冗余设备工作方式</label>
            <{html_options output=array('轮循方式', '热备方式', '802.3ad')
                values=array('balance-rr', 'backup', '802.3ad')
                selected=$workMode|default: 'balance-rr'
                name="workMode"}>
        </div>
		<div class="row">
            <label class="simpleLabel">修改后, 先保存配置然后重启设备后才能正式生效.</label>
        </div>
    </fieldset>
</form>
