<?php defined('BASEPATH') OR exit('No direct script access allowed');

/* -- Hear ye, hear ye --

The email settings are now taking place in
libraries/My_Email.php Most (or all) of the ones you
need to worry about are editable from the
settings page of the admin panel.

This public service announcement was sponsored in
part by www.unruhdesigns.com  :)
*/
$config['mailtype']="html";   
$config['protocol']="smtp";  
$config['smtp_host']="ssl://smtp.googlemail.com";  
$config['smtp_port']=465;  
$config['smtp_timeout']="30";  
$config['smtp_user']="webdev.onbusiness@gmail.com";  
$config['smtp_pass']="webdevob_2013";  
$config['charset']="utf-8";  
$config['newline']="\r\n";  
  
  // $email_config = Array(
				// 'protocol'  => 'smtp',
				// 'smtp_host' => 'ssl://smtp.googlemail.com',
				// 'smtp_port' => 465,
				// 'smtp_user' => 'webdev.onbusiness@gmail.com',
				// 'smtp_pass' => 'webdevob_2013',
				// 'mailtype'  => 'html',
				// 'smtp_timeout' => '30',
				// 'charset' => 'utf-8',
				// 'starttls'  => true,
				// 'newline'   => "\r\n"
			// );

			// $from = array('email' => 'webdev.onbusiness@gmail.com');
			// $to = array('veztsol@gmail.com');
			// $subject = "Testing Mail";
			// $message = "Welcome";
			// $this->load->library('email', $email_config);
			// $this->email->initialize($email_config);
				
			// $this->email->set_newline("\r\n");
			// $this->email->from($from['email']);
			// $this->email->to($to);
			// $this->email->subject($subject);
			// $this->email->message($message);

		 // if ($this->email->send()) {  echo "<script>alert('An email is sent to your email address');</script>";  } 
		 // else {  show_error($this->email->print_debugger());}
