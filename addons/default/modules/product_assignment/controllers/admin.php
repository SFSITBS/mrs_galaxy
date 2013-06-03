<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 
 * @author 		PyroCMS Dev Team
 * @package 	PyroCMS\Core\Modules\Blog\Controllers
 */
class Admin extends Admin_Controller
{
	/**
	 * The current active section
	 *
	 * @var string
	 */
	protected $section = '';

	/**
	 * Array that contains the validation rules
	 *
	 * @var array
	 */
	 
	//~ CURRENT FIELDS FOR CATEGORY (3): cat_name, description, stocktype, category code
	protected $validation_rules = array(
			array(
			'field' => 'purchasing_staff',
			'label' => 'lang:prod_assign:assign_to_label',
			'rules' => 'trim|required|'
		)
	);

	/**
	 * The constructor
	 */
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model(array('prod_assign_m','prod_assign_nav_m','audit_trail/audit_trail_m','materialrequest/matreq_m','materialrequest/send_mail_m','divgroups/divgroups_m','category_m', 'blog_categories_m','approvediv/approvediv_m','users/user_m','users/profile_m','items/item_m'));
		$this->lang->load('prod_assign');
		
		$this->load->library('form_validation');
		$this->form_validation->set_rules($this->validation_rules);		
		
		$div_groups = $this->divgroups_m->get_all();
	
		$this->template->set('div_groups', $div_groups);
	}

	/**
	 * Index method, lists all categories
	 * 
	 * @return void
	 */
	public function index()
	{
		// make sure the user accessing this module is a Division Group Approver
		$user_id = $this->current_user->id;
		$is_purchasing = $this->prod_assign_m->is_purchasing($user_id);
	
		$this->pyrocache->delete_all('modules_m');
		if($is_purchasing == 0)
		{ 	
			$this->session->set_flashdata('error', lang('prod_assign:user_no_purchaser'));
			redirect('admin');
		}
		else
		{
		
		// Create pagination links
		$total_rows = $this->category_m->count_all();  // count_all() directly count rows of db declared in model
		$pagination = create_pagination('admin/prod_assign/index', $total_rows, NULL, 4);
			
		// Using this data, get the relevant results
		$categories = $this->category_m->limit($pagination['limit'])->get_all(); //get_all() directly get all rows od db declared in model
		$accounting_categories = $this->category_m->get_accounting_categories();	
		
		//set the base/default where clause
		$base_where = array('show_future' => TRUE);
		if ($this->input->post('f_division_group')) 	$base_where['division_group'] = $this->input->post('f_division_group');
		if ($this->input->post('f_keywords')) 	
		{	
			$base_where['keywords'] = $this->input->post('f_keywords');
		}
		if ($this->input->post('f_unassigned')) 	
		{	
			$base_where['assigned'] = $this->input->post('f_unassigned');		
		}
		
		$purchasing_requests = $this->prod_assign_m->limit($pagination['limit'])->get_many_by($base_where);
		$mr_status = $this->matreq_m->get_statuses();
		$users = $this->user_m->get_all();
	
		}
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters')
			->set('categories', $categories)
			->set('accounting_categories', $accounting_categories)
			->set('users', $users)
			->set('purchase_request_items', $purchasing_requests)
			->set('mr_status', $mr_status)
			->set('pagination', $pagination)
			->set('category_m', $this->category_m);
		
		$this->input->is_ajax_request()
			? $this->template->build('admin/prod_assign/index')
			: $this->template->build('admin/index');

		
	}
	
	public function assign_item($itemid)
	{
		($itemid) or redirect ('admin/prod_assign/index');
		
			
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
		//get purchasing staffs
		$purchasing_off = $this->prod_assign_m->get_purchasing_officer();
		//get details of the item
		$pr_item = $this->prod_assign_m->get(array('id'=> $itemid));	
		//get pr details
		$relative_pr = $this->prod_assign_m->get_pr($pr_item->pr_id); 					
		//get mr details of pr
		$mr = $this->matreq_m->get($relative_pr->mr_id);		
		//get requestor of mr 					
		$requestor = $this->profile_m->get_profile(array('user_id'=>$mr->requestor));
		//get division of mr
		$division_group = $this->divgroups_m->get($mr->division_group);	
		//get item description
		$item =  $this->prod_assign_nav_m->get(array('id'=>$pr_item->item_id),$division_group->division_group_name); 
				
		$this->form_validation->set_rules($this->validation_rules);
		
		
		if ($this->form_validation->run())
		{	
			$INPUT = array(
				'canvassed_by' 		=> $this->input->post('purchasing_staff')
		
			);				
			$profile = $this->profile_m->get_profile(array('user_id'=>$this->input->post('purchasing_staff')));
			$this->prod_assign_m->update($itemid, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('prod_assign:assign_success_label'), $item['description'],$profile->first_name.' '.$profile->last_name)) 
				: $this->session->set_flashdata('error', lang('prod_assign:assign_error_label'));
		
			
			redirect('admin/product_assignment');
		}
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->set_partial('purchasers', 'admin/partials/purchasers')
			->set('pr_item',$pr_item)
			->set('purchasing_officer',$purchasing_off)
			->set('relative_pr',$relative_pr)
			->set('mr',$mr)
			->set('requestor',$requestor)
			->set('division_group',$division_group)
			->set('item',$item)
			->build('admin/prod_assign/assign_item');
	}


	
	

	
}
