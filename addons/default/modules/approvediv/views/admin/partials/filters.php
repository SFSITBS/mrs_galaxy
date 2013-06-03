<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
		<ul>  
  		  		
		<li>
        		<?php echo lang('approvediv:status_label', 'f_status'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_status"><option value="<?php echo 0?>">All</option>
					<?php foreach($statuses as $status){?>
					<?php if( $status->desc != "Draft" ) { ?>
					<option value="<?php echo $status->id?>"><?php echo $status->desc;?></option>
					<?php }}?>
        		</select>
    		</li>
			
			<li>
				<?php echo lang('approvediv:keywords_label', 'f_status'); ?>
				<?php echo form_input('f_keywords','', 'maxlength="60" id="title" style="width:300px;"'); ?>
			</li>
			
			<li>
				<?php echo form_checkbox(array('name' => 'f_for_approval',	'value' => true)); ?>
			</li>
			
			<li>				
				<?php echo lang('approvediv:for_approval_label', 'f_for_approval'); ?>
			</li>
			
			
			<!--<li><?php echo anchor(current_url() . '#', lang('buttons.cancel'), 'class="cancel"'); ?></li>-->
		</ul>
	<?php echo form_close(); ?>
</fieldset>
