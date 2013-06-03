<?php if ($material_requests): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="400"><?php echo lang('audit_trail:request_label'); ?></th>
				<th width="100"><?php echo lang('audit_trail:date_needed_label'); ?></th>
				<th width="250"><?php echo lang('audit_trail:request_status_label'); ?></th>
				<th width="100"><?php echo lang('audit_trail:created_by_label'); ?></th>
				<th width="180"><?php echo lang('audit_trail:approved_by'); ?></th
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
				<?php foreach ($material_requests as $mr):  { ?>
				<tr>
					<td><a href="admin/audit_trail/view_mr/<?php echo $mr->id; ?>"><?php echo $mr->title; ?></a></td>
					<td><?php echo $mr->date_needed; ?></td>
					<td><?php if($mr_status){ foreach($mr_status as $mr_stat){ if($mr->status==$mr_stat->id){echo $mr_stat->desc;} }}?></td>
					<td><?php if($users){ foreach($users as $user){ if($user->id==$mr->requestor)echo $user->username; }}?></td>
					<td><?php if($users){ foreach($users as $user){ if($user->id==$mr->division_approver)echo $user->username; }}?></td>
			
				</tr>
				<?php } endforeach; ?>
			</tbody>
		</table>

		<div class="table_action_buttons">
		<?php //$this->load->view('admin/partials/buttons', array('buttons' => array('delete') )); ?>
		</div>

		<?php //echo form_close(); ?>

	<?php else: ?>
		<div class="no_data"><?php echo lang('approvegroup:no_pending'); ?></div>
	<?php endif; ?>
