<form action="Function/systemManagement/admin/cert.php" method="POST" id="CACertForm"
        onSubmit="return false">
    <table class="column_95 tablesorter">
        <caption>
                                    证书管理
        </caption>
        <tbody>
        <tr>
            <td class="column_40">
                <label class="floatRight" for="CAcert">
                    CA中心证书<em class="required">*</em>
                </label>
            </td>
            <td>
                <{include file='layout/upload.tpl' name='CAcert' id='CAcert'}>
            </td>
        </tr>
        <tr>
            <td>
                <label class="floatRight" for="SIScert">
                    证书
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <{include file='layout/upload.tpl' name='SIScert' id='SIScert'}>
            </td>
        </tr>
        <tr>
            <td>
                <label class="floatRight" for="SISkey">
                    密钥
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <{include file='layout/upload.tpl' name='SISkey' id='SISkey'}>
            </td>
        </tr>
        <tr>
            <td class="textCenter" colspan="2">
                <input class="button" type="button" onClick="confirmImport()" value="导入"/>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    $(".button").button();
    validateForm($("#CACertForm"));

    var uploadWid =  $('#CAcert').width();
    $('.uploadText').width(uploadWid - 75);
});
</script>
<script type="text/javascript" src="Public/js/systemManagement/admin/cert.js"></script>
