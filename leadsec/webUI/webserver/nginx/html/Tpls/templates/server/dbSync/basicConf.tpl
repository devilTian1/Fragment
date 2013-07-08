    <form action="Function/server/dbSync/basicConf.php" method="POST" id="fileCertConfForm"
        onSubmit="return false">
    <table class="column_95 tablesorter">
         <caption>
            证书设置:
        </caption>
        <tr>
            <td class="column_25">
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
                   	用户证书
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <{include file='layout/upload.tpl' name="SIScert" id="SIScert" }>
            </td>
        </tr>
        <tr>
            <td>
                <label class="floatRight" for="SISkey">
                   	用户密钥
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <{include file='layout/upload.tpl' name="SISkey" id="SISkey" }>
            </td>
        </tr>
        <tr>
            <td>
                <label class="floatRight" for="SISkey">
                   	用户密钥口令
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <input class="w200" type="password" name="userKeyWord" id="userKeyWord" size="34" />        
            </td>
        </tr>
		<tr>
            <td>
                <label class="floatRight" for="SISkey">
                   	对端证书公共名
                    <em class="required">*</em>
                </label>
            </td>
            <td>
                <input class="w200" type="text" name="certCommname" id="certCommname" size="34" />        
            </td>
        </tr>
        <tr>
        	<td>&nbsp;</td>
            <td >
                <button class="inputbtn standard" type="button" id="setSyncBtn" onClick="importCACert()">
                	导入</button>
            </td>
        </tr>
    </table>

    <br/>
 
    <table class="column_95 textMid tablesorter" id="certListTable">
        <caption>
            文件交换证书列表:
        </caption>
        <thead><tr>
        	<th class="column_20">证书文件</th>
            <th class="column_20">公共名</th>
            <th class="column_20">过期时间</th>
            <th class="column_20">状态</th>
            <th class="column_20">操作</th>
        </tr></thead>
        <tbody>
            <tr>
               <td colspan="5">Loading……</td>
            </tr>
        </tbody>
    </table>
 </form>
<script type="text/javascript" src="Public/js/server/dbSync/basicConf.js"></script>
<script type="text/javascript"> 
$(document).ready(function(){
	renderStandardUi();	
	validateForm($("#fileCertConfForm"));
    var uploadWid =  $('#CAcert').width();
    $('.uploadText').width(uploadWid - 75);
	freshTable('Function/server/dbSync/basicConf.php', $('#certListTable'));
});
</script>

