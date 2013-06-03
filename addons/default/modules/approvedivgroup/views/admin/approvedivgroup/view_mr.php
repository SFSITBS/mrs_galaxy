<script type="text/javascript">
	function DoSubmit(line){
          }
</script>

<section class="title">
	<h4><?php echo 'View Requisition'; ?></h4>
</section>

<section class="item">
	
	<div class="form_inputs" >
		
				<fieldset id="filters">
	
	<h4>Request Details</h4>
		
		<ul>
			<li> 
				<label for="purpose"><?php echo lang('approvegroup:purpose_label'); ?></label>
				<div class="input"><?php foreach($purposes as $purpose)
									{ if($mr->accounting_cat=== $purpose->id) 
										 echo $purpose->name;
									}?>
							<?php //echo $mr->accounting_cat; ?></div>
			</li>
			
			<li>
				<label for="title"><?php echo lang('approvegroup:request_label'); ?></label>
				<div class="input"><?php echo $mr->title; ?></div>				
			</li>
			
			<li>
				<label for="narrative"><?php echo lang('approvegroup:narrative_label'); ?></label>
				<div class="input"><?php echo $mr->narrative; ?></div>
			</li>
			<li>
				<label for="date_needed"><?php echo lang('approvegroup:date_needed_label'); ?></label>
				<div class="input"><?php echo $mr->date_needed;  ?></div>
			</li>
			
		<h4>Items on Requests</h4>
		<?php if(!$data['cart']){?>
			
		<?php }else{
				//print_r($data['cart']);
			?>
			<table border="0" class="table-list">
				<thead>
					<tr>
					<th ><?php echo 'Description'; ?></th>
					<th ><?php echo 'Quantity' ?></th>
					<th width="100px" ><?php echo " "; ?></th>
					
					</tr>
				</thead>
				<tbody>

				<?php
					foreach($data['cart'] as $item1)
					{
					$cur_item_info = $this->item_m->get($item1->item_code);	
					?>
						<input type="hidden" name="item_id" value="<?php echo $item1->item_code; ?>">
						<tr>
						<td><?php echo $cur_item_info->description; ?></td>

						<td>
						<input type="text" id ="<?php echo "quantity".$item1->item_code;?>" name="quantity" value="<?php echo $item1->quantity; ?>" disabled>
						<?php //echo form_input(array('name'=>'quantity','value'=>$item1['quantity'],'size'=>'2'));?>
						</td>
						</tr>
					<?php
					}
				
				?>
				</tbody>
			</table>
			
			<?php }?>
			
			<li>
		<h4><?php echo lang('approvegroup:mr_history_label'); if($mr_history)
					{ ?></h4>
		<table border="0" class="table-list">
				<thead>
					<tr>
					<th ><?php echo lang('approvegroup:mr_history_date_label'); ?></th>
					<th ><?php echo lang('approvegroup:mr_history_action_label'); ?></th>
					<th ><?php echo lang('approvegroup:mr_history_user_label'); ?></th>
					<th ><?php echo lang('approvegroup:mr_history_remarks_label'); ?></th>
					<th width="100px" ><?php echo " "; ?></th>
					
					</tr>
				</thead>
				<tbody>

				<?php
					
						foreach($mr_history as $hist)
						{
						$action = $this->audit_trail_m->get_mr_history_actions($hist->action);							
						$mr_user = $this->user_m->get(array('id'=>$hist->user_id));
						
						?>
							<input type="hidden" name="item_id" value="<?php echo $hist->id; ?>">
							<tr>	
							<td><?php echo $hist->created; ?></td>
							<td><?php echo $action->description; ?></td>
							<td><?php  echo $mr_user->username;?></td>
							<td><?php  echo $hist->remarks;?></td>
							</tr>
						<?php
						}
					}
					else
						{?><div class="no_data"><?php echo lang('approvegroup:no_posts'); }?></div>

			
				</tbody>
			</table>
			
		</li>
		<form id="frm" name="frm" action="admin/approvedivgroup/require_changes/<?php echo $mr->id;?>" method="post">

		<h4><?php echo lang('approvegroup:remarks_label'); ?> </h4> 
		 <div class="input"><?php echo form_textarea(array('name'=>'remarks', 'value' => '','rows' => 5)); ?></div>
	
</fieldset>

		
		<div class="buttons">
			<?php if($mr->status == 2||$mr->status == 3 ||$mr->status == 6 ||$mr->status == 7)  {echo anchor('admin/approvedivgroup/change_stat/hold', 'Hold', 'class="btn blue"'); ?>			
			<?php if($mr->status == 2 || $mr->status == 6 ) {echo anchor('admin/approvedivgroup/change_stat/force_approve', 'Force Approve', 'class="btn blue"');} ?>	
			<?php if($mr->status == 3 || $mr->status == 7 ) {echo anchor('admin/approvedivgroup/change_stat/approve/', 'Approve', 'class="btn blue"');} ?>		
			<?php $this->load->view('admin/partials/buttons', array('buttons' => array('require_changes')));} ?>	
 		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('cancel'))); ?>	
		</div>
		</form>

		
			
	</div>
	
	

</section>
