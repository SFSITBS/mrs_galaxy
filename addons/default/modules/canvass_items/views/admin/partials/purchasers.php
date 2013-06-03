<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
			<ul>  
  		  		
			<li>
        		<?php echo lang('prod_assign:requestor_division_label', 'f_division_group'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_division_group"><option value="<?php echo 0?>">All</option>
					<?php foreach($div_groups as $div){?>
					<?php  ?>
					<option value="<?php echo $div->id?>"><?php echo $div->division_group_name;?></option>
					<?php }?>
        		</select>
    		</li>
			
			<li>
				<?php echo lang('prod_assign:item_keywords_label', 'f_status'); ?>
				<?php echo form_input('f_keywords','', 'maxlength="60" id="title" style="width:300px;"'); ?>
			</li>
			
			
			
			
			<!--<li><?php echo anchor(current_url() . '#', lang('buttons.cancel'), 'class="cancel"'); ?></li>-->
		</ul>
	<?php echo form_close(); ?>
</fieldset>
