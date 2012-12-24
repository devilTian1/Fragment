<form action="Function/resConf/user/userGroup.php" method="POST" id="editProcessForm" onSubmit="return false;">
    <fieldset>
        <legend>进程添加（URL只支持http、https、ftp三种协议，并且不能够有分号、逗号和加号）</legend>
        <div id="mainContent" style="height: 200px;">
            <table id="processList" class="column_95 textMid tablesorter">
                <thead>
                <tr>
                <th class="column_10">软件名</th>
                <th class="column_10">进程名</th>
                <th class="column_10">提示信息</th>
                <th class="column_10">URL</th>
                <th class="column_10">操作</th>
                </tr>
                </thead>
            </table>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="softName">软件名:<em class="required">*</em></label>
            <input type="text" name="softName" maxlength="15" value=""/>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="processName">进程名:<em class="required">*</em></label>
            <input type="text" name="processName" maxlength="15" value=""/>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="promptInformation">提示信息:<em class="required">*</em></label>
            <input type="text" name="PromptInformation" maxlength="15" value=""/>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="processUrl">进程URL:<em class="required">*</em></label>
            <input type="text" name="processUrl" maxlength="15" value=""/>
        </div>
    </fieldset>
</html>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
});
</script>

