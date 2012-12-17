<form action="Function/resConf/user/userGroup.php" method="POST" id="editProcessForm" onSubmit="return false;">
<fieldset>
    <legend>进程添加（URL只支持http、https、ftp三种协议，并且不能够有分号、逗号和加号）</legend>
    <div class="row">
         <thead>
            <tr>
            <th class="column_20">软件名</th>
            <th class="column_20">进程名</th>
            <th class="column_20">提示信息</th>
            <th class="column_20">URL</th>
            <th class="column_20">操作</th>
            </tr>
        </thead>
</div>
<br class="clearFloat"/>
<hr/>
    <div class="row">
        <label for="userListName">软件名:<em class="required">*</em></label>
        <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>"
    </div>
<br class="clearFloat"/>
<hr/>
    <div class="row">
        <label for="userListName">进程名:<em class="required">*</em></label>
        <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>"
    </div>
<br class="clearFloat"/>
<hr/>
    <div class="row">
        <label for="userListName">提示信息:<em class="required">*</em></label>
        <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>"
    </div>
<br class="clearFloat"/>
<hr/>
    <div class="row">
        <label for="userListName">进程URL:<em class="required">*</em></label>
        <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>"
    </div>
<br class="clearFloat"/>
<hr/>
<div class="row">
    <button class="standard floatLeft" type="submit" name="process" id="process">
    进程添加
    </button>
</div>
<fieldset>
</html>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
});
</script>

