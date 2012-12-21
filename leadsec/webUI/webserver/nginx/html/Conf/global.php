<?php
define('COMPANY_NAME', '北京网御星云信息技术有限公司');

define('PRODUCT_NAME', 'SIS安全隔离网闸');

// install path of sis webui
define('WEB_PATH', '/usr/local/webserver/nginx/html');

// database dir path  
// chmod 766
define('DB_PATH', '/usr/local/conf');

// Expired Time, second
define('EXPIRED_TIME', 86400);

// Limited Error Login Num
define('LIMITERR_NUM', 3);
// Limited Error Login Time, second
define('LIMITERR_TIME', 10);

define('DEBUG', false);

define('THEME_PATH', 'Public/default');

define('CLI_PATH', '/usr/local/bin');

define('UPLOAD_PATH', '/tmp/upload');

// Val 0：Firewall，1：IDS、2：VPN、 3：NetGap
define('LOG_DEVID', 3); 
define('LOG_PATH', '/var/log/fw.log')
?>
