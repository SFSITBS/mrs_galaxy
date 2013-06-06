<?php defined('BASEPATH') OR exit('No direct script access allowed');

class canvassing_nav_m extends MY_Model
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
	

	function get_all_supplier($company)
	{
		$company = str_replace(array("?","!",",","."), "", $company);
		$table = $company.'$'.'Vendor';	
	
		$query = $this->_db->get('['.$table.']');
        return $query->result();
	}
	
	function get_supplier($params,$company)
	{
		$company = str_replace(array("?","!",",","."), "", $company);
		$table = $company.'$'.'Vendor';	
	
		$query = $this->_db->where($params)->get('['.$table.']');
        return $query->row();
	}
	
	
}