<?php defined('BASEPATH') OR exit('No direct script access allowed');

class cat_assign_nav_m extends MY_Model
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
	

	function get_all_categories()
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item Category';	
	
		$query = $this->_db->get('['.$table.']');
        return $query->result();
	}
	

	function get_itemcategory_params($params)
	{
		$company = str_replace(array("?","!",",","."), "", 'SFS Holdings');
		$table = $company.'$'.'Item Category';	
	
		$query = $this->_db->like($params)->get('['.$table.']');
        return $query->row();
	}

	
	
}