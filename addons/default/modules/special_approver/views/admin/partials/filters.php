<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
		<ul>  
				
			<li>
				<?php echo lang('special_approvegroup:keywords_label', 'f_status'); ?>
				<?php echo form_input('f_keywords','', 'maxlength="60" id="title" style="width:300px;"'); ?>
			</li>
			<li>
        		<?php echo lang('special_approvegroup:status_label', 'f_status'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_status"><option value="<?php echo 0?>">All</option>
					<?php $_statuses = $this->matreq_m->get_statuses(); 
					foreach($_statuses as $status){?>
					<?php if( $status->desc != "Draft" ) { ?>
					<option value="<?php echo $status->id?>"><?php echo $status->desc;?></option>
					<?php }}?>
        		</select>
    		</li>
			
			<li>
        		<?php echo lang('special_approvegroup:search_division_group', 'f_division_group'); ?>
        		<select name="f_division_group">
					<?php foreach($division_groups as $div_g) {?>
					<option value="<?php echo $div_g->id?>"><?php echo $div_g->division_group_name;?></option>
					<?php }?>
        		</select>
    		</li>
		
			
			<!--<li><?php echo anchor(current_url() . '#', lang('buttons.cancel'), 'class="cancel"'); ?></li>-->
		</ul>
	<?php echo form_close(); ?>
</fieldset>
