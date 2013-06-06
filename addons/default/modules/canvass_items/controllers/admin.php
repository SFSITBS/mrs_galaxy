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
			'field' => 'unit_price',
			'label' => 'lang(canvassing:price_label)',
			'rules' => 'trim|required|numeric'
		),
			array(
			'field' => 'supplier',
			'label' => 'lang(canvassing:supplier_label)',
			'rules' => 'required'
		)
		,
			array(
			'field' => 'quantity',
			'label' => 'lang(canvassing:quantity_label)',
			'rules' => 'required|numeric'
		)
	);

	/**
	 * The constructor
	 */
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model(array('canvassing_m','canvassing_nav_m','product_assignment/prod_assign_m','product_assignment/prod_assign_nav_m','audit_trail/audit_trail_m','materialrequest/matreq_m','materialrequest/send_mail_m','divgroups/divgroups_m', 'blog_categories_m','approvediv/approvediv_m','users/user_m','users/profile_m','items/item_m'));
		$this->lang->load('canvassing');
		
		$this->load->library(array('form_validation','session'));
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
		$is_purchasing = $this->canvassing_m->is_purchasing($user_id);
	
		$this->pyrocache->delete_all('modules_m');
		if($is_purchasing == 0)
		{ 	
			$this->session->set_flashdata('error', lang('cannvassing:user_no_purchaser'));
			redirect('admin');
		}
		else
		{
		
			// Create pagination links
			$total_rows = $this->canvassing_m->count_all();  // count_all() directly count rows of db declared in model
			$pagination = create_pagination('admin/canvass_items/index', $total_rows, NULL, 4);
				
			//set the base/default where clause
			$base_where = array('show_future' => TRUE);
			if ($this->input->post('f_division_group')) 	$base_where['division_group'] = $this->input->post('f_division_group');
			if ($this->input->post('f_keywords')) 			$base_where['keywords'] = $this->input->post('f_keywords');
				
			$purchasing_request_items = $this->canvassing_m->limit($pagination['limit'])->get_many_by($base_where);
		}
		
		//do we need to unset the layout because the request is ajax?
		 $this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
			
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters')
			->set('purchase_request_items', $purchasing_request_items)
			->set('pagination', $pagination);
		
		$this->input->is_ajax_request()
			? $this->template->build('admin/canvass_items/index')
			: $this->template->build('admin/index');

		
	}
	
	
	public function set($itemid)
	{
		($itemid) or redirect ('admin/canvass_items/index');
		
		$this->session->set_userdata('pri_id',$itemid);
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
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
		//get company
		$company = $this->prod_assign_m->get_company(array('id' => $division_group->company));
		//get item description
		$item =  $this->prod_assign_nav_m->get(array('No_'=>$pr_item->item_code),$company->company_name);
		//get suppler
		$supplier =  $this->canvassing_nav_m->get_all_supplier($company->company_name);
		
		$canvassed_items = $this->canvassing_m->get_canvassed_items(array('pr_item_id' => $itemid));
		
		$this->form_validation->set_rules($this->validation_rules);
		
		
		if ($this->form_validation->run())
		{	
			$INPUT = array(
				'pr_item_id' 	=> $itemid,
				'supplier' 		=> $this->input->post('supplier'),
				'unit_price' 		=> $this->input->post('unit_price'),
				'total_price' 		=> ($this->input->post('unit_price')*$this->input->post('quantity')),
				'quantity' 		=> $this->input->post('quantity'),
				'remarks' 		=> $this->input->post('remarks')
		
			);			
			$is_existing = $this->canvassing_m->get_where_canvassed_items(array('pr_item_id'=>$itemid,'supplier'=>$this->input->post('supplier')));
			if($is_existing)
			{	$this->session->set_flashdata('error', lang('canvassing:canvass_exist_label'));}
			else 
			{ $this->canvassing_m->insert($INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('canvassing:canvass_success_label'))) 
				: $this->session->set_flashdata('error', lang('canvassing:canvass_error_label'));
			}
		
			
			redirect('admin/canvass_items/set/'.$itemid);
		}
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->set_partial('purchasers', 'admin/partials/purchasers')
			->set('pr_item',$pr_item)
			->set('relative_pr',$relative_pr)
			->set('mr',$mr)
			->set('requestor',$requestor)
			->set('supplier',$supplier)
			->set('canvassed_items',$canvassed_items)
			->set('division_group',$division_group)
			->set('company',$company)
			->set('item',$item)
			->build('admin/canvass_items/set');
	}
	
	public function delete($id)
	{
		$id  or redirect('admin/canvass_items/index');
		
		$this->canvassing_m->delete_entry($id);

		redirect('admin/canvass_items/set/'.$this->session->userdata('pri_id'));
	}
	


	
	

	
}
