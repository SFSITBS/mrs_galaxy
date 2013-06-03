<?php  if ($material_requests): ?>
		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="300"><?php echo lang('approvediv:request_label'); ?></th>
				<th width="300"><?php echo lang('approvediv:narrative_label'); ?></th>
				<th width="100"><?php echo lang('approvediv:created_by_label'); ?></th>
				<th width="200"><?php echo lang('approvediv:submitted_on_label'); ?></th>
				<th width="150"><?php echo lang('approvediv:request_status_label'); ?></th>
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
				<?php foreach ($material_requests as $mr)
				{ $requestor = $this->profile_m->get_profile(array('user_id' =>$mr->requestor));
					$class = ""; 
					if($mr->force_approved)
					{	$class = "blue_alert";}
					if( ($mr->status == 2 ||$mr->status == 6) && (date('Y-m-d',strtotime($mr->submitted)) >= date('Y-m-d',now()) ))
					{	$class = "red_alert"; }
					?>
				<tr id=<?php echo $class;?>>
					<td><a href="admin/approvediv/view_mr/<?php echo $mr->id; ?>"><b><?php echo $mr->title; ?></b></a></td>
					<td><?php echo $mr->narrative;?></td>
					<td><?php echo $requestor->first_name.' '.$requestor->last_name;?></td>
					<td><?php echo date('Y-m-d h:i:s a',strtotime($mr->submitted)); ?></td>
					<td><i><?php if($mr_status){ foreach($mr_status as $mr_stat){ if($mr->status==$mr_stat->id){echo $mr_stat->desc;} }}?></i></td>
					<!--<td class="align-center buttons buttons-small">
						<?php echo anchor('admin/categories/edit/'.$mr->id, lang('global:edit'), 'class="button edit"'); ?>
						<?php echo anchor('admin/categories/delete/'.$mr->id, lang('global:delete'), 'class="confirm button delete"') ;?>
						<?php //echo anchor('admin/categories/approve/'.$mr->id, lang('global:approve') , 'class="button approve"'); ?>
					</td>-->
				
				</tr>
				<?php } ?>
			</tbody>
		</table>

		<div class="table_action_buttons">
		<?php //$this->load->view('admin/partials/buttons', array('buttons' => array('delete') )); ?>
		</div>

		<?php //echo form_close(); ?>

	<?php else: ?>
		<div class="no_data"><?php echo lang('approvediv:no_requisition'); ?></div>
	<?php endif; ?>
