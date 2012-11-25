<table class="column_95">
    <tbody>
        <tr>
            <td class="tdheader column_40">软件版本号 :</td>
            <td class="tdbody"><{$lastestVersion|default: '没有任何升级记录'}></td>
        </tr>
        <tr>
            <td class="tdheader column_40">
                <span class="red">*</span>配置文件:
            </td>
            <td class="tdbody">
                <form action="Function/systemManagement/maintain/manufacture.php"
                    method="POST" id="uploadManuFileForm" onSubmit='return false'>
                    <input type="file" name="manuFile"/>
                </form>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40"></td>
            <td class="tdbody">
                <button class="standard" type="button"
                    onClick="openManuDialog()" id="manuBtn">
                开始生产</button>
            </td>
        </tr>
    </tbody>
</table>
<script type="text/javascript" src="Public/js/systemManagement/maintain/manufacture.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#uploadManuFileForm"));
    });
</script>
