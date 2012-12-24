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

/* Get an array that represents directory tree
 * @param string $directory. Directory path
 * @param bool $recursive.   Include sub directories
 * @param bool $listDirs.    Include directories on listing
 * @param bool $listFiles.   Include files on listing
 * @param bool $dirStruct.   directory structure or not.
 *  Multi-dimensional Arry or One-dimensional array.
 * @param regex $exclude.    Exclude paths that matches this regex
 */
function directoryToArray($dir, $rescursive = true, $listDirs = false, $listFiles = true, $dirStruct = false, $exclude = '') {
    if ($handle = opendir($dir)) {
        $result = array();
        while (false !== ($file = readdir($handle))) {
            preg_match("/(^(([\.]){1,2})$|(\.(svn|git|md))|(Thumbs\.db|\.DS_STORE))$/i", $file, $skip);
            $skipByExclude = false;
            if ($exclude) {
                preg_match($exclude, $file, $skipByExclude);
            }
            if (!$skip && !$skipByExclude) {
                $path = $dir . DIRECTORY_SEPARATOR . $file;
                if (is_dir($path)) {
                    if ($rescursive) {
                        if ($dirStruct) {
                            $result[$file] = directoryToArray($path,
                                $rescursive, $listDirs, $listFiles,
                                $dirStruct, $exclude);
                        } else {
                            $result = array_merge($result,
                                directoryToArray($path, $rescursive,
                                    $listDirs, $listFiles, $dirStruct,
                                    $exclude));
                        }
                    }
                    if ($listDirs) {
                        if ($dirStruct) {
                            $result[$file] = '';
                        } else {
                            $result[] = $path;
                        }
                    }
                } else {
                    if ($listFiles) {
                        $result[] = $path;
                    }
                }
            }
        }
        closedir($handle);
        return $result;
    } else {
        throw new Exception("ERROR: 无法打开指定目录[$dir].");
    }
}

/*
 * Get an array that represents lines of file.
 * @param $path String. file path.
 * @param $rowsCount Integer. The number of file line to be displayed.
 * @param $includeFunc String. function name which used to validate
 *   this line.
 * @param $formatFunc String. function name which used to format return
 *   result of $includeFunc()
 */
function fileLinesToArr($path = LOG_PATH, $rowsNum = 10, $includeFunc = NULL,
    $formatFunc = NULL) {
    $result = array();
    $fp     = @fopen($path, 'r');
    $count  = 0;
    if ($fp) {
        while (false !== ($buffer = fgets($fp, 4096))) {
            if ($count < $rowsNum) {
                if ($includeFunc !== NULL && $match = $includeFunc($buffer)) {
                    if ($formatFunc !== NULL && $r = $formatFunc($match)) {
                        $result[] = $r;
                    } else {
                        $result[] = $match;
                    }
                } else {
                    $result[] = $buffer;
                }
                $count++;
            }
        }
        if (!feof($fp)) {
            throw new Exception("Error: unexpected fgets() fail.");
        }
        fclose($fp);
    }
    return $result;
}

/*
 * Convert the netmask length to decimal netmask. eg: 24 -> 255.255.255.0
 *  return the original value if $mask is a decimal netmask.
 * @param $mask String. Subnet mask.
 * @return string.Dotted decimal notation.
 *   eg: 255.255.128.0
 */
function conventToIpv4Mask($mask) {
    $regexp = '/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/';
    if (preg_match($regexp, $mask)) {
        return $mask;
    } else {
        $mask = intval($mask);
        if ($mask >= 1 && $mask <= 32) {
            $maskFrag =
                str_split(str_pad(str_repeat('1', $mask), 32, '0'), 8);
            foreach ($maskFrag as $k => $v) {
                $maskFrag[$k] = base_convert($v, 2, 10);
            }
            return join('.', $maskFrag);
        } else {
            throw new Exception('incorrect subnet mask: ' . $mask);
        }
    }
}
