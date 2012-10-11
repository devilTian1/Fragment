<?php
class db_sqlite { 
//打开sqlite数据库 
	function connect_sqlite($dbname) {
		$conn = null; 
		if(file_exists(DBROOT.$dbname)) { 
			$dbPath = 'sqlite:'.DBROOT.$dbname; 
			try { 
				$conn = new PDO($dbPath); 
				$conn->beginTransaction(); 
			} catch(PDOException $e) { 
				echo 'Exception is:'.$e->getMessage();
			} 
			return $conn;
		} else {
			exit("数据库文件不存在"); 
		}
	}
	//查询操作 
	function query_sqlite($conn,$sql) { 
		$result = array(); 
		try { 
			$sth = $conn->prepare($sql); 
			$sth->execute();
			//获取结果
			$result = $sth->fetchAll(); 
		} catch(PDOException $e) {
			echo 'Exception is:'.$e->getMessage(); 
		} 
		return $result; 
	}
	//得到第一条记录
	function query_first($conn,$sql) { 
		$result = 0; 
		try {
			$sth = $conn->prepare($sql); 
			$sth->execute();
			//获取结果 
			$vec = $sth->fetchAll();
			//echo (count($vec));
			$result = $vec[0]; 
		} catch(PDOException $e) {
			echo 'Exception is:'.$e->getMessage(); 
		} 
		return $result; 
	}
	//查询总记录数
	function query_count($conn,$sql) { 
		$result = 0; 
		try {
			$sth = $conn->prepare($sql); 
			$sth->execute();
			//获取结果 
			$vec = $sth->fetchAll();
			//echo (count($vec));
			$result = count($vec); 
		} catch(PDOException $e) {
			echo 'Exception is:'.$e->getMessage(); 
		} 
		return $result; 
	}
	//add,update,delete执行操作 
	function exec_sqlite($conn,$sql) {
		$count = 0; 
		try {
			$count = $conn->exec($sql);
		} catch(PDOException $e) { 
			$conn->rollBack();
			echo 'Exception is:'.$e->getMessage();
		} 
		return $count; 
	} 
	/** * 提交事务。针对执行exec_sqlite后 */ 
	function commit_sqlite($conn) { 
		$conn->commit(); 
	}
	//关闭连接 
	function close_sqlite($conn) { 
		$conn=null; 
	}
}
?> 