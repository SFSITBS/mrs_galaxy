<?php defined('BASEPATH') OR exit('No direct script access allowed');

$lang['audit_trail:post']                 = 'Post';
$lang['audit_trail:posts']                   = 'Posts';

// labels

$lang['audit_trail:request_label']                  		 = 'Requests Title';
$lang['audit_trail:request_status_label']                 = 'Status';
$lang['audit_trail:created_by_label']                	 = 'Created by';
$lang['audit_trail:created_on_label']              		 =  'Created on';
$lang['audit_trail:narrative_label']            			  	 = 'Narrative';
$lang['audit_trail:purpose_label']                			 = 'Purpose';
$lang['audit_trail:date_needed_label']             			 = 'Date Needed';
$lang['audit_trail:remarks_label']             			 = 'Approval Remarks';
$lang['audit_trail:approved_by']             			 = 'Last Approved by';

$lang['audit_trail:search_mr_title']                  	= 'Requests Title';
$lang['audit_trail:search_date']             				= 'Date';
$lang['audit_trail:search_division_group']                 = 'Division Group';


$lang['audit_trail:mr_history_label']                 = 'Requisition History';
$lang['audit_trail:mr_history_action_label']          = 'Action';
$lang['audit_trail:mr_history_user_label']           =  'Last Updated By';
$lang['audit_trail:mr_history_date_label']           =  'Date';
$lang['audit_trail:mr_history_remarks_label']           =  'Remarks';



$lang['audit_trail:cat_items_count_label']				 = 'No of Items';
//~ $lang['audit_trail:cat_accountingcat_label']		 = 'Accounting approvegroup';
$lang['audit_trail:author_unknown']				= 'Unknown';
$lang['audit_trail:keywords_label']				= 'Keywords';
$lang['audit_trail:tagged_label']					= 'Tagged';
$lang['audit_trail:approvegroup_label']                 = 'approvegroup';
$lang['audit_trail:post_label']                     = 'Post';
$lang['audit_trail:date_label']                     = 'Date';
$lang['audit_trail:date_at']                        = 'at';
$lang['audit_trail:time_label']                     = 'Time';
$lang['audit_trail:status_label']                   = 'Status';
$lang['audit_trail:stocking_item_label']            = 'Stocking Item';
$lang['audit_trail:nonstocking_item_label']         = 'Non-stocking Item';
$lang['audit_trail:finished_good_label']           = 'Finished Good';
$lang['audit_trail:raw_material_label']            = 'Raw Material';
$lang['audit_trail:service_label']           		 = 'Service/Labour';
$lang['audit_trail:content_label']                  = 'Content';
$lang['audit_trail:options_label']                  = 'Options';
$lang['audit_trail:intro_label']                    = 'Introduction';
$lang['audit_trail:no_approvegroup_select_label']       = '-- None --';
$lang['audit_trail:new_approvegroup_label']             = 'Add a approvegroup';
$lang['audit_trail:subscripe_to_rss_label']         = 'Subscribe to RSS';
$lang['audit_trail:all_posts_label']             = 'All posts';
$lang['audit_trail:posts_of_approvegroup_suffix']    = ' posts';
$lang['audit_trail:rss_name_suffix']                = ' approvegroup';
$lang['audit_trail:rss_approvegroup_suffix']            = ' approvegroup';
$lang['audit_trail:author_name_label']              = 'Author name';
$lang['audit_trail:read_more_label']                = 'Read More&nbsp;&raquo;';
$lang['audit_trail:created_hour']                   = 'Created on Hour';
$lang['audit_trail:created_minute']                 = 'Created on Minute';
$lang['audit_trail:comments_enabled_label']         = 'Comments Enabled';

// titles
$lang['audit_trail:create_title']                   = 'Add approvegroup';
$lang['audit_trail:edit_title']                     = 'Edit approvegroup "%s"';
$lang['audit_trail:archive_title']                 = 'Archive';
$lang['audit_trail:posts_title']					= 'Posts';
$lang['audit_trail:rss_posts_title']				= 'approvegroup posts for %s';
$lang['audit_trail:approvegroup_title']				= 'Categories';
$lang['audit_trail:all_request_title']				= 'Material Requests';
$lang['audit_trail:list_title']					= 'List Posts';

// messages
$lang['audit_trail:no_posts']                    = 'There are no recorded history for this requisition.';
$lang['audit_trail:no_pending']                    = 'There are no requisitions pending for your approval.';
$lang['audit_trail:subscripe_to_rss_desc']          = 'Get posts straight away by subscribing to our RSS feed. You can do this via most popular e-mail clients, or try <a href="http://reader.google.co.uk/">Google Reader</a>.';
$lang['audit_trail:currently_no_posts']          = 'There are no posts at the moment.';
$lang['audit_trail:post_add_success']            = 'The post "%s" was added.';
$lang['audit_trail:post_add_error']              = 'An error occured.';
$lang['audit_trail:edit_success']                   = 'The post "%s" was updated.';
$lang['audit_trail:edit_error']                     = 'An error occurred.';
$lang['audit_trail:publish_success']                = 'The post "%s" has been published.';
$lang['audit_trail:mass_publish_success']           = 'The posts "%s" have been published.';
$lang['audit_trail:publish_error']                  = 'No posts were published.';
$lang['audit_trail:delete_success']                 = 'The post "%s" has been deleted.';
$lang['audit_trail:mass_delete_success']            = 'The posts "%s" have been deleted.';
$lang['audit_trail:delete_error']                   = 'No posts were deleted.';
$lang['audit_trail:already_exist_error']            = 'A approvegroup with this code already exist.';

$lang['audit_trail:cat_no_categories']          = 'There are no categories.';
$lang['audit_trail:user_no_approver']           = 'Oops! how did you get there? You cannot access that page.';
$lang['audit_trail:cat_add_success']            = 'Your approvegroup has been saved.';
$lang['audit_trail:cat_add_error']              = 'An error occurred.';
$lang['audit_trail:cat_edit_success']           = 'The approvegroup was saved.';
$lang['audit_trail:cat_edit_error']             = 'An error occurred.';
$lang['audit_trail:cat_delete_confirm']         = 'Are you sure you want to delete this Inventory approvegroup? The system will perform additional check before actual deletion to ensure data integrity is not compromised';
$lang['audit_trail:cat_mass_delete_error']      = 'Error occurred while trying to delete approvegroup "%s".';
$lang['audit_trail:cat_delete_error']           = 'Error occurred while trying to delete approvegroup "%s".';
$lang['audit_trail:cat_delete_error_has_item']  = 'The approvegroup cannot be deleted as items are reffering to this approvegroup.';
$lang['audit_trail:cat_mass_delete_success']    = '%s categories out of %s successfully deleted.';
$lang['audit_trail:cat_delete_success']         = 'The approvegroup has been deleted';
$lang['audit_trail:cat_no_select_error']        = 'You need to select categories first.';
$lang['audit_trail:cat_already_exist_error']    = 'A approvegroup with the name "%s" already exists.';



$lang['audit_trail:twitter_posted']                 = 'Posted "%s" %s';
$lang['audit_trail:twitter_error']                  = 'Twitter Error';

// date
$lang['audit_trail:archive_date_format']		= "%B %Y";
