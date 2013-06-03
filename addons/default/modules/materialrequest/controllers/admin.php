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
	protected $section = 'posts';

	/**
	 * Array that contains the validation rules
	 *
	 * @var array
	 */
	protected $validation_rules =  array(
		//~ 'title' => array(
			//~ 'field' => 'title',
			//~ 'label' => 'lang:global:title',
			//~ 'rules' => 'trim|htmlspecialchars|required|max_length[100]|callback__check_title'
		//~ ),
		//~ 'slug' => array(
			//~ 'field' => 'slug',
			//~ 'label' => 'lang:global:slug',
			//~ 'rules' => 'trim|required|alpha_dot_dash|max_length[100]|callback__check_slug'
		//~ ),
		array(
			'field' => 'title',
			'label' => 'lang:matreq:title_label',
			'rules' => 'trim|htmlspecialchars|required|max_length[50]'
		),
		array(
			'field' => 'narrative',
			'label' => 'lang:matreq:narrative_label',
			'rules' => 'trim|htmlspecialchars|required|max_length[50]'
		),
		array(
			'field' => 'purpose',
			'label' => 'lang:matreq:purpose_label',
			'rules' => 'trim|numeric'
		),
		array(
			'field' => 'date_needed',
			'label' => 'lang:matreq:date_needed_label',
			'rules' => 'trim|required'
		)
	);

	/**
	 * The constructor
	 */
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model(array('matreq_m','matreq_items_m','send_mail_m', 'blog_categories_m','categories/category_m','items/item_m','audit_trail/audit_trail_m','users/profile_m','users/user_m','settings/settings_m'));
		$this->lang->load(array('blog', 'categories','matreq','items/item'));
		$this->load->library('session');
		$this->load->library(array('keywords/keywords', 'form_validation','requests','email'));
		
		// Date ranges for select boxes
		$this->template
			->set('hours', array_combine($hours = range(0, 23), $hours))
			->set('minutes', array_combine($minutes = range(0, 59), $minutes))
		;

		
		$_statuses = $this->matreq_m->get_statuses();
	
		$this->template->set('statuses', $_statuses);
	}

	/**
	 * Show all created blog posts
	 * 
	 * @return void
	 */
	public function index()
	{
		//set the base/default where clause
		$base_where = array('show_future' => TRUE);

		//add post values to base_where if f_module is posted
		if ($this->input->post('f_status') ) 	$base_where['status'] 	= $this->input->post('f_status');
		if ($this->input->post('f_keywords')) 	$base_where['keywords'] = $this->input->post('f_keywords');
		//if ($this->input->post('f_date_submitted')) 	$base_where['date_submitted'] = $this->input->post('f_date_submitted');
		
		$base_where['requestor'] = $this->current_user->id;
		$mr_status = $this->matreq_m->get_statuses();
	
		
		// Create pagination links
		$total_rows = $this->matreq_m->count_by($base_where);
		$pagination = create_pagination('admin/matreq/index', $total_rows);
		
		// Using this data, get the relevant results
		$material_request = $this->matreq_m->limit($pagination['limit'])->get_many_by($base_where);
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		
		$this->template
			->title($this->module_details['name'])
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters')
			->set('pagination', $pagination)
			->set('material_request', $material_request)
			->set('mr_status', $mr_status);

		$this->input->is_ajax_request()
			? $this->template->build('admin/tables/_posts')
			: $this->template->build('admin/index');

	}

	/**
	 * Create new post
	 *
	 * @return void
	 */
	public function create()
	{
		//get requestor's information 
		$requestor_id = $this->current_user->id;
		
		// check if requestor is assigned to any division
		if(!$division = $this->matreq_m->get_requestor_division($requestor_id))
		{	
			$this->session->set_flashdata('error', sprintf($this->lang->line('matreq:invalid_requestor'), $this->input->post('title')));  
			redirect('admin/materialrequest');
		}
		// check if date needed 
		if(!$division = $this->matreq_m->get_requestor_division($requestor_id))
		{	
			$this->session->set_flashdata('error', sprintf($this->lang->line('matreq:invalid_requestor'), $this->input->post('title')));  
			redirect('admin/materialrequest');
		}
		$created_on = now();
		 
		if($this->_check_dateneeded($this->input->post('date_needed')))
		{
			$this->session->set_flashdata('error', sprintf($this->lang->line('matreq:invalid_date_needed'), $this->input->post('title')));  
			redirect('admin/materialrequest/create');
		}
		
		$this->form_validation->set_rules($this->validation_rules);
		
		if ($this->form_validation->run())
		{
			// They are trying to put this live
			//~ if ($this->input->post('status') == 'live')
			//~ {
				//~ role_or_die('blog', 'put_live');
//~ 
                //~ $hash = "";
			//~ }
			//$this->input->post('btnAction') == 'save_exit' ? redirect('admin/blog') : redirect('admin/blog/edit/' . $id);
			//if($this->input->post('btnAction') == 'save_draft'){
			if ($id = $this->matreq_m->insert(array(
				'division'						=> $division->id,
				'division_group'				=> $division->division_group,
				'created'						=> NULL,
				'submitted'						=> NULL,
				'date_needed'					=> $this->input->post('date_needed'),
				'requestor'						=> $this->current_user->id,
				'division_approver'				=> NULL,
				'division_group_approver'		=> NULL,
				'force_approved'				=> NULL,
				'status'						=> 1, // Draft
				'accounting_cat'				=> $this->input->post('purpose'),
				'title'							=> $this->input->post('title'),
				'narrative'						=> $this->input->post('narrative')
			)))
			{
				
				//~ $this->pyrocache->delete_all('blog_m');
				//~ $this->session->set_flashdata('success', sprintf($this->lang->line('blog:post_add_success'), $this->input->post('title')));
				
				// Blog article has been updated, may not be anything to do with publishing though
				//~ Events::trigger('post_created', $id);

				// They are trying to put this live
				//~ if ($this->input->post('status') == 'live')
				//~ {
					//~ // Fire an event, we're posting a new blog!
					//~ Events::trigger('post_published', $id);
				//~ }
			}
			else
			{
				$this->session->set_flashdata('error', lang('matreq:request_add_error'));
			}
			
			$this->session->set_flashdata('success', lang('matreq:request_add_success'));
			
			// Redirect back to the form or main page
			$this->input->post('btnAction') == 'save_draft' ? redirect('admin/materialrequest') : redirect('admin/materialrequest/add_items/' . $id);
		}
		else
		{
			// Go through all the known fields and get the post values
			$matreq = new stdClass;
			foreach ($this->validation_rules as $key => $field)
			{
				$matreq->$field['field'] = set_value($field['field']);
			}
			$matreq->created_on = $created_on;
			// if it's a fresh new article lets show them the advanced editor
			//$post->type or $post->type = 'wysiwyg-advanced';
		}
		$purposes = $this->category_m->get_accounting_categories();	
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		$categories = $this->category_m->get_all();
		$mr = null;
		$this->template
			->title($this->module_details['name'], lang('blog:create_title'))
			->append_metadata($this->load->view('fragments/wysiwyg', $this->data, TRUE))
			->append_js('jquery/jquery.tagsinput.js')
			->append_js('module::blog_form.js')
			->append_css('jquery/jquery.tagsinput.css')
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters_item')
			->set('categories', $categories)
			->set('mr', $mr)
			->set('purposes', $purposes)
			->build('admin/form');
	}

	public function add_items($id=0)
	{
		// is ID specified
		$id OR redirect('admin/materialrequest');
		
		$mr = $this->matreq_m->get($id);
		
		// mr exist?
		$mr OR redirect('admin/materialrequest');
	
		//set new session for cart
		
		// is MR items allowed to be editted
		if($mr->status > 1 && $mr->status != 5 )
		 { 
			 $this->session->set_flashdata('error', lang('matreq:edit_not_allowed_error'));
			 redirect('admin/materialrequest'); 
		 }
		 
		$this->session->set_userdata('mr_id',$id);
		$this->session->unset_userdata('cart');
		
		if($mr->status == 1)
		$this->_reload();
		
		if($mr->status == 5)
		$this->_reload2();
		
	}
	
	
	
	public function add_item_to_mr($id=0, $quantity=0)
	{		
		$this->session->userdata('mr_id') OR redirect('admin/materialrequest');
		
		$data=array();
		$item_id = $id;
		$quantity = (!$this->input->post('quantity')) ? 1 : !$this->input->post('quantity') ;
		
		if(!$item_id)
		{
			$this->session->set_flashdata('error', lang('matreq:error_adding_item'));
		}
		else
		{	if(!$this->requests->add_item($item_id,$quantity))
			{
					$this->session->set_flashdata('error', lang('matreq:error_adding_item'));
			}
				
				
		}
		
		$this->_reload($data);
		
	}
	
	function edit_item($line,$quantity)
	{
		$this->session->userdata('mr_id') OR redirect('admin/materialrequest');
		
		$data= array();
		
		//invalid quantity, set to previous quantity
		if($quantity == 0)		
			$this->session->set_flashdata('error', lang('matreq:error_editing_quantity'));
		else
			$this->requests->edit_item($line,$quantity);		
		
		$this->_reload($data);
	}

	
	public function delete_item($item_number)
	{
		$this->requests->delete_item($item_number);
		$this->_reload();
	}
	
	
	public function _reload($data=array())
	{		
	
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
		$requestor_info = $this->current_user;
		$data['mrid']= $this->session->userdata('mr_id');
		$data['cart']=$this->requests->get_cart();

		
		//set the base/default where clause
		$base_where = array('show_future' => TRUE, 'status' => 'all');

		//add post values to base_where if f_module is posted
		if ($this->input->post('f_category')) 	$base_where['category'] = $this->input->post('f_category');
		//if ($this->input->post('f_status')) 	$base_where['status'] 	= $this->input->post('f_status');
		if ($this->input->post('f_keywords')) 	$base_where['keywords'] = $this->input->post('f_keywords');

		// Create pagination links
		$total_rows = $this->item_m->count_by($base_where);
		$pagination = create_pagination('admin/materialrequest/add_item_to_mr/', $total_rows);

		// Using this data, get the relevant results
		$item = $this->item_m->limit($pagination['limit'])->get_many_by($base_where);
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		$categories = $this->category_m->get_all();		
		$purposes = $this->category_m->get_accounting_categories();
			
		$this->template
			->title($this->module_details['name'])
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters_item')
			->set('pagination', $pagination)
			->set('categories', $categories)
			->set('category_m', $this->category_m)
			->set('data', $data)
			->set('purposes', $purposes)
			->set('mr', $mr)
			->set('items', $item);

		$this->input->is_ajax_request()
			? $this->template->build('admin/tables/posts')
			: $this->template->build('admin/add_items');
	
	}
	
	//NEW FUNCTIONS --------------VEN	
	public function view_mr($id=0)
	{	// is ID specified
		$id OR redirect('admin/materialrequest');
		
		$mr = $this->matreq_m->get($id);
		
		// mr exist?
		$mr OR redirect('admin/materialrequest');
		 
		$this->session->set_userdata('mr_id',$id);
		$this->session->unset_userdata('cart');
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
		$requestor_info = $this->current_user;
		$data['mrid']= $this->session->userdata('mr_id');
		$data['cart']=$this->matreq_m->get_mr_items($this->session->userdata('mr_id'));

		$mr_history = $this->audit_trail_m->get_mr_history($this->session->userdata('mr_id'));				
		
		
		//set the base/default where clause
		$base_where = array('show_future' => TRUE, 'status' => 'all');

		//add post values to base_where if f_module is posted
		if ($this->input->post('f_category')) 	$base_where['category'] = $this->input->post('f_category');
		//if ($this->input->post('f_status')) 	$base_where['status'] 	= $this->input->post('f_status');
		if ($this->input->post('f_keywords')) 	$base_where['keywords'] = $this->input->post('f_keywords');

		// Create pagination links
		$total_rows = $this->item_m->count_by($base_where);
		$pagination = create_pagination('admin/materialrequest/add_item_to_mr/', $total_rows);

		// Using this data, get the relevant results
		$item = $this->item_m->limit($pagination['limit'])->get_many_by($base_where);
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		$categories = $this->category_m->get_all();		
		$purposes = $this->category_m->get_accounting_categories();
			
		$this->template
			->title($this->module_details['name'])
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters_item')
			->set('pagination', $pagination)
			->set('categories', $categories)
			->set('category_m', $this->category_m)
			->set('data', $data)
			->set('purposes', $purposes)
			->set('mr', $mr)
			->set('mr_history', $mr_history)
			->set('items', $item);

		$this->input->is_ajax_request()
			? $this->template->build('admin/tables/posts')
			: $this->template->build('admin/view_mr');

	}
	public function edit_mr_details($mr_id=0)
	{
		$mr_id or redirect('admin/materialrequest');
		
		//get requestor's information 
		$requestor_id = $this->current_user->id;
		
		// check if requestor is assigned to any division
		if(!$division = $this->matreq_m->get_requestor_division($requestor_id))
		{	
			$this->session->set_flashdata('error', sprintf($this->lang->line('matreq:invalid_requestor'), $this->input->post('title')));  
			redirect('admin/materialrequest');
		}
			
		$this->form_validation->set_rules($this->validation_rules);
		
		if ($this->form_validation->run())
		{	
			$mr = $this->matreq_m->get($mr_id);
		
			 if($mr->status == 1 || $mr->status == 5)
			$INPUT = array(
				'status' 			=> $mr->status,
				'date_needed'					=> $this->input->post('date_needed'),
				'requestor'						=> $this->current_user->id,
				'accounting_cat'				=> $this->input->post('purpose'),
				'title'							=> $this->input->post('title'),
				'narrative'						=> $this->input->post('narrative')
		
			);				
			
			$this->matreq_m->update($mr_id, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('category:cat_edit_success'), $this->input->post('cat_name')) )
				: $this->session->set_flashdata('error', lang('cat_edit_error'));

			{
				
				//~ $this->pyrocache->delete_all('blog_m');
				//~ $this->session->set_flashdata('success', sprintf($this->lang->line('blog:post_add_success'), $this->input->post('title')));
				
				// Blog article has been updated, may not be anything to do with publishing though
				//~ Events::trigger('post_created', $id);

				// They are trying to put this live
				//~ if ($this->input->post('status') == 'live')
				//~ {
					//~ // Fire an event, we're posting a new blog!
					//~ Events::trigger('post_published', $id);
				//~ }
			}
			
			
			$this->session->set_flashdata('success', lang('matreq:request_add_success'));
			
			// Redirect back to the form or main page
			$this->input->post('btnAction') == 'save_draft' ? redirect('admin/materialrequest') : redirect('admin/materialrequest/add_items/' . $mr_id);
		}
		else
		{
			// Go through all the known fields and get the post values
			$matreq = new stdClass;
			foreach ($this->validation_rules as $key => $field)
			{
				$matreq->$field['field'] = set_value($field['field']);
			}
					// if it's a fresh new article lets show them the advanced editor
			//$post->type or $post->type = 'wysiwyg-advanced';
		}
		
		
		$purposes = $this->category_m->get_accounting_categories();	
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		$categories = $this->category_m->get_all();
		$mr = $this->matreq_m->get($mr_id);
			
		
		$this->template
			->title($this->module_details['name'], lang('blog:create_title'))
			->append_metadata($this->load->view('fragments/wysiwyg', $this->data, TRUE))
			->append_js('jquery/jquery.tagsinput.js')
			->append_js('module::blog_form.js')
			->append_css('jquery/jquery.tagsinput.css')
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters_item')
			->set('categories', $categories)
			->set('mr', $mr)
			->set('purposes', $purposes)
			->build('admin/form');
	}
	
	public function _reload2($data=array())
	{		
		
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
		$requestor_info = $this->current_user;
		$data['mrid']= $this->session->userdata('mr_id');
		
		//fetch mr items from database
		$mr_items = $this->matreq_m->get_mr_items($this->session->userdata('mr_id'));
		foreach($mr_items as $mri)
		{
			$this->requests->add_item($mri->item_code,$mri->quantity);
		}
		
		//set fetch items to cart session
		$data['cart']=$this->requests->get_cart();
		
		
		//set the base/default where clause
		$base_where = array('show_future' => TRUE, 'status' => 'all');

		//add post values to base_where if f_module is posted
		if ($this->input->post('f_category')) 	$base_where['category'] = $this->input->post('f_category');
		//if ($this->input->post('f_status')) 	$base_where['status'] 	= $this->input->post('f_status');
		if ($this->input->post('f_keywords')) 	$base_where['keywords'] = $this->input->post('f_keywords');

		// Create pagination links
		$total_rows = $this->item_m->count_by($base_where);
		$pagination = create_pagination('admin/materialrequest/add_item_to_mr/', $total_rows);

		// Using this data, get the relevant results
		$item = $this->item_m->limit($pagination['limit'])->get_many_by($base_where);
		
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
		$categories = $this->category_m->get_all();		
		$purposes = $this->category_m->get_accounting_categories();
			
		$this->template
			->title($this->module_details['name'])
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters_item')
			->set('pagination', $pagination)
			->set('categories', $categories)
			->set('category_m', $this->category_m)
			->set('data', $data)
			->set('purposes', $purposes)
			->set('mr', $mr)
			->set('items', $item);

		$this->input->is_ajax_request()
			? $this->template->build('admin/tables/posts')
			: $this->template->build('admin/add_items');
	
	}
				
	
	function submit_requisition($mr_id)
	{			
		$mr_id OR redirect('admin/materialrequest');
		
		// Get the unit			
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
	
		// ID specified?
		$mr or redirect('admin/blog/materialrequest/index');

		//get items
		$items = $this->session->userdata('cart');
			
		//mr has session items?
		$items or redirect('admin/materialrequest/add_items/'.$mr_id);
		
		//fetch from db mr items
		$db_mr_items = $this->matreq_items_m->get($mr_id);
						
		
		if($mr->status == 1 || $mr->status == 5)
		{
			//delete mr items
			$this->matreq_items_m->delete_items($mr_id);
			
			//insert items to database
			for($ctr=1;$ctr<=count($items);$ctr++)
			{				
				if ($id = $this->matreq_items_m->insert(array(
					'mr_id'					=> $mr_id,
					'item_code'				=>  $items[$ctr]['item_id'],
					'quantity'				=>  $items[$ctr]['quantity'],
					'quantity_issued'		=>  null,
					'completed'				=> null
				)))
				{}	
			
			}
		
			//update status only of mr			
			// if($mr->status == 1)
			$INPUT = array(
				'status' 			=> 2
			);
			$audit_trail   = array(
					'relative_id'			=> $mr_id,
					'action'		=> 1,
					'created'	=> null,
					'user_id' 		=> $this->current_user->id,
					'remarks' => ''
			);			
			
			$this->matreq_m->update($mr_id, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('matreq:submit_success'), 'Your requisition') )
				: $this->session->set_flashdata('error', lang('matreq:submit_error'));

			
			$this->audit_trail_m->insert_to_history($audit_trail);	
			
			//*************************
			//*SEND email notification
			//***********************	
			//REQUISITIONERS
			$this->send_mail($mr,'submitted_for_approval',$this->current_user,'admin/materialrequest/view_mr/','You have submitted this requisition for your division approval.');
			
			//get approvers
			$division = $this->matreq_m->get_requestor_division($this->current_user->id);
			$approver1 = $this->user_m->get_where(array('id' =>$division->approver));
			$approver_proxy = $this->user_m->get_where(array('id' =>$division->approver_proxy));
			
			//send to APPROVER and proxy
			!$approver1 or $this->send_mail($mr,'pending_for_approval',$approver1,'admin/approvediv/view_mr/',"This requisition is pending for your approval.");
			!$approver_proxy or $this->send_mail($mr,'pending_for_approval',$approver_proxy,'admin/approvediv/view_mr/',"This requisition is pending for your approval.");
			
			//*****************
			//******END SEND
			//**************
		}
		$this->session->unset_userdata('mr_id');
		redirect('admin/materialrequest');
	}
	
	
	public function send_mail($mr,$slug,$send_to,$link,$message)
	{
			//if send mail is allowed amd has email
			if($send_to->email && $send_to->allow_notification)
			{
				$this->send_mail_m->send_mail($slug,$send_to,$mr,$link,$message);								
			}	
	}
	
	
	public function _check_dateneeded($date)
	{
		//within 5 days validation
		//$this->form_validation->set_message('_check_dateneeded', sprintf(lang('matreq:invalid_date_needed'), lang('global:title')));
		// if($date < date('Y-m-d', strtotime('+5 days')) && $date != null)
		// {
			// return true;
		// }
		$this->form_validation->set_message('_check_dateneeded', sprintf(lang('matreq:invalid_date_needed'), lang('global:title')));
		if($date < date('Y-m-d', strtotime('+1 days')) && $date != null)
		{
			return true;
		}
	}
	// END VEN
	
	/**
	 * Edit blog post
	 *
	 * 
	 * @param int $id the ID of the blog post to edit
	 * @return void
	 */
	public function edit($id = 0)
	{
		$id OR redirect('admin/blog');

		$post = $this->blog_m->get($id);

		// If we have keywords before the update, we'll want to remove them from keywords_applied
		$old_keywords_hash = (trim($post->keywords) != '') ? $post->keywords : null;

		$post->keywords = Keywords::get_string($post->keywords);

		// If we have a useful date, use it
		if ($this->input->post('created_on'))
		{
			$created_on = strtotime(sprintf('%s %s:%s', $this->input->post('created_on'), $this->input->post('created_on_hour'), $this->input->post('created_on_minute')));
		}

		else
		{
			$created_on = $post->created_on;
		}
		
		$this->form_validation->set_rules(array_merge($this->validation_rules, array(
			'title' => array(
				'field' => 'title',
				'label' => 'lang:global:title',
				'rules' => 'trim|htmlspecialchars|required|max_length[100]|callback__check_title['.$id.']'
			),
			'slug' => array(
				'field' => 'slug',
				'label' => 'lang:global:slug',
				'rules' => 'trim|required|alpha_dot_dash|max_length[100]|callback__check_slug['.$id.']'
			),
		)));
        $hash = $this->input->post('preview_hash');

        if ($this->input->post('status') == 'draft' and $this->input->post('preview_hash') == '')
        {

            $hash = $this->_preview_hash();
        }
		
		if ($this->form_validation->run())
		{
			// They are trying to put this live
			if ($post->status != 'live' and $this->input->post('status') == 'live')
			{
				role_or_die('blog', 'put_live');
			}

			$author_id = empty($post->display_name) ? $this->current_user->id : $post->author_id;

			$result = $this->blog_m->update($id, array(
				'title'				=> $this->input->post('title'),
				'slug'				=> $this->input->post('slug'),
				'category_id'		=> $this->input->post('category_id'),
				'keywords'			=> Keywords::process($this->input->post('keywords'), $old_keywords_hash),
				'intro'				=> $this->input->post('intro'),
				'body'				=> $this->input->post('body'),
				'status'			=> $this->input->post('status'),
				'created_on'		=> $created_on,
				'comments_enabled'	=> $this->input->post('comments_enabled'),
				'author_id'			=> $author_id,
				'type'				=> $this->input->post('type'),
				'parsed'			=> ($this->input->post('type') == 'markdown') ? parse_markdown($this->input->post('body')) : '',
                'preview_hash'      => $hash,
			));
			
			if ($result)
			{
				$this->session->set_flashdata(array('success' => sprintf(lang('blog:edit_success'), $this->input->post('title'))));

				// Blog article has been updated, may not be anything to do with publishing though
				Events::trigger('post_updated', $id);

				// They are trying to put this live
				if ($post->status != 'live' and $this->input->post('status') == 'live')
				{
					// Fire an event, we're posting a new blog!
					Events::trigger('post_published', $id);
				}
			}
			
			else
			{
				$this->session->set_flashdata('error', lang('blog:edit_error'));
			}

			// Redirect back to the form or main page
			$this->input->post('btnAction') == 'save_exit' ? redirect('admin/blog') : redirect('admin/blog/edit/' . $id);
		}

		// Go through all the known fields and get the post values
		foreach ($this->validation_rules as $key => $field)
		{
			if (isset($_POST[$field['field']]))
			{
				$post->$field['field'] = set_value($field['field']);
			}
		}

		$post->created_on = $created_on;
		
		$this->template
			->title($this->module_details['name'], sprintf(lang('blog:edit_title'), $post->title))
			->append_metadata($this->load->view('fragments/wysiwyg', array(), TRUE))
			->append_js('jquery/jquery.tagsinput.js')
			->append_js('module::blog_form.js')
			->append_css('jquery/jquery.tagsinput.css')
			->set('post', $post)
			->build('admin/form');
	}

	/**
	 * Preview blog post
	 * 
	 * @param int $id the ID of the blog post to preview
	 * @return void
	 */
	public function preview($id = 0)
	{
		$post = $this->blog_m->get($id);

		$this->template
				->set_layout('modal', 'admin')
				->set('post', $post)
				->build('admin/preview');
	}

	/**
	 * Helper method to determine what to do with selected items from form post
	 * 
	 * @return void
	 */
	public function action()
	{
		switch ($this->input->post('btnAction'))
		{
			case 'publish':
				$this->publish();
			break;
			
			case 'delete':
				$this->delete();
			break;
			
			default:
				redirect('admin/blog');
			break;
		}
	}

	/**
	 * Publish blog post
	 * 
	 * @param int $id the ID of the blog post to make public
	 * @return void
	 */
	public function publish($id = 0)
	{
		role_or_die('blog', 'put_live');

		// Publish one
		$ids = ($id) ? array($id) : $this->input->post('action_to');

		if ( ! empty($ids))
		{
			// Go through the array of slugs to publish
			$post_titles = array();
			foreach ($ids as $id)
			{
				// Get the current page so we can grab the id too
				if ($post = $this->blog_m->get($id))
				{
					$this->blog_m->publish($id);

					// Wipe cache for this model, the content has changed
					$this->pyrocache->delete('blog_m');
					$post_titles[] = $post->title;
				}
			}
		}

		// Some posts have been published
		if ( ! empty($post_titles))
		{
			// Only publishing one post
			if (count($post_titles) == 1)
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('blog:publish_success'), $post_titles[0]));
			}
			// Publishing multiple posts
			else
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('blog:mass_publish_success'), implode('", "', $post_titles)));
			}
		}
		// For some reason, none of them were published
		else
		{
			$this->session->set_flashdata('notice', $this->lang->line('blog:publish_error'));
		}

		redirect('admin/blog');
	}

	/**
	 * Delete blog post
	 * 
	 * @param int $id the ID of the blog post to delete
	 * @return void
	 */
	public function delete($id = 0)
	{
		$this->load->model('comments/comments_m');

		role_or_die('blog', 'delete_live');

		// Delete one
		$ids = ($id) ? array($id) : $this->input->post('action_to');

		// Go through the array of slugs to delete
		if ( ! empty($ids))
		{
			$post_titles = array();
			$deleted_ids = array();
			foreach ($ids as $id)
			{
				// Get the current page so we can grab the id too
				if ($post = $this->blog_m->get($id))
				{
					if ($this->blog_m->delete($id))
					{
						$this->comments_m->where('module', 'blog')->delete_by('module_id', $id);

						// Wipe cache for this model, the content has changed
						$this->pyrocache->delete('blog_m');
						$post_titles[] = $post->title;
						$deleted_ids[] = $id;
					}
				}
			}
			
			// Fire an event. We've deleted one or more blog posts.
			Events::trigger('post_deleted', $deleted_ids);
		}

		// Some pages have been deleted
		if ( ! empty($post_titles))
		{
			// Only deleting one page
			if (count($post_titles) == 1)
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('blog:delete_success'), $post_titles[0]));
			}
			// Deleting multiple pages
			else
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('blog:mass_delete_success'), implode('", "', $post_titles)));
			}
		}
		// For some reason, none of them were deleted
		else
		{
			$this->session->set_flashdata('notice', lang('blog:delete_error'));
		}

		redirect('admin/blog');
	}

	/**
	 * Callback method that checks the title of an post
	 * 
	 * @param string title The Title to check
	 * @return bool
	 */
	public function _check_title($title, $id = null)
	{
		$this->form_validation->set_message('_check_title', sprintf(lang('blog:already_exist_error'), lang('global:title')));
		return $this->blog_m->check_exists('title', $title, $id);			
	}
	
	/**
	 * Callback method that checks the slug of an post
	 * 
	 * @param string slug The Slug to check
	 * @return bool
	 */
	public function _check_slug($slug, $id = null)
	{
		$this->form_validation->set_message('_check_slug', sprintf(lang('blog:already_exist_error'), lang('global:slug')));
		return $this->blog_m->check_exists('slug', $slug, $id);
	}

    private function _preview_hash()
    {

        return md5(microtime() + mt_rand(0,1000));

    }
}
