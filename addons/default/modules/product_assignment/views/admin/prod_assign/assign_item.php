<script type="text/javascript">
	function DoSubmit(line){
          }
</script>

<section class="title">
	<h4><?php echo lang('prod_assign:assign_label');?></h4>
</section>

<section class="item">
	
<?php echo form_open_multipart(); ?>
	<div class="form_inputs" >
		
				<fieldset id="filters">
	
	<h4><?php echo lang('prod_assign:pr_no_label'); if($pr_item) {echo ' : '.$pr_item->pr_id;}?></h4>
		
		<ul>
			<li> 
				<label for="purpose"><?php echo lang('prod_assign:item_description_label'); ?> : </label>
				<div class="input"><?php
						
					if($item) {echo $item['description'];}
				?>
				</div>	
			</li>
			
			<li>
				<label for="title"><?php echo lang('prod_assign:requestor_label'); ?> : </label>
				<div class="input"><?php if($requestor) {echo $requestor->first_name.' '.$requestor->last_name.' - '.$division_group->division_group_name;} ?></div>				
			</li>

			<li>
				<label for="narrative"><?php echo lang('prod_assign:assign_to_label'); ?></label>
				<div class="input">
				<select name="purchasing_staff">
					<?php foreach($purchasing_officer as $p_officer)
					{ $profile = $this->profile_m->get_profile(array('user_id'=>$p_officer->id));
					?>
					<option value="<?php echo $p_officer->id?>"><?php if($profile){echo $profile->first_name.' '.$profile->last_name;}?></option>
					<?php }?>
        		</select>
				</div>
			</li>
			
		
</fieldset>

		
		<div class="buttons">
		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('save'))); ?>	
 		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('cancel'))); ?>	
		</div>

		
			
	</div>
	
	
<?php echo form_close(); ?>

</section>
