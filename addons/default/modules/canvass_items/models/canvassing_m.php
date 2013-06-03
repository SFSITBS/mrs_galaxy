<?php defined('BASEPATH') OR exit('No direct script access allowed');

class canvassing_m extends MY_Model
{
	protected $_table = 'default_purchase_request_items';

	
	
	
	public function is_purchasing($id)
	{
		$this->db->where(array('id' => $id));
		
		$user_info = $this->db->get('users')->row();
		
		$is_purchasing = ($user_info->group_id == '5') ? 1 : 0;
		
		return $is_purchasing;
		
			
	}

	public function get_purchasing_officer()
	{
		return $this->db->select('*')	
			->where('group_id',5)
			->get('default_users')
			->result();
	}
	

	public function insert($input = array())
	{
		parent::insert(array(
			//~ 'title'=>$input['title'],
			//~ 'slug'=>url_title(strtolower(convert_accented_characters($input['title'])))
			'description' 			=> $input['description'],
			'is_stocking' 			=> $input['is_stocking'],
			'category_code' 		=> $input['category_code'],
			'cat_name' 					=> $input['cat_name']
		));
		
		return $this->db->insert_id();
	}
	
	public function get($params)
	{
		return	$this->db
			->select('*')
			->from('default_purchase_request_items')
			->where($params)
			->get()
			->row();
		
	}
	public function get_where($params)
	{
		return	$this->db
			->select('*')
			->from('default_purchase_request_items')
			->where($params)
			->get()
			->result();
		
	}
	public function get_all()
	{
		return	$this->db
					->get('default_purchase_request_items')
			->result();
		
	}
	public function get_all_unassigned()
	{
		return	$this->db
					->where('canvassed_by is null')
					->or_where('canvassed_by','')
					->get('default_purchase_request_items')
			->result();
		
	}
	public function get_all_search()
	{
		return	$this->db
		->select('*')
		->from('default_purchase_request_items')
		->join('default_purchase_request','default_purchase_request.id = default_purchase_request_items.pr_id')
		->join('default_material_requests','default_material_requests.id = default_purchase_request.mr_id')
		->join('default_division_groups','default_division_groups.id = default_material_requests.division_group')
		->get()
		->result();
		
	}
	public function get_pr($id)
	{
		return	
			$this->db
					->select('*')
					->where('id',$id)
					->get('default_purchase_request')
			->row();
	}

	public function get_many_by($params = array())
	{
		$this->load->helper('date');
		$this->db->where('canvassed_by',$this->current_user->id);
		
		if (!empty($params['division_group']))
		{
			$this->db->where('material_requests.division_group', $params['division_group']);
		}
		if (!empty($params['keywords']))
		{
			$this->db->where('item_id',$this->prod_assign_nav_m->get_descriptions($params['keywords']));
		}
		if (!empty($params['assigned']))
		{
			$this->db->having('canvassed_by is null')->or_having('canvassed_by = \'\'');
		}
		
		// Limit the results based on 1 number or 2 (2nd is offset)
		if (isset($params['limit']) && is_array($params['limit']))
			$this->db->limit($params['limit'][0], $params['limit'][1]);
		elseif (isset($params['limit']))
			$this->db->limit($params['limit']);
		
		return $this->get_all_search();
	}
	
	public function count_tagged_by($tag, $params)
	{
		return $this->select('*')
			->from('blog')
			->join('keywords_applied', 'keywords_applied.hash = blog.keywords')
			->join('keywords', 'keywords.id = keywords_applied.keyword_id')
			->where('keywords.name', str_replace('-', ' ', $tag))
			->where($params)
			->count_all_results();
	}
	
	public function get_tagged_by($tag, $params)
	{
		return $this->db->select('blog.*, blog.title title, blog.slug slug, blog_categories.title category_title, blog_categories.slug category_slug, profiles.display_name')
			->from('blog')
			->join('keywords_applied', 'keywords_applied.hash = blog.keywords')
			->join('keywords', 'keywords.id = keywords_applied.keyword_id')
			->join('blog_categories', 'blog_categories.id = blog.category_id', 'left')
			->join('profiles', 'profiles.user_id = blog.author_id', 'left')
			->where('keywords.name', str_replace('-', ' ', $tag))
			->where($params)
			->get()
			->result();
	}

	public function count_by($params = array())
	{
		$this->db->join('blog_categories', 'blog.category_id = blog_categories.id', 'left')
			// we need the display name joined so we can get an accurate count when searching
			->join('profiles', 'profiles.user_id = blog.author_id');

		if (!empty($params['category']))
		{
			if (is_numeric($params['category']))
				$this->db->where('blog_categories.id', $params['category']);
			else
				$this->db->where('blog_categories.slug', $params['category']);
		}

		if (!empty($params['month']))
		{
			$this->db->where('MONTH(FROM_UNIXTIME(created_on))', $params['month']);
		}

		if (!empty($params['year']))
		{
			$this->db->where('YEAR(FROM_UNIXTIME(created_on))', $params['year']);
		}

		if ( ! empty($params['keywords']))
		{
			$this->db
				->like('blog.title', trim($params['keywords']))
				->or_like('profiles.display_name', trim($params['keywords']));
		}

		// Is a status set?
		if (!empty($params['status']))
		{
			// If it's all, then show whatever the status
			if ($params['status'] != 'all')
			{
				// Otherwise, show only the specific status
				$this->db->where('status', $params['status']);
			}
		}

		// Nothing mentioned, show live only (general frontend stuff)
		else
		{
			$this->db->where('status', 'live');
		}

		return $this->db->count_all_results('blog');
	}

	public function update($id, $input)
	{
		//$input['updated_on'] = now();
        //if($input['status'] == "live" and $input['preview_hash'] !='') $input['preview_hash'] = '';
		return parent::update($id, $input);
	}


}
