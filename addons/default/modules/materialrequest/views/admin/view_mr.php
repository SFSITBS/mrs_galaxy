<script type="text/javascript">
	function DoSubmit(line){
    	quantity = 	 document.getElementById("quantity"+line).value;
		window.location = "admin/materialrequest/edit_item/"+line+"/"+quantity;
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
				<label for="purpose"><?php echo lang('matreq:purpose_label'); ?><span>*</span></label>
				<div class="input"><?php foreach($purposes as $purpose)
									{ if($mr->accounting_cat=== $purpose->id) 
										 echo $purpose->name;
									}?>
							<?php //echo $mr->accounting_cat; ?></div>
			</li>
			
			<li>
				<label for="title"><?php echo lang('matreq:title_label'); ?> <span>*</span></label>
				<div class="input"><?php echo $mr->title; ?></div>				
			</li>
			
			<li>
				<label for="narrative"><?php echo lang('matreq:narrative_label'); ?> <span>*</span></label>
				<div class="input"><?php echo $mr->narrative; ?></div>
			</li>
			<li>
				<label for="date_needed"><?php echo lang('matreq:date_needed_label'); ?> <span>*</span></label>
				<div class="input"><?php echo $mr->date_needed;  ?></div>
			</li>
			
		<h4>Items on Requests</h4>
		<?php if(!$data['cart']){?>
			<div class="no_data">
				<?php echo lang('matreq:no_items_selected'); ?>
				Add items below<?php //echo anchor('admin/users/create', 'here'); ?>
			</div>
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
		<h4><?php echo lang('matreq:mr_history_label'); if($mr_history)					{  ?></h4>
		<table border="0" class="table-list">
				<thead>
					<tr>
					<th ><?php echo lang('matreq:mr_history_date_label'); ?></th>
					<th ><?php echo lang('matreq:mr_history_action_label'); ?></th>
					<th ><?php echo lang('matreq:mr_history_user_label'); ?></th>
					<th ><?php echo lang('matreq:mr_history_remarks_label'); ?></th>
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
							<td><?php  echo $mr_user->username?></td>
							<td><?php  echo $hist->remarks;?></td>
							</tr>
						<?php
						}
					}
					else
						{?><div class="no_data"><?php echo lang('matreq:no_posts'); }?></div>

				
				</tbody>
			</table>
			
		</li>

</fieldset>
		<div class="buttons">
			<?php $this->load->view('admin/partials/buttons', array('buttons' => array('cancel'))); ?>						
		</div>
	</div>
	
	

</section>
