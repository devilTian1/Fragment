<form action="Function/systemManagement/maintain/upgrade.php" method="POST" id="upgradeForm" 
    onSubmit="return false">
    <table class="column_95">
        <tbody>
            <tr>
                <td class="tdheader column_40">系统当前软件版本 :</td>
                <td class="tdbody"><{$lastestVersion|default:'没有任何版本信息'}></td>
            </tr>
            <tr>
                <td class="tdheader">
					<span class="red">*</span> 升级文件:
				</td>
				<td>
					<{include file='layout/upload.tpl' name='file' id='file'}>
				</td>
				<!--
                <td class="tdbody">
                    <input name="upgradeFile" type="file" id="file" />
                </td>
				-->
            </tr>
            <tr>
                <td></td>
                <td>
                    <button class="inputbtn standard" type="button" onClick="upgradeSystem()">
                        升级</button>
                </td>
            </tr>
        </tbody>
    </table>
</form>

<table class="column_95 textMid tablesorter" id="upgradeListTable">
    <caption>版本日志信息</caption>
    <thead>
        <tr>
            <th class="column_10">生效</th>
            <th class="column_15">文件名</th>
            <th class="column_55">详细信息</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='4'>Loading ... ...</td>
        </tr>
    </tbody>
</table>

<form class="inline" action="Function/systemManagement/maintain/upgrade.php" method="POST">
	<input type="hidden" name="action" value="exportUpgradeHistory"/>
	<button class="inputbtn standard" type="submit">
		导出升级历史</button>
	<input type="hidden" name="downloadUpgradeHistory" value='1'/>
</form>
<button  type="button"  class="inputbtn standard" onclick="window.open('http://www.leadsec.com.cn')">
	检查最新升级包</button>
<form class="inline" action="Function/systemManagement/maintain/upgrade.php?reboot=22" method="GET"
	id="rebootForm" onSubmit="return false">
	<button type="button" class="inputbtn standard" onclick="openRebootDialog()">
		重启<{$smarty.const.PRODUCT_NAME}></button>
</form>
       


<script type="text/javascript" src="Public/js/systemManagement/maintain/upgrade.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#upgradeForm"));
		freshTable('Function/systemManagement/maintain/upgrade.php', $('#upgradeListTable'),'ORDER BY id DESC');
		var uploadWid =  $('#file').width();
		$('.uploadText').width(uploadWid - 75);
    });
</script>
