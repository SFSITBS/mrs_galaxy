<?php if ((isset($analytic_visits) OR isset($analytic_views)) AND $theme_options->pyrocms_analytics_graph == 'yes'): ?>
<script type="text/javascript">

$(function($) {
		var visits = <?php echo isset($analytic_visits) ? $analytic_visits : 0; ?>;
		var views = <?php echo isset($analytic_views) ? $analytic_views : 0; ?>;

		$.plot($('#analytics'), [{ label: 'Visits', data: visits },{ label: 'Page views', data: views }], {
			lines: { show: true },
			points: { show: true },
			grid: { hoverable: true, backgroundColor: '#fefefe' },
			series: {
				lines: { show: true, lineWidth: 1 },
				shadowSize: 0
			},
			xaxis: { mode: "time" },
			yaxis: { min: 0},
			selection: { mode: "x" }
		});
		
		function showTooltip(x, y, contents) {
			$('<div id="tooltip">' + contents + '</div>').css( {
				position: 'absolute',
				display: 'none',
				top: y + 5,
				left: x + 5,
				'border-radius': '3px',
				'-moz-border-radius': '3px',
				'-webkit-border-radius': '3px',
				padding: '3px 8px 3px 8px',
				color: '#ffffff',
				background: '#000000',
				opacity: 0.80
			}).appendTo("body").fadeIn(500);
		}
	 
		var previousPoint = null;
		
		$("#analytics").bind("plothover", function (event, pos, item) {
			$("#x").text(pos.x.toFixed(2));
			$("#y").text(pos.y.toFixed(2));
	 
				if (item) {
					if (previousPoint != item.dataIndex) {
						previousPoint = item.dataIndex;
						
						$("#tooltip").remove();
						var x = item.datapoint[0],
							y = item.datapoint[1];
						
						showTooltip(item.pageX, item.pageY,
									item.series.label + " : " + y);
					}
				}
				else {
					$("#tooltip").fadeOut(500);
					previousPoint = null;            
				}
		});
	
	});
</script>

<section class="title">
	<h4>Statistics</h4>
</section>
	
<div id="analyticsWrapper">
	<div id="analytics"></div>
</div>

<?php endif; ?>
<!-- End Analytics -->
	
<!-- Add an extra div to allow the elements within it to be sortable! -->
<div id="sortable">

	<!-- Dashboard Widgets -->
	{{ widgets:area slug="dashboard" }}

	<!-- PENDING FOR APPROVAL -->
	<?php if (isset($recent_comments) AND is_array($recent_comments) AND $theme_options->pyrocms_recent_comments == 'yes') : ?>
	<div class="one_half">
		
		<section class="draggable title">
			<h4><?php echo lang('mrs:pending_for_approval') ?></h4>
			<a class="tooltip-s toggle" title="Toggle this element"></a>
		</section>
		
		<section class="item">
			<ul >
			<li>
			<table>
			
				<?php if ($mr_approval): ?>	
				<thead>
					<tr>
					<th ><?php echo 'Requisition Title'; ?></th>
					<th ><?php echo 'Created By' ?></th>
					
					</tr>
				</thead>
				
						<?php foreach ($mr_approval AS $mr) : 
								$user = $this->user_m->get(array('id'=>$mr->requestor));
						?>					
							<tr>
								<td><?php echo '<a href="admin/approvedivgroup/view_mr/'.$mr->id.'">'.$mr->title.'</a>'; ?></td>
								<td><?php echo $user->username; ?></td>
							</tr>
						<?php endforeach; ?>
				<?php else: ?>
						<?php echo lang('mrs:no_posts');?>
				<?php endif; ?>
			</table>
			</li>
			<li>
			<h4><?php echo lang('mrs:on_hold') ?></h4>
			<table>		
				<?php if($mr_on_hold): ?>
				<thead>
					<tr>
					<th ><?php echo 'Requisition Title'; ?></th>
					<th ><?php echo 'Created By' ?></th>
					
					</tr>
				</thead>
						<?php foreach ($mr_on_hold as $mr) : 
								$user = $this->user_m->get(array('id'=>$mr->requestor));						?>					
							<tr>
								<td><?php echo '<a href="admin/approvediv/view_mr/'.$mr->id.'">'.$mr->title.'</a>'; ?></td>
								<td><?php echo $user->username; ?></td>
							</tr>
						<?php endforeach; ?>
				<?php else: ?>
						<?php echo lang('mrs:no_on_hold');?>
				<?php endif; ?>
			</table>
			</li>
			</ul>
		</section>
	</div>		
	
	
	<?php endif; ?>
	<!-- End Recent Comments -->
	
	
	
	<!-- Begin Quick Links -->
	<?php if ($theme_options->pyrocms_quick_links == 'yes') : ?>
	<div class="one_half last">
		
		<section class="draggable title">
			<h4><?php echo lang('mrs:notifications') ?></h4>
			<a class="tooltip-s toggle" title="Toggle this element"></a>
		</section>
		
		<section id="quick_links" class="item <?php echo isset($rss_items); ?>">
			<ul>
				<?php if(array_key_exists('comments', $this->permissions) OR $this->current_user->group == 'admin'): ?>
				<li>
					<a class="tooltip-s" title="<?php echo lang('cp_manage_comments') ?>" href="<?php echo site_url('admin/comments') ?>"><?php echo Asset::img('icons/comments.png', lang('cp_manage_comments')); ?></a>
				</li>
				<?php endif; ?>
				
				<?php if(array_key_exists('pages', $this->permissions) OR $this->current_user->group == 'admin'): ?>
				<li>
					<a class="tooltip-s" title="<?php echo lang('cp_manage_pages'); ?>" href="<?php echo site_url('admin/pages') ?>"><?php echo Asset::img('icons/pages.png', lang('cp_manage_pages')); ?></a>
				</li>
				<?php endif; ?>
				
				<?php if(array_key_exists('files', $this->permissions) OR $this->current_user->group == 'admin'): ?>
				<li>
					<a class="tooltip-s" title="<?php echo lang('cp_manage_files'); ?>" href="<?php echo site_url('admin/files') ?>"><?php echo Asset::img('icons/files.png', lang('cp_manage_files')); ?></a>
				</li>
				<?php endif; ?>
				
				<?php if(array_key_exists('users', $this->permissions) OR $this->current_user->group == 'admin'): ?>
				<li>
					<a class="tooltip-s" title="<?php echo lang('cp_manage_users'); ?>" href="<?php echo site_url('admin/users') ?>"><?php echo Asset::img('icons/users.png', lang('cp_manage_users')); ?></a>
				</li>
				<?php endif; ?>
			</ul>
		</section>

	</div>		
	<?php endif; ?>
	<!-- End Quick Links -->

	<!-- Begin RSS Feed -->
	<?php if ( isset($rss_items) AND $theme_options->pyrocms_news_feed == 'yes') : ?>
	<div id="feed" class="one_half last">
		
		<section class="draggable title">
			<h4><?php echo lang('cp_news_feed_title'); ?></h4>
			<a class="tooltip-s toggle" title="Toggle this element"></a>
		</section>
		
		<section class="item">
			<ul><li>
				<?php 
			
				foreach($news_feeds as $news): 
				
				
				foreach($material_req as $mat_r)
				{ if($mat_r->id == $news->relative_id){
				?>
				
				<?php
				$mr = $this->matreq_m->get($news->relative_id); 
				$user = $this->profile_m->get_profile(array('user_id'=>$news->user_id));
				$status = $this->audit_trail_m->get_mr_history_actions($news->action);?>
						
					<?php
					
						$item_date	= strtotime($news->created);
						$item_month = date('M', $item_date);
						$item_day	= date('j', $item_date);
						$item_time	= date('h:i:s a', $item_date);
					?>
						
					<div class="date">
						<span class="month">
							<?php echo $item_month ?>
						</span>
						<span class="day">
							<?php echo $item_day; ?>
						</span>
					</div>
					
					<h4><?php echo $item_time;?></h4>
					<?php 
					$string = 'changed to '.$status->description.' updated'; 
					if ($news->action == 1) 
						$string = lang('news:submitted_for_approval');
					if ($news->action == 2)
						$string = lang('news:on_hold');
					if ($news->action == 3)
						$string = lang('news:require_changes');
					if ($news->action == 4)
						$string = lang('news:approved');
					if ($news->action == 5)
						$string = lang('news:forced_approved');
					?>		
					<?php $view_link ='admin/approvedivgroup/view_mr/'.$mr->id; ?>
										
					<p class='item_body' style='width =100%;'><?php echo '<a href='.$view_link.'><strong>'.$mr->title.'</strong></a> has been <i> '.$string.'</i> by '.$user->first_name.' '.$user->last_name.'.'  ;?></p>
				<br/><br/>
				<?php }}endforeach; ?></li>
			</ul>
		</section>

	</div>		
	<?php endif; ?>
	<!-- End RSS Feed -->

</div>
<!-- End sortable div -->