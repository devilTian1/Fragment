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

function getLicense($link) {
    $modTable = array('fileEx'          => 'file_swap',
                      'fileSync'        => 'file_swap_new',
                      'db'              => 'database_swap',
                      'safeBrowse'      => 'http_access',
                      'ftp'             => 'ftp_access',
                      'mail'            => 'mail_access',
                      'dbSync'          => 'database_access',
                      'safePass'        => 'fastpass_access',
                      'msgTrans'        => 'msg_swap',
                      'customized'      => 'custom_access',
                      'ids'             => 'ids',
                      'HA'              => 'ha',
                      'lvs'             => 'ha',
                      'virusProtection' => 'anti-virus',

                      'ctcp_status'     => 'custom_access',
                      'cudp_status'     => 'custom_access',
                      'db_status'       => 'database_swap',
                      'db_swap_status'  => 'database_access',
                      'sync_status'     => 'file_swap',
                      'fs_new_status'   => 'file_swap_new',
                      'http_status'     => 'http_access',
                      'sync_msg_status' => 'msg_swap',
                      'smtp_status'     => 'mail_access',
                      'pop3_status'     => 'mail_access',
                      'ftp_status'      => 'ftp_access',
                      'status'          => 'fastpass_access'
                );
    $db  = new dbsqlite(DB_PATH . '/private.db');
    $app = $modTable[$link];
    if (empty($app)) {
        return true;
    }
    $sql = "SELECT value FROM license WHERE application = '$app'";
    $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    return $result['value'] !== '0' ? true : false;
}

function getRoleName($roleArr, $glue = '/') {
    $result = array();
    if (array_search('super', $roleArr) !== false) {
        return '超级';
    }
    if (array_search('manager', $roleArr) !== false) {
        $result[] = '配置';
    }
    if (array_search('policyer', $roleArr) !== false) {
        $result[] = '策略';
    }
    if (array_search('auditor', $roleArr) !== false) {
        $result[] = '日志';
    }
    return join($glue, $result);
}


/* insert a new line into specified file.
 * @param string $filePath. file path which need to handle.
 * @param string $newLine. new line to be inserted.
 * @param string $regexp. if the param is set, insert into the specified line
 *  before or after. otherwise, unshift/push the new line.
 * @param string $pos. insertion position. APPEND | PREPEND. default: APPEND
 */
function insertLineIntoFile($filePath, $newLine, $regexp = '', $pos = 'APPEND') {
    if ($pos !== 'APPEND' && $pos !== 'PREPEND') {
        throw new Exception("Can not insert new line.[position=$pos]");
    }
    $contents = '';
    if ($regexp === '') {
        if ($pos === 'APPEND') {
            file_put_contents($filePath, $newLine, FILE_APPEND | LOCK_EX);
        } else if ($pos === 'PREPEND') {
            $contents = file_get_contents($filePath);
            $contents = $newLine . "\n" . $contents;
            file_put_contents($filePath, $contents);
        }
        return ;
    } else {
        $contents = file_get_contents($filePath);
        if ($pos === 'APPEND') {
            $replacement = "$1" . PHP_EOL . $newLine;
        } else if ($pos === 'PREPEND') {
            $replacement = $newLine . PHP_EOL . '$1';
        }
        $contents = preg_replace($regexp, $replacement, $contents);
        file_put_contents($filePath, $contents);
    }
}

/* get value of param from specified file.
 * @param string $filePath. file path which need to fetch.
 * @param string $include.  include line that matches this regex.
 * @return array $result. the matches result of function preg_match()
 *  which is the third parameter. if no search, return array().
 */
function getParamFromFile($filePath, $include) {
    $result = array();
    $fp = @fopen($filePath, 'r');
    if ($fp) {
        while (!feof($fp)) {
            $buffer = fgets($fp, 4096);
            if (preg_match($include, $buffer ,$result)) {
                return $result;
            }
        }
        fclose($fp);
        return $result;
    } else {
        throw New Exception("Can not read file [$filePath]");
    }
}

/* set param from the specified file recursively
 * @param string $filePath. file path which need to be modified.
 * @param string $include.  include line that matches this regex.
 * @param string $newLine.  the new line to be used to replace.
 */
function modifyParamFromFile($filePath, $include, $newLine) {
    $contents = file_get_contents($filePath);
    $contents = preg_replace($include, $newLine, $contents);
    file_put_contents($filePath, $contents);
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
function directoryToArray($dir, $rescursive = false, $listDirs = false, $listFiles = true, $dirStruct = false, $exclude = '') {
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
 * @param $offset Integer. start at that offset in the lines. default: 1
 * @param $includeFunc String. function name which used to validate
 *   this line.
 * @param $formatFunc String. function name which used to format return
 *   result of $includeFunc()
 */
function fileLinesToArr($path = LOG_PATH, $rowsNum = 10, $offset = 1,
    $includeFunc = NULL, $formatFunc = NULL, $includeFuncGrep = NULL) {
    $result = array();
    $fp     = @fopen($path, 'r');
    if ($fp) {
        while (false !== ($buffer = fgets($fp, 4096))) {
            if ($offset > 0) {
                $offset--;
            }
            if ($offset === 0 && empty($rowsNum) || count($result) <= $rowsNum) {
                if ($includeFunc !== NULL) {
                    if (($includeFuncGrep !== NULL) && ($match = $includeFunc($buffer,$includeFuncGrep))) {
                        if ($formatFunc !== NULL && $r = $formatFunc($match)) {
                            $result[] = $r;
                        } else {
                            $result[] = $match;
                        }
                    } else if ($match = $includeFunc($buffer)) {
                        if ($formatFunc !== NULL && $r = $formatFunc($match)) {
                            $result[] = $r;
                        } else {
                            $result[] = $match;
                        }
                    }
                } else {
                    $result[] = $buffer;
                }
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
 * Convert the netmask to specified format.
 * @param $mask String. Subnet mask.
 * @param $format String. 'dot' means 32-bits mask. 'int' means Netmask length.
 *   eg: 'dot' => 255.255.0.0, int => 16.
 * @return string.Dotted decimal notation.
 *   eg: 255.255.128.0
 */
function convertToIpv4Mask($mask, $format = 'dot') {
    $regexp = '/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/';
    if (($format === 'dot' && preg_match($regexp, $mask)) ||
        ($format === 'int' && $mask >= 1 && $mask <= 32)) {
        return $mask;
    } else if ($format === 'int') {
        $maskFrag = explode('.', $mask);
        $result = 0;
        foreach ($maskFrag as $v) {
            $result += substr_count(base_convert($v, 10, 2), '1');
        }
        return $result;
    } else if ($format === 'dot') {
        $mask = intval($mask);//转换为整形
        if ($mask >= 1 && $mask <= 32) {
            $maskFrag =
                str_split(str_pad(str_repeat('1', $mask), 32, '0'), 8);
            foreach ($maskFrag as $k => $v) {
                $maskFrag[$k] = base_convert($v, 2, 10);//把数字的2进制转化为10进制
            }
            return join('.', $maskFrag);
        } else {
            throw new Exception('incorrect subnet mask: ' . $mask);
        }
        return join('.', $maskFrag);
    } else {
        throw new Exception("incorrect subnet mask: $mask, format: $format");
    }
}

/*
 * Validate ipv4 format.
 * @param $ipv4 string. to be validated.
 * @return bool. If it`s ipv4 format then return true. otherwise, false.  
 */
function validateIpv4Format($ip) {
    $regexp = '/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}' .
        '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/';
    return preg_match($regexp, $ip);
}
