    <button class="floatLeft" type="submit" onClick="openImportCertDialog()" name="import">导入</button>
    <table class="column_95 textMid tablesorter" id="cert">
        <caption>
            管理员证书列表:
        </caption>
        <thead><tr>
            <th class="column_15">文件名</th>
            <th class="column_15">颁发者</th>
            <th class="column_15">颁发给</th>
            <th class="column_45">有效期</th>
            <th class="column_10">操作</th>
        </tr></thead>
        <tr>

            <td>admin.pem</td>
            <td>tpyzqCA</td>
            <td>admin</td>
            <td>GMT 2005/04/20 03:34:29 - GMT 2015/04/19 03:34:28</td>
            <td>生效 删除</td>
        </tr>
        <tr>
            <td>admin.pem</td>
            <td>tpyzqCA</td>
            <td>admin</td>
            <td>GMT 2005/04/20 03:34:29 - GMT 2015/04/19 03:34:28</td>
            <td>生效 删除</td>
        </tr>
    </table>
    <ol class="pagination floatRight">
        <li><a href="#?page=1" rel="prev">Prev</a></li>
        <li><a href="#?page=1" rel="prev">1</a></li>
        <li class="selected">2</li>
        <li><a href="#?page=3">3</a></li>
        <li><a href="#?page=4">4</a></li>
        <li><a href="#?page=5">5</a></li>
        <li><a href="#?page=3" rel="next">Next</a></li>
    </ol>
    <button class="floatLeft" type="submit" onClick="openImportCertDialog()" name="import">导入</button>

<script type="text/javascript"> 
$(document).ready(function() {
    $("[name='import']").button();
});
</script>
<script type="text/javascript" src="Public/js/systemManagement/conf/cert.js"></script>
