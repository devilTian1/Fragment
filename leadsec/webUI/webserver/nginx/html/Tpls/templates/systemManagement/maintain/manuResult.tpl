&lt;table class='column_95'>
    &lt;tbody>
        &lt;tr>
            &lt;td class='tdheader column_40'>结果:&lt;/td>
            &lt;td class='tdbody'><{$msg}>&lt;/td>
        &lt;/tr>
        &lt;tr>
            &lt;td class='tdheader column_40'>生产结果报告&lt;/td>
            &lt;td class='tdbody'>
                &lt;form action='Function/systemManagement/maintain/manufacture.php'
                    method='POST' id='uploadManuFileForm'>
                        &lt;input type="hidden" name="download" value="1"/>
                        &lt;button class='standard' type='submit'
                            id='manuBtn'>
                            导出&lt;/button>
                &lt;/form>
            &lt;/td>
        &lt;/tr>
    &lt;/tbody>
&lt;/table>
&lt;script type='text/javascript'>
    $(document).ready(function() {
        renderStandardUi();
    });
&lt;/script>
