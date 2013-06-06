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
			'label' => 'lang:cat_assign:assign_to_label',
			'rules' => 'trim|required|'
		)
	);

	/**
	 * The constructor
	 */
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model(array('cat_assign_m','cat_assign_nav_m','product_assignment/prod_assign_m','product_assignment/prod_assign_nav_m','audit_trail/audit_trail_m','materialrequest/matreq_m','materialrequest/send_mail_m','divgroups/divgroups_m','category_m', 'blog_categories_m','approvediv/approvediv_m','users/user_m','users/profile_m','items/item_m'));
		$this->lang->load('cat_assign');
		$this->load->library(array('form_validation'));
		
		$this->form_validation->set_rules($this->validation_rules);		
		
		$categories = $this->prod_assign_nav_m->get_all_categories();
	
		$this->template->set('_categories', $categories);
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
			$this->session->set_flashdata('error', lang('cat_assign:user_no_purchaser'));
			redirect('admin');
		}
		else
		{
		
		// Create pagination links
		$total_rows = $this->category_m->count_all();  // count_all() directly count rows of db declared in model
		$pagination = create_pagination('admin/prod_assign/index', $total_rows, NULL, 4);
				
		//assign category tab		
		$_categories = $this->cat_assign_nav_m->get_all_categories();		
		$purchasing_off = $this->prod_assign_m->get_all_purchasing_officer(); //get purchasing staffs
		
		//set the base/default where clause			
		$assigned_category = $this->cat_assign_m->get_all();
		$base_where = array('show_future' => TRUE);
		if ($this->input->post('f_category')) 			{$base_where['category'] = $this->input->post('f_category');}
		if ($this->input->post('f_purchasing_staff')) 	{$base_where['purchaser'] = $this->input->post('f_purchasing_staff');}
	
		$assigned_category = $this->cat_assign_m->limit($pagination['limit'])->get_many_by($base_where);
		}
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters')
			->set('_categories', $_categories)
			->set('purchasing_officer', $purchasing_off)
			->set('assigned_category', $assigned_category)
			->set('pagination', $pagination);
		
		$this->input->is_ajax_request()
			? $this->template->build('admin/cat_assign/index')
			: $this->template->build('admin/index');

		
	}
	
	public function assign()
	{
		// make sure the user accessing this module is a Division Group Approver
		$user_id = $this->current_user->id;
		$is_purchasing = $this->prod_assign_m->is_purchasing($user_id);
	
		$this->pyrocache->delete_all('modules_m');
		if($is_purchasing == 0)
		{ 	
			$this->session->set_flashdata('error', lang('cat_assign:user_no_purchaser'));
			redirect('admin');
		}
		else
		{
		
			// Create pagination links
			$total_rows = $this->category_m->count_all();  // count_all() directly count rows of db declared in model
			$pagination = create_pagination('admin/prod_assign/index', $total_rows, NULL, 4);
					
			//load options		
			$_categories = $this->cat_assign_nav_m->get_all_categories();		
			$purchasing_off = $this->prod_assign_m->get_all_purchasing_officer(); //get purchasing staffs			
			
			$this->form_validation->set_rules($this->validation_rules);		
			
			if ($this->form_validation->run())
			{	
				$INPUT = array(
					'purchaser_id' 		=> $this->input->post('purchasing_staff'),
					'category_code' 	=> $this->input->post('category')
			
				);				
				
				$isexisting = $this->cat_assign_m->get(array('purchaser_id'=>$this->input->post('purchasing_staff'),'category_code' => $this->input->post('category')));
				if($isexisting)
				{	$this->session->set_flashdata('error', lang('cat_assign:assign_exists_label'));	}
				
				else
				{	$profile = $this->profile_m->get_profile(array('user_id'=>$this->input->post('purchasing_staff')));
					$code_desc =  $this->cat_assign_nav_m->get_itemcategory_params(array('Code'=>$this->input->post('category')));
					$this->cat_assign_m->insert($INPUT)
						? $this->session->set_flashdata('success', sprintf( lang('cat_assign:assign_success_label'), $code_desc->Description,$profile->first_name.' '.$profile->last_name)) 
						: $this->session->set_flashdata('error', lang('cat_assign:assign_error_label'));	
				}
				redirect('admin/category_assignment');
			}
		}
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->set('_categories', $_categories)
			->set('purchasing_officer', $purchasing_off)
			->set('pagination', $pagination)
			->build('admin/cat_assign/assign_category');

	
	}
	
	public function delete($id)
	{
		$id  or redirect('admin/category_assignment');
		
		$this->cat_assign_m->delete($id);

		redirect('admin/category_assignment');
	}
	
	// public function new_assignment()
	// {
		// $data=array();
		// $code= $this->input->post('category');
		// $purchasing_staff = (!$this->input->post('purchasing_staff')) ? 1 : !$this->input->post('purchasing_staff') ;
		
		// if(!$code)
		// {
			// $this->session->set_flashdata('error', lang('matreq:error_adding_item'));
		// }
		// else
		// {	if(!$this->assign_category->add_item($code,$purchasing_staff))
			// {
					// $this->session->set_flashdata('error', lang('cat_assign:assign_error'));
			// }
				
				
		// }
		
		// $this->_reload($data);
	// }

	
	// public function _reload($data=array())
	// {		
					
		// // Create pagination links
		// $total_rows = $this->category_m->count_all();  // count_all() directly count rows of db declared in model
		// $pagination = create_pagination('admin/prod_assign/index', $total_rows, NULL, 4);
			
		// // assign item tab
		// $accounting_categories = $this->category_m->get_accounting_categories();	
		// $itemcode= $this->prod_assign_nav_m->get_descriptions(array('LOWER(Description)'=>strtolower($this->input->post('f_keywords'))));
		
		// //assign category tab		
		// $_categories = $this->prod_assign_nav_m->get_all_categories();		
		// $purchasing_off = $this->prod_assign_m->get_all_purchasing_officer(); //get purchasing staffs
		// $assigned_category = $this->prod_assign_m->get_category_assignment(''); //get purchasing staffs
		
		// //fetch assignment from database
		// foreach($assigned_category as $asc)
		// {
			// $this->assign_category->add_item($asc->category_code,$asc->purchaser_id);
		// }	
			
		// //set the base/default where clause
		// $base_where = array('show_future' => TRUE);
		// if ($this->input->post('f_division_group')) 	$base_where['division_group'] = $this->input->post('f_division_group');
		// if ($this->input->post('f_keywords')) 			$base_where['keywords'] = $this->input->post('f_keywords');
		// if ($this->input->post('f_unassigned')) 		$base_where['assigned'] = $this->input->post('f_unassigned');	
		// if ($this->input->post('f_category')) 			{$base_where['category'] = $this->input->post('f_category');}			
		
		
		// $purchasing_request_items = $this->prod_assign_m->limit($pagination['limit'])->get_many_by($base_where);
		// $mr_status = $this->matreq_m->get_statuses();
		// $users = $this->user_m->get_all();
		
		// $data['cart']=$this->assign_category->get_cart();

		
		// //do we need to unset the layout because the request is ajax?
		// $this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
		// $this->template
			// ->title($this->module_details['name'], lang('cat_list_title'))
			// ->append_js('admin/filter.js')
			// ->set_partial('filters', 'admin/partials/filters')
			// ->set('_categories', $_categories)
			// ->set('purchasing_officer', $purchasing_off)
			// ->set('assigned_category', $assigned_category)
			// ->set('users', $users)
			// ->set('purchase_request_items', $purchasing_request_items)
			// ->set('mr_status', $mr_status)
			// ->set('pagination', $pagination)
			// ->set('data', $data)
			// ->set('category_m', $this->category_m);
		
		// $this->input->is_ajax_request()
			// ? $this->template->build('admin/prod_assign/index')
			// : $this->template->build('admin/index');

	
	// }

	
	

	
}
