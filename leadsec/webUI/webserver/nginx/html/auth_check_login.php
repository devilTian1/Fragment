<?php
    header('Content-type: text/html; charset=utf-8');
    setlocale(LC_CTYPE, 'zh_CN.utf8');
    // set exception handler
    function exceptionHandler($e) {
        echo json_encode(array('msg' => $e->getMessage()));
    }
    set_exception_handler('exceptionHandler');

    // Load Config File
    require_once('Conf/global.php');
    // Exception driver
    require_once(WEB_PATH . '/Lib/driver/exception.php');
    // CLI driver
    require_once(WEB_PATH . '/Lib/driver/cli.php');
    // upload driver
    require_once(WEB_PATH . '/Lib/driver/fileUpload.php');
    // DB driver
    require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
    // function
    require_once(WEB_PATH . '/Lib/driver/function.php');
    
    $msg = 'show';
    if ($_GET['checkExistUserName']) {
        $name = $_GET['authUserListName'];
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id FROM user_online WHERE user_id = " .
            "(SELECT user_id FROM user where user_name='$name')";
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        return;
    } else if (!empty($_POST['authType'])) {
        $msg = 'fail';
        //auth usrname and password
        $clientIp = get_client_ip();
        $username = $_POST['authUserListName'];
        if ('local' === $_POST['authType']) {
            $localPasswd = $_POST['passwd_user'];
            $cmd = "auth_login type localpwd user $username ip $clientIp password $localPasswd";
        } else if ('localdyn' === $_POST['authType']) {
            $localPasswd = $_POST['passwd_user']; 
            $dynPasswd = $_POST['dynpasswd']; 
            $cmd = "auth_login type dynpwd user $username ip $clientIp password $localPasswd dynpassword $dynPasswd";
        } else {
            $cmd = "auth_login type vip user $username ip $clientIp";
        }
        // run cli        
        $cli = new cli();
        $ret = $cli->setGetResult(true)->setIsRec(false)->run($cmd);
 
        if ('success' === $ret[0]) {
            $msg = 'success';
        }
   } else {

    }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="charset" content="UTF8"/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/manufacture/default/css/form.css'/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/manufacture/default/css/link.css'/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/default/css/common.css'/>
        <link rel="stylesheet" href="Public/js/jquery/smoothness/jquery-ui-1.8.23.custom.css" type="text/css" />
    </head>
    <body>
<form method="POST" id="authLoginForm" action="auth_check_login.php"> 
       	        <!-- CONTENT -->
            <div class="content">
                <fieldset>
                 <?php if('success' === $msg) {?>
                    登录成功!
                    <script type="text/javascript">                           
                        function getURLStr(key) {
                            var str = location.search;
                            var indexNum = str.indexOf(key);
                            if (indexNum > 0) {
                                return str.substring(indexNum+key.length);
                            } else {
                                return "";
                            }
                        }
                        
                        function delayJumpToURL(destURL) {
                            var delay = document.getElementById("delayTime").innerHTML;;
                            if(delay > 0) {
                                delay--;
                                document.getElementById("delayTime").innerHTML = delay;
                            } else {
                                if (destURL.substring(0,4) === "http") {
                                    window.location.href = destURL;
                                } else {
                                    window.location.href = "http://"+destURL;
                                }
                            }
                            setTimeout("delayJumpToURL('"+destURL+"')",1000);
                        }
                        var turnToURL = getURLStr("url=");
                        
                        if (turnToURL!=="") {
                            var tipStr = "<br/> 页面将在<span id=\"delayTime\" >3</span>秒后自动跳转，如果不跳转，请点击下面链接。<br/>";
                            document.write(tipStr);
                            if (turnToURL.substring(0,4) === "http") {
                                document.write("<a href='"+turnToURL+"'>跳转</a>");
                            } else {
                                document.write("<a href='http://"+turnToURL+"'>跳转</a>");
                            }
                            delayJumpToURL(turnToURL);
                        }
                    </script>
                 <?} else {?>                    
                        <?php if('fail' === $msg) { ?>
                             <div class="error column_30">登录失败，请重新登录!</div><br class="clear_float"/>
                        <?}?>
                   
                        <div class="row">
                                <label>认证类型 :</label>
                                <label><select name="authType">
                                    <option value="local" selected="selected">本地认证</option>
                                    <option value="localdyn">本地密码+动态密码</option>
                                    <option value="vip">免认证</option>
                                </select></label>                         
                        </div>
                        <br class="clear_float"/>
                        <div class="row">
                            <label>用户名 :</label>
                            <input type="text" name="authUserListName" value=""/>
                        </div>
                        <br class="clear_float"/>
                        <div class="row">
                            <label>密码 :</label>
                            <input type="password" name="passwd_user" value=""/>
                        </div>
                        <br class="clear_float"/>
                        <div class="row">
                            <label>动态密码 :</label>
                            <input type="password" name="dynpasswd" value="">
                        </div>
                        <br class="clear_float"/>
                        <div class="row floatRight column_75">
                            <button class="button" type="submit" id="submitbtn" name="submitbtn"> 登录 </button>                          
                         </div>
                     </fieldset>
                 <?}?>
           </div>
</form>
                            
            <!-- FOOTER -->
            <div class="footer textCenter">
                <div class="bottom">@ 2010-2020 <?php echo COMPANY_NAME;?>版权所有</div>
            </div>
        </div>
    </body>
</html>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.validate.min.js"></script>
<!-- Put our libraries next -->
<script type="text/javascript" src="Public/js/common.js"></script>
<script type="text/javascript" src="Public/js/ui.standard.js"></script>
<script type="text/javascript" src="Public/js/validation.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $("fieldset").css("padding-left",'48em');
        $("fieldset").css("padding-right",'30em');
        $(".button").button();
        validateForm($('#authLoginForm'));
        authTypeCtrl();
        $("select[name='authType']").bind("change",function() {
           authTypeCtrl();
        });
        $("#authLoginForm").attr("action","auth_check_login.php"+location.search);
    });

function authTypeCtrl() {
    var selectedType = $("select[name='authType'] option:selected").val();
    if(selectedType == 'local') {
        $("input[name='dynpasswd']").attr("disabled",'disabled');
        $("input[name='passwd_user']").removeAttr("disabled");
    } else if (selectedType == 'localdyn') {
        $("input[name='dynpasswd']").removeAttr("disabled");
        $("input[name='passwd_user']").removeAttr("disabled");
    } else {
        $("input[name='dynpasswd']").attr("disabled",'disabled');
        $("input[name='passwd_user']").attr("disabled",'disabled');
    }
}
</script>
