<?php 	$purchasing_request_items= $this->canvassing_m->get_where(array('canvassed_by'=>$this->current_user->id)); if ($purchase_request_items): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="100"><?php echo lang('canvassing:pr_no_label'); ?></th>
				<th width="400"><?php echo lang('canvassing:item_description_label'); ?></th>
				<th width="200"><?php echo lang('canvassing:date_created_label'); ?></th>
				<th width="300"><?php echo lang('canvassing:requestor_division_label'); ?></th>
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
					$company = $this->prod_assign_m->get_company(array('id' => $division_group->company));
					$item =  $this->prod_assign_nav_m->get(array('No_'=>$pr_items->pri_item_code),$company->company_name);
				
				?>
					<tr>
				 	<td><?php echo $pr_items->pr_id;  ?></td>
				 	<td><?php //print_r($item);
						echo $item->Description;?></td>
				 	<td><?php echo $relative_pr->date_created;?></td>
				 	<td><?php echo $requestor->first_name.' '.$requestor->last_name.' - '.$division_group->division_group_name;?></td>
					<td><?php  echo anchor('admin/canvass_items/set/' . $pr_items->pri_id, 'Canvass Item', 'class="btn orange"'); ?></td>
						<input type="submit" value="assign_item" style="display:none;">
						
						
					</tr>
				<?php 
				}?>
			</tbody>
		</table>



	<?php else: ?>
		<div class="no_data"><?php echo lang('canvassing:no_items'); ?></div>
	<?php endif; ?>
