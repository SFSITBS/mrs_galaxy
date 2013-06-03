<fieldset id="filters">
	
	<legend><?php echo lang('global:filters'); ?></legend>
	
	<?php echo form_open(''); ?>
	<?php echo form_hidden('f_module', $module_details['slug']); ?>
		<ul>  
<!--
			
			<li>
        		<?php //echo lang('blog_status_label', 'f_status'); ?>
        		<?php //echo form_dropdown('f_status', array(" " => lang('global:select-all')) + $statuses); ?>
    		</li>
-->
    		
    		<li>
        		<?php echo lang('matreq:status_label', 'f_status'); ?>
        		<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
        		<select name="f_status"><option value="<?php echo 0?>">All</option>
					<?php foreach($statuses as $status){?>
					<option value="<?php echo $status->id?>"><?php echo $status->desc;?></option>
					<?php }?>
        		</select>
    		</li>
			
			<li>
				<?php echo lang('matreq:keywords_label', 'f_status'); ?>
				<?php echo form_input('f_keywords','', 'maxlength="60" id="title" style="width:300px;"'); ?>
			</li>
			
			<!--<li>
				<?php echo lang('matreq:date_from_label', 'f_date_submitted_from');?></label>
				<?php echo form_input('f_date_submitted_from', '', 'maxlength="10" id="datepicker" class="text width-20"' ); ?>
			</li>
			<li>
				<?php echo lang('matreq:date_to_label', 'f_date_submitted_to'); ?></label>
				<?php echo form_input('f_date_submitted_to', '', 'maxlength="10" id="datepicker2" class="text width-20"' ); ?>
			</li>
			
			<li><?php echo anchor(current_url() . '#', lang('buttons.cancel'), 'class="cancel"'); ?></li>-->
		</ul>
	<?php echo form_close(); ?>
</fieldset>
