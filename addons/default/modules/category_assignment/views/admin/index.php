<section class="title">
	<h4><?php echo lang('cat_assign:title_label'); ?></h4>
</section>

<section class="item">

		
		<!--ASSIGN ITEMS -->
		<div class="form_inputs" id="assign_item">
		
		<?php template_partial('filters'); ?>

		<?php echo form_open('admin/blog/action'); ?>

			<div id="filter-stage">
				<?php template_partial('cat_assign/index'); ?>
			</div>

			<!--<div class="table_action_buttons">
				<?php $this->load->view('admin/partials/buttons', array('buttons' => array('delete', 'publish'))); ?>
			</div>-->

		<?php echo form_close(); ?>
		
		</div>
</section>

