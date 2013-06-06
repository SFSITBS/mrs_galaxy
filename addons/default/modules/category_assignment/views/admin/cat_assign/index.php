


<?php  if ($assigned_category): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="300"><?php echo lang('cat_assign:purchasing_officer_label'); ?></th>
				<th width="200"><?php echo lang('cat_assign:category_label'); ?></th>
				<th width="500"></th>
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
				<?php foreach($assigned_category as $ac)
					{  
						$officer = $this->profile_m->get_profile(array('user_id'=>$ac->purchaser_id));
						$category_ = $this->prod_assign_nav_m->get_itemcategory_params(array('LOWER(Code)'=>strtolower($ac->category_code)));
						?>
						<tr>
						<td><?php if($officer) {echo $officer->last_name.' '.$officer->first_name; } ?></td>
						<td><?php echo $ac->category_code.' - '.$category_->Description;;?></td>
						<td><?php echo anchor('admin/category_assignment/delete/' . $ac->id, 'Delete', 'class="btn red"');?></td>
						<input type="submit" value="assign_item" style="display:none;">						
							
						</tr>
					<?php 
					}?>
				
			</tbody>
		</table>

		<?php //echo form_close(); ?>

	<?php else: ?>
		<div class="no_data"><?php echo lang('cat_assign:no_category_assigned'); ?></div>
	<?php endif; ?>
