<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title></title>
        <link rel="stylesheet" href="{$smarty.const.THEME_PATH}/css/login.css" type="text/css" />
    </head>
    <body>
        <fieldset>
            <legend>登录网御SIS安全隔离网闸</legend>
            <div>
                <label for="username">用户名:<em class="required">*</em></label>
                <input type="text" name="username" id="username"/>
                <br class="clearFloat"/>
            </div>
            
            <div>
                <label for="passwd">密码:<em class="required">*</em></label>
                <input type="text" name="passwd" id="passwd"/>
                <br class="clearFloat"/>
            </div>
            <br/>

            <button onClick="login()">
                Login
            </button>
        </fieldset>
    </body>
</html>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="Public/js/login.js"></script>
<script type="text/javascript">
    $("#add").button();
</script>
