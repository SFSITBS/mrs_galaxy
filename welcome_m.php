<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

// An example of a model containing a connection to MS NAV


class Welcome_m extends CI_Model {
	
	private $_navcon = NULL;
	
    function __construct()
    {
        // Call the Model constructor
        parent::__construct();

        $config_2['hostname'] = "SFSW2K8R2SRV3\NAV";
		$config_2['username'] = "sa";
		$config_2['password'] = "1";
		$config_2['database'] = "Cronus";
		$config_2['dbdriver'] = "sqlsrv";
		$config_2['dbprefix'] = "";
		$config_2['pconnect'] = FALSE;
		$config_2['db_debug'] = TRUE;
		$config_2['cache_on'] = FALSE;
		$config_2['cachedir'] = "";
		$config_2['char_set'] = "utf8";
		$config_2['dbcollat'] = "utf8_general_ci";

		//Initiate connection string
		$this->_navcon = $this->load->database($config_2,TRUE);
    }
    
    function get_last_ten_companies()
    {
		$this->_navcon->limit(1);
        $query = $this->_navcon->get('[Company]');
        return $query->result();
    }

    

}
