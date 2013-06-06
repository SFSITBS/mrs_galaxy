<script type="text/javascript">
	function DoSubmit(line){
          }
</script>

<section class="title">
	<h4><?php echo lang('canvassing:canvass_label');?></h4>
</section>

<section class="item">
	
<?php echo form_open_multipart(); ?>
	<div class="form_inputs" >
		
	<fieldset >
	<legend><h4><?php echo lang('canvassing:pr_no_label'); if($pr_item) {echo ' : '.$pr_item->pr_id;}  	if($item) {echo '     -      '.$item->Description;}?> </h4></legend>
		
		<ul>
		
			<li>
				<label for="title"><?php echo lang('canvassing:requestor_label'); ?> : </label>
				<div class="input"><?php if($requestor) {echo $requestor->first_name.' '.$requestor->last_name.' - '.$division_group->division_group_name;} ?></div>				
			</li>

			<li>
				<label for="Quantity"><?php echo lang('canvassing:quantity_label'); ?> : </label>
				<div class="input">
				<?php echo form_input('orig_quantity', htmlspecialchars_decode($pr_item->quantity), 'maxlength="60" id="quantity" style="width:100px;" disabled'); ?>
				</div>
			</li>
			<li>
				<label for="Price"><?php echo lang('canvassing:unit_label'); ?> : </label>
				<div class="input">
				<?php echo form_input('orig_unit', htmlspecialchars_decode($pr_item->unit), 'maxlength="60" id="price" style="width:100px;" dosabled'); ?>
				</div>
			</li>
	</fieldset>		
	
	
	<fieldset>
		<legend><h4><?php echo lang('canvassing:history_label');?> </h4></legend>

		<table border="0" class="table-list">
			<thead>
			<tr>
				<th width="400"><?php echo lang('canvassing:supplier_label'); ?></th>
				<th width="80"><?php echo lang('canvassing:quantity_label'); ?></th>
				<th width="150"><?php echo lang('canvassing:unit_price_label'); ?></th>
				<th width="150"><?php echo lang('canvassing:total_price_label'); ?></th>
				<th width="300"><?php echo lang('canvassing:remarks_label'); ?></th>
				<th width="300"><?php echo lang('canvassing:date_created_label'); ?></th>
				<th width="200"></th>
			</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="3">
						<div class="inner"><?php $this->load->view('admin/partials/pagination'); ?></div>
					</td>
				</tr>
			</tfoot>
			<tbody>
				<?php foreach($canvassed_items as $ci)
					{  
						$_supplier = $this->canvassing_nav_m->get_supplier(array('No_'=>$ci->supplier),$company->company_name);
						?>
						<tr>
						<td><?php echo $_supplier->Name; ?></td>
						<td><?php echo $ci->quantity; ?></td>
						<td><?php echo $ci->unit_price; ?></td>
						<td><?php echo ($ci->quantity *  $ci->unit_price); ?></td>
						<td><?php echo $ci->remarks; ?></td>
						<td><?php echo date('Y-M-d h:i:s a',strtotime($ci->date_canvassed)); ?></td>
						<td><?php echo anchor('admin/canvass_items/delete/' . $ci->canvass_id, 'Delete', 'class="btn red"');?></td>
						<input type="submit" value="assign_item" style="display:none;">						
							
						</tr>
					<?php 
					}?>
				<tr id="blue_highlight">
				<td><select name="supplier">
								<?php foreach($supplier as $sup)
								{ ?>
								<option value="<?php echo $sup->No_;?>"><?php echo $sup->Name; ?></option>
								<?php }?>
					</select>
				</td>
				<td><?php echo form_input('quantity', htmlspecialchars_decode(''), 'maxlength="50" id="quantity" style="width:50px;" '); ?></td>
				<td><?php echo form_input('unit_price', htmlspecialchars_decode(''), 'maxlength="50" id="price" style="width:100px;" '); ?></td>
				<td>--</td>
				<td><?php echo form_input('remarks', htmlspecialchars_decode(''), 'maxlength="60" id="remarks" style="width:150px;" '); ?></td>
				<td colspan='2'><div class="buttons"><?php $this->load->view('admin/partials/buttons', array('buttons' => array('add_new_canvass'))); ?></div></td>
				</tr>			
			</tbody>
		</table>
	</fieldset>
		
	
	<div class="buttons">
		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('back'))); ?>	
		</div>

		
			
	</div>
	
	
<?php echo form_close(); ?>

</section>
