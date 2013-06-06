<section class="title">
	<h4><?php echo lang('prod_assign:title_label'); ?></h4>
</section>

<section class="item">

	<div class="tabs">

		<ul class="tab-menu">
			<li><a href="#assign_item"><span><?php echo lang('prod_assign:item_assign_label');?></span></a></li>
		<!--	<li><a href="#assign_category"><span><?php echo lang('prod_assign:category_assign_label');?></span></a></li>-->
		</ul>
		
		<!--ASSIGN ITEMS -->
		<div class="form_inputs" id="assign_item">
			
		<?php template_partial('filters'); ?>

		<?php echo form_open('admin/blog/action'); ?>

			<div id="filter-stage">
				<?php template_partial('prod_assign/index'); ?>
			</div>

			<!--<div class="table_action_buttons">
				<?php $this->load->view('admin/partials/buttons', array('buttons' => array('delete', 'publish'))); ?>
			</div>-->

		<?php echo form_close(); ?>
		
		</div>
		
		<!--ASSIGN CATEGORY--->
		<!--<div class="form_inputs" id="assign_category">
		
		<?php echo form_open('admin/blog/action'); ?>

			<div id="filter-stage">
			<fieldset id="filters">
	
			<?php echo form_open(''); ?>
			<?php echo form_hidden('f_module', $module_details['slug']); ?>
				
				
				<table border="0" class="table-list">
				<thead></thead>
				<tfoot></tfoot>		
					<tr style = "color: #eca750; font-weight:bold; font-size:12px;">
					<th width="80">	<?php if($_categories){ echo lang('prod_assign:category_label', 'f_category'); ?></th>
					<th width="100">	<select name="category"><option value="<?php echo 0?>">All</option>
							<?php 
									foreach($_categories as $cat){?>
										<option value="<?php echo $cat->Code?>"><?php echo $cat->Description;?></option>
							<?php } ?>
							</select>
						<?php } ?>
					</th>
					
					<th width="80">	<?php echo lang('prod_assign:assign_to_label', 'purchasing_staff'); ?></th>
					<th width="100"> 	<select name="purchasing_staff">
							<?php foreach($purchasing_officer as $p_officer)
							{ $profile = $this->profile_m->get_profile(array('user_id'=>$p_officer->id));
							?>
							<option value="<?php echo $p_officer->id;?>"><?php if($profile){echo $profile->first_name.' '.$profile->last_name;}?></option>
							<?php }?>
							</select>					
					</th>
					<th width="450">
					<div class="table_action_buttons">
					<?php echo anchor('admin/product_assignment/new_assignment/', 'Assign', 'class="btn orange"');?>
					</div>
					</th>
					</tr>
				</table>
			
			<?php echo form_close(); ?>
			</fieldset>
			
			
			<fieldset>		

				<ul>			
					<li>					
						<?php if(!$data['cart']):?>
								<table border="0" class="table-list">
									<thead>
									<tr>
										<th width="300"><?php echo lang('prod_assign:purchasing_officer_label'); ?></th>
										<th width="150"><?php echo lang('prod_assign:category_code_label'); ?></th>
										<th width="400"><?php echo lang('prod_assign:category_description_label'); ?></th>
										<th width="200"></th>
									</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="3">
												<div class="inner"><?php $this->load->view('admin/partials/pagination'); ?></div>
											</td>
										</tr>
									</tfoot>
									<tbody>
									
									
										<?php 
										foreach($assigned_category as $ac)
										{  
											$officer = $this->profile_m->get_profile(array('user_id'=>$ac->purchaser_id));
											$category_ = $this->prod_assign_nav_m->get_itemcategory_params(array('LOWER(Code)'=>strtolower($ac->category_code)));
											?>
											<tr>
											<td><?php if($officer) {echo $officer->last_name.' '.$officer->first_name; } ?></td>
											<td><?php echo $ac->category_code;?></td>
											<td><?php if($category_) {echo $category_->Description;  } ?></td>
											<td><?php echo anchor('admin/product_assignment/assign_item/' . $ac->id, 'Edit', 'class="btn blue"');
											echo anchor('admin/product_assignment/assign_item/' . $ac->id, 'Delete', 'class="btn red"');?></td>
												<input type="submit" value="assign_item" style="display:none;">
												
												
											</tr>
										<?php 
										}?>
									</tbody>
								</table>

								<div class="table_action_buttons">
								<?php //$this->load->view('admin/partials/buttons', array('buttons' => array('delete') )); ?>
								</div>

								<?php //echo form_close(); ?>

							<?php else: ?>
								<div class="no_data"><?php echo lang('prod_assign:no_category_assigned'); ?></div>
							<?php endif; ?>
					</li>
				</ul>
			</fieldset>	
			</div>

			<div class="table_action_buttons">
				<?php $this->load->view('admin/partials/buttons', array('buttons' => array('publish'))); ?>
			</div>
			
		<?php echo form_close(); ?>
		</div>--->
		
	</div>

</section>

