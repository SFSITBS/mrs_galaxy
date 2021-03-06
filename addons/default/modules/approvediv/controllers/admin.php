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
			'field' => 'cat_name',
			'label' => 'lang:category:cat_name_label',
			'rules' => 'trim|required|htmlspecialchars|max_length[50]'
		),
		array(
			'field' => 'description',
			'label' => 'lang:category:cat_desc_label',
			'rules' => 'trim|required|htmlspecialchars|max_length[100]'
			//~ 'rules' => 'trim|required|alpha_dot_dash|max_length[100]|callback__check_slug'
		),
		array(
			'field' => 'is_stocking',
			'label' => 'lang:category:cat_stock_type_label',
			'rules' => 'trim|htmlspecialchars'
		),
		array(
			'field' => 'category_code',
			'label' => 'lang:category:cat_code_label',
			'rules' => 'trim|required|alpha|max_length[6]|min_length[3]'
		)
	);

	/**
	 * The constructor
	 */
	public function __construct()
	{
		parent::__construct();
		
		$this->load->model(array('approvediv_m','audit_trail/audit_trail_m','materialrequest/matreq_m','materialrequest/send_mail_m','category_m', 'blog_categories_m','approvediv_m','users/user_m','users/profile_m','items/item_m'));
		$this->lang->load('approvediv');
		
		$this->load->library('form_validation');
		$this->form_validation->set_rules($this->validation_rules);
		$_statuses = $this->matreq_m->get_statuses();
	
		$this->template->set('statuses', $_statuses);

	}

	/**
	 * Index method, lists all categories
	 * 
	 * @return void
	 */
	public function index()
	{
		// make sure the user accessing this module is a Division Approver
		$user_id = $this->current_user->id;
		$is_approver = $this->approvediv_m->is_division_approver($user_id);
		
				
		$this->pyrocache->delete_all('modules_m');
		if($is_approver == 0)
		{ 	
			$this->session->set_flashdata('error', lang('approvediv:user_no_approver'));
			redirect('admin');
		}
		else
		{
			$users_division = $this->approvediv_m->get_approver_division($user_id);	
		
			if(!$users_division)
			{ 	
				$this->session->set_flashdata('error', lang('approvediv:user_no_approver'));
				redirect('admin');
			} 
			//set the base/default where clause
			$base_where = array('show_future' => TRUE);
			
			//add post values to base_where if f_module is posted
			if ($this->input->post('f_status') ) 	$base_where['status'] 	= $this->input->post('f_status');
			if ($this->input->post('f_keywords')) 	$base_where['keywords'] = $this->input->post('f_keywords');
			if ($this->input->post('f_for_approval')) 	$base_where['for_approval'] = $this->input->post('f_for_approval');
			
			$base_where['division'] = $users_division->id;
			$base_where['for_approval'] = 0;
			
			// Create pagination links
			$total_rows = $this->approvediv_m->count_by_division($users_division->id);  // count_all() directly count rows of db declared in model
			$pagination = create_pagination('admin/approvediv/index', $total_rows, NULL, 4);
				
			// Using this data, get the relevant results		
			$division_requests = $this->approvediv_m->limit($pagination['limit'])->get_all(); //get_all() directly get all rows od db declared in model
			$accounting_categories = $this->category_m->get_accounting_categories();
			$categories = $this->category_m->get_accounting_categories();
		
			//$material_requests = $this->approvediv_m->get_divapproval($users_division->id);
			$material_requests = $this->approvediv_m->limit($pagination['limit'])->get_many_by($base_where);
	
			$mr_status = $this->matreq_m->get_statuses();
			$users = $this->user_m->get_all();
 
		}
		//do we need to unset the layout because the request is ajax?
		$this->input->is_ajax_request() and $this->template->set_layout(FALSE);		
		
		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))	
			->append_js('admin/filter.js')
			->set_partial('filters', 'admin/partials/filters')
			->set('material_requests', $material_requests)
			->set('mr_status', $mr_status)
			->set('categories', $categories)
			->set('users', $users)
			->set('accounting_categories', $accounting_categories)
			->set('pagination', $pagination)
			->set('category_m', $this->category_m);
			
		$this->input->is_ajax_request()
			? $this->template->build('admin/approvediv/index')
			: $this->template->build('admin/index');

		
	}

	//new functions VENNN
	public function view_mr($id=0)
	{	
		$is_approver = $this->approvediv_m->is_division_approver($this->current_user->id);
		
		$this->pyrocache->delete_all('modules_m');
		if($is_approver == 0)
		{ 	
			$this->session->set_flashdata('error', lang('approvediv:user_no_approver'));
			redirect('admin');
		}
		else
		{
			// is ID specified
			$id OR redirect('admin/approvediv');
			
			$mr = $this->matreq_m->get($id);
			// mr exist?
			$mr OR redirect('admin/approvediv');
			
					 
			$this->session->set_userdata('mr_id',$id);
			$this->session->unset_userdata('cart');
			$mr = $this->matreq_m->get($id);
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
			$total_rows = $this->matreq_m->count_by($base_where);
			$pagination = create_pagination('admin/materialrequest/add_item_to_mr/', $total_rows);

			// Using this data, get the relevant results
			$item = $this->matreq_m->limit($pagination['limit'])->get_many_by($base_where);
			
			//do we need to unset the layout because the request is ajax?
			$this->input->is_ajax_request() and $this->template->set_layout(FALSE);
			$categories = $this->category_m->get_all();		
			$purposes = $this->category_m->get_accounting_categories();
				
			$this->template
				->title($this->module_details['name'])
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

	}
	
	function require_changes($mr_id)
	{			
		$mr_id OR redirect('admin/approvediv');
		
		// Get the unit			
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
	
		// ID specified?
		$mr or redirect('admin/blog/approvediv/index');
		
		//if mr is for division approval or on hold
		if($mr->status == 2 || $mr->status == 6)
		{			
			$INPUT = array(
				'status' 			=> 5,
				'division_approver' => $this->current_user->id,
				'remarks'			=> $this->input->post('remarks')
			);
			
			$audit_trail   = array(
					'relative_id'			=> $mr_id,
					'action'		=> 3,
					'created'	=> null,
					'user_id' 		=> $this->current_user->id,
					'remarks' => $this->input->post('remarks')
			);		
				
			
			$this->approvediv_m->update($mr_id, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('approvediv:edit_success'), $mr->title) )
				: $this->session->set_flashdata('error', lang('approvediv:edit_error'));

			$this->audit_trail_m->insert_to_history($audit_trail);

			//*************************
			//*SEND email notification
			//***********************	
				
			//get details of requisitioner and approvers				
			$division = $this->matreq_m->get_requestor_division($mr->requestor);
			$division_group = $this->matreq_m->get_group_approvers($division->division_group);
			
			$requisitioner =  $this->user_m->get_where(array('id' =>$mr->requestor));			
			$approver = $this->user_m->get_where(array('id' =>$division->approver));
			$approver_proxy = $this->user_m->get_where(array('id' =>$division->approver_proxy));
			$group_approver = $this->user_m->get_where(array('id' =>$division_group->approver));
			$group_approver_proxy = $this->user_m->get_where(array('id' =>$division_group->approver_proxy));
			
			
			//send to REQUISITIONERS
			$this->send_mail($mr,'require_changes',$requisitioner,'admin/materialrequest/add_items/','Your requisition requires changes. Please review the details.');
		
			//send to APPROVER and proxy
			$message = "This requisition was returned to the requisitioner.";
			$message2 = $message;
			
			if($approver && $approver->id == $this->current_user->id )
			{
				$message = "You have rejected this requisition.".$message;
			}
			if($approver_proxy && $approver_proxy->id == $this->current_user->id )
			{
				$message2 = "You have rejected this requisition.".$message2;
			}				
			
			$this->send_mail($mr,'require_changes',$approver,'admin/approvediv/view_mr/',$message);
			$this->send_mail($mr,'require_changes',$approver_proxy,'admin/approvediv/view_mr/',$message2);
			//*****************
			//******END SEND
			//**************
			
		}		
		redirect('admin/approvediv');
	}
	
	function change_stat($stat)
	{			
		$stat OR redirect('admin/approvediv');
		
		$mr_id = $this->session->userdata('mr_id');
		
		$mr_id OR redirect('admin/approvediv');
		// Get the unit			
		$mr = $this->matreq_m->get($this->session->userdata('mr_id'));
	
		// ID specified?
		$mr or redirect('admin/blog/approvediv/index');
		
		if($mr->status == 2 || $mr->status == 6 )
		{
			if($stat == 'hold')
			{
				$INPUT = array(
				'status' 			=> 6,
				'division_approver' => $this->current_user->id,
				'date_approved' => date("Y-m-d H:i:s")
				);
				
				$audit_trail   = array(
					'relative_id'			=> $mr_id,
					'action'		=> 2,
					'created'	=> null,
					'user_id' 		=> $this->current_user->id,
					'remarks' => ''
				);		
				$new_status = 6;
				$slug = 'on_hold';
				$message_requisitioner = 'Your requisition is currently on hold.';
				$message_approver = 'This requisition is on hold.';
				$message_approver2 = 'This requisition is on hold.';
			}				
			if($stat == 'approve')
			{
				$INPUT = array(
				'status' 			=> 3,
				'division_approver' => $this->current_user->id,
				'date_approved' => date("Y-m-d H:i:s")
				);
				
				$audit_trail   = array(
					'relative_id'			=> $mr_id,
					'action'		=> 4,
					'created'	=> null,
					'user_id' 		=> $this->current_user->id,
					'remarks' => ''
				);		
				$new_status = 3;
				$slug = 'approved';
				$message_requisitioner = 'Your requisition has been approved by your division approver.';
				$message_approver = 'This requisition has been approved';
				$message_approver2 = 'This requisition has been approved';
			}			
		
			$this->approvediv_m->update($mr_id, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('approvediv:edit_success'), $mr->title) )
				: $this->session->set_flashdata('error',lang('approvediv:edit_error'));
			
			
			$this->audit_trail_m->insert_to_history($audit_trail);	
			
			//*************************
			//*SEND email notification
			//***********************	
				
			//get details of requisitioner and approvers				
			$mr->status = $new_status;
			$division = $this->matreq_m->get_requestor_division($mr->requestor);
			$division_group = $this->matreq_m->get_group_approvers($division->division_group);
			
			$requisitioner =  $this->user_m->get_where(array('id' =>$mr->requestor));			
			$approver = $this->user_m->get_where(array('id' =>$division->approver));
			$approver_proxy = $this->user_m->get_where(array('id' =>$division->approver_proxy));
			$group_approver = $this->user_m->get_where(array('id' =>$division_group->approver));
			$group_approver_proxy = $this->user_m->get_where(array('id' =>$division_group->approver_proxy));			
			
			//send to REQUISITIONERS
			$this->send_mail($mr,$slug,$requisitioner,'admin/materialrequest/add_items/',$message_requisitioner);
			
			//send to approver
			if($approver->id == $this->current_user->id && $stat == 'approve')
				$message_approver ='You have approved this requisition.';
			if($approver_proxy->id == $this->current_user->id && $stat == 'approve')
				$message_approver2 ='You have approved this requisition.';
			if($approver->id == $this->current_user->id && $stat == 'hold')
				$message_approver ='You have put this requisition on hold.';
			if($approver_proxy->id == $this->current_user->id && $stat == 'hold' )
				$message_approver2 ='You have put this requisition on hold.';
			!$approver or $this->send_mail($mr,$slug,$approver,'admin/approvediv/view_mr/',$message_approver);
			!$approver_proxy or $this->send_mail($mr,$slug,$approver_proxy,'admin/approvediv/view_mr/',$message_approver2);
			
			//send to next approver if approved by first level
			if($stat == 'approve')
			{
				!$group_approver or $this->send_mail($mr,'pending_for_approval',$group_approver,'admin/approvedivgroup/view_mr/','This requisition is pending for your approval.');
				!$group_approver_proxy or $this->send_mail($mr,'pending_for_approval',$group_approver_proxy,'admin/approvedivgroup/view_mr/','This requisition is pending for your division group approval.');
			}
			//*****************
			//******END SEND
			//**************
		}		
		redirect('admin/approvediv');
	}
		
	public function send_mail($mr,$slug,$send_to,$link,$message)
	{
			//if send mail is allowed amd has email
			if($send_to->email && $send_to->allow_notification)
			{
				$this->send_mail_m->send_mail($slug,$send_to,$mr,$link,$message);								
			}	
	}

	//end VENNN
	
	/**
	 * Create new category
	 *
	 * @return void
	 */
		public function create()
		{
		
		$this->form_validation->set_rules('category_code', 'lang:category:cat_code_label', 'trim|alpha|max_length[6]|min_length[3]|callback__check_code['.$this->input->post('category_code').']');

			
			// Validate the data
		if ($this->form_validation->run())
		{
			if ($id = $this->category_m->insert($_POST))
			{
				
				// Fire an event. A new blog category has been created.
				//	Events::trigger('blog_category_created', $id);

				$this->session->set_flashdata('success', sprintf( lang('category:cat_add_success'), $this->input->post('id')) );
			}
			else
			{
				$this->session->set_flashdata('error', lang('category:cat_add_error'));
			}
			
			redirect('admin/categories');
		}

		$category = new stdClass();
		$accounting_categories = $this->category_m->get_accounting_categories();
				
		// Loop through each validation rule
		foreach ($this->validation_rules as $rule)
		{
			$category->{$rule['field']} = set_value($rule['field']);
		}
		
		$this->template
			->title($this->module_details['name'], lang('cat_create_title'))
			->set('category', $category)
			->set('accounting_categories', $accounting_categories)
			->build('admin/approvediv/form');	
		}
	/**
	 * Edit blog post
	 *
	 * 
	 * @param int $id the ID of the blog post to edit
	 * @return void
	 */
	public function edit($id = 0)
	{
		$id OR redirect('admin/categories');

		// Get the category
		$category = $this->category_m->get($id);
		
		// ID specified?
		$category or redirect('admin/blog/approvediv/index');

		$this->form_validation->set_rules('cat_name', 'lang:category:cat_name_label', 'trim|htmlspecialchars|required|max_length[50]');
	
		// Validate the results
		if ($this->form_validation->run())
		{		
			
			$INPUT = array(
				'description' 			=> $this->input->post('description'),
				'is_stocking' 			=> $this->input->post('is_stocking'),
				'cat_name' 					=> $this->input->post('cat_name')
			);
			
			$this->category_m->update($id, $INPUT)
				? $this->session->set_flashdata('success', sprintf( lang('category:cat_edit_success'), $this->input->post('cat_name')) )
				: $this->session->set_flashdata('error', lang('cat_edit_error'));
			
			// Fire an event. A blog category is being updated.
			Events::trigger('blog_category_updated', $id);
			
			redirect('admin/approvediv/index');
		}
		//~ print_r($this->validation_rules);
		//~ die();
		// Loop through each rule
		foreach ($this->validation_rules as $rule)
		{
			if ($this->input->post($rule['field']) !== FALSE)
			{
				$category->{$rule['field']} = $this->input->post($rule['field']);
			}
		}
		$accounting_categories = $this->category_m->get_accounting_categories();	
		$this->template
			->title($this->module_details['name'], sprintf(lang('cat_edit_title'), $category->id))
			->set('accounting_categories', $accounting_categories)
			->set('category', $category)
			->build('admin/approvediv/form');
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
		//Check if at least 1 item is under this category
		//echo ($this->category_m->check_if_has_items($id)) ? 'di pde' : 'pede';
		//die();
		
		if($this->category_m->check_if_has_items($id))
		{
			$this->session->set_flashdata('error', sprintf(lang('category:cat_delete_error_has_item')));
		}
		else
		{
			if($this->category_m->delete($id))
			{
				$this->session->set_flashdata('success', sprintf(lang('category:cat_delete_success')));
			}
			else
			{
				$this->session->set_flashdata('error', sprintf(lang('category:cat_delete_error')));
			}
		}
			
		
		
		$id_array = (!empty($id)) ? array($id) : $this->input->post('action_to');
		
		// Delete multiple
		//~ if (!empty($id_array))
		//~ {
			//~ $deleted = 0;
			//~ $to_delete = 0;
			//~ $deleted_ids = array();
			//~ foreach ($id_array as $id)
			//~ {
				//~ if ($this->category_m-88>delete($id))
				//~ {
					//~ $deleted++;
					//~ $deleted_ids[] = $id;
				//~ }
				//~ else
				//~ {
					//~ $this->session->set_flashdata('error', sprintf(lang('category:cat_mass_delete_error'), $id));
				//~ }
				//~ $to_delete++;
			//~ }
			//~ 
			//~ if ( $deleted > 0 )
			//~ {
				//~ $this->session->set_flashdata('success', sprintf(lang('category:cat_mass_delete_success'), $deleted, $to_delete));
			//~ }
			//~ 
			//~ // Fire an event. One or more categories have been deleted.
			//~ Events::trigger('blog_category_deleted', $deleted_ids);
		//~ }		
		//~ else
		//~ {
			//~ $this->session->set_flashdata('error', lang('cat_no_select_error'));
		//~ }
		
		redirect('admin/approvediv/index');
	}

	/**
	 * Callback method that checks the category code of a category
	 * 
	 * @param string title The Title to check
	 * @return bool
	 */
	public function _check_code($code, $id = null)
	{
		$this->form_validation->set_message('_check_code', sprintf(lang('category:already_exist_error'), lang('global:title')));
		return $this->category_m->check_exists('category_code', $code);			
	}
	
	/**
	 * Callback method that checks the title of the category
	 * 
	 * @param string title The title to check
	 * @return bool
	 */
	//~ public function _check_code($code = '',$id = null)
	//~ {
		//~ //$id = $this->input->post('id');
		//~ $method = $this->input->post('method');
		//~ 
		//~ if ($this->category_m->check_exists('id', $code, $id))
		//~ {
			//~ if($method == 'create'){
				//~ $this->form_validation->set_message('_check_code', sprintf(lang('category:already_exist_error'), $code));
				//~ return FALSE;
				//~ }
			//~ if($method == 'edit'){
				//~ return TRUE;
				//~ }
			//~ 
		//~ }
//~ 
		//~ return TRUE;
	//~ }
	
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
