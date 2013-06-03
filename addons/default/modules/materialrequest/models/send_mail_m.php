<?php defined('BASEPATH') OR exit('No direct script access allowed');

class send_mail_m extends MY_Model
{
	protected $_table = 'material_requests';


	public function get_actng_cat($id)
	{
		return $this->db
			->select('accounting_category.*')
			->where('id', $id)
			->get('accounting_category')
			->row();
	}
	
	public function get_mr_items($mr_id)
	{
		return $this->db
			->select('material_requests_items.*')
			->where(array('mr_id' => $mr_id))
			->get('material_requests_items')
			->result();
	}
	
	public function get_status_desc($id)
	{
		return $this->db
			->select('material_requests_statuses.*')
			->where('id', $id)
			->get('material_requests_statuses')
			->row();
	}
	public function get_division_group($id)
	{
		return $this->db
			->select('default_division_groups.*')
			->where('id', $id)
			->get('default_division_groups')
			->row();
	}
	
	public function get_where($params)
	{		
		return $this->db
			->select('default_users.*')
			->where($params)
			->get('default_users')
			->row();
	}
	function get_profile($params = array())
	{
		$query = $this->db->get_where('profiles', $params);

		return $query->row();
	}
	
	
	public function send_mail($slug,$send_to,$mr,$link,$message)
	{
		$purpose = $this->get_actng_cat($mr->accounting_cat);
		$items = $this->get_mr_items($mr->id);
		
		$total_items = 0;
		foreach($items as $total)
		{
			$total_items = $total_items + $total->quantity;
		}
			
		$user = $this->get_where(array('id' =>$mr->requestor));
		$profile_requestor = $this->get_profile(array('id' =>$mr->requestor));
		$status = $this->get_status_desc($mr->status);		
		$division_group = $this->get_division_group($mr->division_group);
			
						
			
		try
		{
		
			//$email_config = $this->settings_m->get_email_config();
			//$this->load->library('email', $email_config);			
			$this->load->library('email');			
			//$this->email->initialize($email_config);
		
			Events::trigger('email', array(
							'name' => 'SFS LOGISTICS',
							'sender_ip' => $this->input->ip_address(),
							'sender_agent' => $this->agent->browser().' '.$this->agent->version(),
							'sender_os' => $this->agent->platform(),
							'slug' => $slug,
							'to' => $send_to->email,
							'ref_id' => $mr->id,
							'purpose' => $purpose->name,
							'title' => $mr->title,
							'date_needed' => $mr->date_needed,
							'total_request' => $total_items,
							'company' => $division_group->division_group_name,
							'requested_by' => $profile_requestor->first_name.' '.$profile_requestor->last_name,
							'status' => $status->desc,
							'message' => $message,
							'view_link' => $link.$mr->id
						),'array');
		}
		catch(Exception $e)
		{
			echo "<script>alert('Please check your internet connection.')</script>";
		}			
			
	}	
	


}
