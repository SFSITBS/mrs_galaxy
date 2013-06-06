<?php defined('BASEPATH') or exit('No direct script access allowed');
/**
 * Keywords Library
 *
 * @author		PyroCMS Dev Team
 * @package		PyroCMS\Core\Modules\Keywords\Libraries
 */

class Assign_Category {

	protected $ci;

	/**
	 * The Keywords Construct
	 */
	public function __construct()
	{
		ci()->load->model('product_assignment/prod_assign_m');
		ci()->load->model('product_assignment/prod_assign_nav_m');
		ci()->load->model('users/profile_m');
		$this->ci =& get_instance();
		
		
	/*	$this->ci->lang->load('keywords/keywords');

		$this->get_all();
		*/
	}
	
	
	public function get_cart()
	{
		if(!$this->ci->session->userdata('cart'))
			$this->set_cart(array());

		return $this->ci->session->userdata('cart');
	}
	
	function add_item($code,$purchaser_id)
	{
		$assign_info = $this->ci->prod_assign_nav_m->get_itemcategory_params(array('Code'=>strtolower($code)));
		
		

		//Get all items in the cart so far...
		$items = $this->get_cart();

        //We need to loop through all items in the cart.
        //If the item is already there, get it's key($updatekey).
        //We also need to get the next key that we are going to use in case we need to add the
        //item to the cart. Since items can be deleted, we can't use a count. we use the highest key + 1.

        $maxkey=0;                       //Highest key so far
        $itemalreadyinsale=FALSE;        //We did not find the item yet.
		$insertkey=0;                    //Key to use for new entry.
		$updatekey=0;                    //Key to use to update(quantity)

		foreach ($items as $item)
		{
            //We primed the loop so maxkey is 0 the first time.
            //Also, we have stored the key in the element itself so we can compare.

			if($maxkey <= $item['line'])
			{
				$maxkey = $item['line'];
			}

			// if($item['code']==$code)
			// {
				// $updatekey=$item['line'];
			// }
		}

		$insertkey=$maxkey+1;

		//array/cart records are identified by $insertkey and item_id is just another field.
		$prof = $this->ci->profile_m->get_profile(array('user_id'=>$purchaser_id));
		$item = array(($insertkey)=>
		array(
			'line'=>$insertkey,
			'purchaser'=> $prof->first_name.' ',$prof->last_name,
			'code'=>$code,
			)
		);

		//Item already exists and is not serialized, add to quantity
		if($itemalreadyinsale)
		{
			$items[$updatekey]['quantity']+=$quantity;
		}
		else
		{
			//add to existing array
			$items+=$item;
		}

		$this->set_cart($items);
		return true;

	}
	
	function edit_item($line,$quantity)
	{
		$items = $this->get_cart();
		if(isset($items[$line]))
		{
			$items[$line]['quantity'] = $quantity;
			$this->set_cart($items);
		}

		return false;
	}
	
	
	public function set_cart($cart_data)
	{
		$this->ci->session->set_userdata('cart',$cart_data);
	}
	
	
	public function delete_item($line)
	{
		$items=$this->get_cart();
		unset($items[$line]);
		$this->set_cart($items);
	}
	
	/**
	 * Get keywords
	 *
	 * Gets all the keywords
	 *
	 * @param	string	$hash	The unique hash stored for a entry
	 * @return	array
	 */
	public function get_string($hash)
	{
		$keywords = array();
		
		foreach (ci()->keyword_m->get_applied($hash) as $keyword)
		{
			$keywords[] = $keyword->name;
		}
		
		return implode(', ', $keywords);
	}
	
	/**
	 * Get keywords
	 *
	 * Gets just the keywords, no other data
	 *
	 * @param	string	$hash	The unique hash stored for a entry
	 * @return	array
	 */
	public function get_array($hash)
	{
		$keywords = array();
		
		foreach (ci()->keyword_m->get_applied($hash) as $keyword)
		{
			$keywords[] = $keyword->name;
		}
		
		return $keywords;
	}
	
	/**
	 * Get full array of keywords
	 *
	 * Returns keywords with all data
	 *
	 * @param	string	$hash	The unique hash stored for a entry
	 * @return	array
	 */
	public function get($hash)
	{
		return ci()->keyword_m->get_applied($hash);
	}

	/**
	 * Add Keyword
	 *
	 * Adds a new keyword to the database
	 *
	 * @param	array	$keyword
	 * @return	int
	 */
	public function add($keyword)
	{
		return ci()->keyword_m->insert(array('name' => self::prep($keyword)));
	}

	/**
	 * Prepare Keyword
	 *
	 * Gets a keyword ready to be saved
	 *
	 * @param	string	$keyword
	 * @return	bool
	 */
	public function prep($keyword)
	{
		if (function_exists('mb_strtolower'))
		{
			return mb_strtolower(trim($keyword));
		}
		else
		{
			return strtolower(trim($keyword));
		}
	}

	/**
	 * Process Keywords
	 *
	 * Process a posted list of keywords into the db
	 *
	 * @param	string	$group	Arbitrary string to "namespace" unique requests
	 * @param	string	$keywords	String containing unprocessed list of keywords
	 * @param	string	$old_hash	If running an update, provide the old hash so we can remove it
	 * @return	string
	 */
	public function process($keywords, $old_hash = null)
	{
		// Remove the old keyword assignments if we're updating
		if ($old_hash !== null)
		{
			ci()->db->delete('keywords_applied', array('hash' => $old_hash));
		}

		// No keywords? Let's not bother then
		if ( ! ($keywords = trim($keywords)))
		{
			return '';
		}

		$assignment_hash = md5(microtime().mt_rand());
		
		// Split em up and prep away
		$keywords = explode(',', $keywords);
		foreach ($keywords as &$keyword)
		{
			$keyword = self::prep($keyword);
		/*
		// Find out which keywords are already being used	
		$matched = array_map(function($row) {
			if ($row) return ($row->name;
		}, ci()->db->where_in('name', $keywords)->get('keywords')->result());
		
		*/
			// Keyword already exists
			if (($row = ci()->db->where('name', $keyword)->get('keywords')->row()))
			{
				$keyword_id = $row->id;
			}
			
			// Create it, and keep the record
			else
			{
				$keyword_id = self::add($keyword);
			}
			
			// Create assignment record
			ci()->db->insert('keywords_applied', array(
				'hash' => $assignment_hash,
				'keyword_id' => $keyword_id,
			));
		}
		
		return $assignment_hash;
	}

}

/* End of file Keywords.php */
