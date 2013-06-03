<?php if ($purchase_request_items): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="100"><?php echo lang('prod_assign:pr_no_label'); ?></th>
				<th width="400"><?php echo lang('prod_assign:item_description_label'); ?></th>
				<th width="200"><?php echo lang('prod_assign:date_created_label'); ?></th>
				<th width="300"><?php echo lang('prod_assign:requestor_division_label'); ?></th>
				<th width="100"></th>
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
				foreach($purchase_request_items as $pr_items)
				{  
					$relative_pr = $this->prod_assign_m->get_pr($pr_items->pr_id);
					$mr = $this->matreq_m->get($relative_pr->mr_id);
					$requestor = $this->profile_m->get_profile(array('user_id'=>$mr->requestor));
					$division_group = $this->divgroups_m->get($mr->division_group);	
					$item =  $this->prod_assign_nav_m->get(array('id'=>$pr_items->item_id),$division_group->division_group_name);
				?>
					<tr>
				 	<td><?php echo $pr_items->pr_id;  ?></td>
				 	<td><?php //print_r($item);
						echo $item['description'];?></td>
				 	<td><?php echo $relative_pr->date_created;?></td>
				 	<td><?php echo $requestor->first_name.' '.$requestor->last_name.' - '.$division_group->division_group_name;?></td>
					<td><?php if(!$pr_items->canvassed_by){ echo anchor('admin/product_assignment/assign_item/' . $pr_items->id, 'Assign Item', 'class="btn orange"'); }
					else{ echo anchor('admin/product_assignment/assign_item/' . $pr_items->id, 'Reassign Item', 'class="btn green"');}?></td>
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
		<div class="no_data"><?php echo lang('prod_assign:no_requisition'); ?></div>
	<?php endif; ?>
