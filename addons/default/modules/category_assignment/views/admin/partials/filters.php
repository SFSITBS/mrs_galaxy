<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
			<ul>  
  		  		
			<li>
        		<?php echo lang('cat_assign:purchasing_officer_label', 'f_purchasing_staff'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_purchasing_staff">
							<option value="<?php echo 0;?>"><?php echo lang('global:select-all');?></option>	
							<?php foreach($purchasing_officer as $p_officer)
							{ $profile = $this->profile_m->get_profile(array('user_id'=>$p_officer->id));
							?>
							<option value="<?php echo $p_officer->id;?>"><?php if($profile){echo $profile->first_name.' '.$profile->last_name;}?></option>
							<?php }?>
				</select>	
    		</li>
			
				
			
			<li>
        		<?php if($_categories){ echo lang('cat_assign:category_label', 'f_category'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_category">
								<option value="<?php echo 0;?>"><?php echo lang('global:select-all');?></option>					
					<?php 		foreach($_categories as $cat){?>
								<option value="<?php echo $cat->Code?>"><?php echo $cat->Description;?></option>
					<?php } ?>
        		</select>
				<?php } ?>
    		</li>
			
			
			
						
			
			<li><?php echo anchor(current_url() . '#', 'Reset Search', 'class="blue cancel"'); ?></li>
		</ul>
	<?php echo form_close(); ?>
</fieldset>
