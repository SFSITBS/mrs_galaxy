<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
		<ul>  
			<li>
				<?php echo lang('audit_trail:search_pr_title', 'f_status'); ?>
				<select name="f_keywords">
					<?php foreach($material_requests as $mr) {?>
					<option value="<?php echo $mr->id?>"><?php echo $mr->title;?></option>
					<?php }?>
        		</select>
			</li>
			
			<li>
        		<?php echo lang('audit_trail:search_division_group', 'f_status'); ?>
        		<select name="f_status">
					<?php foreach($division_groups as $div_g) {?>
					<option value="<?php echo $div_g->id?>"><?php echo $div_g->division_group_name;?></option>
					<?php }?>
        		</select>
    		</li>
			
			<li>
				<?php echo lang('audit_trail:search_date', 'f_status'); ?></label>
				<?php echo form_input('f_date', '', 'maxlength="10" id="datepicker" class="text width-20" value="'.now().'"'); ?>
			</li>
			
			<li><?php echo anchor(current_url() . '#', lang('buttons.cancel'), 'class="cancel"'); ?></li>
		</ul>
	<?php echo form_close(); ?>
</fieldset>
