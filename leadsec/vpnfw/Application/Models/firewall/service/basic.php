<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class BasicModel {
    	public function getInitPageData(){
    		  return $this->getInitPagination();
    	}
    	
	    public function getInitTable(){
	    	$Id=@$_POST['ld'];
	    	if($Id['limit']=='all'){
	    		$where="";
	    	}else{
	    		$where="LIMIT ".$Id['limit']." OFFSET ".$Id['offset'];
	    	}
	    	$this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
	    	$sql="SELECT external_name, ip, mask, ipv6, ipv6_mask, phy_device FROM interface WHERE alias_id != -1";
	        $sql.=' '.$where;
	    	$data    = $this->db->getInstance('configs')
	                               ->query($sql)
	                               ->getAllData(PDO::FETCH_BOTH);
			return $data;
	         
	    }
	    public function getInitPagination(){
	    	$Id=@$_POST['ld'];
	    	isset($Id['limit'])?$limit=$Id['limit']:$limit=10;
	    	isset($Id['offset'])?$offset=$Id['offset']:$offset=0;
	    	
	    	 $this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
	         $result     = $this->db->getInstance('configs')
	                                 ->query('SELECT external_name, ip, mask, ipv6, ipv6_mask, phy_device FROM interface WHERE alias_id != -1')
	                                 ->getCount();
		     $data['dataCount']=$result;
		     $data['rowsCount']=$limit;
		     if($limit=='all') $limit=$result;
		     $data['pageCount']=ceil($result/$limit);
		     $data['clickedPageNo']=ceil($offset/$limit)+1;
		     $data['clickedPageNo']<=1?$data['prev']=1:$data['prev']=$data['clickedPageNo']-1;
		     $data['clickedPageNo']>=$data['pageCount']?$data['next']=$data['pageCount']:$data['next']=$data['clickedPageNo']+1;
		     return $data;
	    }
	    public function freshTableAndPagination(){
	    	 $data['initTable']=$this->getInitTable();
	    	 $data['initData']=$this->getInitPagination();
	    	 return $data;
	    }
	    
	    public function batchDel(){
	    	
	    }
    }
?>
