<section class="title">
	<h4><?php echo lang('prod_assign:title_label'); ?></h4>
</section>

<section class="item">

	<?php template_partial('filters'); ?>

	<?php echo form_open('admin/blog/action'); ?>

		<div id="filter-stage">
			<?php template_partial('canvass_items/index'); ?>
		</div>

		<!--<div class="table_action_buttons">
			<?php $this->load->view('admin/partials/buttons', array('buttons' => array('delete', 'publish'))); ?>
		</div>-->

	<?php echo form_close(); ?>

</section>

