-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 07, 2017 at 11:19 AM
-- Server version: 5.6.35-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s9mindxp_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `address_proof`
--

CREATE TABLE `address_proof` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `adharcard` text NOT NULL,
  `driving_license` text NOT NULL,
  `pan_card` text NOT NULL,
  `votercard` text NOT NULL,
  `passport` text NOT NULL,
  `other` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address_proof`
--

INSERT INTO `address_proof` (`id`, `uid`, `adharcard`, `driving_license`, `pan_card`, `votercard`, `passport`, `other`, `created_at`, `updated_at`) VALUES
(1, 2, '591bf2385f037_PAN Application Filing Successfull  RIGARO EWORKS.png', ' ', '', '591bfb6673000_Thankyou For Applying  RIGARO EWORKS.png', ' ', ' ', '2017-05-17 06:46:45', '2017-05-17 07:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `name`, `logo`, `email`, `created_at`, `updated_at`) VALUES
(6, 'Maxtel Infosystems Pvt. Ltd', '58ff37cbaf238_company-2.png', '[\"sahil@minxpert.com\",\"banish.mst@gmail.com\"]', '2017-02-24 13:04:45', '2017-04-26 07:57:47'),
(7, 'Mind Solutions Technology', '58ff3831650d3_company-2.png', '[\"sahil@minxpert.com\",\"banish.mst@gmail.com\"]', '2017-02-24 13:05:09', '2017-04-26 07:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `desc` text NOT NULL,
  `codes` varchar(255) NOT NULL,
  `permission` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `name`, `desc`, `codes`, `permission`, `created_at`, `updated_at`) VALUES
(1, 'HR', 'Human Resource', '1234', '[\"view_employees\",\"newemployee\",\"edit_employee\",\"view_employees_delete\",\"display_dept\",\"add_department\",\"edit_department\",\"display_dept_delete\",\"add_noticeboard\",\"view_noticeboard_delete\"]', '2017-02-11 06:06:38', '2017-02-15 12:43:41'),
(2, 'Developing', 'Developers', '123456', '[\"view_employees\",\"newemployee\",\"edit_employee\",\"display_dept\",\"add_department\"]', '2017-02-11 08:34:56', '2017-02-11 08:34:56'),
(4, 'IT', 'IT Department', '248001', '[\"view_employees\",\"newemployee\",\"edit_employee\",\"view_employees_delete\",\"display_dept\",\"add_department\",\"edit_department\",\"display_dept_delete\",\"view_noticeboard\",\"add_noticeboard\",\"edit_noticeboard\",\"view_noticeboard_delete\"]', '2017-05-30 15:39:26', '2017-05-30 15:39:26');

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `matric` text,
  `plustwo` text NOT NULL,
  `diploma` text NOT NULL,
  `graduation` text NOT NULL,
  `postgraduation` text NOT NULL,
  `other` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `uid`, `matric`, `plustwo`, `diploma`, `graduation`, `postgraduation`, `other`, `created_at`, `updated_at`) VALUES
(1, 2, '591c09c006f81_bluedemobutton.jpg', ' ', '', '591c09d73749c_bluedemobutton.jpg', ' ', ' ', '2017-05-17 08:28:48', '2017-05-17 08:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `employee_address`
--

CREATE TABLE `employee_address` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `address_type` varchar(255) DEFAULT '',
  `address_line1` text NOT NULL,
  `address_line2` text NOT NULL,
  `primary_address` text NOT NULL,
  `country` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_address`
--

INSERT INTO `employee_address` (`id`, `uid`, `address_type`, `address_line1`, `address_line2`, `primary_address`, `country`, `created_at`, `updated_at`) VALUES
(1, 2, 'test', 'test', 'test', 'tes', 'India', '2017-03-07 12:49:15', '2017-03-07 12:57:20'),
(2, 2, 'test', 'test', 'test', 'tes', 'India', '2017-03-09 04:55:57', '2017-03-09 04:55:57');

-- --------------------------------------------------------

--
-- Table structure for table `employee_bank`
--

CREATE TABLE `employee_bank` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `account_type` varchar(255) NOT NULL DEFAULT '',
  `nature` varchar(255) NOT NULL DEFAULT '',
  `account_no` varchar(255) NOT NULL DEFAULT '',
  `account_for` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_bank`
--

INSERT INTO `employee_bank` (`id`, `uid`, `account_type`, `nature`, `account_no`, `account_for`, `created_at`, `updated_at`) VALUES
(1, 2, 'Savings Account', 'Bank Details', '12462463434', 1, '2017-03-10 08:51:27', '2017-03-10 09:02:33');

-- --------------------------------------------------------

--
-- Table structure for table `employee_contact`
--

CREATE TABLE `employee_contact` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `relationship` varchar(255) NOT NULL DEFAULT '',
  `mst_emp_flag` int(11) NOT NULL,
  `dependent_flag` int(11) NOT NULL,
  `emergency_flag` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_contact`
--

INSERT INTO `employee_contact` (`id`, `uid`, `name`, `relationship`, `mst_emp_flag`, `dependent_flag`, `emergency_flag`, `created_at`, `updated_at`) VALUES
(1, 2, 'test', 'test', 1, 1, 1, '2017-03-10 11:32:04', '2017-03-10 11:32:04'),
(2, 2, 'test', 'test', 1, 2, 1, '2017-03-10 11:57:38', '2017-03-10 11:57:38');

-- --------------------------------------------------------

--
-- Table structure for table `employee_credential`
--

CREATE TABLE `employee_credential` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `credential_type` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_credential`
--

INSERT INTO `employee_credential` (`id`, `uid`, `credential_type`, `username`, `password`, `created_at`, `updated_at`) VALUES
(2, 2, 'skype', 'abc@gmail.com', 'MTIzNDU2', '2017-04-25 09:46:47', '2017-04-25 09:46:47');

-- --------------------------------------------------------

--
-- Table structure for table `employee_docrequest`
--

CREATE TABLE `employee_docrequest` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `doctype` varchar(255) NOT NULL DEFAULT '',
  `doccountry` varchar(255) NOT NULL DEFAULT '',
  `period` varchar(255) NOT NULL DEFAULT '',
  `company_logo` varchar(100) NOT NULL DEFAULT '',
  `from_month` varchar(100) NOT NULL DEFAULT '',
  `docfromyear` varchar(100) NOT NULL DEFAULT '',
  `tomonth` varchar(100) NOT NULL DEFAULT '',
  `doctoyear` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_docrequest`
--

INSERT INTO `employee_docrequest` (`id`, `uid`, `doctype`, `doccountry`, `period`, `company_logo`, `from_month`, `docfromyear`, `tomonth`, `doctoyear`, `created_at`, `updated_at`) VALUES
(1, 2, 'payslip', 'India', 'on', 'mindsolution', '01', '2011', '01', '2015', '2017-04-03 11:48:56', '2017-04-03 11:48:56'),
(2, 2, 'payslip', 'India', 'on', 'mindsolution', '04', '2015', '02', '2014', '2017-04-03 11:51:28', '2017-04-03 11:51:28');

-- --------------------------------------------------------

--
-- Table structure for table `employee_grievance`
--

CREATE TABLE `employee_grievance` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `category` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `descrip` text NOT NULL,
  `attach` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_grievance`
--

INSERT INTO `employee_grievance` (`id`, `uid`, `category`, `subject`, `descrip`, `attach`, `created_at`, `updated_at`) VALUES
(1, 2, 'Appraisal', 'Appraisal', 'Hello Mam/SIr,\r\n\r\nIt is my duty to inform you that This is appraisal month so When I get form to regarding this.\r\n\r\nThanks', '58e2037ed3edc_images.jpg', '2017-04-03 08:10:38', '2017-04-03 08:10:38');

-- --------------------------------------------------------

--
-- Table structure for table `employee_language`
--

CREATE TABLE `employee_language` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `language` varchar(100) NOT NULL DEFAULT '',
  `mother_tongue` varchar(100) NOT NULL DEFAULT '',
  `spoken_fluency` varchar(50) NOT NULL DEFAULT '',
  `reading_fluency` varchar(50) NOT NULL DEFAULT '',
  `written_fluency` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_language`
--

INSERT INTO `employee_language` (`id`, `uid`, `language`, `mother_tongue`, `spoken_fluency`, `reading_fluency`, `written_fluency`, `created_at`, `updated_at`) VALUES
(1, 2, 'Hindi', 'Yes', 'High', 'High', 'High', '2017-03-11 11:16:32', '2017-03-11 11:16:32'),
(2, 2, 'English', 'No', 'Medium', 'High', 'High', '2017-03-11 11:31:44', '2017-03-11 11:32:45'),
(3, 2, 'Punjabi', 'No', 'Medium', 'Low', 'Low', '2017-03-11 11:33:08', '2017-03-11 11:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `employee_letters`
--

CREATE TABLE `employee_letters` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `letter` text NOT NULL,
  `letter_type` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_letters`
--

INSERT INTO `employee_letters` (`id`, `uid`, `letter`, `letter_type`, `created_at`, `updated_at`) VALUES
(4, 2, 'Banish103_new_appointment.docx', '2', '2017-04-21 10:11:48', '2017-04-21 10:11:48'),
(5, 2, 'Banish103_new_appointment.docx', '3', '2017-04-21 10:22:04', '2017-04-21 10:22:04'),
(6, 3, 'Prince104_Appoitment_letter_V2.0.docx', '2', '2017-05-02 10:50:11', '2017-05-02 10:50:11'),
(7, 3, 'Prince104_Appoitment_letter_V2.0.docx', '2', '2017-05-02 10:50:32', '2017-05-02 10:50:32');

-- --------------------------------------------------------

--
-- Table structure for table `employee_qualification`
--

CREATE TABLE `employee_qualification` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `institute` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_qualification`
--

INSERT INTO `employee_qualification` (`id`, `uid`, `type`, `institute`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 2, 'IOS', 'terte', '2017-03-02 00:00:00', '2017-03-01 00:00:00', '2017-03-23 12:42:20', '2017-03-23 12:42:20');

-- --------------------------------------------------------

--
-- Table structure for table `employee_reporting`
--

CREATE TABLE `employee_reporting` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `reporting_manager` int(11) NOT NULL,
  `hr_manager` int(11) NOT NULL,
  `finance_manager` int(11) NOT NULL,
  `admin_manager` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_reporting`
--

INSERT INTO `employee_reporting` (`id`, `uid`, `reporting_manager`, `hr_manager`, `finance_manager`, `admin_manager`, `created_at`, `updated_at`) VALUES
(3, 2, 3, 11, 3, 11, '2017-04-27 07:42:46', '2017-04-27 07:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `employee_work`
--

CREATE TABLE `employee_work` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `company` varchar(255) NOT NULL,
  `work_nature` text NOT NULL,
  `position` varchar(255) NOT NULL,
  `joining_date` datetime NOT NULL,
  `leaving_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_work`
--

INSERT INTO `employee_work` (`id`, `uid`, `company`, `work_nature`, `position`, `joining_date`, `leaving_date`, `created_at`, `updated_at`) VALUES
(2, 2, 'MST', 'Developing', 'PHP Developer', '2016-01-03 00:00:00', '2017-03-28 00:00:00', '2017-03-30 10:23:33', '2017-03-30 10:23:33');

-- --------------------------------------------------------

--
-- Table structure for table `emp_crresume`
--

CREATE TABLE `emp_crresume` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `f_name` varchar(255) NOT NULL DEFAULT '',
  `m_name` varchar(255) NOT NULL DEFAULT '',
  `l_name` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `address` text NOT NULL,
  `phone` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `website` varchar(100) NOT NULL DEFAULT '',
  `biography` text NOT NULL,
  `job_title` text NOT NULL,
  `short_desc` text NOT NULL,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `school_name` text NOT NULL,
  `short_descedu` text NOT NULL,
  `degree` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_crresume`
--

INSERT INTO `emp_crresume` (`id`, `uid`, `f_name`, `m_name`, `l_name`, `country`, `city`, `address`, `phone`, `email`, `website`, `biography`, `job_title`, `short_desc`, `date_from`, `date_to`, `school_name`, `short_descedu`, `degree`, `created_at`, `updated_at`) VALUES
(1, 2, 'Demo', 'gs', 'Freelancer', 'india', 'demo', 'HP', 'bayorims@gmail.com', 'banish.mst@gmail.com', 'www.banishblog.com', '<h1>test<br></h1>', 'test', 'test', '2017-03-01 00:00:00', '2017-03-22 00:00:00', 'test', 'test', 'tset', '2017-03-31 12:16:03', '2017-03-31 12:16:03');

-- --------------------------------------------------------

--
-- Table structure for table `emp_fullandfinal`
--

CREATE TABLE `emp_fullandfinal` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `rgappdate` datetime NOT NULL,
  `rgadate` datetime NOT NULL,
  `nperiod` varchar(255) NOT NULL DEFAULT '',
  `pending` varchar(255) NOT NULL DEFAULT '',
  `hoto` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_fullandfinal`
--

INSERT INTO `emp_fullandfinal` (`id`, `uid`, `rgappdate`, `rgadate`, `nperiod`, `pending`, `hoto`, `created_at`, `updated_at`) VALUES
(1, 15, '2017-03-06 00:00:00', '2017-06-11 00:00:00', '20', '0', 0, '2017-04-28 08:05:48', '2017-06-02 14:11:18');

-- --------------------------------------------------------

--
-- Table structure for table `emp_leaves`
--

CREATE TABLE `emp_leaves` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `leave_type` int(11) NOT NULL,
  `leave_number` double NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT '',
  `from_date` date NOT NULL DEFAULT '0000-00-00',
  `to_date` date NOT NULL DEFAULT '0000-00-00',
  `reason` text NOT NULL,
  `attach` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_leaves`
--

INSERT INTO `emp_leaves` (`id`, `uid`, `leave_type`, `leave_number`, `status`, `from_date`, `to_date`, `reason`, `attach`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, 'pending', '2017-01-01', '2017-02-16', 'attch', 'test.png', '2017-02-28 11:29:59', '2017-02-28 11:29:59'),
(2, 2, 2, 0.5, 'pending', '2017-01-01', '2017-02-16', 'attch', 'test.png', '2017-02-28 11:29:59', '2017-02-28 11:29:59'),
(3, 2, 2, 0.5, 'pending', '2017-02-01', '2017-02-16', 'attch', 'test.png', '2017-02-28 11:29:59', '2017-02-28 11:29:59'),
(5, 3, 10, 0.5, 'pending', '2017-01-01', '2017-01-16', 'attch', 'test.png', '2017-02-28 11:29:59', '2017-02-28 11:29:59'),
(6, 3, 11, 0.5, 'pending', '2017-02-01', '2017-02-16', 'attch', 'test.png', '2017-02-28 11:29:59', '2017-02-28 11:29:59'),
(12, 3, 9, 3, 'pending', '2017-03-01', '2017-03-09', 'fd', 'test.png', '2017-03-02 12:53:29', '2017-03-02 12:53:29');

-- --------------------------------------------------------

--
-- Table structure for table `emp_profile`
--

CREATE TABLE `emp_profile` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `marital_status` varchar(255) NOT NULL DEFAULT '',
  `dom` date NOT NULL,
  `disability_details` text NOT NULL,
  `father_fname` varchar(255) NOT NULL DEFAULT '',
  `father_mname` varchar(255) NOT NULL,
  `father_lname` varchar(255) NOT NULL DEFAULT '',
  `mother_fname` varchar(255) NOT NULL,
  `mother_mname` varchar(255) NOT NULL,
  `mother_lname` varchar(255) NOT NULL,
  `spouse_fname` varchar(255) NOT NULL,
  `spouse_mname` varchar(255) NOT NULL,
  `spouse_lname` varchar(255) NOT NULL,
  `children` text NOT NULL,
  `emergency_contact` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_At` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_profile`
--

INSERT INTO `emp_profile` (`id`, `uid`, `marital_status`, `dom`, `disability_details`, `father_fname`, `father_mname`, `father_lname`, `mother_fname`, `mother_mname`, `mother_lname`, `spouse_fname`, `spouse_mname`, `spouse_lname`, `children`, `emergency_contact`, `created_at`, `updated_At`) VALUES
(1, 2, 'unmarried', '0000-00-00', '', '', '', '', '', '', '', '', '', '', '', '9415658639', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `emp_resume`
--

CREATE TABLE `emp_resume` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `resume` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_resume`
--

INSERT INTO `emp_resume` (`id`, `uid`, `resume`, `created_at`, `updated_at`) VALUES
(1, 2, '58de3069cf13a_Resume.pdf', '2017-03-31 10:33:13', '2017-03-31 10:33:13');

-- --------------------------------------------------------

--
-- Table structure for table `emp_uid`
--

CREATE TABLE `emp_uid` (
  `id` int(11) NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_uid`
--

INSERT INTO `emp_uid` (`id`, `uid`, `created_at`, `updated_at`) VALUES
(1, '104', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `leave_type` varchar(255) NOT NULL DEFAULT '',
  `leave_number` double NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`id`, `uid`, `leave_type`, `leave_number`, `created_at`, `updated_at`) VALUES
(1, 2, 'PL', 4, '2017-04-06 00:00:00', '2017-04-06 05:40:50'),
(2, 2, 'CL', 2, '2017-04-06 00:00:00', '2017-04-06 05:40:50'),
(3, 2, 'SL', 1.33336, '2017-04-06 00:00:00', '2017-04-06 05:40:50'),
(4, 2, 'SL ME', 2, '2017-04-06 00:00:00', '2017-04-06 05:40:50'),
(12, 3, 'SL ME', 1.5, '2017-03-02 00:00:00', '2017-03-02 08:03:29'),
(11, 3, 'SL', 1.0000200000000001, '2017-03-02 00:00:00', '2017-03-02 08:03:29'),
(10, 3, 'CL', 1.5, '2017-03-02 00:00:00', '2017-03-02 08:03:29'),
(9, 3, 'PL', 3, '2017-03-02 00:00:00', '2017-03-02 08:03:29'),
(13, 1, 'PL', 1, '1903-12-11 00:00:00', '2017-03-03 06:18:56'),
(14, 1, 'CL', 0.5, '1903-12-11 00:00:00', '2017-03-03 06:18:56'),
(15, 1, 'SL', 0.33334, '1903-12-11 00:00:00', '2017-03-03 06:18:56'),
(16, 1, 'SL ME', 0.5, '1903-12-11 00:00:00', '2017-03-03 06:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `letter_type`
--

CREATE TABLE `letter_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `letter_type`
--

INSERT INTO `letter_type` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Appointment', '2017-04-19 12:25:30', '2017-04-19 12:25:30'),
(3, 'Appraisal', '2017-04-21 10:21:21', '2017-04-21 10:21:21');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `desc` text NOT NULL,
  `is_visible` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `desc`, `is_visible`, `created_at`, `updated_at`) VALUES
(1, 'Happy New Year', 'Hello All. Welcome back. This year is going to be amazing. A lot of new product in the pipeline.', 0, '2017-02-10 10:08:55', '2017-02-10 11:30:58'),
(2, 'New Update', 'Sample one', 0, '2017-02-10 11:31:25', '2017-02-10 11:31:25');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `uid`, `subject`, `message`, `type`, `created_at`, `updated_at`) VALUES
(1, 2, 'Regarding Leave', 'Your leave has been approved.', 'Leave', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 2, 'Regarding Appraisal', 'Your appraisal will be announced soon.', 'other', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `dop` date NOT NULL,
  `from_date` date NOT NULL DEFAULT '0000-00-00',
  `to_date` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payroll`
--

INSERT INTO `payroll` (`id`, `uid`, `dop`, `from_date`, `to_date`, `created_at`, `updated_at`) VALUES
(1, 2, '2017-02-17', '2017-02-01', '2017-08-01', '2017-02-17 13:20:49', '2017-02-17 13:20:49'),
(4, 3, '2017-02-23', '2017-02-01', '2017-12-01', '2017-02-23 09:49:25', '2017-02-23 09:49:25');

-- --------------------------------------------------------

--
-- Table structure for table `previous-employement`
--

CREATE TABLE `previous-employement` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `experience` text NOT NULL,
  `salaryslip` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `company_name` varchar(255) NOT NULL DEFAULT '',
  `company_website` varchar(255) NOT NULL DEFAULT '',
  `employee_id` varchar(255) NOT NULL DEFAULT '',
  `period_from` date NOT NULL,
  `period_to` date NOT NULL,
  `formsixteen` text NOT NULL,
  `formeighteen` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `previous-employement`
--

INSERT INTO `previous-employement` (`id`, `uid`, `experience`, `salaryslip`, `created_at`, `updated_at`, `company_name`, `company_website`, `employee_id`, `period_from`, `period_to`, `formsixteen`, `formeighteen`) VALUES
(1, 2, ' ', ' ', '2017-05-17 09:13:55', '2017-05-17 12:11:06', 'test', 'test', 'test', '2016-02-04', '2016-02-05', '591c3dda6b051_bluedemobutton.jpg', ' ');

-- --------------------------------------------------------

--
-- Table structure for table `resignation_formalities`
--

CREATE TABLE `resignation_formalities` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `r_accepted` int(11) NOT NULL,
  `r_date` date NOT NULL,
  `notice_period_server` int(11) NOT NULL,
  `less_period` int(11) NOT NULL,
  `last_working_date` date NOT NULL,
  `dues_pending` int(11) NOT NULL,
  `dues_amount` double NOT NULL,
  `eligible` int(11) NOT NULL,
  `eligible_detail` text NOT NULL,
  `issue` varchar(255) NOT NULL,
  `exit_formalities` int(11) NOT NULL,
  `exit_formalities_detail` text NOT NULL,
  `remark_behaviour` text NOT NULL,
  `other_comment` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `resignation_request`
--

CREATE TABLE `resignation_request` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `r_date` date NOT NULL,
  `reason` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resignation_request`
--

INSERT INTO `resignation_request` (`id`, `uid`, `r_date`, `reason`, `created_at`, `updated_at`) VALUES
(6, 2, '2017-05-22', 'test', '2017-05-22 11:54:52', '2017-05-22 11:54:52'),
(3, 3, '2017-05-17', 'test', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 2, '2017-05-15', 'tewst', '2017-05-22 11:55:37', '2017-05-22 11:55:37');

-- --------------------------------------------------------

--
-- Table structure for table `rules_regulations`
--

CREATE TABLE `rules_regulations` (
  `id` int(11) NOT NULL,
  `description_responsibilities` text NOT NULL,
  `other_beifits` text NOT NULL,
  `skills` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rules_regulations`
--

INSERT INTO `rules_regulations` (`id`, `description_responsibilities`, `other_beifits`, `skills`, `created_at`, `updated_at`) VALUES
(1, 'Vivamus dignissim ex eu diam eleifend pharetra. Aliquam eleifend arcu quis risus scelerisque feugiat. Donec suscipit tincidunt purus et vulputate. Proin ac rutrum urna, nec elementum leo. Praesent commodo neque nunc, efficitur aliquam quam iaculis a. Sed quis eros justo. Pellentesque ut turpis quam. ', '<ul>\r\n				<li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li>\r\n				<li>Aliquam tincidunt mauris eu risus.</li>\r\n				<li>Vestibulum auctor dapibus neque.</li>\r\n				<li>Nunc dignissim risus id metus.</li>\r\n				<li>Cras ornare tristique elit.</li>\r\n				<li>Vivamus vestibulum nulla nec ante.</li>\r\n				<li>Praesent placerat risus quis eros.</li>\r\n				<li>Fusce pellentesque suscipit nibh.</li>\r\n				<li>Integer vitae libero ac risus egestas placerat.</li>\r\n				<li>Vestibulum commodo felis quis tortor.</li>\r\n				<li>Ut aliquam sollicitudin leo.</li>\r\n				<li>Cras iaculis ultricies nulla.</li>\r\n				<li>Donec quis dui at dolor tempor interdum.</li>\r\n				<li>Vivamus molestie gravida turpis.</li>\r\n				<li>Fusce lobortis lorem at ipsum semper sagittis.</li>\r\n				<li>Nam convallis pellentesque nisl.</li>\r\n				<li>Integer malesuada commodo nulla.</li>\r\n			</ul>', '<ul>\r\n				<li>Ut aliquam sollicitudin leo.</li>\r\n				<li>Cras iaculis ultricies nulla.</li>\r\n				<li>Donec quis dui at dolor tempor interdum.</li>\r\n				<li>Vivamus molestie gravida turpis.</li>\r\n				<li>Fusce lobortis lorem at ipsum semper sagittis.</li>\r\n			</ul>', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `salary_template`
--

CREATE TABLE `salary_template` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `template_name` varchar(255) NOT NULL DEFAULT '',
  `employee_CPF` varchar(255) NOT NULL DEFAULT '',
  `employee_CPF_rate` varchar(50) NOT NULL DEFAULT '',
  `employer_CPF_contribution` varchar(255) NOT NULL DEFAULT '',
  `employer_CPF_contribution_rate` varchar(255) DEFAULT '',
  `basicsalary` varchar(255) NOT NULL DEFAULT '',
  `total_allowance` varchar(255) NOT NULL DEFAULT '',
  `total_allowance_detail` text,
  `total_allowence_value` varchar(255) NOT NULL DEFAULT '',
  `total_deduction` varchar(255) NOT NULL DEFAULT '',
  `total_deduction_detail` varchar(255) NOT NULL DEFAULT '',
  `total_deduction_value` varchar(255) NOT NULL,
  `net_salary` varchar(255) NOT NULL DEFAULT '',
  `salary_period` varchar(255) NOT NULL,
  `aditional_payment` varchar(255) NOT NULL DEFAULT '',
  `aditional_payment_detail` varchar(255) NOT NULL DEFAULT '',
  `aditional_payment_value` varchar(255) NOT NULL,
  `notes` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salary_template`
--

INSERT INTO `salary_template` (`id`, `uid`, `template_name`, `employee_CPF`, `employee_CPF_rate`, `employer_CPF_contribution`, `employer_CPF_contribution_rate`, `basicsalary`, `total_allowance`, `total_allowance_detail`, `total_allowence_value`, `total_deduction`, `total_deduction_detail`, `total_deduction_value`, `net_salary`, `salary_period`, `aditional_payment`, `aditional_payment_detail`, `aditional_payment_value`, `notes`, `created_at`, `updated_at`) VALUES
(1, 2, 'Banish', '', '0', '', '0', '23400', '90', '[\"test\",\"test1\",\"test2\",\"fsdfs\"]', '[\"20\",\"30\",\"40\",\"50\"]', '90', '[\"tes\",\"test\",\"test\"]', '[\"30\",\"40\",\"20\"]', '23460', '{\"hourly\":\"hourly\",\"daily\":\"daily\",\"weekly\":\"weekly\",\"fortnightly\":\"fortnightly\"}', '60', '[\"tests\",\"test\",\"tes\"]', '[\"20\",\"30\",\"10\"]', 'testet', '2017-02-16 12:16:35', '2017-02-17 11:49:01'),
(2, 3, 'Prince', '', '0', '', '0', '24000', '1000', '[\"test\",\"test\",\"tes\"]', '[\"200\",\"300\",\"500\"]', '1200', '[\"tset\",\"test\"]', '[\"1000\",\"200\"]', '25100.00', '{\"hourly\":\"hourly\",\"daily\":\"daily\",\"weekly\":\"weekly\",\"fortnightly\":\"fortnightly\"}', '1300', '[\"tset\",\"test\",\"est\"]', '[\"300\",\"500\",\"500\"]', 'test', '2017-02-23 10:01:32', '2017-02-23 10:01:32');

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `id` int(11) NOT NULL,
  `latest_updates` text NOT NULL,
  `others` text NOT NULL,
  `vivamus_molestie` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `updates`
--

INSERT INTO `updates` (`id`, `latest_updates`, `others`, `vivamus_molestie`, `created_at`, `updated_at`) VALUES
(1, 'Vivamus dignissim ex eu diam eleifend pharetra. Aliquam eleifend arcu quis risus scelerisque feugiat. Donec suscipit tincidunt purus et vulputate. Proin ac rutrum urna, nec elementum leo. Praesent commodo neque nunc, efficitur aliquam quam iaculis a. Sed quis eros justo. Pellentesque ut turpis quam. ', '\r\n    Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\r\n    Aliquam tincidunt mauris eu risus.\r\n    Vestibulum auctor dapibus neque.\r\n    Nunc dignissim risus id metus.\r\n    Cras ornare tristique elit.\r\n    Vivamus vestibulum nulla nec ante.\r\n    Praesent placerat risus quis eros.\r\n    Fusce pellentesque suscipit nibh.\r\n    Integer vitae libero ac risus egestas placerat.\r\n    Vestibulum commodo felis quis tortor.\r\n    Ut aliquam sollicitudin leo.\r\n    Cras iaculis ultricies nulla.\r\n    Donec quis dui at dolor tempor interdum.\r\n    Vivamus molestie gravida turpis.\r\n    Fusce lobortis lorem at ipsum semper sagittis.\r\n    Nam convallis pellentesque nisl.\r\n    Integer malesuada commodo nulla.\r\n', '\r\n    Ut aliquam sollicitudin leo.\r\n    Cras iaculis ultricies nulla.\r\n    Donec quis dui at dolor tempor interdum.\r\n    Vivamus molestie gravida turpis.\r\n    Fusce lobortis lorem at ipsum semper sagittis.\r\n', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `houseno` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `address_street_no1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `postal_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `e_contact1` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `emp_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `working_hours` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `working_weeks` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notice_period` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `for_days` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prob_start_date` date NOT NULL DEFAULT '0000-00-00',
  `prob_end_date` date NOT NULL DEFAULT '0000-00-00',
  `e_department` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `sex` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `religion` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `caste` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `nationality` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `adhar_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `enrollment_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `pan_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `npr` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `jobtitle` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `qualification` text COLLATE utf8_unicode_ci NOT NULL,
  `blood_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bank_author` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch` text COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `acc_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ifsccode` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `remark` text COLLATE utf8_unicode_ci NOT NULL,
  `unQid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` text COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `f_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `l_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `father_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `show_pass` text COLLATE utf8_unicode_ci,
  `image` text COLLATE utf8_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `address` text COLLATE utf8_unicode_ci,
  `f_h` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salary` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `company` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `doo` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dob` date NOT NULL DEFAULT '0000-00-00',
  `age` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `doj` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `doa` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `doap` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `designation` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_type` int(11) DEFAULT NULL,
  `emp_stat` int(11) NOT NULL,
  `bank_statement` text COLLATE utf8_unicode_ci NOT NULL,
  `account_statement` text COLLATE utf8_unicode_ci NOT NULL,
  `cancel_check` text COLLATE utf8_unicode_ci NOT NULL,
  `emp_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `emp_docs` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `houseno`, `address_street_no1`, `country`, `postal_code`, `e_contact1`, `emp_type`, `working_hours`, `working_weeks`, `notice_period`, `for_days`, `prob_start_date`, `prob_end_date`, `e_department`, `sex`, `religion`, `caste`, `nationality`, `adhar_number`, `enrollment_id`, `pan_number`, `npr`, `jobtitle`, `qualification`, `blood_group`, `bank_author`, `branch`, `city`, `acc_no`, `ifsccode`, `remark`, `unQid`, `uuid`, `name`, `f_name`, `l_name`, `father_name`, `email`, `password`, `show_pass`, `image`, `remember_token`, `phone_number`, `address`, `f_h`, `salary`, `company`, `doo`, `dob`, `age`, `doj`, `doa`, `doap`, `designation`, `user_type`, `emp_stat`, `bank_statement`, `account_statement`, `cancel_check`, `emp_status`, `emp_docs`, `created_at`, `updated_at`) VALUES
(1, '1234', '2131', 'India', '160022', '21313123', 'full time', 'office business hours', '{\"mon\":\"mon\",\"tue\":\"tue\",\"wed\":\"wed\",\"thu\":\"thu\",\"fri\":\"fri\",\"sat\":\"sat\"}', '1', 'for month', '2015-01-01', '2015-03-01', '1', 'male', 'hindu', '', '', '', '', '', '', 'admin', 'NA', '', 'admin', 'Chandigarh', 'Chandigarh', '123456789', 'SBI54654D', 'SBI', '1998111', '101', 'sahil', 'sahil', 'admin', '', 'sahil@mindxpert.com', '$2y$10$7x6NcEnq90te9xGrDoL8b.e0TynCfmm1YrclaEVeKTUd9zMFPNrQu', '123456', '589d7399f1ac1_images.jpg', 'w1wWixrO7N05mGV8TR66vOl6ZAgCx3Uf0ceVKsOxglMY8tVuhydwao8sDdbF', '6515646', 'test', 'NA', '00000', '', '0000-00-00 00:00:00', '1991-04-18', '', '1903-12-11 00:00:00', '1900-12-01 00:00:00', '', 'Admin', 0, 0, '', '', '', '', '', '2017-02-06 03:14:09', '2017-02-10 02:32:33'),
(2, '1234', '2131', 'india', '160022', '6515646', 'full time', 'shift hours', '{\"mon\":\"mon\",\"tue\":\"tue\",\"wed\":\"wed\",\"thu\":\"thu\",\"fri\":\"fri\",\"sat\":\"sat\",\"sun\":\"sun\"}', '1', 'for days', '2015-01-01', '2015-03-01', '0', 'male', 'hindu', 'hindu', 'Indian', '', '', '', '', 'php', 'MCA', '', 'Banish Chandel', 'Chandigarh', 'Chandigarh', '123456789', 'SBI54654D', 'SBI', '1998112', '103', 'Banish', 'Banish', 'Chandel', '', 'banish.mst@gmail.com', '$2y$12$AcEYg82JRCdFCVEn/lShVOng6xXaOBp3sKnITMzVFwSz1tJo.3NqK', '1234567', '589d7399f1ac1_images.jpg', 'IdaGzbQaUYwCE3GMJVLhewoK9wC8xx7IIhUdCHUtN5CttoazJsU6KB1AXWYM', '9418960278', 'test', 'R Singh', '23400', '6', '0000-00-00 00:00:00', '1991-04-18', '', '2017-04-12 00:00:00', '1900-12-01 00:00:00', '2017-04-06', 'PHP DEVELOPER', 2, 1, '', '', '', '', '', '2017-02-06 03:14:09', '2017-04-21 06:40:30'),
(3, '1234', '2131', 'india', '160022', '9569854320', 'full time', 'shift hours', '{\"mon\":\"mon\",\"tue\":\"tue\",\"wed\":\"wed\",\"thu\":\"thu\",\"fri\":\"fri\",\"sat\":\"sat\",\"sun\":\"sun\"}', '1', 'for days', '2015-01-01', '2015-03-01', '0', 'male', 'others', '', '', '', '', '', '', 'UI', 'MCA', '', 'Prince', 'Chandigarh', 'Chandigarh', '123456789', 'SBI54654D', 'SBI', '1998113', '104', 'Prince', 'Prince', 'Kohli', '', 'prince.mst@gmail.com', '$2y$10$7x6NcEnq90te9xGrDoL8b.e0TynCfmm1YrclaEVeKTUd9zMFPNrQu', '123456', '589d7399f1ac1_images.jpg', '6ymX9nAE30kaqNFSzrK7H6ALffYC0rG19BMdeiNGEvoQSOJgeYDAzQtiJphk', '9888441786', 'test', 'R Singh', '24000', '6', '0000-00-00 00:00:00', '1986-02-26', '', '2016-01-01 00:00:00', '2016-01-01 00:00:00', '', 'PHP DEVELOPER', 1, 1, '', '', '', '', '', '2017-02-06 03:14:09', '2017-03-02 02:32:50'),
(11, '12324', 'ambala', 'India', '160022', '8950233176', 'full time', 'office business hours', '{\"mon\":\"mon\",\"tue\":\"tue\",\"wed\":\"wed\",\"thu\":\"thu\",\"fri\":\"fri\",\"sat\":\"sat\"}', '1', 'for month', '2017-02-01', '2017-07-07', '2', 'male', 'chinese', '', '', '', '', '', '', 'iOS Developer', 'BSC', '', 'Sumit Singh', 'Chandigarh', 'Chandigarh', '13246546464', 'SBI54654D', 'test', '1998114', '105', 'Sumit', 'Sumit', 'Singh', '', 'sumitsingh.mst@gmail.com', '$2y$12$IszMs3zh9i3imIlWW6WgnO.ctPiBGKT8H9uTPxbgOFWdoZIB.ejne', '12345678', '58a6f2e292001_images.jpg', NULL, '8950233176', NULL, '', '21000', '', '0000-00-00 00:00:00', '1990-06-02', '', '2016-06-23 00:00:00', '2016-06-15 00:00:00', '', '', 3, 1, '', '', '', '', '', '2017-02-17 07:26:02', '2017-02-17 07:26:02'),
(19, '1', 'Guru Teg Bhadur Colony, Malerkotla, Sangrur', 'India', '148023', '917889151924', ' ', ' ', ' ', '30', 'for days', '2017-06-06', '2017-06-06', '2', 'male', 'hindu', '', '', '', '', '', '', 'DBA', 'Btech, MBA', '', ' ', ' ', ' ', ' ', ' ', ' ', '7001', 'MIPL2014270', 'Gurdeep', 'Gurdeep', 'Singh', 'test', 'test', ' ', ' ', '593174e28edbe_company.png', NULL, '91991589554', '1,Guru Teg Bhadur Colony, Malerkotla, Sangrur,India,148023', '', '16500', '7', '2017-06-06 00:00:00', '1989-09-30', '1970-01-01', '2017-06-06 00:00:00', '2017-06-06 00:00:00', '', '', 3, 2, ' ', ' ', ' ', '', '59366d7be8bca_briefcase.svg,59366d7be8d37_calendar.svg,59366d7be8f16_check-mark.svg,59366d7be907a_dots-beginning-text-lines-interface-button-symbol.svg,59366d7be91d4_employees.svg,59366d7be9609_logout.svg,59366d7be994e_notebook.svg,59366d7be9b01_plus-sign-in-circle.svg,59366d7be9c60_profile.svg', '2017-06-02 08:53:30', '2017-06-06 04:39:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address_proof`
--
ALTER TABLE `address_proof`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_address`
--
ALTER TABLE `employee_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_bank`
--
ALTER TABLE `employee_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_contact`
--
ALTER TABLE `employee_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_credential`
--
ALTER TABLE `employee_credential`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_docrequest`
--
ALTER TABLE `employee_docrequest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_grievance`
--
ALTER TABLE `employee_grievance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_language`
--
ALTER TABLE `employee_language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_letters`
--
ALTER TABLE `employee_letters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_qualification`
--
ALTER TABLE `employee_qualification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_reporting`
--
ALTER TABLE `employee_reporting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_work`
--
ALTER TABLE `employee_work`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_crresume`
--
ALTER TABLE `emp_crresume`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_fullandfinal`
--
ALTER TABLE `emp_fullandfinal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_leaves`
--
ALTER TABLE `emp_leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_profile`
--
ALTER TABLE `emp_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_resume`
--
ALTER TABLE `emp_resume`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_uid`
--
ALTER TABLE `emp_uid`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `letter_type`
--
ALTER TABLE `letter_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `previous-employement`
--
ALTER TABLE `previous-employement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resignation_formalities`
--
ALTER TABLE `resignation_formalities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resignation_request`
--
ALTER TABLE `resignation_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rules_regulations`
--
ALTER TABLE `rules_regulations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `salary_template`
--
ALTER TABLE `salary_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address_proof`
--
ALTER TABLE `address_proof`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `employee_address`
--
ALTER TABLE `employee_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee_bank`
--
ALTER TABLE `employee_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee_contact`
--
ALTER TABLE `employee_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee_credential`
--
ALTER TABLE `employee_credential`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee_docrequest`
--
ALTER TABLE `employee_docrequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee_grievance`
--
ALTER TABLE `employee_grievance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `employee_language`
--
ALTER TABLE `employee_language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `employee_letters`
--
ALTER TABLE `employee_letters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `employee_qualification`
--
ALTER TABLE `employee_qualification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `employee_reporting`
--
ALTER TABLE `employee_reporting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `employee_work`
--
ALTER TABLE `employee_work`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `emp_crresume`
--
ALTER TABLE `emp_crresume`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `emp_fullandfinal`
--
ALTER TABLE `emp_fullandfinal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `emp_leaves`
--
ALTER TABLE `emp_leaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `emp_profile`
--
ALTER TABLE `emp_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `emp_resume`
--
ALTER TABLE `emp_resume`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `emp_uid`
--
ALTER TABLE `emp_uid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `letter_type`
--
ALTER TABLE `letter_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `previous-employement`
--
ALTER TABLE `previous-employement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `resignation_formalities`
--
ALTER TABLE `resignation_formalities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `resignation_request`
--
ALTER TABLE `resignation_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `rules_regulations`
--
ALTER TABLE `rules_regulations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `salary_template`
--
ALTER TABLE `salary_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
