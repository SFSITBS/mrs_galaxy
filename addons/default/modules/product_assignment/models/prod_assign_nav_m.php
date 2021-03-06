<?php defined('BASEPATH') OR exit('No direct script access allowed');

class prod_assign_nav_m extends MY_Model
{
	protected $_table = 'stockmaster';	
	private $_db = NULL;
	
	function __construct()
    {
        // Call the Model constructor
        parent::__construct();
		//Initiate connection string, configured in database.php
		$this->_db = $this->load->database('navcon',TRUE);
    }
	
	function get_last_ten_companies()
    {
		$this->_db->limit(1);
        $query = $this->_db->get('[Company]');
        return $query->result();
    }

    
	public function get($params,$company)
	{
	
		$company = str_replace(array("?","!",",","."), "", $company);
		$table = $company.'$'.'Item';	
		
        $query = $this->_db->where($params)->get('['.$table.']');
        return $query->row();

	}
	public function get_descriptions($params)
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item';	
	
		$query = $this->_db->select('*')->like($params)->get('['.$table.']');
        return $query->row();
	}
	public function get_descriptions_company($params,$company)
	{
		$company = str_replace(array("?","!",",","."), "", $company);
		$table = $company.'$'.'Item';	
	
		$query = $this->_db->select('*')->like($params)->get('['.$table.']');
        return $query->row();
	}
	
	function get_all_categories()
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item Category';	
	
		$query = $this->_db->get('['.$table.']');
        return $query->result();
	}
	
	function get_item_params($params)
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item';	
	
		$query = $this->_db->like($params)->get('['.$table.']');
        return $query->result();
	}
	
	function get_itemcategory_params($params)
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item Category';	
	
		$query = $this->_db->like($params)->get('['.$table.']');
        return $query->row();
	}

	//TRADITIONAL
	
	// public function connect()
	// {
		
		// // Since UID and PWD are not specified in the $connectionInfo array,
		// // The connection will be attempted using Windows Authentication.
		// $serverName = "ITS2"; //serverName\instanceName
		// $connectionInfo = array( "UID"=>"sa", "PWD" => "sfssql_2005?", "Database"=>"db_sfs_log_test");

		// $conn = sqlsrv_connect( $serverName, $connectionInfo);

		// if( $conn ) 
		// {
			// // echo "Connection established.<br />";
			 
		// }
		// else{
			 // echo "Connection could not be established.<br />";
			 // die( print_r( sqlsrv_errors(), true));
		// }
		// return $conn;

	// }
	// public function close_connection($conn)
	// {	
			
		  // sqlsrv_close($conn);
	// }
	// public function get_all()
	// {
		// if($this->connect())
		// {
			// $sql = "SELECT * FROM Company";
			// $stmt = sqlsrv_query( $this->connect(), $sql );
		
		
			// $sql = "SELECT * FROM Company";
			// $stmt = sqlsrv_query( $this->connect(), $sql );
			// if($stmt) {
				// die( print_r( sqlsrv_errors(), true) );
			// }
			
			// // $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC)
			// //return $row;
			 // while( $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC) ) {
				  // // echo $row['timestamp'].", ".$row['Name']."<br />";
			 // }
		 // }
	
	// }

	
	// public function get($params=array(),$company)
	// {
		// $company = str_replace(' ','_',$company);
		// $table = $company.'$'.'items';
		// $result =array();
		// if($this->connect())
		// {	
			// // $conn = $this->connect();
			// // $sth = $conn->prepare("SELECT * FROM ".$table);
			// // $sth->execute();
			// // $result = $sth->fetchAll();
			
			 // $conn= $this->connect();
			 // $qry = "SELECT * FROM ".$table." where id = ".$params['id'];
			 // $stmt = sqlsrv_query( $conn, $qry );
			 // if($stmt == false)
			 // {
				// die( print_r( sqlsrv_errors(), true) );
			 // }
			 	// $rows =sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
			 // // while( $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC) ) {
				// // $rows = $rows.'|'.$row['description'];
			 // // } 
			// $result = $rows;
			 
			// sqlsrv_free_stmt($stmt);
		// }
		// else
		// {
			// echo "Connection to NAV cannot be established";
		// }
			 
		// return $result;

	// }
	
	// public function get_where($params,$company)
	// {
		// $company = str_replace(' ','_',$company);
		// $table = $company.'$'.'items';
		// $result =array();
		// if($this->connect())
		// {	
					 // $conn= $this->connect();
			 // $qry = "SELECT * FROM ".$table." where id = ".$params['id'];
			 // $stmt = sqlsrv_query( $conn, $qry );
			 // if($stmt == false)
			 // {
				// die( print_r( sqlsrv_errors(), true) );
			 // }
			// $rows =sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
			 
			// $result = $rows;
			 
			// sqlsrv_free_stmt($stmt);
		// }
		// else
		// {
			// echo "Connection to NAV cannot be established";
		// }
			 
		// return $result;

	// }
	
	// public function get_descriptions($params)
	// {
		// $company = str_replace(' ','_','SFS Holdings');
		// $table = $company.'$'.'items';
		// $result =array();
		// if($this->connect())
		// {	
					 // $conn= $this->connect();
			 // $qry = "SELECT * FROM ".$table." where description like '%".$params."%'";
			 // $stmt = sqlsrv_query( $conn, $qry );
			 // if($stmt == false)
			 // {
				// die(  print_r( sqlsrv_errors(), true) );
			 // }
			// $rows =sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);
			 
			// $result = $rows['id'];
			
			// sqlsrv_free_stmt($stmt);
		// }
		// else
		// {
			// echo "Connection to NAV cannot be established";
		// }
			 
		// return $result;

	// }
	
}