<form action="Function/systemManagement/conf/params.php" method="POST" id="setParamsForm"
onSubmit="return false;">
<table class="column_95">
    <caption>
    <{$smarty.const.PRODUCT_NAME}>
    </caption>
    <tbody>
    <tr>
        <td width="250" class="tdheader"><{$smarty.const.PRODUCT_NAME}>:</td>
        <td class="tdbody">
            <input class="floatLeft width150" type="text" name="netname"
                value="<{$netname}>" id="netname"/>
        </td>
    </tr>
    <tr>
        <td></td>
        <td class="tdbody">
            <button class="inputbtn standard" type="button"
                id="setParams" onClick="setSysParams()">
            确定
            </button>
        </td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/systemManagement/conf/params.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#setParamsForm"));
    $('#netname').bind('keypress', function(event){
        if (event.keyCode == '13') {
            setSysParams();
            return false;
        }
    });
});
</script>
