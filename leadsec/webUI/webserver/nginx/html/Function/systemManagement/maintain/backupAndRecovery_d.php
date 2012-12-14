<?php
    /*
        遍历一个文件夹下的所有文件与子文件夹
    */
    function my_scandir($dir)
    {
        $files=array();
        if(is_dir($dir)){
            if($handle=opendir($dir)){
                while(($file=readdir($handle))!==false){
                    if($file!="." && $file!=".."){
                        if(is_dir($dir."/".$file)){
                            $files[$file]=my_scandir($dir."/".$file);
                        } else {
                            $files[]=$dir."/".$file;
                        }
                    }
                }
                closedir($handle);
                return $files;
            }
        } else {
                echo "<font color='red'>"."文件路径不存在"."</font>";
        }
    }
    
    /*
        获取文件的后缀名
    */
    function extend_1($file_name) {   
    $retval="";   
    $pt=strrpos($file_name, ".");   
        if ($pt) {
            $retval=substr($file_name, $pt+1, strlen($file_name) - $pt); 
        }
        return ($retval);   
    } 

    
    /*
        截取数据库的名称不包含后缀名
    */
    function getDbName($url) {
        if(!empty($url)) {
            $filename= substr( $url , strrpos($url , '/')+1);
            $path = substr($filename,0,strrpos($filename , '.'));
            return $path ;
        }
    }


    /*
        判断要下载的文件属于外网与内网
    */
    function ExportFile() {
        require_once($_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php');
        require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
        require_once(WEB_PATH . '/Lib/driver/function.php');
        $db=new dbsqlite(DB_PATH.'/netgap_system.db');
        $host=$db->query("SELECT host FROM system")->getFirstData(PDO::FETCH_ASSOC);
        if ($host['host']==='O'){
            $configfile="ngconfig_out.txt";
        } else {
            $configfile="ngconfig_in.txt";
        }
        return  $configfile ;
    }
    
    // 获取后缀名为.db的文件,然后将此类型的文件存放在一个数组中
    $dir = "/usr/local/conf";
    $arr_file = my_scandir($dir);
    $arr_file_db =array();
    foreach($arr_file as $key=>$val ){
        if(!is_array($val) && extend_1($val)==='db') {
                $arr_file_db[]= $val;
            }

    }


    $filename = urlencode(ExportFile());
    header("Content-Type: application/octet-stream; charset=utf-8;");
    header("Content-Disposition: attachment; filename=\"$filename\";");
    header("Content-Length: 100;");
    header("Content-Transfer-Encoding: binary;");
    header('Pragma: Public;', true);
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');

    
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php');
        DEBUG && error_reporting(E_ALL);
  
        function exceptionHandler($e) {
            echo json_encode(array('status' => -1, 'msg' => $e->getMessage()));
        }
        set_exception_handler('exceptionHandler');
        require_once(WEB_PATH . '/Lib/driver/exception.php');
        require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
        require_once(WEB_PATH . '/Lib/driver/cli.php');
        require_once(WEB_PATH . '/Lib/core/cmd.php');
        require_once(WEB_PATH . '/Lib/driver/function.php');        
        $cli = new cli();
        $lenth_db = count($arr_file_db);    
        $downtimestr = 'Leadsec Secutiry Netgap' . date('Y-n-d H:i:s',time());
        $downlist = '--------DO NOT edit this line';
        $os = get_client_os();
        if ($os ==='Linux') {
            echo $downtimestr . "\n";
            echo $downlist . "\n" ;
        } else if ($os === 'Windows XP') {
            echo $downtimestr . "\r\n";
            echo $downlist . "\r\n";
        }

        for($i=0;$i<$lenth_db;$i++) {
            $cmd="sqlite3 \"{$arr_file_db[$i]}\" '.table' ";
            $table_str=$cli->run($cmd);
            $tables_arr = explode(' ',$table_str);
            $lenth_tables = count($tables_arr);
            for($j=0;$j<$lenth_tables;$j++) {
                if(!empty($tables_arr[$j])) {
                    $db = new dbsqlite($arr_file_db[$i]);
                    $result = $db->query("SELECT * FROM  {$tables_arr[$j]} ")
                    ->getAllData(PDO::FETCH_ASSOC);
                    if(!empty($result)) {
                        if ($os ==='Linux') {
                        foreach($result as $key =>$val) {
                            if($_POST['switch']==='off') {                            
                                if(!empty($val)) {
                                        echo "setdb".' '.getDbName($arr_file_db[$i]).' '.$tables_arr[$j].' ';
                                    foreach($val as $k=>$v) {
                                        echo "$k  $v";
                                    }
                                        echo "\n" ;
                                }
                            } elseif($_POST['switch']==='on') {
                                if(!empty($val)) {
                                        $str= "setdb".' '.getDbName($arr_file_db[$i]).' '.$tables_arr[$j].' ';
                                        echo md5($str);
                                    foreach($val as $k=>$v) {
                                        $str_val=$k.' '.$v;
                                        echo md5($str_val);
                                    }
                                        echo "\n" ;
                                }
                            }

                        }
                                            
                    } else if ($os === 'Windows XP') {
                            foreach($result as $key =>$val) {
                            if($_POST['switch']==='off') {                            
                                if(!empty($val)) {
                                        echo "setdb".' '.getDbName($arr_file_db[$i]).' '.$tables_arr[$j].' ';
                                    foreach($val as $k=>$v) {
                                        echo "$k  $v";
                                    }
                                        echo "\r\n" ;
                                }
                            } elseif($_POST['switch']==='on') {                        
                                if(!empty($val)) {
                                        $str= "setdb".' '.getDbName($arr_file_db[$i]).' '.$tables_arr[$j].' ';
                                        echo md5($str);
                                    foreach($val as $k=>$v) {
                                        $str_val=$k.' '.$v;
                                        echo md5($str_val);
                                    }
                                        echo "\r\n" ;
                                }
                             }                                  

                           }
                        }      
                    }
                }
            }           
        }
        
?> 




