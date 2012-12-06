<table class="column_95">
     <tbody>
        <tr>
            <td  width="250" class="tdheader">系统当前软件版本 :</td>
            <td  class="tdbody"><{$lastestVersion}></td>
        </tr>
        <tr>
            <td class="tdheader">
                <span class="red">*</span> 升级文件:
            </td>
            <td class="tdbody">
                <form class="inline" action="Function/systemManagement/maintain/upgrade.php" method="POST" id="upgradeForm" 
                    onSubmit="return false">
                    <input name="upgradeFile" type="file" id="upgradeFile" />
                </form>
            </td>
        </tr>
        <tr>
            <td class="tdheader column_40"></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"  onClick="updata()">
                    升级
                </button>
            </td>
        </tr>
    </tbody>
</table>


<table class="column_95 textMid tablesorter">
    <caption>
        版本日志信息
    </caption>
    <thead>
    <thead>
        <tr>
            <th class="column_10">生效</th>
            <th class="column_15">文件名</th>
            <th class="column_55">详细信息</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
        <{foreach $result_list as $k => $val}>
             <tr>
                 <td><{$val.id}></td>
                 <td><{$val.up_version}></td>
                 <td><{$val.del_bugs}></td>
                 <td><{$val.up_time}></td>
             </tr>
        <{/foreach}>
        <tr>
            <td colspan="4">
                <form action="Function/systemManagement/maintain/upgrade.php" method="POST" class="inline">
                    <button class="inputbtn standard" type="submit">
                        导出升级历史
                    </button>
                    <input type="hidden" name="downloadUpgradeHistory" value='1'/>
                 </form>

                     <button  type="button"  class="inputbtn standard"  onclick="window.open('http://www.leadsec.com.cn')" >
                         检查最新升级包
                     </button>

                 <form action="Function/systemManagement/maintain/upgrade.php?reboot=22" method="POST" class="inline"
                    id = "rebootForm"onSubmit="return false">
                    <button type="button" class ="inputbtn standard" onclick="reboot()" >
                         重启<{$smarty.const.PRODUCT_NAME}>
                    </button>
                </form>
            </td>
        </tr>
</table>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#upgradeForm"));
});
</script>
<script type="text/javascript" src="Public/js/systemManagement/maintain/upgrade.js"></script>
