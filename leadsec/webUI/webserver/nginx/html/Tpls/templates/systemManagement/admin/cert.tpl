    <button class="floatLeft" type="submit" onClick="openDialog()" name="import">导入</button>
    <table class="column_95 textMid tablesorter" id="clientTcp">
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
    <button class="floatLeft" type="submit" onClick="openDialog()" name="import">导入</button>

<div class="hide" id="dialogForm">
    <fieldset>
        <legend>导入证书</legend>
        <div>
            <label for="type">类型:</label>
            <span>
                <input class="radio" type="radio" name="type" onClick="toggleDom($('#certDiv'))"/>
                xxx证书
            </span>
            <span>
                <input class="radio" type="radio" name="type" onClick="toggleDom($('#adminCertDiv'))"/>
                管理员证书
            </span>
        </div>
        <br class="clearFloat"/>
        <div class="hide" name="toggleDiv" id="adminCertDiv">
        </div>
        <div class="hide" name="toggleDiv" id="certDiv">
            <div>
                <label for="mid">CA中心证书<em class="required">*</em></label>
                <input type="file" name="CAcert" id="CAcert"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="mid">二级CA证书<em class="required">*</em></label>
                <input type="file" name="CAcert" id="CAcert"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="mid">安全隔离网闸证书<em class="required">*</em></label>
                <input type="file" name="SIScert" id="SIScert"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="mid">安全隔离网闸密钥<em class="required">*</em></label>
                <input type="file" name="SISkey" id="SISkey"/>
            </div>
            <br class="clearFloat"/>
        </div>
    </fieldset>
</div>
<script type="text/javascript">
    $("[name='import']").button();
</script>
