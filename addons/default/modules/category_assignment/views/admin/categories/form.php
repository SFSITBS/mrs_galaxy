<section class="title">
	<?php //echo $this->uri->uri_string(); die();?>
	<?php //print_r($category); die();?>
	<?php if ($this->controller == 'admin' && $this->method === 'edit'): ?>
	<h4><?php echo sprintf(lang('category:edit_title'), $category->name);?></h4>
	<?php else: ?>
	<h4><?php echo lang('category:create_title');?></h4>
	<?php endif; ?>
</section>

<section class="item">
<?php echo form_open($this->uri->uri_string(), 'class="crud" id="categories"'); ?>
	
<div class="form_inputs" style="width:70%;">

	<ul>
		<li>
			<label for="category_code"><?php echo lang('category:cat_code_label');?> <span>*</span></label>
			<div class="input">
					<?php //echo  form_input('stock_type', $category->stock_type); ?>
					<?php echo  ($this->method === 'edit') ? $category->category_code : form_input('category_code', $category->category_code); ?>
					<?php if($this->method != 'edit'){?>
					<br/><span class="side-info" >3 to 6 characters in length, containing only letters. Note that this could only be defined once and editting this field is not allowed in the future.</span>
					<?php }else { echo form_hidden('category_code', $category->category_code); } ?>
		</li>
		
		<li>
			<label for="cat_name"><?php echo lang('category:cat_name_label');?> <span>*</span></label>
			<div class="input">
				<?php $data_cat_name = array('name' => 'cat_name','value' => $category->cat_name); ?>
				<?php echo  form_input('cat_name', $category->cat_name); ?> 
				<br/><span class="side-info" >Max of 50 characters in length</span>
			</div>
			
		</li>
		
		<li>
			<label for="description"><?php echo lang('category:cat_desc_label');?> <span>*</span></label>
			<div class="input">
				<?php $data_description = array('name' => 'description','value' => $category->description,'style' => 'width:100%'); ?>
				<?php echo  form_input($data_description); ?>
				<br/><span class="side-info" >Max of 50 characters in length</span>
			</div>
		</li>
		
		<li>
			<label for="stock_type"><?php echo lang('category:cat_stock_type_label');?> <span>*</span></label>
			<div class="input">
					<?php //echo  form_input('stock_type', $category->stock_type); ?>
					<?php echo  form_dropdown('is_stocking', 										// field name
								array(	'1' => lang('category:stocking_item_label'), 			// options then their values
										'0' => lang('category:nonstocking_item_label')), 
								$category->is_stocking);											// default value ?>			
				<br/><span class="side-info" >Will items under this category stocked?</span>														
			</div>
		</li>
		
		
		
		
		
		<!-- Ready GL account assignment for future version -->	
			<?php echo  form_hidden('stockact', '0'); ?>
			<?php echo  form_hidden('wipact', '0'); ?>
			<?php echo  form_hidden('adjglact', '0'); ?>
			<?php echo  form_hidden('issueglact', '0'); ?>
			<?php echo  form_hidden('purchpricevaract', '0'); ?>
			<?php echo  form_hidden('materialuseagevarac', '0'); ?>
			
			<?php echo  form_hidden('method', $this->method); ?>
		

	</ul>
	<div><?php $this->load->view('admin/partials/buttons', array('buttons' => array('save', 'cancel') )); ?></div>
</div>
<!--
	<div style="clear:both"></div>
-->
	

<?php echo form_close(); ?>
</section>
