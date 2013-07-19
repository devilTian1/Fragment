<?php
define('COMPANY_NAME', '');

define('PRODUCT_NAME', '安全隔离与信息交换系统');

// install path of sis webui
define('WEB_PATH', '/usr/local/webserver/nginx/html/new');

// database dir path  
// chmod 766
define('DB_PATH', '/usr/local/conf');

// Language
define('DEFAULT_LOCALE', 'zh_CN.UTF-8');

// Expired Time, second
define('EXPIRED_TIME',600);

// Limited Error Login Num
define('LIMITERR_NUM', 3);
// Limited Error Login Time, second
define('LIMITERR_TIME', 600);

define('DEBUG', true);

define('THEME_PATH', 'Public/default');

define('CLI_PATH', '/usr/local/bin');

define('UPLOAD_PATH', '/tmp/upload');

// Val 0：Firewall，1：IDS、2：VPN、 3：NetGap
define('LOG_DEVID', 3); 
define('LOG_PATH', '/var/log/fw.log');

define('HIDE_SUPER', false);
?>
