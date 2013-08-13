<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class BasicModel {
	    public function getInitPageData() {
	            $this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
	            $result     = $this->db->getInstance('configs')
	                                 ->query('SELECT external_name, ip, mask, ipv6, ipv6_mask, phy_device FROM interface WHERE alias_id != -1')
	                                 ->getCount();
		        $data['dataCount']=$result;
		        $data['pageCount']=ceil($result/10);
		        $data['clickedPageNo']=1;
		        $data['prev']=1;
		        $data['next']=2;
		        return $data;
	     }

	    public function getTableData($where=''){
	    	$this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
	    	$sql="SELECT external_name, ip, mask, ipv6, ipv6_mask, phy_device FROM interface WHERE alias_id != -1";
	        $sql.=' '.$where;
	    	$data    = $this->db->getInstance('configs')
	                               ->query($sql)
	                               ->getAllData(PDO::FETCH_BOTH);
			return $data;
	         
	    }   
    }
?>
