<?php defined('BASEPATH') OR exit('No direct script access allowed');

class cat_assign_m extends MY_Model
{
	protected $_table = 'default_category_assignment';

	
	
	public function insert($input = array())
	{
		parent::insert(array(
			//~ 'title'=>$input['title'],
			//~ 'slug'=>url_title(strtolower(convert_accented_characters($input['title'])))
			'purchaser_id' 			=> $input['purchaser_id'],
			'category_code'			=> $input['category_code']
		));
		
		return $this->db->insert_id();
	}
	
	public function get($params)
	{
		return	$this->db
			->select('*')
			->from('default_category_assignment')
			->where($params)
			->get()
			->row();
		
	}
	public function get_where($params)
	{
		return	$this->db
			->select('*')
			->from('default_category_assignment')
			->where($params)
			->get()
			->result();
		
	}
	public function get_all()
	{
		return	$this->db
			->get('default_category_assignment')
			->result();		
	}
	

	public function get_many_by($params = array())
	{
		$this->load->helper('date');
		
		
		if (!empty($params['category']))
		{	
			$this->db->where('category_code',$params['category']);
		}
		if (!empty($params['purchaser']))
		{	
			$this->db->where('purchaser_id',$params['purchaser']);
				
		}
		// Limit the results based on 1 number or 2 (2nd is offset)
		if (isset($params['limit']) && is_array($params['limit']))
			$this->db->limit($params['limit'][0], $params['limit'][1]);
		elseif (isset($params['limit']))
			$this->db->limit($params['limit']);
		
		return $this->get_all();
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
