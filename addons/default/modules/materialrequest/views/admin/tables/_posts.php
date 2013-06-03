<?php if ($material_request) : ?>
	<table border="0" class="table-list">
		<thead>
			<tr>
				<th width="300"><?php echo lang('matreq:title_label'); ?></th>
				<th class="100"><?php echo lang('matreq:purpose_label'); ?></th>
				<th class="200"><?php echo lang('matreq:narrative_label'); ?></th>
				<th class="100"><?php echo lang('matreq:submitted_on_label'); ?></th>
				<th class="100"><?php echo lang('matreq:status_label'); ?></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan="7">
					<div class="inner"><?php $this->load->view('admin/partials/pagination'); ?></div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<?php foreach ($material_request as $post) { 
					$purposes = $this->category_m->get_actng_cat($post->accounting_cat); 
					?>
					<tr >
					<td><b><?php if($post->status==1 || $post->status==5 ) // draft, require changes
					{?> <a href="admin/materialrequest/add_items/<?php echo $post->id; ?>" ><?php }?>
					
					<?php if($post->status>1 && $post->status!=5 ) //for approval
					{?><a href="admin/materialrequest/view_mr/<?php echo $post->id; ?>"><?php }?>
					
					
					<?php echo $post->title; ?>					
					</a></b></td>
					<td class="collapse"><?php echo $purposes->name; ?></td>
					<td class="collapse"><?php echo $post->narrative; ?></td>
					<td class="collapse"><?php echo date('Y-m-d h:i:s a', strtotime($post->submitted)); ?></td>
					<td class="collapse"><i><?php if($mr_status){ foreach($mr_status as $mr_stat){ if($post->status==$mr_stat->id){echo $mr_stat->desc;} }}?></i></td>
					<td class="collapse">
					<?php //if (isset($post->display_name)): ?>
						<?php //echo anchor('user/' . $post->author_id, $post->display_name, 'target="_blank"'); ?>
					<?php //else: ?>
						<?php //echo lang('blog_author_unknown'); ?>
					<?php //endif; ?>
					</td>
					<td><?php //echo lang('blog_'.$post->status.'_label'); ?></td>
					<td>

                        <?php //if($post->status=='live') : ?>
                            <?php //echo anchor('blog/' . date('Y/m',$post->created_on). '/'. $post->slug, lang('global:view'), 'class="btn green" target="_blank"');?>
                        <?php //else: ?>
                            <?php //echo anchor('blog/preview/' . $post->preview_hash, lang('global:preview'), 'class="btn green" target="_blank"');?>
                        <?php //endif; ?>
						<?php //echo anchor('admin/blog/edit/' . $post->id, lang('global:edit'), 'class="btn orange edit"'); ?>
						<?php //echo anchor('admin/blog/delete/' . $post->id, lang('global:delete'), array('class'=>'confirm btn red delete')); ?>
					</td>
				</tr>
			<?php } ?>
		</tbody>
	</table>
<?php  else: ?>
	<div class="no_data"><?php echo lang('matreq:no_requisition'); ?></div>
<?php endif; ?>
