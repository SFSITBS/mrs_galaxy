<?php if ($material_requests): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="400"><?php echo lang('special_approvegroup:request_label'); ?></th>
				<th width="250"><?php echo lang('special_approvegroup:narrative_label'); ?></th>
				<th width="100"><?php echo lang('special_approvegroup:created_by_label'); ?></th>
				<th width="180"><?php echo lang('special_approvegroup:approved_by'); ?></th>			
				<th width="250"><?php echo lang('special_approvegroup:request_status_label'); ?></th>
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
				<?php foreach ($material_requests as $mr): 
				{ $requestor = $this->profile_m->get_profile(array('user_id' =>$mr->requestor));
				$last_approver = $this->profile_m->get_profile(array('user_id' =>$mr->division_approver)); ?>
				<tr>
					<td><a href="admin/special_approver/view_mr/<?php echo $mr->id; ?>"><?php echo $mr->title; ?></a></td>
					<td><?php echo $mr->narrative; ?></td>
					<td><?php if($requestor){ echo $requestor->first_name.' '.$requestor->last_name; }?></td>
					<td><?php if($last_approver){ echo $last_approver->first_name.' '.$last_approver->last_name; }?></td>
					<td><i><?php if($mr_status){ foreach($mr_status as $mr_stat){ if($mr->status==$mr_stat->id){echo $mr_stat->desc;} }}?></i></td>
			
				</tr>
				<?php } endforeach; ?>
			</tbody>
		</table>

		<div class="table_action_buttons">
		<?php //$this->load->view('admin/partials/buttons', array('buttons' => array('delete') )); ?>
		</div>

		<?php //echo form_close(); ?>

	<?php else: ?>
		<div class="no_data"><?php echo lang('special_approvegroup:no_requisition'); ?></div>
	<?php endif; ?>
