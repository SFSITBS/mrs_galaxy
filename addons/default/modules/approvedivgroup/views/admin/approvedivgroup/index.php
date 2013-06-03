<?php if ($material_requests): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="400"><?php echo lang('approvegroup:request_label'); ?></th>
				<th width="400"><?php echo lang('approvegroup:narrative_label'); ?></th>
				<th width="100"><?php echo lang('approvegroup:created_by_label'); ?></th>
				<th width="100"><?php echo lang('approvegroup:date_needed_label'); ?></th>
				<th width="180"><?php echo lang('approvegroup:approved_by'); ?></th>
				<th width="250"><?php echo lang('approvegroup:request_status_label'); ?></th>
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
				<?php foreach ($material_requests as $mr){ 
				$requestor = $this->profile_m->get_profile(array('user_id' =>$mr->requestor));
				$last_approver = $this->profile_m->get_profile(array('user_id' =>$mr->division_approver)) ;
				$class = ""; 
					if($mr->force_approved)
					{	$class = "blue_alert";}
					if( ( $mr->status == 3 ||$mr->status == 7) && (date('Y-m-d',strtotime($mr->submitted)) >= date('Y-m-d',now()) ))
					{	$class = "red_alert"; }
					 ?>
				<tr id=<?php echo $class;?>>
					<td><a href="admin/approvedivgroup/view_mr/<?php echo $mr->id; ?>"><?php echo $mr->title; ?></a></td>
					<td><?php echo $mr->narrative;?></td>
					<td><?php if($requestor) { echo $requestor->first_name.' '.$requestor->last_name; }?></td>
					<td><?php echo $mr->date_needed;?></td>
					<td><?php if($last_approver) { echo $last_approver->first_name.' '.$last_approver->last_name; } ?></td>
					<td><i><?php if($mr_status){ foreach($mr_status as $mr_stat){ if($mr->status==$mr_stat->id){echo $mr_stat->desc;} }}?></i></td>
				<!--<td class="align-center buttons buttons-small">
						<?php echo anchor('admin/categories/edit/'.$mr->id, lang('global:edit'), 'class="button edit"'); ?>
						<?php echo anchor('admin/categories/delete/'.$mr->id, lang('global:delete'), 'class="confirm button delete"') ;?>
						<?php //echo anchor('admin/categories/approve/'.$mr->id, lang('global:approve'), 'class="button approve"'); ?>
					</td>-->
				
				</tr>
				<?php }  ?>
			</tbody>
		</table>

		<div class="table_action_buttons">
		<?php //$this->load->view('admin/partials/buttons', array('buttons' => array('delete') )); ?>
		</div>

		<?php //echo form_close(); ?>

	<?php else: ?>
		<div class="no_data"><?php echo lang('approvegroup:no_requisition'); ?></div>
	<?php endif; ?>
