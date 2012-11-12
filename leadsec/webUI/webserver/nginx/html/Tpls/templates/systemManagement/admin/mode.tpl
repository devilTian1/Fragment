<form action="Function/systemManagement/admin/mode.php" method="POST" id="modeForm"
    onSubmit="return false;">
    <input type="hidden" name="type" value="set"/>
    <table class="column_95">
      <caption>
      客户端TCP访问表
      </caption>
      <tbody>
        <tr>
            <td class="tdheader">
                <input name="web" type="checkbox" checked="checked" disabled="disabled"/>
            </td>
            <td class="tdbody">Web (https) 管理</td>
        </tr>
        <tr>
            <td class="tdheader">
                <input name="cmd" type="checkbox" checked="checked" disabled="disabled"/>
            </td>
            <td class="tdbody"> 串口命令行 </td>
        </tr>
        <tr>
            <td class="tdheader">
                <input type="checkbox" <{$isSSH}> name="ssh" id="ssh"/>
            </td>
            <td class="tdbody"> 启用远程 SSH </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="standard" type="submit" onClick="modifyMode()"
                    id="submitbtn">
                    确定
                </button>
            </td>
        </tr>
       </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/systemManagement/admin/mode.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
	})
</script>
