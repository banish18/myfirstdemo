-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 07, 2017 at 11:15 AM
-- Server version: 5.6.35-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s9mindxp_ppm`
--

-- --------------------------------------------------------

--
-- Table structure for table `bugs`
--

CREATE TABLE `bugs` (
  `bugs_id` int(11) NOT NULL,
  `bugs_project_id` int(11) NOT NULL,
  `bugs_client_id` int(11) NOT NULL,
  `bugs_title` varchar(250) NOT NULL,
  `bugs_description` text NOT NULL,
  `bugs_reported_by_id` int(11) NOT NULL,
  `bugs_date` datetime NOT NULL,
  `bugs_status` varchar(20) NOT NULL DEFAULT 'new-bug' COMMENT 'new-bug/resolved/not-a-bug/in-progress/recurring',
  `bugs_comment` text NOT NULL,
  `bugs_resolved_by_id` int(11) NOT NULL,
  `bugs_admin_unread_comments` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `bugs_client_unread_comments` varchar(10) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `bugs_reported_by` varchar(10) NOT NULL DEFAULT 'client' COMMENT 'client/team'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `bug_comments`
--

CREATE TABLE `bug_comments` (
  `bug_comments_id` int(11) NOT NULL,
  `bug_comments_bug_id` int(11) DEFAULT NULL,
  `bug_comments_project_id` int(11) DEFAULT NULL,
  `bug_comments_date_added` datetime DEFAULT NULL,
  `bug_comments_user_id` int(11) DEFAULT NULL,
  `bug_comments_text` text,
  `bug_comments_user_type` varchar(10) DEFAULT NULL COMMENT 'client/team'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `ci_log`
--

CREATE TABLE `ci_log` (
  `ci_log_type` varchar(50) DEFAULT NULL COMMENT 'V4: Use whole table - with no data',
  `ci_log_file` varchar(50) DEFAULT NULL,
  `ci_log_function` varchar(50) DEFAULT NULL,
  `ci_log_line` int(11) DEFAULT NULL,
  `ci_log_message` text,
  `ci_log_date` datetime NOT NULL,
  `ci_log_ip_address` varchar(100) DEFAULT NULL,
  `ci_log_browser` varchar(100) DEFAULT NULL,
  `ci_log_user_agent` varchar(150) DEFAULT NULL,
  `ci_log_mobile_user` varchar(5) DEFAULT NULL,
  `ci_log_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT 'This Table: Has no default data',
  `ip_address` varchar(45) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `user_agent` varchar(120) COLLATE utf8_bin NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='dev: clear all data';

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('10244085bcbe428b1af8b10b222362a5', '103.245.189.198', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:53.0) Gecko/20100101 Firefox/53.0', 1495779833, 'a:8:{s:9:\"user_data\";s:0:\"\";s:15:\"team_profile_id\";s:1:\"1\";s:21:\"team_profile_uniqueid\";s:13:\"56b2148181cde\";s:22:\"team_profile_full_name\";s:4:\"Demo\";s:18:\"team_profile_email\";s:14:\"demo@gmail.com\";s:22:\"team_profile_groups_id\";s:1:\"1\";s:28:\"team_profile_avatar_filename\";s:17:\"56b2148181cde.png\";s:11:\"groups_name\";s:13:\"Administrator\";}'),
('92057fa76d96e3ebac1a03b7dd5637e1', '80.85.84.15', '0', 1495775314, ''),
('082490e1ca54435c5804e17e7790f0d5', '80.85.84.15', '0', 1495775379, ''),
('0e7084de96f1cc0c134ad613793c6313', '80.85.84.15', '0', 1495775380, ''),
('ccf4aa6a56eaf23a39dfc05adf58d2cf', '80.85.84.15', '0', 1495775380, ''),
('fdec9bfdddbebeef81c32430a3a03dbd', '80.85.84.15', '0', 1495775381, ''),
('a70e9e4378ffa377f6e18c9b9d7d86e4', '80.85.84.15', '0', 1495775381, ''),
('e9f0d40e3eaae46b65835096e82c0b6a', '80.85.84.15', '0', 1495775381, ''),
('6846c57dae12402aed8a4b2f52535cf0', '80.85.84.15', '0', 1495775381, ''),
('e979b1c88851c35afa2e0acc2a36afcb', '80.85.84.15', '0', 1495775381, ''),
('869fdee62da95c85f529e8d31b422683', '80.85.84.15', '0', 1495775381, ''),
('ce496738de1c28ec3b28607a816e0ac7', '80.85.84.15', '0', 1495775382, ''),
('a43d4879a20d6daa56b47af736ef2de1', '80.85.84.15', '0', 1495775435, ''),
('074dba26b32d5f6d38b133d83b3d0849', '80.85.84.15', '0', 1495775438, ''),
('ec7ef02356c3744ee5394de7ecc2fa31', '80.85.84.15', '0', 1495775452, ''),
('bf273bcb46b50fb5db8a609804415698', '80.85.84.15', '0', 1495775614, ''),
('4b72fcbc5209a2f09256be1b63afcc21', '80.85.84.15', '0', 1495775637, ''),
('09c1c9390da008ec4e95b5f396a28e79', '80.85.84.15', '0', 1495775708, ''),
('ee3ea3ae78b6044c7a397260b62041f5', '80.85.84.15', '0', 1495775734, ''),
('74c601bb33691840b0c7414f1057c3aa', '80.85.84.15', '0', 1495775750, ''),
('e008555091be22cb053851156a4fd21c', '80.85.84.15', '0', 1495775797, ''),
('61bb02736d475d7c9dd689cb04517d61', '80.85.84.15', '0', 1495775765, ''),
('6f16b23387dc9062c9f7d735ce39bcdc', '80.85.84.15', '0', 1495779842, '');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `clients_id` int(11) NOT NULL COMMENT 'This Table: Has no default data',
  `clients_date_created` date NOT NULL,
  `clients_company_name` varchar(150) NOT NULL,
  `clients_address` varchar(100) DEFAULT NULL,
  `clients_city` varchar(50) DEFAULT NULL,
  `clients_state` varchar(50) DEFAULT NULL,
  `clients_zipcode` varchar(50) DEFAULT NULL,
  `clients_country` varchar(50) DEFAULT NULL,
  `clients_website` varchar(50) DEFAULT NULL,
  `clients_optionalfield1` text,
  `clients_optionalfield2` text,
  `clients_optionalfield3` text,
  `client_unique_code` varchar(20) DEFAULT NULL,
  `clients_notes` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`clients_id`, `clients_date_created`, `clients_company_name`, `clients_address`, `clients_city`, `clients_state`, `clients_zipcode`, `clients_country`, `clients_website`, `clients_optionalfield1`, `clients_optionalfield2`, `clients_optionalfield3`, `client_unique_code`, `clients_notes`) VALUES
(1, '2017-05-26', 'Demo Company', '', '', '', '', '', '', '', '', '', 'HHyCRpBboyoAFQmSEGcn', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients_optionalfields`
--

CREATE TABLE `clients_optionalfields` (
  `clients_optionalfield_name` varchar(100) DEFAULT NULL COMMENT 'This table has 3 default rows',
  `clients_optionalfield_title` varchar(50) DEFAULT NULL,
  `clients_optionalfield_status` varchar(10) DEFAULT NULL,
  `clients_optionalfield_require` varchar(10) DEFAULT 'no' COMMENT 'yes/no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `clients_optionalfields`
--

INSERT INTO `clients_optionalfields` (`clients_optionalfield_name`, `clients_optionalfield_title`, `clients_optionalfield_status`, `clients_optionalfield_require`) VALUES
('clients_optionalfield1', 'Sample Text', 'disabled', 'no'),
('clients_optionalfield2', 'Sample Text', 'disabled', 'no'),
('clients_optionalfield3', 'Sample Text', 'disabled', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `client_users`
--

CREATE TABLE `client_users` (
  `client_users_id` int(11) NOT NULL COMMENT 'This Table: Has no default data',
  `client_users_clients_id` int(11) NOT NULL,
  `client_users_uniqueid` varchar(20) DEFAULT NULL,
  `client_users_avatar_filename` varchar(150) DEFAULT NULL,
  `client_users_full_name` varchar(75) NOT NULL,
  `client_users_job_position_title` varchar(50) DEFAULT NULL,
  `client_users_email` varchar(75) NOT NULL,
  `client_users_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'case sensitive utf8_bin',
  `client_users_telephone` varchar(50) DEFAULT NULL,
  `client_users_main_contact` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `client_users_reset_code` varchar(50) DEFAULT NULL,
  `client_users_reset_timestamp` datetime DEFAULT NULL,
  `client_users_last_active` datetime DEFAULT NULL,
  `client_users_file_added` varchar(5) DEFAULT 'yes',
  `client_users_milestone_added` varchar(5) DEFAULT 'yes',
  `client_users_milestone_completed` varchar(5) DEFAULT 'yes',
  `client_users_message_added` varchar(5) DEFAULT 'yes',
  `client_users_file_message_added` varchar(5) DEFAULT 'yes',
  `client_users_invoice_added` varchar(5) DEFAULT 'yes',
  `client_notifications_system` varchar(5) DEFAULT 'yes'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

--
-- Dumping data for table `client_users`
--

INSERT INTO `client_users` (`client_users_id`, `client_users_clients_id`, `client_users_uniqueid`, `client_users_avatar_filename`, `client_users_full_name`, `client_users_job_position_title`, `client_users_email`, `client_users_password`, `client_users_telephone`, `client_users_main_contact`, `client_users_reset_code`, `client_users_reset_timestamp`, `client_users_last_active`, `client_users_file_added`, `client_users_milestone_added`, `client_users_milestone_completed`, `client_users_message_added`, `client_users_file_message_added`, `client_users_invoice_added`, `client_notifications_system`) VALUES
(1, 1, 't6SBdidQR9CnYaUrsFTa', NULL, 'Demo', '', 'democomp@gmail.com', '14f4b2fc501ab14a296b1e8f621dffd6', '', 'yes', NULL, NULL, NULL, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `cronjobs`
--

CREATE TABLE `cronjobs` (
  `cronjobs_id` varchar(100) NOT NULL,
  `cronjobs_last_run` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `email_log`
--

CREATE TABLE `email_log` (
  `email_log_id` int(11) NOT NULL,
  `email_log_date` date NOT NULL,
  `email_log_time` time NOT NULL,
  `email_log_to_type` varchar(10) DEFAULT NULL,
  `email_log_to_address` varchar(100) DEFAULT NULL,
  `email_log_subject` varchar(250) DEFAULT NULL,
  `email_log_message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

--
-- Dumping data for table `email_log`
--

INSERT INTO `email_log` (`email_log_id`, `email_log_date`, `email_log_time`, `email_log_to_type`, `email_log_to_address`, `email_log_subject`, `email_log_message`) VALUES
(1, '2017-05-26', '04:55:22', NULL, 'democomp@gmail.com', 'Project Dashboard - Welcome ', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Welcome</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">Demo</span><br />\n<br />\nYour company has just been added to our Project Management Dashboard.<br />\n<br />\nBelow are your primary users login details.<br />\n<br />\nRemember, you can easily add more users to your company account via the Dashboard.<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Username</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">democomp@gmail.com</td>\n		</tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Password</td>\n			<td style=\"border: 1px solid #DDDDDD;\">demo@1234</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"http://demo.mindxpert.com/client\">http://demo.mindxpert.com/client</a></span></div>\n<br />\nFreelance Dashboard<br />\nThanks</div>\n</div>\n'),
(2, '2017-05-26', '04:55:24', NULL, 'demo@gmail.com', 'New Client Added', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Client</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>Demo</strong><br />\n<br />\nA new client has just been added to the Project Management Dashboard<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Full Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">Demo</td>\n		</tr>\n		<tr>\n		  <td style=\"border: 1px solid #DDDDDD;\"> Email Address</td>\n		  <td style=\"border: 1px solid #DDDDDD;\">democomp@gmail.com</td>\n	    </tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Company Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\">Demo Company</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"http://demo.mindxpert.com/admin\">http://demo.mindxpert.com/admin</a></span></div>\n<br />\n</div>\n</div>\n');

-- --------------------------------------------------------

--
-- Table structure for table `email_queue`
--

CREATE TABLE `email_queue` (
  `email_queue_id` int(11) NOT NULL,
  `email_queue_email` varchar(100) NOT NULL,
  `email_queue_subject` varchar(250) NOT NULL,
  `email_queue_message` text NOT NULL,
  `email_queue_date` datetime NOT NULL,
  `email_queue_attachment` varchar(250) DEFAULT NULL,
  `email_queue_attachment_delete` varchar(5) DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `filedownloads`
--

CREATE TABLE `filedownloads` (
  `filedownloads_id` int(11) NOT NULL,
  `filedownloads_project_id` int(11) NOT NULL,
  `filedownloads_client_id` int(11) NOT NULL,
  `filedownloads_file_id` int(11) NOT NULL,
  `filedownloads_date` datetime NOT NULL,
  `filedownloads_user_type` varchar(10) NOT NULL COMMENT 'client/team',
  `filedownloads_user_id` int(11) NOT NULL COMMENT 'id of client user/team member'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `files_id` int(11) NOT NULL,
  `files_project_id` int(11) NOT NULL,
  `files_client_id` int(11) NOT NULL,
  `files_uploaded_by` varchar(10) NOT NULL COMMENT 'client/team',
  `files_uploaded_by_id` int(11) NOT NULL,
  `files_name` varchar(250) NOT NULL,
  `files_description` text NOT NULL,
  `files_size` int(11) NOT NULL,
  `files_size_human` varchar(20) NOT NULL,
  `files_date_uploaded` date NOT NULL,
  `files_time_uploaded` time NOT NULL,
  `files_foldername` varchar(50) NOT NULL,
  `files_extension` varchar(50) NOT NULL,
  `files_events_id` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `file_comments`
--

CREATE TABLE `file_comments` (
  `file_comments_id` int(11) NOT NULL,
  `file_comments_file_id` int(11) NOT NULL,
  `file_comments_project_id` int(11) NOT NULL,
  `file_comments_client_id` int(11) NOT NULL,
  `file_comments_text` text NOT NULL,
  `file_comments_date` datetime NOT NULL,
  `file_comments_by` varchar(10) NOT NULL COMMENT 'team/client',
  `file_comments_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `file_messages`
--

CREATE TABLE `file_messages` (
  `messages_id` int(11) NOT NULL,
  `messages_project_id` int(11) NOT NULL,
  `messages_file_id` int(11) NOT NULL,
  `messages_date` datetime NOT NULL,
  `messages_text` tinytext NOT NULL,
  `messages_by_id` int(11) NOT NULL,
  `messages_by` varchar(20) NOT NULL COMMENT 'client/team'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `file_messages_replies`
--

CREATE TABLE `file_messages_replies` (
  `messages_replies_id` int(11) NOT NULL,
  `messages_replies_message_id` int(11) NOT NULL,
  `messages_replies_date` datetime NOT NULL,
  `messages_replies_text` text NOT NULL,
  `messages_replies_by_id` int(11) NOT NULL,
  `messages_replies_by` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `groups_id` int(11) NOT NULL COMMENT 'This table: Has 1 default row for admin group. Group ID must be [1] & Group Name must be [Administrator]',
  `groups_name` varchar(250) NOT NULL,
  `my_project_details` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_files` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_milestones` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_my_tasks` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_others_tasks` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_messages` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_team_messages` tinyint(4) NOT NULL DEFAULT '1',
  `my_project_invoices` tinyint(4) NOT NULL DEFAULT '1',
  `bugs` tinyint(4) NOT NULL DEFAULT '1',
  `clients` tinyint(4) NOT NULL DEFAULT '1',
  `tickets` tinyint(4) NOT NULL DEFAULT '1',
  `quotations` tinyint(4) NOT NULL DEFAULT '1',
  `groups_allow_delete` tinyint(1) NOT NULL DEFAULT '1',
  `groups_allow_edit` tinyint(1) NOT NULL DEFAULT '1',
  `groups_allow_migrate` tinyint(1) NOT NULL DEFAULT '1',
  `groups_allow_change_permissions` tinyint(1) NOT NULL DEFAULT '1',
  `groups_allow_zero_members` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`groups_id`, `groups_name`, `my_project_details`, `my_project_files`, `my_project_milestones`, `my_project_my_tasks`, `my_project_others_tasks`, `my_project_messages`, `my_project_team_messages`, `my_project_invoices`, `bugs`, `clients`, `tickets`, `quotations`, `groups_allow_delete`, `groups_allow_edit`, `groups_allow_migrate`, `groups_allow_change_permissions`, `groups_allow_zero_members`) VALUES
(1, 'Administrator', 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0),
(2, 'Staff', 1, 4, 4, 4, 1, 4, 4, 1, 4, 1, 4, 3, 1, 1, 1, 1, 1),
(3, 'Agent', 1, 4, 1, 2, 1, 0, 4, 0, 4, 0, 0, 0, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoices_id` int(11) NOT NULL,
  `invoices_custom_id` varchar(150) DEFAULT NULL,
  `invoices_unique_id` varchar(75) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `invoices_project_id` int(11) NOT NULL,
  `invoices_clients_id` int(11) NOT NULL,
  `invoices_pretax_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `invoices_tax_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `invoices_amount` decimal(10,2) DEFAULT '0.00',
  `invoices_tax_rate` decimal(10,2) DEFAULT '0.00',
  `invoices_date` date NOT NULL,
  `invoices_due_date` date NOT NULL,
  `invoices_status` varchar(30) NOT NULL DEFAULT 'due' COMMENT 'new/paid/due/partpaid/overdue [new is the status of an unpublished/unsent invoice]',
  `invoices_notes` varchar(250) DEFAULT NULL,
  `invoices_created_by_id` int(11) DEFAULT NULL,
  `invoices_times_emailed` int(11) DEFAULT '0',
  `invoices_last_emailed` datetime DEFAULT NULL,
  `invoices_events_id` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `invoice_items_id` int(11) NOT NULL,
  `invoice_items_date_added` date NOT NULL,
  `invoice_items_title` varchar(250) NOT NULL,
  `invoice_items_description` varchar(250) DEFAULT NULL,
  `invoice_items_amount` decimal(10,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `invoice_products`
--

CREATE TABLE `invoice_products` (
  `invoice_products_id` int(11) NOT NULL,
  `invoice_products_project_id` int(11) NOT NULL,
  `invoice_products_invoice_id` int(11) NOT NULL,
  `invoice_products_title` varchar(250) NOT NULL,
  `invoice_products_description` varchar(250) NOT NULL,
  `invoice_products_quantity` int(11) NOT NULL,
  `invoice_products_rate` decimal(10,2) NOT NULL,
  `invoice_products_total` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `messages_id` int(11) NOT NULL,
  `messages_project_id` int(11) NOT NULL,
  `messages_date` datetime NOT NULL,
  `messages_text` text NOT NULL,
  `messages_by` varchar(15) NOT NULL COMMENT 'client/team',
  `messages_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `messages_replies`
--

CREATE TABLE `messages_replies` (
  `messages_replies_id` int(11) NOT NULL,
  `messages_replies_project_id` int(11) NOT NULL,
  `messages_replies_message_id` int(11) NOT NULL,
  `messages_replies_date` datetime NOT NULL,
  `messages_replies_text` text NOT NULL,
  `messages_replies_by` varchar(15) NOT NULL COMMENT 'client/team',
  `messages_replies_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `milestones`
--

CREATE TABLE `milestones` (
  `milestones_id` int(11) NOT NULL,
  `milestones_project_id` int(11) NOT NULL,
  `milestones_client_id` int(11) NOT NULL,
  `milestones_title` varchar(250) NOT NULL,
  `milestones_start_date` date NOT NULL,
  `milestones_end_date` date NOT NULL,
  `milestones_created_by` int(11) NOT NULL,
  `milestones_status` varchar(50) NOT NULL DEFAULT 'pending' COMMENT 'pending/completed/behind schedule',
  `milestones_events_id` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `mynotes`
--

CREATE TABLE `mynotes` (
  `mynotes_id` int(11) NOT NULL,
  `mynotes_project_id` int(11) NOT NULL,
  `mynotes_team_id` int(11) NOT NULL,
  `mynotes_last_edited` datetime NOT NULL,
  `mynotes_text` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `online_status`
--

CREATE TABLE `online_status` (
  `online_status_id` int(11) NOT NULL COMMENT 'This Table: Has no default data',
  `online_status_userid` int(11) NOT NULL,
  `online_status_usertype` int(11) NOT NULL,
  `online_status_last_seen` time DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payments_id` int(11) NOT NULL,
  `payments_invoice_id` int(11) NOT NULL,
  `payments_project_id` int(11) NOT NULL,
  `payments_client_id` int(11) NOT NULL,
  `payments_amount` decimal(10,2) NOT NULL,
  `payments_currency_code` varchar(25) NOT NULL,
  `payments_transaction_id` varchar(100) DEFAULT NULL,
  `payments_transaction_status` varchar(50) DEFAULT NULL,
  `payments_date` datetime NOT NULL,
  `payments_method` varchar(50) NOT NULL,
  `payments_notes` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `paypal_ipn_log`
--

CREATE TABLE `paypal_ipn_log` (
  `ipn_id` int(11) NOT NULL,
  `ipn_date` date NOT NULL,
  `ipn_invoice_id` int(11) DEFAULT '0',
  `ipn_project_id` int(11) DEFAULT '0',
  `ipn_invoice_unique_id` varchar(50) DEFAULT '0',
  `ipn_transaction_id` varchar(50) DEFAULT '0',
  `ipn_transaction_amount` varchar(50) DEFAULT '0',
  `ipn_transaction_status` varchar(50) DEFAULT NULL,
  `ipn_data_dump` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `level` tinyint(4) DEFAULT NULL,
  `view_item` varchar(3) NOT NULL DEFAULT 'no',
  `add_item` varchar(3) NOT NULL DEFAULT 'no',
  `edit_item` varchar(3) NOT NULL DEFAULT 'no',
  `delete_item` varchar(3) NOT NULL DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`level`, `view_item`, `add_item`, `edit_item`, `delete_item`) VALUES
(0, 'no', 'no', 'no', 'no'),
(1, 'yes', 'no', 'no', 'no'),
(2, 'yes', 'yes', 'no', 'no'),
(3, 'yes', 'yes', 'yes', 'no'),
(4, 'yes', 'yes', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `pinned`
--

CREATE TABLE `pinned` (
  `pinned_id` int(11) NOT NULL,
  `pinned_project_id` int(11) DEFAULT NULL,
  `pinned_userid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `ppmupdates`
--

CREATE TABLE `ppmupdates` (
  `id` int(11) NOT NULL,
  `latest_version` varchar(255) NOT NULL,
  `update_notes` text NOT NULL,
  `update_download_link` text NOT NULL,
  `update_available` int(11) NOT NULL,
  `purchase_code` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ppmupdates`
--

INSERT INTO `ppmupdates` (`id`, `latest_version`, `update_notes`, `update_download_link`, `update_available`, `purchase_code`) VALUES
(1, '2.0.1', '\r\nA new update is available\r\n\r\n    - Download the file using the link below\r\n    - Unzip the file\r\n    - Upload the\"contents\" of the unzipped folder into your \"main FTP\" directory\r\n    (i.e.to over-write folders with same name in your FTP)\r\n\r\nWARNING: Always beackup your website and database before doing an update\r\n', 'http://mindxpert.com/development/file.zip', 1, 'feejha5a1-t90f-4u8e-bla6-753d655a4d02');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `projects_id` int(11) NOT NULL,
  `projects_date_created` date NOT NULL,
  `project_deadline` date DEFAULT NULL,
  `projects_date_completed` date DEFAULT NULL,
  `projects_clients_id` int(11) NOT NULL,
  `projects_team_lead_id` int(11) DEFAULT NULL,
  `projects_title` varchar(250) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `projects_description` text CHARACTER SET utf8 COLLATE utf8_bin,
  `projects_last_activity` datetime DEFAULT NULL,
  `projects_progress_percentage` tinyint(3) DEFAULT '0',
  `projects_status` varchar(30) NOT NULL DEFAULT 'in progress' COMMENT 'in progress/completed/behind schedule',
  `projects_events_id` varchar(40) DEFAULT NULL,
  `projects_optionalfield1` text,
  `projects_optionalfield2` text,
  `projects_optionalfield3` text,
  `projects_optionalfield4` text,
  `projects_optionalfield5` text,
  `project_allow_client_add_tasks` varchar(5) DEFAULT 'no' COMMENT 'yes/no',
  `project_allow_client_delete_own_tasks` varchar(5) DEFAULT 'no' COMMENT 'yes/no',
  `project_allow_client_delete_any_tasks` varchar(5) DEFAULT 'no' COMMENT 'yes/no',
  `project_allow_client_add_task_files` varchar(5) DEFAULT 'no' COMMENT 'yes/no',
  `project_allow_client_delete_own_task_files` varchar(5) DEFAULT 'no' COMMENT 'yes/no',
  `project_allow_client_delete_any_task_files` varchar(5) DEFAULT 'no' COMMENT 'yes/no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `projects_optionalfields`
--

CREATE TABLE `projects_optionalfields` (
  `projects_optionalfield_name` varchar(100) NOT NULL,
  `projects_optionalfield_title` varchar(50) NOT NULL,
  `projects_optionalfield_status` varchar(10) NOT NULL COMMENT 'enabled/disabled',
  `projects_optionalfield_require` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `projects_optionalfields`
--

INSERT INTO `projects_optionalfields` (`projects_optionalfield_name`, `projects_optionalfield_title`, `projects_optionalfield_status`, `projects_optionalfield_require`) VALUES
('projects_optionalfield1', 'Website URL', 'enabled', 'no'),
('projects_optionalfield2', 'FTP User Name', 'enabled', 'no'),
('projects_optionalfield3', 'FTP Password', 'enabled', 'no'),
('projects_optionalfield4', 'Sample Text', 'disabled', 'no'),
('projects_optionalfield5', 'Sample Text', 'disabled', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `project_events`
--

CREATE TABLE `project_events` (
  `project_events_id` int(11) NOT NULL,
  `project_events_project_id` varchar(40) NOT NULL,
  `project_events_date` datetime NOT NULL,
  `project_events_type` varchar(100) DEFAULT NULL COMMENT 'deleted/milestone/ file/invoice/file-message/project-message/milestone/task/project/bug/payment',
  `project_events_details` varchar(100) DEFAULT NULL,
  `project_events_action` varchar(100) DEFAULT NULL,
  `project_events_target_id` varchar(150) DEFAULT NULL,
  `project_events_user_id` int(11) DEFAULT NULL,
  `project_events_user_type` varchar(30) DEFAULT NULL,
  `project_events_link` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `project_members`
--

CREATE TABLE `project_members` (
  `project_members_index` int(11) NOT NULL,
  `project_members_team_id` int(11) NOT NULL,
  `project_members_project_id` int(11) NOT NULL,
  `project_members_project_lead` varchar(5) NOT NULL DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `quotationforms`
--

CREATE TABLE `quotationforms` (
  `quotationforms_id` int(11) NOT NULL,
  `quotationforms_title` varchar(200) NOT NULL,
  `quotationforms_code` text NOT NULL,
  `quotationforms_date_created` datetime NOT NULL,
  `quotationforms_status` varchar(20) NOT NULL DEFAULT 'enabled' COMMENT 'enabled/disabled',
  `quotations_created_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP (has 1 default row)';

--
-- Dumping data for table `quotationforms`
--

INSERT INTO `quotationforms` (`quotationforms_id`, `quotationforms_title`, `quotationforms_code`, `quotationforms_date_created`, `quotationforms_status`, `quotations_created_by_id`) VALUES
(1, 'Web Design Quotation Form', '{\"fields\":[{\"label\":\"Do you have your existing site for redesign or you need new website\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\",\"description\":\"Test\"},\"cid\":\"c35\"},{\"label\":\"Can you please describe your business\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c10\"},{\"label\":\"Who are your competitors\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c14\"},{\"label\":\"Do you have special features in mind\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c18\"},{\"label\":\" Is the content ready for your web site\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c40\"},{\"label\":\"Are there any example websites that you like\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c30\"},{\"label\":\"What is your approximate budget for this project\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c26\"},{\"label\":\"What is your deadline for finishing the site\",\"field_type\":\"paragraph\",\"required\":true,\"field_options\":{\"size\":\"small\"},\"cid\":\"c44\"}]}', '2014-12-11 08:34:00', 'enabled', 1);

-- --------------------------------------------------------

--
-- Table structure for table `quotationforms_templates`
--

CREATE TABLE `quotationforms_templates` (
  `quotationforms_templates_id` varchar(100) NOT NULL,
  `quotationforms_templates_title` varchar(150) NOT NULL,
  `quotationforms_templates_content` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `quotations_id` int(11) NOT NULL,
  `quotations_date` datetime NOT NULL,
  `quotations_form_title` varchar(250) NOT NULL,
  `quotations_post_data` text NOT NULL,
  `quotations_form_data` text NOT NULL,
  `quotations_by_client` varchar(10) DEFAULT 'no' COMMENT 'yes/no',
  `quotations_client_id` int(11) DEFAULT NULL,
  `quotations_company_name` varchar(100) DEFAULT NULL,
  `quotations_name` varchar(100) DEFAULT NULL,
  `quotations_email` varchar(100) DEFAULT NULL,
  `quotations_telephone` varchar(100) DEFAULT NULL,
  `quotations_amount` decimal(10,2) DEFAULT NULL,
  `quotations_admin_notes` text,
  `quotations_reviewed_by_id` int(11) DEFAULT NULL,
  `quotations_reviewed_date` date DEFAULT NULL,
  `quotations_status` varchar(15) DEFAULT 'pending' COMMENT 'completed/pending'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `search_cache`
--

CREATE TABLE `search_cache` (
  `id` int(11) NOT NULL COMMENT 'This Table: Has no default data',
  `query_string` text CHARACTER SET utf8 COLLATE utf8_bin,
  `date_added` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `settings_bank`
--

CREATE TABLE `settings_bank` (
  `settings_id` varchar(20) NOT NULL,
  `bank_active` varchar(20) NOT NULL COMMENT 'yes/no',
  `settings_bank_details` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_bank`
--

INSERT INTO `settings_bank` (`settings_id`, `bank_active`, `settings_bank_details`) VALUES
('default', 'no', 'To make a bank transfer, please use the following banking details<br />\n<br />\n<strong>Bank Name:</strong> bank pvt ltd<br />\n<strong>Bank Address:</strong> 1 some road, some city, some country<br />\n<strong>Account Number:</strong> 000-000-000-000<br />\n<strong>Sort Code:</strong> 000-000<br />\n<strong>Swift Code:</strong> XYZ-00-0-00<br />\n<br />\nOnce your payment has been received, your invoice will be updated.<br />\n&nbsp;');

-- --------------------------------------------------------

--
-- Table structure for table `settings_cash`
--

CREATE TABLE `settings_cash` (
  `settings_id` varchar(20) NOT NULL,
  `cash_active` varchar(10) NOT NULL COMMENT 'yes/no',
  `settings_cash_details` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_cash`
--

INSERT INTO `settings_cash` (`settings_id`, `cash_active`, `settings_cash_details`) VALUES
('default', 'yes', 'Once you have made your cash payment please advise us so that your invoice can be updated.');

-- --------------------------------------------------------

--
-- Table structure for table `settings_clientform`
--

CREATE TABLE `settings_clientform` (
  `settings_id` varchar(20) NOT NULL,
  `clients_address` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `clients_city` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `clients_state` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `clients_zipcode` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `clients_country` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `clients_website` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `client_users_telephone` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no',
  `client_users_job_position_title` varchar(5) NOT NULL DEFAULT 'no' COMMENT 'yes/no'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_clientform`
--

INSERT INTO `settings_clientform` (`settings_id`, `clients_address`, `clients_city`, `clients_state`, `clients_zipcode`, `clients_country`, `clients_website`, `client_users_telephone`, `client_users_job_position_title`) VALUES
('default', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `settings_company`
--

CREATE TABLE `settings_company` (
  `settings_id` varchar(20) NOT NULL,
  `company_name` varchar(100) NOT NULL COMMENT 'This Table: Has one default row with place holder company details. [company_sys: default]',
  `company_address_street` varchar(150) DEFAULT NULL,
  `company_address_city` varchar(100) DEFAULT NULL,
  `company_address_state` varchar(100) DEFAULT NULL,
  `company_address_zip` varchar(50) DEFAULT NULL,
  `company_address_country` varchar(50) DEFAULT NULL,
  `company_telephone` varchar(25) DEFAULT NULL,
  `company_email` varchar(100) NOT NULL,
  `company_email_name` varchar(50) NOT NULL,
  `company_email_signature` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_company`
--

INSERT INTO `settings_company` (`settings_id`, `company_name`, `company_address_street`, `company_address_city`, `company_address_state`, `company_address_zip`, `company_address_country`, `company_telephone`, `company_email`, `company_email_name`, `company_email_signature`) VALUES
('default', 'Some Company Inc', '1 Some Street', 'Some City', '', '000000', 'Some Country', '000000000', 'you@somecompnay.ccc', 'Some Company Name', 'Freelance Dashboard<br />\nThanks');

-- --------------------------------------------------------

--
-- Table structure for table `settings_emailtemplates`
--

CREATE TABLE `settings_emailtemplates` (
  `id` int(11) NOT NULL,
  `DELETE_POST_DEV` text NOT NULL,
  `type` varchar(10) NOT NULL COMMENT 'admin/client',
  `status` varchar(20) NOT NULL DEFAULT 'enabled' COMMENT 'enabled/disabled',
  `settings_id` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `subject` varchar(250) NOT NULL,
  `message` text NOT NULL,
  `restore_subject` varchar(250) NOT NULL COMMENT 'restore data',
  `restore_message` text NOT NULL COMMENT 'restore data',
  `variables` text NOT NULL COMMENT 'available vars'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_emailtemplates`
--

INSERT INTO `settings_emailtemplates` (`id`, `DELETE_POST_DEV`, `type`, `status`, `settings_id`, `title`, `subject`, `message`, `restore_subject`, `restore_message`, `variables`) VALUES
(1, 'tested - feb 2016', 'client', 'enabled', 'new_client_welcome_client', 'lang_new_client', 'Project Dashboard - Welcome ', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Welcome</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.to_name]</span><br />\n<br />\nYour company has just been added to our Project Management Dashboard.<br />\n<br />\nBelow are your primary users login details.<br />\n<br />\nRemember, you can easily add more users to your company account via the Dashboard.<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Username</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.username]</td>\n		</tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Password</td>\n			<td style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n[var.email_signature]</div>\n</div>\n', 'Project Dashboard - Welcome ', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Welcome</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.to_name]</span><br />\n<br />\nYour company has just been added to our Project Management Dashboard.<br />\n<br />\nBelow are your primary users login details.<br />\n<br />\nRemember, you can easily add more users to your company account via the Dashboard.<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Username</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.username]</td>\n		</tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Password</td>\n			<td style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n[var.email_signature]</div>\n</div>\n', '[var.to_name], [var.username], [var.company_name], [var.url_dashboard], [var.todays_date], [var.email_signature]'),
(18, 'tested - feb 2016', 'admin', 'enabled', 'new_quotation_admin', 'lang_new_quotation', 'New Quotation Request', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">QUOTATION</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new quotation has been submitted.\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Company Name</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.company_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Name</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Telephone</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_telephone]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Email</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_email]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Quotation Form</td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.quotation_form_name]</td>\n  </tr>\n </tbody>\n</table>\n<br /><br>\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_quotation]\">[var.url_quotation]</a> </span></div><br />\n</div>\n</div>', 'New Quotation Request', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">QUOTATION</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new quotation has been submitted.\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Company Name</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.company_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Name</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Telephone</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_telephone]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Contact Email</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.contact_email]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Quotation Form</td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.quotation_form_name]</td>\n  </tr>\n </tbody>\n</table>\n<br /><br>\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_quotation]\">[var.url_quotation]</a> </span></div><br />\n</div>\n</div>', '[var.to_name], [var.company_name], [var.contact_name], [var.contact_telephone], [var.contact_email], [var.quotation_form_name], [var.url_dashboard], [var.todays_date]'),
(7, 'tested - feb 2016', 'client', 'enabled', 'new_invoice_client', 'lang_new_invoice', 'Your Invoice', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">YOUR INVOICE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]</span></span><br />\n<br />\nPlease find attched your invoice. You can download the attachment and print it for your records.<br />\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice Total</td>\n    <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_total_amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Your Payments</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_previous_payments]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Amount Now Due</strong></td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_amount_due]</strong></td>\n  </tr>\n</table>\n<br /><br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n      <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Invoice Status</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_status]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Created</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_created]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Due</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_due]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n  </table>\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>View &amp; Pay Invoice  </strong><span style=\"font-size:14px;\"><a href=\"[var.url_invoice]\">[var.url_invoice]</a></span></div>\n<br /> \n[var.invoice_terms]\n<br />\n<br />\n[var.email_signature]</div>\n</div>\n', 'Your Invoice', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">YOUR INVOICE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]</span></span><br />\n<br />\nPlease find attched your invoice. You can download the attachment and print it for your records.<br />\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice Total</td>\n    <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_total_amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Your Payments</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_previous_payments]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Amount Now Due</strong></td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_amount_due]</strong></td>\n  </tr>\n</table>\n<br /><br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n      <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Invoice Status</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_status]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Created</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_created]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Due</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_due]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n  </table>\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>View &amp; Pay Invoice  </strong><span style=\"font-size:14px;\"><a href=\"[var.url_invoice]\">[var.url_invoice]</a></span></div>\n<br /> \n[var.invoice_terms]\n<br />\n<br />\n[var.email_signature]</div>\n</div>\n', '[var.to_name], [var.clients_company_name], [var.invoice_id], [var.invoice_custom_id], [var.invoice_total_amount], [var.invoice_previous_payments], [var.invoice_amount_due], [var.invoice_date_created], [var.invoice_date_due], [var.invoice_status], [var.project_title], [var.project_id], [var.invoice_terms], [var.url.invoice], [var.url_dashboard], [var.email_signature]'),
(8, '', 'client', 'enabled', 'reminder_invoice_client', 'lang_invoice_reminder', 'Your Invoice - Reminder', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\"> INVOICE REMINDER</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]</span></span><br />\n<br />\nPlease find attched your invoice. You can download the attachment and print it for your records.<br />\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice Total</td>\n    <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_total_amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Your Payments</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_previous_payments]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Amount Now Due</strong></td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_amount_due]</strong></td>\n  </tr>\n</table>\n<br /><br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n      <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Invoice Status</td>\n      <td style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_status]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Created</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_created]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Due</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_due]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n  </table>\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>View &amp; Pay Invoice  </strong><span style=\"font-size:14px;\"><a href=\"[var.url_invoice]\">[var.url_invoice]</a></span></div>\n<br /> \n[var.invoice_terms]\n<br />\n<br />\n[var.email_signature]</div>\n</div>\n', 'Your Invoice - Reminder', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\"> INVOICE REMINDER</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]</span></span><br />\n<br />\nPlease find attched your invoice. You can download the attachment and print it for your records.<br />\n<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice Total</td>\n    <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_total_amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Your Payments</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_previous_payments]</td>\n  </tr>\n  <tr>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Amount Now Due</strong></td>\n    <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_amount_due]</strong></td>\n  </tr>\n</table>\n<br /><br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"329\" style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n      <td width=\"605\" style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Invoice Status</td>\n      <td style=\"border: 1px solid #DDDDDD;\"><strong>[var.invoice_status]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Created</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_created]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Due</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_date_due]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n  </table>\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>View &amp; Pay Invoice  </strong><span style=\"font-size:14px;\"><a href=\"[var.url_invoice]\">[var.url_invoice]</a></span></div>\n<br /> \n[var.invoice_terms]\n<br />\n<br />\n[var.email_signature]</div>\n</div>\n', '[var.to_name], [var.clients_company_name], [var.invoice_id], [var.invoice_custom_id], [var.invoice_total_amount], [var.invoice_previous_payments], [var.invoice_amount_due], [var.invoice_date_created], [var.invoice_date_due], [var.invoice_status], [var.project_title], [var.project_id], [var.invoice_terms], [var.url.invoice], [var.url_dashboard], [var.email_signature]'),
(5, 'tested - feb 2016', 'client', 'enabled', 'new_project_client', 'lang_new_project', 'New Project Created', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW PROJECT</div>\n<div style=\"text-align:center; font-size:24px; font-weight:bold; color:#535353;\"></div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]<br />\n</span></span><br /> \n  A new project has been added to your Project Dashboard.\n  <br />\n  <br />\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Title</strong></td>\n      <td width=\"276\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.project_title]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Deadline</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_deadline]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project Created By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_created_by]</td>\n    </tr>\n  </table><br>\n<br>\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong> Project URL </strong><span style=\"font-size:14px;\"><a href=\"[var.url_project]\">[var.url_project]</a></span></div>\n<br />\n[var.email_signature]\n</div>\n</div>', 'New Project Created', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW PROJECT</div>\n<div style=\"text-align:center; font-size:24px; font-weight:bold; color:#535353;\"></div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">[var.to_name]<br />\n</span></span><br /> \n  A new project has been added to your Project Dashboard.\n  <br />\n  <br />\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Title</strong></td>\n      <td width=\"276\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.project_title]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Deadline</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_deadline]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project Created By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_created_by]</td>\n    </tr>\n  </table><br>\n<br>\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong> Project URL </strong><span style=\"font-size:14px;\"><a href=\"[var.url_project]\">[var.url_project]</a></span></div>\n<br />\n[var.email_signature]\n</div>\n</div>', '[var.to_name], [var.clients_company_name], [var.project_title], [var.project_id], [var.project_deadline], [var.project_created_by], [var.url_project], [var.url_dashboard], [var.todays_date], [var.email_signature] '),
(50, 'tested - feb 2016', 'client', 'enabled', 'general_notification_client', 'lang_general_notification', 'Project Notification', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">[var.email_title]</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.addressed_to]</span><br />\n<br />\n[var.email_message]<br />\n<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.client_dashboard_url]\">[var.client_dashboard_url]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', 'Project Notification', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">  [var.email_title]</div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.addressed_to]<br />\n</span><br /> \n  [var.email_message]<br />\n  <br />\n  <br>\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.client_dashboard_url]\">[var.client_dashboard_url]</a></span></div>\n<br />\n[var.company_email_signature]\n</div>\n</div>', '[var.company_email_signature], [var.todays_date], [var.client_dashboard_url], [var.notification_message]'),
(3, 'tested - feb 2016', 'client', 'enabled', 'new_user_client', 'lang_new_user', 'Dashboard Login Details', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Dashboard Login Details</div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.to_name]<br />\n</span><br /> \n  You have just been added to the Project Dashboard<br />\n  <br />\n  Below are your users login details<br />\n<br>\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Username</td>\n      <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Password</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n    </tr>\n  </table>\n<br>\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n[var.email_signature]\n</div>\n</div>', 'Dashboard Login Details', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Dashboard Login Details</div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.to_name]<br />\n</span><br /> \n  You have just been added to the Project Dashboard<br />\n  <br />\n  Below are your users login details<br />\n<br>\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Username</td>\n      <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Password</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n    </tr>\n  </table>\n<br>\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n[var.email_signature]\n</div>\n</div>', '[var.to_name], [var.clients_company_name], [var.username], [var.password], [var.url_dashboard], [var.todays_date], [var.email_signature] '),
(51, 'tested - feb 2016', 'admin', 'enabled', 'general_notification_admin', 'lang_general_notification', 'Project Notification', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">  [var.email_title]</div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.addressed_to]<br />\n</span><br /> \n  [var.email_message]<br />\n  <br />\n  <br>\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.admin_dashboard_url]\">[var.admin_dashboard_url]</a></span></div>\n<br />\n</div>\n</div>', 'Project Notification', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">  [var.email_title]</div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span style=\"font-weight:bold;\">[var.addressed_to]<br />\n</span><br /> \n  [var.email_message]<br />\n  <br />\n  <br>\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.admin_dashboard_url]\">[var.admin_dashboard_url]</a></span></div>\n<br />\n</div>\n</div>', '[var.company_email_signature], [var.todays_date], [var.client_dashboard_url], [var.notification_message]'),
(2, 'tested - feb 2016', 'admin', 'enabled', 'new_client_admin', 'lang_new_client', 'New Client Added', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Client</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA new client has just been added to the Project Management Dashboard<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Full Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.clients_full_name]</td>\n		</tr>\n		<tr>\n		  <td style=\"border: 1px solid #DDDDDD;\"> Email Address</td>\n		  <td style=\"border: 1px solid #DDDDDD;\">[var.clients_email]</td>\n	    </tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Company Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n</div>\n</div>\n', 'New Client Added', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Client</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA new client has just been added to the Project Management Dashboard<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Full Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.clients_full_name]</td>\n		</tr>\n		<tr>\n		  <td style=\"border: 1px solid #DDDDDD;\"> Email Address</td>\n		  <td style=\"border: 1px solid #DDDDDD;\">[var.clients_email]</td>\n	    </tr>\n		<tr>\n			<td style=\"border: 1px solid #DDDDDD;\">Company Name</td>\n			<td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n		</tr>\n	</tbody>\n</table>\n&nbsp;\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a></span></div>\n<br />\n</div>\n</div>\n', '[var.to_name], [var.clients_full_name], [var.clients_email], [var.clients_company_name], [var.url_dashboard], [var.todays_date]'),
(6, 'tested - feb 2016', 'admin', 'enabled', 'new_project_admin', 'lang_new_project', 'New Project Created', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW PROJECT</div>\n<div style=\"text-align:center; font-size:24px; font-weight:bold; color:#535353;\"></div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\"> [var.to_name]<br />\n</span></span><br /> \n  A new project has been added to the Project Dashboard<br />\n  <br />\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Title</strong></td>\n      <td width=\"276\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.project_title]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Client</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Deadline</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_deadline]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project Created By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_created_by]</td>\n    </tr>\n  </table>\n  <br /><br>\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project URL </strong><span style=\"font-size:14px;\"><a href=\"[var.url_project]\">[var.url_project]</a></span></div>\n</div>\n</div>', 'New Project Created', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW PROJECT</div>\n<div style=\"text-align:center; font-size:24px; font-weight:bold; color:#535353;\"></div>\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\"> [var.to_name]<br />\n</span></span><br /> \n  A new project has been added to the Project Dashboard<br />\n  <br />\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td width=\"150\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Title</strong></td>\n      <td width=\"276\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>[var.project_title]</strong></td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Client</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Deadline</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_deadline]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_id]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project Created By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.project_created_by]</td>\n    </tr>\n  </table>\n  <br /><br>\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project URL </strong><span style=\"font-size:14px;\"><a href=\"[var.url_project]\">[var.url_project]</a></span></div>\n</div>\n</div>', '[var.to_name], [var.clients_company_name], [var.project_title], [var.project_id], [var.project_deadline], [var.project_created_by], [var.url_project], [var.url_dashboard], [var.todays_date] '),
(4, 'tested - feb 2016', 'admin', 'enabled', 'new_user_admin', 'lang_new_user', 'New Client User', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n  <div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Client User</div>\n  <div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"> <strong>[var.to_name]</strong><br>\n    <br>\n    A new Client User  has just been added to the Project Dashboard<br />\n    <br />\n    Below are the user\'s login details<br />\n    <br>\n    <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Client Name</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n      </tr>\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Full Name</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.users_full_name]</td>\n      </tr>\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Username</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n      </tr>\n      <tr>\n        <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Password</td>\n        <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n      </tr>\n    </table>\n    <br>\n    <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </div>\n  </div>\n</div>', 'New Client User', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n  <div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Client User</div>\n  <div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"> <strong>[var.to_name]</strong><br>\n    <br>\n    A new Client User  has just been added to the Project Dashboard<br />\n    <br />\n    Below are the user\'s login details<br />\n    <br>\n    <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Client Name</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.clients_company_name]</td>\n      </tr>\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Full Name</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.users_full_name]</td>\n      </tr>\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Username</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n      </tr>\n      <tr>\n        <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Password</td>\n        <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n      </tr>\n    </table>\n    <br>\n    <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </div>\n  </div>\n</div>', '[var.to_name], [var.clients_company_name], [var.username], [var.password], [var.users_full_name], [var.url_dashboard], [var.todays_date], [var.email_signature] '),
(11, '', 'client', 'enabled', 'password_reset_client', 'lang_reset_password', 'Reset Your Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Reset Your Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br />\nYou have requested to reset your password. You can reset you password using the link below.<br />\n<br />\nThis link will expire after <strong>30 Minutes</strong>.<br />\n<br />\nIf you have not requested this email please notify us.<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Password reset link: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_reset_link]\">[var.url_reset_link]</a> </span></div><br>\n [var.email_signature]\n</div>\n</div>\n', 'Reset Your Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Reset Your Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br />\nYou have requested to reset your password. You can reset you password using the link below.<br />\n<br />\nThis link will expire after <strong>30 Minutes</strong>.<br />\n<br />\nIf you have not requested this email please notify us.<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Password reset link: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_reset_link]\">[var.url_reset_link]</a> </span></div><br>\n [var.email_signature]\n</div>\n</div>\n', '[var.to_name], [var.todays_date], [var.url_reset_link], [var.url_dashboard], [var.email_signature]'),
(12, '', 'client', 'enabled', 'new_password_client', 'lang_new_password', 'Your New Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Your New Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br /> \nYour password has been reset. Below is your new password<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">New Password</td>\n    <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.new_password]</td>\n  </tr>\n</table>\n<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </span></div><br />\n[var.email_signature]\n</div>\n</div>\n', 'Your New Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Your New Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br /> \nYour password has been reset. Below is your new password<br />\n<br />\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">New Password</td>\n    <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.new_password]</td>\n  </tr>\n</table>\n<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </span></div><br />\n[var.email_signature]\n</div>\n</div>\n', '[var.to_name], [var.todays_date], [var.new_password], [var.url_dashboard], [var.email_signature]');
INSERT INTO `settings_emailtemplates` (`id`, `DELETE_POST_DEV`, `type`, `status`, `settings_id`, `title`, `subject`, `message`, `restore_subject`, `restore_message`, `variables`) VALUES
(14, '', 'admin', 'enabled', 'password_reset_admin', 'lang_reset_password', 'Reset Your Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Reset Your Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br />\nYou have requested to reset your password. You can reset you password using the link below.<br />\n<br />\nThis link will expire after <strong>30 Minutes</strong>.<br />\n<br />\nIf you have not requested this email please notify us.<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Password reset link: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_reset_link]\">[var.url_reset_link]</a> </span></div><br>\n</div>\n</div>\n', 'Reset Your Password', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">Reset Your Password</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><span class=\"style1\"><span style=\"font-weight:bold;\">Hello [var.to_name]</span></span><br />\n<br />\nYou have requested to reset your password. You can reset you password using the link below.<br />\n<br />\nThis link will expire after <strong>30 Minutes</strong>.<br />\n<br />\nIf you have not requested this email please notify us.<br />\n&nbsp;\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Password reset link: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_reset_link]\">[var.url_reset_link]</a> </span></div><br>\n</div>\n</div>\n', '[var.to_name], [var.todays_date], [var.url_reset_link], [var.url_dashboard]'),
(17, '', 'client', 'enabled', 'new_quotation_client', 'lang_new_quotation', 'Your Quotation Request', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">QUOTATION</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nThank you for you for filling in our Quotation Request Form.<br />\n<br />\nPlease find below are our quotation:<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Quotation Date</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.todays_date]</td>\n  </tr>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\">Our Quotation</td>\n   <td style=\"border: 1px solid #DDDDDD;\"><strong>[var.currency_symbol][var.quotation_amount]</strong></td>\n  </tr>\n  <tr>\n   <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Addtitional Comments</td>\n   <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.quotation_notes]</td>\n  </tr>\n </tbody>\n</table>\n<br />\nThank you and we look forward to working with you.<br />\n<br />\n[var.email_signature]</div>\n</div>', 'Your Quotation Request', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">QUOTATION</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nThank you for you for filling in our Quotation Request Form.<br />\n<br />\nPlease find below are our quotation:<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Quotation Date</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.todays_date]</td>\n  </tr>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\">Our Quotation</td>\n   <td style=\"border: 1px solid #DDDDDD;\"><strong>[var.currency_symbol][var.quotation_amount]</strong></td>\n  </tr>\n  <tr>\n   <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">Addtitional Comments</td>\n   <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">[var.quotation_notes]</td>\n  </tr>\n </tbody>\n</table>\n<br />\nThank you and we look forward to working with you.<br />\n<br />\n[var.email_signature]</div>\n</div>', '[var.to_name], [var.currency_symbol], [var.quotation_amount], [var.quotation_notes], [var.url_quotation], [var.url_dashboard], [var.todays_date]'),
(21, 'tested - feb 2016', 'client', 'enabled', 'support_ticket_client', 'lang_new_support_ticket', 'Support Ticket', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">SUPPORT TICKET</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA support ticket has been posted<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Ticket Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Ticket ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.ticket_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Department</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_department]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Assigned To</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_assigned_name]</td>\n  </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Submitted By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.submitted_by]</td>\n    </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.ticket_message]<br /></td>\n    </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Ticket URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_ticket]\">[var.url_ticket]</a> </span></div>\n<br />\n [var.email_signature]</div>\n</div>', 'Support Ticket', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">SUPPORT TICKET</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA support ticket has been posted<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Ticket Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Ticket ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.ticket_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Department</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_department]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Assigned To</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_assigned_name]</td>\n  </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Submitted By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.submitted_by]</td>\n    </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.ticket_message]<br /></td>\n    </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Ticket URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_ticket]\">[var.url_ticket]</a> </span></div>\n<br />\n [var.email_signature]</div>\n</div>', '[var.to_name], [var.ticket_title], [var.ticket_message], [var.ticket_id], [var.ticket_department], [var.ticket_assigned_name], [var.submitted_by], [var.url_dashboard], [var.url_ticket], [var.todays_date], [var.email_signature]'),
(15, '', 'admin', 'enabled', 'new_payment_admin', 'lang_new_payment', 'New Payment Received', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Payment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">Hello,<br />\n<br />\nA new payment has been made.<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Client Name</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.clients_company_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Transaction ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.transaction_id]</td>\n  </tr>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\">Amount</td>\n   <td style=\"border: 1px solid #DDDDDD;\">[var.amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Currency</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.currency]</td>\n  </tr>\n </tbody>\n</table>\n</div>\n</div>', 'New Payment Received', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Payment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">Hello,<br />\n<br />\nA new payment has been made.<br />\n&nbsp;\n<table cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\" width=\"100%\">\n <tbody>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Client Name</td>\n   <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.clients_company_name]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Invoice ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.invoice_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Transaction ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.transaction_id]</td>\n  </tr>\n  <tr>\n   <td style=\"border: 1px solid #DDDDDD;\">Amount</td>\n   <td style=\"border: 1px solid #DDDDDD;\">[var.amount]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Currency</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.currency]</td>\n  </tr>\n </tbody>\n</table>\n</div>\n</div>', '[var.clients_company_name], [var.invoice_id], [var.transaction_id], [var.amount], [var.currency]'),
(16, 'tested - feb 2016', 'admin', 'enabled', 'new_team_member', 'lang_new_team_member', 'Account Details', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n  <div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Account Details</div>\n  <div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">[var.to_name]<br />\n    <br />\n    Below are your new Dashboard login details<br />\n    <br>\n    <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Username</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n      </tr>\n      <tr>\n        <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Password</td>\n        <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n      </tr>\n    </table>\n    <br>\n    <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </div>\n  </div>\n</div>', 'Account Details', '<div style=\"height:7px; background-color:#535353\"></div>\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n  <div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Account Details</div>\n  <div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">[var.to_name]<br />\n    <br />\n    Below are your new Dashboard login details<br />\n    <br>\n    <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n      <tr>\n        <td style=\"border: 1px solid #DDDDDD;\">Username</td>\n        <td style=\"border: 1px solid #DDDDDD;\">[var.username]</td>\n      </tr>\n      <tr>\n        <td width=\"150\" style=\"border: 1px solid #DDDDDD;\">Password</td>\n        <td width=\"276\" style=\"border: 1px solid #DDDDDD;\">[var.password]</td>\n      </tr>\n    </table>\n    <br>\n    <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Dashboard Link </strong><span style=\"font-size:14px;\"><a href=\"[var.url_dashboard]\">[var.url_dashboard]</a> </div>\n  </div>\n</div>', '[var.to_name], [var.username],  [var.password], [var.url_dashboard], [var.todays_date]'),
(9, 'tested - feb 2016', 'client', 'enabled', 'new_projectfile_client', 'lang_new_file', 'A New File Has Been Uploaded', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Project File Uploaded</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new file has been uploaded to your project.  </p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td colspan=\"2\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File Details</strong></td>\n      </tr>\n    <tr>\n      <td width=\"274\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"700\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">File Description</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_description]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Uploaded By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_uploaded_by]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Uploaded</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.file_uploaded_date]</td>\n    </tr>\n</table>\n <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <p>    You can download the file via your dashboard\n  </p>\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project Dashboard: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', 'A New File Has Been Uploaded', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Project File Uploaded</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new file has been uploaded to your project.  </p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td colspan=\"2\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File Details</strong></td>\n      </tr>\n    <tr>\n      <td width=\"274\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"700\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">File Description</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_description]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Uploaded By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_uploaded_by]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Uploaded</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.file_uploaded_date]</td>\n    </tr>\n</table>\n <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <p>    You can download the file via your dashboard\n  </p>\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project Dashboard: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', '[var.to_name], [var.project_title], [var.project_status], [var.project_id], [var.project_start_date], [var.project_start_end], [var.file_uploaded_by], [var.file_name], [var.file_description], [var.file_uploaded_date], [var.url_file], [var.url_dashboard], [var.company_email_signature]\n'),
(10, 'tested - feb 2016', 'admin', 'enabled', 'new_projectfile_admin', 'lang_new_file', 'A New File Has Been Uploaded', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Project File Uploaded</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new file has been uploaded to your project.  </p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td colspan=\"2\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File Details</strong></td>\n      </tr>\n    <tr>\n      <td width=\"274\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"700\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">File Description</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_description]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Uploaded By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_uploaded_by]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Uploaded</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.file_uploaded_date]</td>\n    </tr>\n</table>\n <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <p>    You can download the file via your dashboard\n  </p>\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project Dashboard: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', 'A New File Has Been Uploaded', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New Project File Uploaded</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new file has been uploaded to your project.  </p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td colspan=\"2\" bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File Details</strong></td>\n      </tr>\n    <tr>\n      <td width=\"274\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"700\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">File Description</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_description]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Uploaded By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_uploaded_by]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Date Uploaded</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.file_uploaded_date]</td>\n    </tr>\n</table>\n <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <p>    You can download the file via your dashboard\n  </p>\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Project Dashboard: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', ''),
(19, 'tested - feb 2016', 'client', 'enabled', 'file_comment_client', 'lang_new_file_comment', 'New File Comment', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New File Comment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new comment has been posted on one of your project\'s files.</p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_comment]<br />\n        <br />\n        <strong>By: [var.comment_posted_by]</strong></td>\n    </tr>\n  </table>\n  <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File &amp; Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <br />\n<br />\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>File URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', 'New File Comment', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New File Comment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new comment has been posted on one of your project\'s files.</p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_comment]<br />\n        <br />\n        <strong>By: [var.comment_posted_by]</strong></td>\n    </tr>\n  </table>\n  <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File &amp; Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <br />\n<br />\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>File URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', '[var.to_name], [var.file_comment], [var.comment_posted_by], [var.file_name], [var.project_title], [var.project_id], [var.url_file], [var.url_dashboard], [var.company_email_signature]\n'),
(20, 'tested - feb 2016', 'admin', 'enabled', 'file_comment_admin', 'lang_new_file_comment', 'New File Comment', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New File Comment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new comment has been posted on one of your project\'s files.</p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_comment]<br />\n        <br />\n        <strong>By: [var.comment_posted_by]</strong></td>\n    </tr>\n  </table>\n  <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File &amp; Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <br />\n<br />\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>File URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', 'New File Comment', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">New File Comment</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\">\n  <p>Hi [var.to_name],</p>\n  <p>A new comment has been posted on one of your project\'s files.</p>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.file_comment]<br />\n        <br />\n        <strong>By: [var.comment_posted_by]</strong></td>\n    </tr>\n  </table>\n  <br>\n  <table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n    <tr>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\"><strong>File &amp; Project Details</strong></td>\n      <td bgcolor=\"#F5F5F5\" style=\"border: 1px solid #DDDDDD;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td width=\"275\" style=\"border: 1px solid #DDDDDD;\">File Name</td>\n      <td width=\"699\" style=\"border: 1px solid #DDDDDD;\">[var.file_name]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_title]</td>\n    </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Project ID</td>\n      <td style=\"border: 1px solid #DDDDDD;\"> [var.project_id]</td>\n    </tr>\n  </table>\n  <br />\n<br />\n\n  <div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>File URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_file]\">[var.url_file]</a></span></div>\n<br />\n[var.company_email_signature]</div>\n</div>\n', '[var.to_name], [var.file_comment], [var.comment_posted_by], [var.file_name], [var.project_title], [var.project_id], [var.url_file], [var.url_dashboard], [var.company_email_signature]\n'),
(22, 'tested - feb 2016', 'admin', 'enabled', 'support_ticket_admin', 'lang_new_support_ticket', 'Support Ticket', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">SUPPORT TICKET</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA support ticket has been posted<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Ticket Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Ticket ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.ticket_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Department</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_department]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Assigned To</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_assigned_name]</td>\n  </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Submitted By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.submitted_by]</td>\n    </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.ticket_message]<br /></td>\n    </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Ticket URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_ticket]\">[var.url_ticket]</a> </span></div>\n<br />\n</div>\n</div>', 'Support Ticket', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">SUPPORT TICKET</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br />\nA support ticket has been posted<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Ticket Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Ticket ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.ticket_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Department</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_department]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Assigned To</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.ticket_assigned_name]</td>\n  </tr>\n    <tr>\n      <td style=\"border: 1px solid #DDDDDD;\">Submitted By</td>\n      <td style=\"border: 1px solid #DDDDDD;\">[var.submitted_by]</td>\n    </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.ticket_message]<br /></td>\n    </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Ticket URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_ticket]\">[var.url_ticket]</a> </span></div>\n<br />\n</div>\n</div>', '[var.to_name], [var.ticket_title], [var.ticket_message], [var.ticket_id], [var.ticket_department], [var.ticket_assigned_name], [var.submitted_by], [var.url_dashboard], [var.url_ticket], [var.todays_date]'),
(23, 'tested - feb 2016', 'client', 'enabled', 'project_message_client', 'lang_new_project_message', 'New Project Message', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW MESSAGE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new message has been posted to your project\n<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Project ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.project_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Message By</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.message_posted_by]</td>\n  </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.message]<br /></td>\n  </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Message URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_message]\">[var.url_message]</a> </span></div>\n<br />\n</div>\n</div>', 'New Project Message', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW MESSAGE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new message has been posted to your project\n<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Project ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.project_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Message By</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.message_posted_by]</td>\n  </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.message]<br /></td>\n  </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Message URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_message]\">[var.url_message]</a> </span></div>\n<br />\n</div>\n</div>', '[var.to_name], [var.project_title], [var.project_id], [var.message_posted_by], [var.message], [var.url_message], [var.url_dashboard], [var.todays_date], [var.email_signature]'),
(24, 'tested - feb 2016', 'admin', 'enabled', 'project_message_admin', 'lang_new_project_message', 'New Project Message', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW MESSAGE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new message has been posted to your project\n<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Project ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.project_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Message By</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.message_posted_by]</td>\n  </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.message]<br /></td>\n  </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Message URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_message]\">[var.url_message]</a> </span></div>\n<br />\n</div>\n</div>', 'New Project Message', '<div style=\"height:7px; background-color:#535353\">&nbsp;</div>\n\n<div style=\"background-color:#f5f5f5; margin:0px; padding:55px 20px 40px 20px; font-family:Helvetica, sans-serif; font-size:13px; color:#535353;\">\n<div style=\"text-align:center; font-size:34px; font-weight:bold; color:#535353;\">NEW MESSAGE</div>\n\n<div style=\"border-radius: 5px 5px 5px 5px; padding:20px; margin-top:45px; background-color:#FFFFFF; font-family:Arial, Helvetica, sans-serif; font-size:13px;\"><strong>[var.to_name]</strong><br />\n<br /> \nA new message has been posted to your project\n<br />\n&nbsp;\n<table width=\"100%\" cellpadding=\"8\" style=\"border: 1px solid #DDDDDD; border-collapse: collapse; border-spacing: 0;font-size:13px;\">\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Project Title</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.project_title]</td>\n  </tr>\n <tbody>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"150\">Project ID</td>\n    <td style=\"border: 1px solid #DDDDDD;\" width=\"276\">[var.project_id]</td>\n  </tr>\n  <tr>\n    <td style=\"border: 1px solid #DDDDDD;\">Message By</td>\n    <td style=\"border: 1px solid #DDDDDD;\">[var.message_posted_by]</td>\n  </tr>\n  <tr bgcolor=\"#F5F5F5\">\n    <td colspan=\"2\" style=\"border: 1px solid #DDDDDD;\"><br />\n      [var.message]<br /></td>\n  </tr>\n </tbody>\n</table>\n<br /><br />\n\n<div style=\" border:#CCCCCC solid 1px; padding:8px;\"><strong>Message URL: </strong><span style=\"font-size:14px;\"><a href=\"[var.url_message]\">[var.url_message]</a> </span></div>\n<br />\n</div>\n</div>', '[var.to_name], [var.project_title], [var.project_id], [var.message_posted_by], [var.message], [var.url_message], [var.url_dashboard], [var.todays_date]');

-- --------------------------------------------------------

--
-- Table structure for table `settings_events`
--

CREATE TABLE `settings_events` (
  `settings_events_name` varchar(100) NOT NULL,
  `settings_events_enabled` varchar(5) NOT NULL DEFAULT 'yes'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

-- --------------------------------------------------------

--
-- Table structure for table `settings_general`
--

CREATE TABLE `settings_general` (
  `settings_id` varchar(30) NOT NULL DEFAULT 'default',
  `language` varchar(50) NOT NULL DEFAULT 'english',
  `theme` varchar(50) NOT NULL DEFAULT 'default',
  `date_format` varchar(30) NOT NULL DEFAULT 'm-d-Y',
  `results_limit` smallint(6) NOT NULL DEFAULT '25',
  `messages_limit` smallint(6) NOT NULL DEFAULT '10',
  `timeline_limit` smallint(6) NOT NULL DEFAULT '25',
  `currency_symbol` varchar(10) NOT NULL DEFAULT '$',
  `currency_code` varchar(20) NOT NULL DEFAULT 'USD',
  `dashboard_title` varchar(250) NOT NULL DEFAULT 'Project Manager',
  `show_information_tips` varchar(10) NOT NULL DEFAULT 'yes' COMMENT 'yes/no',
  `client_registration` varchar(10) NOT NULL DEFAULT 'yes' COMMENT 'yes/no',
  `notifications_display_duration` int(11) NOT NULL DEFAULT '350',
  `product_purchase_code` varchar(100) DEFAULT NULL,
  `restore_language` varchar(50) NOT NULL DEFAULT 'english',
  `restore_theme` varchar(50) NOT NULL DEFAULT 'default',
  `restore_date_format` varchar(30) NOT NULL DEFAULT 'm-d-Y',
  `restore_results_limit` smallint(6) NOT NULL DEFAULT '25',
  `restore_messages_limit` smallint(6) NOT NULL DEFAULT '10',
  `restore_timeline_limit` smallint(6) NOT NULL DEFAULT '25',
  `restore_currency_code` varchar(20) NOT NULL DEFAULT 'USD',
  `restore_currency_symbol` varchar(10) NOT NULL DEFAULT '$',
  `restore_dashboard_title` varchar(100) NOT NULL DEFAULT 'Project Manager',
  `restore_show_information_tips` varchar(10) NOT NULL DEFAULT 'yes',
  `restore_notifications_display_duration` int(11) NOT NULL DEFAULT '350',
  `restore_client_registration` varchar(10) NOT NULL DEFAULT 'yes',
  `restore_product_purchase_code` varchar(100) DEFAULT NULL,
  `project_list_display` varchar(30) DEFAULT 'extended' COMMENT 'extended/standard'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_general`
--

INSERT INTO `settings_general` (`settings_id`, `language`, `theme`, `date_format`, `results_limit`, `messages_limit`, `timeline_limit`, `currency_symbol`, `currency_code`, `dashboard_title`, `show_information_tips`, `client_registration`, `notifications_display_duration`, `product_purchase_code`, `restore_language`, `restore_theme`, `restore_date_format`, `restore_results_limit`, `restore_messages_limit`, `restore_timeline_limit`, `restore_currency_code`, `restore_currency_symbol`, `restore_dashboard_title`, `restore_show_information_tips`, `restore_notifications_display_duration`, `restore_client_registration`, `restore_product_purchase_code`, `project_list_display`) VALUES
('default', 'english', 'default', 'd-m-Y', 25, 10, 100, '$', 'USD', 'DEMO PPM', 'yes', 'yes', 4500, 'feejha5a1-t90f-4u8e-bla6-753d655a4d02', 'english', 'default', 'm-d-Y', 25, 10, 100, 'USD', '$', 'Project Dashboard', 'yes', 4500, 'yes', NULL, 'extended');

-- --------------------------------------------------------

--
-- Table structure for table `settings_invoices`
--

CREATE TABLE `settings_invoices` (
  `settings_id` varchar(30) NOT NULL,
  `settings_invoices_notes` text,
  `settings_invoices_allow_partial_payment` varchar(10) DEFAULT 'yes' COMMENT 'yes/no',
  `settings_invoices_email_overdue_reminder` varchar(10) DEFAULT 'yes' COMMENT 'yes/no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_invoices`
--

INSERT INTO `settings_invoices` (`settings_id`, `settings_invoices_notes`, `settings_invoices_allow_partial_payment`, `settings_invoices_email_overdue_reminder`) VALUES
('default', 'Payment is due upon receipt of the invoice. Thank you for your business.', 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `settings_payment_methods`
--

CREATE TABLE `settings_payment_methods` (
  `settings_payment_methods_name` varchar(100) NOT NULL COMMENT 'Unique ID: Also used in PAYMENTS table ''payments_method'' to identify payment method',
  `settings_payment_methods_status` varchar(20) NOT NULL COMMENT 'enabled/disabled'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_payment_methods`
--

INSERT INTO `settings_payment_methods` (`settings_payment_methods_name`, `settings_payment_methods_status`) VALUES
('Paypal', 'disabled'),
('Cash', 'enabled'),
('Bank', 'disabled'),
('Stripe', 'disabled');

-- --------------------------------------------------------

--
-- Table structure for table `settings_paypal`
--

CREATE TABLE `settings_paypal` (
  `settings_id` varchar(20) NOT NULL COMMENT 'This Table: Has 1 default record (settings_id = default)',
  `paypal_active` varchar(10) DEFAULT 'no' COMMENT 'yes/no',
  `paypal_email_address` varchar(150) DEFAULT 'USD',
  `paypal_currency` varchar(10) DEFAULT NULL,
  `paypal_ipn_url` varchar(250) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_paypal`
--

INSERT INTO `settings_paypal` (`settings_id`, `paypal_active`, `paypal_email_address`, `paypal_currency`, `paypal_ipn_url`) VALUES
('default', 'yes', 'paypal@somdomain.ccc', 'USD', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings_stripe`
--

CREATE TABLE `settings_stripe` (
  `settings_id` varchar(20) NOT NULL COMMENT '1 default row',
  `stripe_active` varchar(5) NOT NULL DEFAULT 'no',
  `stripe_test_secret_key` varchar(100) DEFAULT NULL,
  `stripe_test_publishable_key` varchar(100) DEFAULT NULL,
  `stripe_live_secret_key` varchar(100) DEFAULT NULL,
  `stripe_live_publishable_key` varchar(100) DEFAULT NULL,
  `stripe_currency` varchar(10) DEFAULT 'USD'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='dev - SKIP';

--
-- Dumping data for table `settings_stripe`
--

INSERT INTO `settings_stripe` (`settings_id`, `stripe_active`, `stripe_test_secret_key`, `stripe_test_publishable_key`, `stripe_live_secret_key`, `stripe_live_publishable_key`, `stripe_currency`) VALUES
('default', 'no', '', '', '', '', 'USD');

-- --------------------------------------------------------

--
-- Table structure for table `setting_system`
--

CREATE TABLE `setting_system` (
  `setting_system_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `system_events`
--

CREATE TABLE `system_events` (
  `id` int(11) NOT NULL,
  `system_events_id` varchar(40) NOT NULL,
  `system_events_project_id` varchar(40) NOT NULL,
  `system_events_date` datetime NOT NULL,
  `events_item` varchar(100) NOT NULL COMMENT 'client,cron,invoice',
  `events_action` varchar(100) NOT NULL,
  `events_user_id` int(11) DEFAULT NULL,
  `event_user_type` varchar(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `tasks_id` int(11) NOT NULL,
  `tasks_milestones_id` int(11) NOT NULL,
  `tasks_project_id` int(11) NOT NULL,
  `tasks_client_id` int(11) NOT NULL,
  `tasks_assigned_to_id` int(11) NOT NULL,
  `tasks_text` varchar(250) NOT NULL,
  `tasks_start_date` date NOT NULL,
  `tasks_end_date` date NOT NULL,
  `tasks_created_by_id` int(11) NOT NULL,
  `tasks_status` varchar(50) NOT NULL DEFAULT 'pending' COMMENT 'pending/completed/behind schedule',
  `tasks_events_id` varchar(40) DEFAULT NULL,
  `tasks_description` text,
  `tasks_created_by` varchar(20) DEFAULT 'team' COMMENT 'team/client',
  `tasks_client_access` varchar(5) DEFAULT 'no' COMMENT 'yes/no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `task_files`
--

CREATE TABLE `task_files` (
  `task_files_id` int(11) NOT NULL,
  `task_files_task_id` int(11) NOT NULL,
  `task_files_project_id` int(11) NOT NULL,
  `task_files_client_id` int(11) NOT NULL,
  `task_files_uploaded_by` varchar(10) NOT NULL COMMENT 'client/team',
  `task_files_uploaded_by_id` int(11) NOT NULL,
  `task_files_name` varchar(250) NOT NULL,
  `task_files_description` text NOT NULL,
  `task_files_size` int(11) NOT NULL,
  `task_files_size_human` varchar(20) NOT NULL,
  `task_files_date_uploaded` date NOT NULL,
  `task_files_foldername` varchar(50) NOT NULL,
  `task_files_extension` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `team_messages`
--

CREATE TABLE `team_messages` (
  `messages_id` int(11) NOT NULL,
  `messages_project_id` int(11) NOT NULL,
  `messages_date` datetime NOT NULL,
  `messages_text` text NOT NULL,
  `messages_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `team_messages_replies`
--

CREATE TABLE `team_messages_replies` (
  `messages_replies_id` int(11) NOT NULL,
  `messages_replies_project_id` int(11) NOT NULL,
  `messages_replies_message_id` int(11) NOT NULL,
  `messages_replies_date` datetime NOT NULL,
  `messages_replies_text` text NOT NULL,
  `messages_replies_by_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `team_notes`
--

CREATE TABLE `team_notes` (
  `team_notes_id` int(11) NOT NULL,
  `team_notes_project_id` int(11) NOT NULL,
  `team_notes_by_id` int(11) NOT NULL,
  `team_notes_date` datetime NOT NULL,
  `team_notes_notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `team_profile`
--

CREATE TABLE `team_profile` (
  `team_profile_id` int(11) NOT NULL COMMENT 'This table: Has 1 default row with placeholder admin',
  `team_profile_groups_id` int(11) NOT NULL,
  `team_profile_uniqueid` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `team_profile_avatar_filename` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `team_profile_full_name` varchar(50) NOT NULL,
  `team_profile_job_position_title` varchar(50) DEFAULT NULL,
  `team_profile_email` varchar(75) NOT NULL,
  `team_profile_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'case sensitive utf8_bin',
  `team_profile_telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `team_profile_reset_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `team_profile_reset_timestamp` datetime DEFAULT NULL,
  `team_profile_notifications_system` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes' COMMENT 'yes/no',
  `team_profile_last_active` datetime DEFAULT NULL,
  `team_profile_notify_file_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_milestone_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_milestone_completed` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_file_message_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_message_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_team_message_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'yes',
  `team_profile_notify_invoice_added` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'no',
  `team_profile_notify_payment_received` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'no',
  `team_profile_pinned_1` int(11) DEFAULT NULL,
  `team_profile_pinned_2` int(11) DEFAULT NULL,
  `team_profile_pinned_3` int(11) DEFAULT NULL,
  `team_profile_pinned_4` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP (1 default row - ignore data, updated on setup)';

--
-- Dumping data for table `team_profile`
--

INSERT INTO `team_profile` (`team_profile_id`, `team_profile_groups_id`, `team_profile_uniqueid`, `team_profile_avatar_filename`, `team_profile_full_name`, `team_profile_job_position_title`, `team_profile_email`, `team_profile_password`, `team_profile_telephone`, `team_profile_reset_code`, `team_profile_reset_timestamp`, `team_profile_notifications_system`, `team_profile_last_active`, `team_profile_notify_file_added`, `team_profile_notify_milestone_added`, `team_profile_notify_milestone_completed`, `team_profile_notify_file_message_added`, `team_profile_notify_message_added`, `team_profile_notify_team_message_added`, `team_profile_notify_invoice_added`, `team_profile_notify_payment_received`, `team_profile_pinned_1`, `team_profile_pinned_2`, `team_profile_pinned_3`, `team_profile_pinned_4`) VALUES
(1, 1, '56b2148181cde', '56b2148181cde.png', 'Demo', 'Manager', 'demo@gmail.com', '14f4b2fc501ab14a296b1e8f621dffd6', '(000)-000-000-000', '', '0000-00-00 00:00:00', 'yes', '2017-05-26 06:24:01', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 1, 2, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `tickets_id` int(11) NOT NULL,
  `tickets_department_id` int(11) NOT NULL,
  `tickets_assigned_to_id` int(11) NOT NULL DEFAULT '0' COMMENT 'un-assigned tickets have ''0'' value',
  `tickets_date` datetime NOT NULL,
  `tickets_title` varchar(250) NOT NULL,
  `tickets_message` text NOT NULL,
  `tickets_client_id` int(11) NOT NULL,
  `tickets_by_user_id` int(11) NOT NULL,
  `tickets_by_user_type` varchar(20) NOT NULL COMMENT 'client/team',
  `tickets_last_active_date` datetime NOT NULL,
  `tickets_status` varchar(20) NOT NULL DEFAULT 'new' COMMENT 'new/answered/client-replied/closed',
  `tickets_file_name` varchar(250) DEFAULT NULL,
  `tickets_file_folder` varchar(250) DEFAULT NULL,
  `tickets_file_size` varchar(250) DEFAULT NULL,
  `tickets_file_extension` varchar(250) DEFAULT NULL,
  `tickets_has_attachment` varchar(250) DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `tickets_departments`
--

CREATE TABLE `tickets_departments` (
  `department_id` int(11) NOT NULL COMMENT 'This Table: Has 1 default row. General Support department',
  `department_name` varchar(100) NOT NULL,
  `department_description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP (1 default row)';

--
-- Dumping data for table `tickets_departments`
--

INSERT INTO `tickets_departments` (`department_id`, `department_name`, `department_description`) VALUES
(1, 'General Support', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `tickets_mailer`
--

CREATE TABLE `tickets_mailer` (
  `tickets_mailer_id` int(11) NOT NULL COMMENT 'default',
  `tickets_mailer_enabled` varchar(50) DEFAULT 'no' COMMENT 'yes/no',
  `tickets_mailer_delete_read` varchar(50) DEFAULT 'yes' COMMENT 'yes/no',
  `tickets_mailer_imap_pop` varchar(50) DEFAULT 'IMAP' COMMENT 'IMAP/POP',
  `tickets_mailer_ssl` varchar(50) DEFAULT 'no' COMMENT 'yes/no',
  `tickets_mailer_email_address` varchar(100) DEFAULT NULL,
  `tickets_mailer_server` varchar(100) DEFAULT 'localhost',
  `tickets_mailer_server_port` varchar(50) DEFAULT '143',
  `tickets_mailer_username` varchar(100) DEFAULT NULL,
  `tickets_mailer_password` varchar(250) DEFAULT NULL,
  `tickets_mailer_flags` varchar(250) DEFAULT NULL,
  `tickets_mailer_imap_settings` varchar(250) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP';

-- --------------------------------------------------------

--
-- Table structure for table `tickets_replies`
--

CREATE TABLE `tickets_replies` (
  `tickets_replies_id` int(11) NOT NULL,
  `tickets_replies_ticket_id` int(11) NOT NULL DEFAULT '0' COMMENT 'un-assigned ticket_replies have ''0'' value',
  `tickets_replies_date` datetime NOT NULL,
  `tickets_replies_message` text NOT NULL,
  `tickets_replies_by_user_id` int(11) NOT NULL,
  `tickets_replies_by_user_type` varchar(20) NOT NULL COMMENT 'client/team',
  `tickets_replies_file_name` varchar(250) DEFAULT NULL,
  `tickets_replies_file_folder` varchar(250) DEFAULT NULL,
  `tickets_replies_file_size` varchar(250) DEFAULT NULL,
  `tickets_replies_file_extension` varchar(250) DEFAULT NULL,
  `tickets_replies_has_attachment` varchar(250) DEFAULT 'no'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `timer`
--

CREATE TABLE `timer` (
  `timer_id` int(11) NOT NULL,
  `timer_project_id` int(11) NOT NULL,
  `timer_start_datetime` datetime DEFAULT NULL,
  `timer_seconds` int(11) DEFAULT '0',
  `timer_team_member_id` int(11) DEFAULT NULL,
  `timer_status` varchar(30) DEFAULT 'stopped' COMMENT 'running/stopped'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev: clear all data';

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE `version` (
  `id` varchar(30) CHARACTER SET latin1 NOT NULL COMMENT 'This table: Has 1 default row after installation or update',
  `version` varchar(20) CHARACTER SET latin1 NOT NULL,
  `date_installed` datetime NOT NULL,
  `install_type` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'new/update'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='dev - SKIP (1 default row - ignore reset on install)';

--
-- Dumping data for table `version`
--

INSERT INTO `version` (`id`, `version`, `date_installed`, `install_type`) VALUES
('default', '2.0', '2016-02-03 09:53:53', 'new');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bugs`
--
ALTER TABLE `bugs`
  ADD PRIMARY KEY (`bugs_id`);

--
-- Indexes for table `bug_comments`
--
ALTER TABLE `bug_comments`
  ADD PRIMARY KEY (`bug_comments_id`);

--
-- Indexes for table `ci_log`
--
ALTER TABLE `ci_log`
  ADD PRIMARY KEY (`ci_log_id`);

--
-- Indexes for table `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `last_activity_idx` (`last_activity`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`clients_id`);

--
-- Indexes for table `client_users`
--
ALTER TABLE `client_users`
  ADD PRIMARY KEY (`client_users_id`);

--
-- Indexes for table `email_log`
--
ALTER TABLE `email_log`
  ADD PRIMARY KEY (`email_log_id`);

--
-- Indexes for table `email_queue`
--
ALTER TABLE `email_queue`
  ADD PRIMARY KEY (`email_queue_id`);

--
-- Indexes for table `filedownloads`
--
ALTER TABLE `filedownloads`
  ADD PRIMARY KEY (`filedownloads_id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`files_id`);

--
-- Indexes for table `file_comments`
--
ALTER TABLE `file_comments`
  ADD PRIMARY KEY (`file_comments_id`);

--
-- Indexes for table `file_messages`
--
ALTER TABLE `file_messages`
  ADD PRIMARY KEY (`messages_id`);

--
-- Indexes for table `file_messages_replies`
--
ALTER TABLE `file_messages_replies`
  ADD PRIMARY KEY (`messages_replies_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`groups_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoices_id`),
  ADD UNIQUE KEY `invoices_unique_id` (`invoices_unique_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`invoice_items_id`);

--
-- Indexes for table `invoice_products`
--
ALTER TABLE `invoice_products`
  ADD PRIMARY KEY (`invoice_products_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messages_id`);

--
-- Indexes for table `messages_replies`
--
ALTER TABLE `messages_replies`
  ADD PRIMARY KEY (`messages_replies_id`);

--
-- Indexes for table `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`milestones_id`);

--
-- Indexes for table `mynotes`
--
ALTER TABLE `mynotes`
  ADD PRIMARY KEY (`mynotes_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payments_id`);

--
-- Indexes for table `paypal_ipn_log`
--
ALTER TABLE `paypal_ipn_log`
  ADD PRIMARY KEY (`ipn_id`);

--
-- Indexes for table `ppmupdates`
--
ALTER TABLE `ppmupdates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`projects_id`);

--
-- Indexes for table `project_events`
--
ALTER TABLE `project_events`
  ADD UNIQUE KEY `project_events_id` (`project_events_id`);

--
-- Indexes for table `project_members`
--
ALTER TABLE `project_members`
  ADD PRIMARY KEY (`project_members_index`),
  ADD UNIQUE KEY `project_members_unique_index` (`project_members_team_id`,`project_members_project_id`);

--
-- Indexes for table `quotationforms`
--
ALTER TABLE `quotationforms`
  ADD PRIMARY KEY (`quotationforms_id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`quotations_id`);

--
-- Indexes for table `search_cache`
--
ALTER TABLE `search_cache`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings_company`
--
ALTER TABLE `settings_company`
  ADD UNIQUE KEY `settings_id` (`settings_id`);

--
-- Indexes for table `settings_emailtemplates`
--
ALTER TABLE `settings_emailtemplates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_id` (`settings_id`);

--
-- Indexes for table `settings_general`
--
ALTER TABLE `settings_general`
  ADD UNIQUE KEY `settings_id` (`settings_id`);

--
-- Indexes for table `settings_invoices`
--
ALTER TABLE `settings_invoices`
  ADD UNIQUE KEY `settings_id` (`settings_id`);

--
-- Indexes for table `setting_system`
--
ALTER TABLE `setting_system`
  ADD PRIMARY KEY (`setting_system_id`);

--
-- Indexes for table `system_events`
--
ALTER TABLE `system_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`tasks_id`);

--
-- Indexes for table `task_files`
--
ALTER TABLE `task_files`
  ADD PRIMARY KEY (`task_files_id`);

--
-- Indexes for table `team_messages`
--
ALTER TABLE `team_messages`
  ADD PRIMARY KEY (`messages_id`);

--
-- Indexes for table `team_messages_replies`
--
ALTER TABLE `team_messages_replies`
  ADD PRIMARY KEY (`messages_replies_id`);

--
-- Indexes for table `team_notes`
--
ALTER TABLE `team_notes`
  ADD PRIMARY KEY (`team_notes_id`);

--
-- Indexes for table `team_profile`
--
ALTER TABLE `team_profile`
  ADD PRIMARY KEY (`team_profile_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`tickets_id`);

--
-- Indexes for table `tickets_departments`
--
ALTER TABLE `tickets_departments`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `tickets_replies`
--
ALTER TABLE `tickets_replies`
  ADD PRIMARY KEY (`tickets_replies_id`);

--
-- Indexes for table `timer`
--
ALTER TABLE `timer`
  ADD PRIMARY KEY (`timer_id`),
  ADD UNIQUE KEY `unique_timer` (`timer_project_id`,`timer_team_member_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bugs`
--
ALTER TABLE `bugs`
  MODIFY `bugs_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bug_comments`
--
ALTER TABLE `bug_comments`
  MODIFY `bug_comments_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ci_log`
--
ALTER TABLE `ci_log`
  MODIFY `ci_log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `clients_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This Table: Has no default data', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `client_users`
--
ALTER TABLE `client_users`
  MODIFY `client_users_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This Table: Has no default data', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `email_log`
--
ALTER TABLE `email_log`
  MODIFY `email_log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `email_queue`
--
ALTER TABLE `email_queue`
  MODIFY `email_queue_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `filedownloads`
--
ALTER TABLE `filedownloads`
  MODIFY `filedownloads_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `files_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `file_comments`
--
ALTER TABLE `file_comments`
  MODIFY `file_comments_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `file_messages`
--
ALTER TABLE `file_messages`
  MODIFY `messages_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `file_messages_replies`
--
ALTER TABLE `file_messages_replies`
  MODIFY `messages_replies_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `groups_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This table: Has 1 default row for admin group. Group ID must be [1] & Group Name must be [Administrator]', AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoices_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `invoice_items_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invoice_products`
--
ALTER TABLE `invoice_products`
  MODIFY `invoice_products_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `messages_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `messages_replies`
--
ALTER TABLE `messages_replies`
  MODIFY `messages_replies_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `milestones`
--
ALTER TABLE `milestones`
  MODIFY `milestones_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mynotes`
--
ALTER TABLE `mynotes`
  MODIFY `mynotes_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payments_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paypal_ipn_log`
--
ALTER TABLE `paypal_ipn_log`
  MODIFY `ipn_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ppmupdates`
--
ALTER TABLE `ppmupdates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `projects_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `project_events`
--
ALTER TABLE `project_events`
  MODIFY `project_events_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `project_members`
--
ALTER TABLE `project_members`
  MODIFY `project_members_index` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `quotationforms`
--
ALTER TABLE `quotationforms`
  MODIFY `quotationforms_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `quotations_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `search_cache`
--
ALTER TABLE `search_cache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This Table: Has no default data';
--
-- AUTO_INCREMENT for table `settings_emailtemplates`
--
ALTER TABLE `settings_emailtemplates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT for table `setting_system`
--
ALTER TABLE `setting_system`
  MODIFY `setting_system_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `system_events`
--
ALTER TABLE `system_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `tasks_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `task_files`
--
ALTER TABLE `task_files`
  MODIFY `task_files_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team_messages`
--
ALTER TABLE `team_messages`
  MODIFY `messages_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team_messages_replies`
--
ALTER TABLE `team_messages_replies`
  MODIFY `messages_replies_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team_notes`
--
ALTER TABLE `team_notes`
  MODIFY `team_notes_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `team_profile`
--
ALTER TABLE `team_profile`
  MODIFY `team_profile_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This table: Has 1 default row with placeholder admin', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `tickets_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tickets_departments`
--
ALTER TABLE `tickets_departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This Table: Has 1 default row. General Support department', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tickets_replies`
--
ALTER TABLE `tickets_replies`
  MODIFY `tickets_replies_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `timer`
--
ALTER TABLE `timer`
  MODIFY `timer_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
