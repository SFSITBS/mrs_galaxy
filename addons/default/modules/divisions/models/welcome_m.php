<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

// An example of a model containing a connection to MS NAV


class Welcome_m extends CI_Model {
	
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

    

}
