    <form action="Function/systemManagement/admin/uploadCert.php" method="POST" id="CACertForm"
        onSubmit="return false">
    <table class="column_95 tablesorter">
        <tr>
            <td class="textCenter" colspan="2">
                <input class="button" type="button" value="CA中心"/>
            </td>
        </tr>
        <tr>
            <td class="column_25">
                <label class="floatRight" for="CAcert">
                    CA中心证书<em class="required">*</em>
                </label>
            </td>
            <td>
                <input class="floatLeft" type="file" name="CAcert" id="CAcert"/>
            </td>
        </tr>
        <tr>
            <td>
                <label class="floatRight" for="CAcert2">
                    二级CA证书
                </label>
            </td>
            <td>
                <input class="floatLeft" type="file" name="CAcert2" id="CAcert2"/>
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
                <input class="floatLeft" type="file" name="SIScert" id="SIScert"/>
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
                <input class="floatLeft" type="file" name="SISkey" id="SISkey"/>
            </td>
        </tr>
        <tr>
            <td class="textCenter" colspan="2">
                <input class="button" type="submit" onClick="importCACert()" value="导入"/>
            </td>
        </tr>
    </table>
    </form>
    <br/>
    <table class="column_95 tablesorter">
        <tr>
            <td class="column_25">
                <label class="floatRight" for="adminCert">
                    管理员证书<em class="required">*</em>
                </label>
            </td>
            <td>
                <input class="floatLeft" type="file" name="adminCert" id="adminCert"/>
            </td>
        </tr>
        <tr>
            <td class="textCenter" colspan="2">
                <input class="button" type="button" value="导入"
                    onClick="importAdminCert()"/>
            </td>
        </tr>
    </table>
    <br/>
    <table class="column_95 textMid tablesorter" id="cert">
        <caption>
            管理员证书列表:
        </caption>
        <thead><tr>
            <th class="column_10">生效</th>
            <th class="column_15">文件名</th>
            <th class="column_65">详细信息</th>
            <th class="column_10">操作</th>
        </tr></thead>
        <tr>
            <td>
                <input type="checkbox"/>
            </td>
            <td>admin.pem</td>
            <td>tpyzqCA
            admin
            GMT 2005/04/20 03:34:29 - GMT 2015/04/19 03:34:28</td>
            <td>
                <a class="delete" href="#">删除</a>
            </td>
        </tr>
        <tr>
            <td>
                <input type="checkbox"/>
            </td>
            <td>admin.pem</td>
            <td>tpyzqCA
            admin
            GMT 2005/04/20 03:34:29 - GMT 2015/04/19 03:34:28</td>
            <td>
                <a class="delete" href="#">删除</a>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <input class="button" type="button"
                    onClick="openImportCertDialog()" name="import" value="生效"/>
            </td>
        </tr>
    </table>

<script type="text/javascript"> 
$(document).ready(function() {
    $(".button").button();
});
</script>
<script type="text/javascript" src="Public/js/systemManagement/conf/cert.js"></script>
