<script type="text/javascript">
	function DoSubmit(line){
          }
</script>

<section class="title">
	<h4><?php echo lang('canvassing:assign_label');?></h4>
</section>

<section class="item">
	
<?php echo form_open_multipart(); ?>
	<div class="form_inputs" >
		
				<fieldset id="filters">
	
	<h4><?php echo lang('canvassing:pr_no_label'); if($pr_item) {echo ' : '.$pr_item->pr_id;}?></h4>
		
		<ul>
			<li> 
				<label for="purpose"><?php echo lang('canvassing:item_description_label'); ?> : </label>
				<div class="input"><?php
						
					if($item) {echo $item['description'];}
				?>
				</div>	
			</li>
			
			<li>
				<label for="title"><?php echo lang('canvassing:requestor_label'); ?> : </label>
				<div class="input"><?php if($requestor) {echo $requestor->first_name.' '.$requestor->last_name.' - '.$division_group->division_group_name;} ?></div>				
			</li>

			<li>
				<label for="Quantity"><?php echo lang('canvassing:quantity_label'); ?> : </label>
				<div class="input">
				<?php echo form_input('quantity', htmlspecialchars_decode(''), 'maxlength="60" id="quantity" style="width:100px;"'); ?>
				</div>
			</li>
			
			<li>
				<label for="Price"><?php echo lang('canvassing:price_label'); ?> : </label>
				<div class="input">
				<?php echo form_input('price', htmlspecialchars_decode(''), 'maxlength="60" id="price" style="width:100px;"'); ?>
				</div>
			</li>
			<li>
				<label for="Supplier"><?php echo lang('canvassing:supplier_label'); ?> : </label>
				<div class="input">
				<?php echo form_input('supplier', htmlspecialchars_decode(''), 'maxlength="60" id="price" style="width:100px;"'); ?>
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
