<table class='column_95'>
    <tbody>
        <tr>
            <td class='tdheader column_40'>结果:</td>
            <td class='tdbody'><{$msg}></td>
        </tr>
        <tr>
            <td class='tdheader column_40'>生产结果报告</td>
            <td class='tdbody'>
                <form action='Function/systemManagement/maintain/manufacture.php?action=export'
                    method='GET' id='uploadManuFileForm' onSubmit='return false'>
                        <button class='standard' type='submit'
                            id='manuBtn'>
                            导出</button>
                </form>
            </td>
        </tr>
    </tbody>
</table>
<script type='text/javascript' src='Public/js/systemManagement/maintain/manufacture.js'></script>
<script type='text/javascript'>
    $(document).ready(function() {
        renderStandardUi();
    });
</script>
