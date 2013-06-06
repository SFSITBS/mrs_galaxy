<script type="text/javascript">
	function DoSubmit(line){
          }
</script>

<section class="title">
	<h4><?php echo lang('cat_assign:category_assign_label');?></h4>
</section>

<section class="item">
	
<?php echo form_open_multipart(); ?>
	<div class="form_inputs" >		
		<fieldset id="filters">

				<ul>  
							
						<li>
							<?php echo lang('cat_assign:purchasing_officer_label', 'purchasing_staff'); ?>
							<?php //echo form_dropdown('f_category', array(0 => lang('global:select-all')) + $categories); ?>
							<select name="purchasing_staff">
										<?php foreach($purchasing_officer as $p_officer)
										{ $profile = $this->profile_m->get_profile(array('user_id'=>$p_officer->id));
										?>
										<option value="<?php echo $p_officer->id;?>"><?php if($profile){echo $profile->first_name.' '.$profile->last_name;}?></option>
										<?php }?>
							</select>	
						</li>
						
							
						
						<li>
							<?php if($_categories){ echo lang('cat_assign:category_label', 'category'); ?>
							<select name="category">				
								<?php 		foreach($_categories as $cat){?>
											<option value="<?php echo $cat->Code?>"><?php echo $cat->Description;?></option>
								<?php } ?>
							</select>
							<?php } ?>
						</li>
						
				</ul>
				
		</fieldset>
		
		<div class="buttons">
		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('save'))); ?>	
 		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('cancel'))); ?>	
		</div>
			
	</div>	
	
<?php echo form_close(); ?>

</section>
