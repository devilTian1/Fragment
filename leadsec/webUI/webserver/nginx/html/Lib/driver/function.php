<?php
/**
 * 常的的方法,如果根据需要在后面添加更多的方法
 */
/**
 * 得到客户端ip地此
 */
function get_client_ip() {
	if (getenv ( "HTTP_CLIENT_IP" ) && strcasecmp ( getenv ( "HTTP_CLIENT_IP" ), "unknown" ))
		$ip = getenv ( "HTTP_CLIENT_IP" );
	else if (getenv ( "HTTP_X_FORWARDED_FOR" ) && strcasecmp ( getenv ( "HTTP_X_FORWARDED_FOR" ), "unknown" ))
		$ip = getenv ( "HTTP_X_FORWARDED_FOR" );
	else if (getenv ( "REMOTE_ADDR" ) && strcasecmp ( getenv ( "REMOTE_ADDR" ), "unknown" ))
		$ip = getenv ( "REMOTE_ADDR" );
	else if (isset ( $_SERVER ['REMOTE_ADDR'] ) && $_SERVER ['REMOTE_ADDR'] && strcasecmp ( $_SERVER ['REMOTE_ADDR'], "unknown" ))
		$ip = $_SERVER ['REMOTE_ADDR'];
	else
		$ip = "unknown";
	return ($ip);
}
//页面跳转
function redirect($info,$url)
{
	echo "<meta http-equiv='refresh' content='1;url=$url'>";
        echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
        echo $info;
}

function redirect_once($url)
{
	echo "<meta http-equiv='refresh' content='0;url=$url'>";
}


function get_client_os()
{
    $agent = $_SERVER['HTTP_USER_AGENT'];
    $os = false;
     if (eregi('win', $agent) && eregi('nt 5.1', $agent)){
        $os = 'Windows XP';
    }
    else if (eregi('linux', $agent)){
        $os = 'Linux';
    }
    else if (eregi('unix', $agent)){
        $os = 'Unix';
    }
    else {
        $os = 'Unknown';
    }
    return $os;
}



