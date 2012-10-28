<div id="dialogForm">
    <fieldset>
        <legend>导入证书</legend>
        <div>
            <label for="type">类型:</label>
            <span>
                <input class="radio" type="radio" name="type" onClick="toggleDom($('#certDiv'))" id="CA"/>
                <label for='CA'>CA证书</label>
            </span>
            <span>
                <input class="radio" type="radio" name="type"
                    onClick="toggleDom($('#adminCertDiv'))" id="admin"/>
                <label for='admin'>管理员证书</label>
            </span>
        </div>
        <br class="clearFloat"/>
        <div class="hide" name="toggleDiv" id="adminCertDiv">
       	    <form action="Function/systemManagement/admin/uploadCert.php" method="POST"
                enctype='multipart/form-data' id="adminCertForm">
            <div>
                <label for="adminCert">管理员证书<em class="required">*</em></label>
                <input type="file" name="adminCert" id="adminCert"/>
            </div>
            </form>
        </div>
        <div class="hide" name="toggleDiv" id="certDiv">
       	    <form action="Function/systemManagement/admin/uploadCert.php" method="POST"
                enctype='multipart/form-data' id="certForm">
            <div>
                <label for="CAcert">CA中心证书<em class="required">*</em></label>
                <input type="file" name="CAcert" id="CAcert"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="CAcert2">二级CA证书<em class="required">*</em></label>
                <input type="file" name="CAcert2" id="CAcert2"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="SIScert">安全隔离网闸证书<em class="required">*</em></label>
                <input type="file" name="SIScert" id="SIScert"/>
            </div>
            <br class="clearFloat"/>
            <div>
                <label for="SISkey">安全隔离网闸密钥<em class="required">*</em></label>
                <input type="file" name="SISkey" id="SISkey"/>
            </div>
            <br class="clearFloat"/>
            </form>
        </div>
    </fieldset>
</div>
