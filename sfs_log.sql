-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2013 at 05:10 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sfs_log`
--

-- --------------------------------------------------------

--
-- Table structure for table `core_settings`
--

CREATE TABLE IF NOT EXISTS `core_settings` (
  `slug` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `default` text COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`slug`),
  UNIQUE KEY `unique - slug` (`slug`),
  KEY `index - slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Stores settings for the multi-site interface';

--
-- Dumping data for table `core_settings`
--

INSERT INTO `core_settings` (`slug`, `default`, `value`) VALUES
('date_format', 'g:ia -- m/d/y', 'g:ia -- m/d/y'),
('lang_direction', 'ltr', 'ltr'),
('status_message', 'This site has been disabled by a super-administrator.', 'This site has been disabled by a super-administrator.');

-- --------------------------------------------------------

--
-- Table structure for table `core_sites`
--

CREATE TABLE IF NOT EXISTS `core_sites` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `ref` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `domain` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique ref` (`ref`),
  UNIQUE KEY `Unique domain` (`domain`),
  KEY `ref` (`ref`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_sites`
--

INSERT INTO `core_sites` (`id`, `name`, `ref`, `domain`, `active`, `created_on`, `updated_on`) VALUES
(1, 'Default Site', 'default', 'localhost', 1, 1354594246, 0);

-- --------------------------------------------------------

--
-- Table structure for table `core_users`
--

CREATE TABLE IF NOT EXISTS `core_users` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `group_id` int(11) DEFAULT NULL,
  `ip_address` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `activation_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_on` int(11) NOT NULL,
  `last_login` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `forgotten_password_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Super User Information' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `core_users`
--

INSERT INTO `core_users` (`id`, `email`, `password`, `salt`, `group_id`, `ip_address`, `active`, `activation_code`, `created_on`, `last_login`, `username`, `forgotten_password_code`, `remember_code`) VALUES
(1, 'sfswebdev@gmail.com', '0a20eb795bf71b411eb25e7d908e99be3b7bf942', 'ce047', 1, '', 1, '', 1354594245, 1354594245, 'SYS_ADMIN', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `default_accounting_category`
--

CREATE TABLE IF NOT EXISTS `default_accounting_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `prefix` varchar(10) NOT NULL,
  `parent` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `default_accounting_category`
--

INSERT INTO `default_accounting_category` (`id`, `name`, `prefix`, `parent`) VALUES
(1, 'Inventory - Office Supplies', 'SOS', 0),
(2, 'Inventory - Food Court', 'MFC', 0),
(3, 'Inventory - LPG', 'LPA', 0),
(4, 'Inventory - LPG Recoveries', 'LPB', 0),
(5, 'Building Improvement', 'PBI', 0),
(6, 'Leasehold Improvements', 'LHI', 0),
(7, 'Machinery & Equipment', 'MNE', 0),
(8, 'Office Furniture Fixture & Equipment', 'OFE', 0),
(9, 'Food Court Equipment', 'FCE', 0),
(10, 'Tools & Equipment', 'TNE', 0),
(11, 'Vehicles', 'VHL', 0),
(12, 'Computer Hardware/ Upgrade', 'ITH', 0),
(13, 'Systems & Softwares', 'ITS', 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_blog`
--

CREATE TABLE IF NOT EXISTS `default_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `attachment` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `intro` text COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `parsed` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) NOT NULL DEFAULT '0',
  `comments_enabled` int(1) NOT NULL DEFAULT '1',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `type` set('html','markdown','wysiwyg-advanced','wysiwyg-simple') COLLATE utf8_unicode_ci NOT NULL,
  `preview_hash` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_title` (`title`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_blog_categories`
--

CREATE TABLE IF NOT EXISTS `default_blog_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_slug` (`slug`),
  UNIQUE KEY `unique_title` (`title`),
  KEY `slug` (`slug`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `default_blog_categories`
--

INSERT INTO `default_blog_categories` (`id`, `slug`, `title`) VALUES
(1, 'sample-category', 'Sample Category');

-- --------------------------------------------------------

--
-- Table structure for table `default_ci_sessions`
--

CREATE TABLE IF NOT EXISTS `default_ci_sessions` (
  `session_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `user_agent` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `default_ci_sessions`
--

INSERT INTO `default_ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('aa97aac26da248e51a831e5966684154', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1354591671, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('9bc7e5fc05964a8984b250382bc6d08c', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358262685, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('4d7e326333cb462441ad7f554604c94d', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1354752788, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('2c6fbb73d6eca0a9781fbeded0022158', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1355361931, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('bd199197168f2cad137cf928aa835e31', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1355382447, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('a42f0e4a67924ba5510fc8e07255e5d8', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358142157, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('3349cee1377ba8e6c997e11aaec3c09f', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358168868, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('a4b7c3fcf080c02468de31109018073f', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358183371, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('361bf859bc604158ac27504eb8b55f17', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358259103, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('f303a8a390a50a1ce24d60fa901381bf', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358259104, ''),
('3eb1059b8dfc16da34484ed75f183608', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358262685, ''),
('f73b2851d07d9a0c7d4c6339c62fa88d', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1358833037, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('e566deea8ef2c364d3e06334fa5aa270', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1359332979, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('e1cc430a07da9e6a55416f1bf646b79d', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.52 Safari/537.17', 1359102197, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:5:"admin";}'),
('ecc1519849d347a7e8bc69011430e1b7', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1359614988, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('b03a8574aa1fe254081cee99a54d0af8', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1360213560, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('ef78c65277a7d908a84b06a46d1980d9', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1360896117, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('e35b4bf84f4038d5f5beb44105aa9606', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361179588, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('5baccdd8f216b30ece1fb0db854e600e', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1360896117, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:21:"admin/materialrequest";}'),
('5d9e968399e639d7140ef865cac5b7ca', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361230843, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('991b2c99cdcf5ed4eb9478d8fd66414f', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361231493, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('3135c63ebc899f5d63eeecdc4a439696', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361231494, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:16:"admin/categories";}'),
('8f3221d01964a904010e24cecc8d1abc', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361231494, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:16:"admin/categories";}'),
('19fcd99e2b904b39e18cf35bbe166df3', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361231495, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:16:"admin/categories";}'),
('78c3463d0289e0d44b27ba91dd2a0807', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1361932303, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('566d6c8c6a3b1c740ebddaf3c9cb5126', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17', 1361781836, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:5:"admin";}'),
('1e750e8a9e6249e62cde3c423d49abae', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362024786, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('6beb689302927feafe8bb36d6e5418e3', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362034185, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('b09b97cf56c2c703c0a7a477c35adca2', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362035004, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('b703fdb6de06239e116c282954d50970', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362035891, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('9e74c32bb2123985d89dbae7bb0c64ed', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362036250, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('83b31416b45429d6d909d5a966766192', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362036602, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('9ecbf8e29bdb11292127a39f9495edf8', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362200183, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('089b6dcc86724f81a0244713d072f3ae', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362221799, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('1ad3b1a435aa9b7fe7a5a404c23f4dd2', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362227190, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('b6a372b6ceb47c189bd675bcb4ee2d1f', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362273905, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('ca004c408bb7468fca4e6c0fd391982c', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362292206, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('6fa586685880b3426189e48857ada161', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362306274, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('0bb6b56e877b49a29aab7cf146e63d3c', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20100101 Firefox/15.0.1', 1362537205, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('e69c297035c8d888e78db3a55933fde6', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22', 1362674581, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('272edfd140f7e09b44cbf510a06ae6c0', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22', 1362674381, ''),
('e81a0204a11dede9898552e6af5a07e8', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22', 1362684110, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('f606ba30b0b846a89b42cf826069f3b6', '0.0.0.0', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', 1362711406, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('ef1feb4fca43889963624af9c42119d1', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22', 1362791169, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:5:"admin";}'),
('24224773dd40a07f9a9f6c6c204553fd', '0.0.0.0', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', 1362791921, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('865f6d91da4fd96cd96f31f9bd6dcfc1', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.152 Safari/537.22', 1362920647, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:5:"admin";}'),
('fc4c33cdb1ed228e7238395c692ec222', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1362920695, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('7fc66baf7f88e56b6a46b8d3c4dcd13e', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1362987752, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('125fc446f13662bcc07a8c48c476904e', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363286987, 'a:10:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:4:"cart";a:3:{i:2;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:2;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"3";}i:3;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:3;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:1:"3";}i:4;a:4:{s:7:"item_id";s:1:"4";s:4:"line";i:4;s:11:"description";s:5:"Bread";s:8:"quantity";s:1:"3";}}s:5:"mr_id";s:1:"2";s:15:"flash:new:error";s:17:"Error adding item";}'),
('fa3b8f92df969507646c686d759e40d0', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363322623, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:4:"cart";a:1:{i:1;a:4:{s:7:"item_id";s:2:"10";s:4:"line";i:1;s:11:"description";s:18:"Under Siege Linked";s:8:"quantity";i:0;}}s:5:"mr_id";s:1:"2";}'),
('d16a11b00f7ddea04553028eae65096e', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363323929, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('e6cbca0882331d1b4abdae4a97375a42', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363323930, ''),
('af99d64da840cac092fd60ef979d747c', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363323931, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:15:"admin/divisions";}'),
('f7e26fa9dff2749bd2e02ae3a3aab57a', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363323931, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:15:"admin/divisions";}'),
('0bd97f120fb81c705543099c317a77fe', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363323931, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:15:"admin/divisions";}'),
('e26262e5b3db6495fd2dd18f7ea18e8a', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363325553, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('be4a98ad6c0a8e2c766b066ef8d8ec4c', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363842982, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('a9d5c83b52546282dee85302dfefe605', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1366001584, 'a:6:{s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('bc9c7da17091296b273abaf2b69cae65', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363335953, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:4:"cart";a:2:{i:2;a:4:{s:7:"item_id";s:2:"30";s:4:"line";i:2;s:11:"description";s:12:"Asahi Aircon";s:8:"quantity";s:0:"";}i:3;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:3;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:0:"";}}s:5:"mr_id";s:1:"2";}'),
('b8de1996ecbd7ba3ecdbd9c81a15b63d', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363609529, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('3c57b9969dec5f2135425480a5e186d1', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363649629, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('ad978a1fd5a6eda604b13f2e9c007afc', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363659311, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('a79f3e652e3f4c648fd66745dc928000', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20100101 Firefox/17.0', 1363686713, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('f00ecc3b56a1255fcae9d469f0c80e1d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366183599, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"6";s:4:"cart";a:3:{i:6;a:4:{s:7:"item_id";s:1:"9";s:4:"line";i:6;s:11:"description";s:11:"Top Gun DVD";s:8:"quantity";i:2;}i:7;a:4:{s:7:"item_id";s:1:"7";s:4:"line";i:7;s:11:"description";s:32:"Die Hard With A Vengeance Linked";s:8:"quantity";s:1:"3";}i:8;a:4:{s:7:"item_id";s:2:"10";s:4:"line";i:8;s:11:"description";s:18:"Under Siege Linked";s:8:"quantity";s:1:"2";}}}'),
('07879fb41bf98cb8dde31518eba728e6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366240223, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:21:"admin/materialrequest";}'),
('64f108515a258410a2d91a6ecc98bc3a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366268057, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:2:"15";s:4:"cart";a:4:{i:5;a:4:{s:7:"item_id";s:1:"6";s:4:"line";i:5;s:11:"description";s:20:"webERP Demo DVD Case";s:8:"quantity";s:1:"1";}i:7;a:4:{s:7:"item_id";s:2:"11";s:4:"line";i:7;s:11:"description";s:30:"Under Siege 2 - Dark Territory";s:8:"quantity";s:1:"1";}i:8;a:4:{s:7:"item_id";s:1:"9";s:4:"line";i:8;s:11:"description";s:11:"Top Gun DVD";s:8:"quantity";s:1:"1";}i:9;a:4:{s:7:"item_id";s:2:"12";s:4:"line";i:9;s:11:"description";s:20:"Action Series Bundle";s:8:"quantity";s:1:"1";}}}'),
('bfab2be7a9acfbdb03120eb201d82be7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348155, ''),
('ac8fbbff944941a713c0c83793cad2dc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348548, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:2:"17";s:4:"cart";a:3:{i:2;a:4:{s:7:"item_id";s:1:"6";s:4:"line";i:2;s:11:"description";s:20:"webERP Demo DVD Case";s:8:"quantity";s:1:"5";}i:3;a:4:{s:7:"item_id";s:1:"8";s:4:"line";i:3;s:11:"description";s:20:"Lethal Weapon Linked";s:8:"quantity";s:1:"3";}i:4;a:4:{s:7:"item_id";s:1:"4";s:4:"line";i:4;s:11:"description";s:5:"Bread";s:8:"quantity";s:1:"1";}}}'),
('d60696b3c969db838fcd8c84bd7a2617', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348278, ''),
('7a89f741f5f38faf7bef4cc70c4f68a8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348280, ''),
('f317697060691bb2cca70e997525fe95', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348284, ''),
('3cedbb20e58d1289b8c7c3d7ac723c0f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348295, ''),
('66ebe89b2f5b9d416ea3da5f9dd9b200', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348300, ''),
('7f9492454070db0fb833a118e1d77609', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348304, ''),
('22bf941a96bc43661400e21b08b9fe0b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348307, ''),
('7802f5815e8c5cd1b00bbbd012d1a0fd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348310, ''),
('9db7eb8b8b86708590ddef7d26b72206', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348601, ''),
('e0601f1e42864af0dfd925ab24485b71', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348324, ''),
('afabe248fd2fe0d5bf415ad66d06083d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348537, ''),
('c8efe420b7306562ed805f9b4c26c07b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348553, ''),
('b8cf8e494af9f191de67c3e76a1d454b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348560, ''),
('8934debc5ec353565e3ff9bb090a7ad6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348593, ''),
('33804a50db9ec49bd29b39760a9102bc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348583, ''),
('b77011bc0ad892b473e11ac396fa5e40', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366348606, ''),
('6b6152ddf0a37e6c2a296cb4fa278b7b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366416458, ''),
('5bfbd9f86ea834f3f3608f5968814472', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602062, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"3";s:4:"cart";a:1:{i:1;a:4:{s:7:"item_id";s:1:"4";s:4:"line";i:1;s:11:"description";s:5:"Bread";s:8:"quantity";s:1:"1";}}}'),
('664ce6857e3c54ceab193cf3935a5b03', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366420426, ''),
('82302c9375a971579b5e57a1f831fbab', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366420427, ''),
('cd3a5e465a337996bc450fa606dbfd90', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366421193, ''),
('bad6c8b01166c15136eeb09eba271b01', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366595673, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:0:{}}'),
('780a5e8525ce15152582d4f7ef79bc72', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366595673, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:33:"admin/materialrequest/add_items/5";}'),
('4f54bb65e05e6ff7b2a8357f25cdb296', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602065, ''),
('6310915426c93fa28455c5deb2db79b6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602072, ''),
('86c0b1fab9d896a1199c75e5d76269cd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602063, ''),
('8ddce1a53c44e7758139ec7730ab733a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366601663, ''),
('dffe36ae109979ca1aff485150766c63', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366600755, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"3";s:4:"cart";a:0:{}}'),
('e069b08dc45eb847898bda20818c6ad6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602127, ''),
('c42eb85565c626b48bec231960c751b0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602147, ''),
('c6b3c73f8905c6a1b8b3fa499e34a299', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1366602159, ''),
('e98c34e5d5ea82c59d663ddf0d3367b4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366959834, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:2:{i:1;a:4:{s:7:"item_id";s:1:"6";s:4:"line";i:1;s:11:"description";s:20:"webERP Demo DVD Case";s:8:"quantity";s:1:"1";}i:2;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:2;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:1:"1";}}}'),
('e4f3b3dacc7d9e9156e96902a1a5c464', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366939860, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('b8df33b2918c6f726ab33c9e0a244a2a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366849881, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('074243354d4e7cabca21cc93e69fc0ab', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1366961927, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"2";s:4:"cart";a:0:{}}'),
('fd3899609c89f180b1af686d639cec6a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367034228, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"3";s:4:"cart";a:0:{}}'),
('917b0be80030faf183520eedccbdfd7f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367059204, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:0:{}}'),
('865d97dd1f350f6839a731c576316785', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367194220, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('33d8c46070b9f6f6acee896f77b9a44c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367128231, ''),
('119b33371e964559506abfd65152491c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367194055, ''),
('562fc7377c13bedf88e1cc36a0394019', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367194137, ''),
('4e74fa9afa75baef8957f3c9355bdc03', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367194171, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:17:"flash:old:success";s:32:"You have logged in successfully.";}'),
('2ef8fca210f1674613bd0bfc570b922d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367194197, ''),
('16c27c24013cfde6048d1e3847950918', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367220598, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('7541758b92a7b7065a9530a6863c4690', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367299503, 'a:10:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:1:{i:1;a:4:{s:7:"item_id";s:2:"12";s:4:"line";i:1;s:11:"description";s:20:"Action Series Bundle";s:8:"quantity";s:1:"0";}}s:15:"flash:old:error";s:22:"Error editing quantity";}'),
('bd5d0bf65c96ac179e861209d9186a39', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367219444, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:0:{}}'),
('4908799a12773b0e676dba569b820372', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367219458, ''),
('dfeb045a11b84816ef87f8eaeae8840e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367300256, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:1:{i:1;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:1;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:1:"y";}}}'),
('26886b72c36029a6c99c52b7a3a9dcbf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367299504, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:35:"admin/materialrequest/edit_item/1/0";}'),
('33f7f1ccee096f9c0c90666f90537438', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367308622, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";}'),
('2252f258c8d608e92ffa00ad85a3b2b0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367454236, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:3:{i:1;a:4:{s:7:"item_id";s:2:"12";s:4:"line";i:1;s:11:"description";s:20:"Action Series Bundle";s:8:"quantity";s:2:"12";}i:2;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:2;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"4";}i:3;a:4:{s:7:"item_id";s:1:"7";s:4:"line";i:3;s:11:"description";s:32:"Die Hard With A Vengeance Linked";s:8:"quantity";s:1:"6";}}}'),
('6d6c8236a951109af60fe06646a58c01', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367454933, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"5";s:4:"cart";a:3:{i:1;a:4:{s:7:"item_id";s:2:"12";s:4:"line";i:1;s:11:"description";s:20:"Action Series Bundle";s:8:"quantity";s:2:"12";}i:2;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:2;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"4";}i:3;a:4:{s:7:"item_id";s:1:"7";s:4:"line";i:3;s:11:"description";s:32:"Die Hard With A Vengeance Linked";s:8:"quantity";s:1:"6";}}}'),
('193965ab70d9443cc44671f65451d2a5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367466642, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:17:"julie@example.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";}'),
('3253763abdd885823c872e55f9741851', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367477740, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('d4ee492855e266670a5734ff511b47e3', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367477497, ''),
('82db1655a997d9675380d955441b9532', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541389, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"2";s:4:"cart";a:0:{}}'),
('1aa285aff61ab16ebb1a831fab9ed7c0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367803671, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"8";s:4:"cart";a:0:{}}'),
('56d598d4a3acfbf6151ecefb8440aaf9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367997429, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('ca9ea911b2b2ca8d9163669847243467', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367992758, ''),
('c6be846ebe47f0c66812142cc4fc904c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541410, ''),
('2ab19b8949e4d46869282a1e212b126d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541412, ''),
('fc2b9815d9a1f9d8ef84b6dd9e991dee', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541415, ''),
('47e1a52246f888a9a63c436ad7cd02e9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541484, ''),
('ec46cf3c5ea9982ac432f327cb79cad1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541420, ''),
('3c3242f2771a0207b02855764d9b1f4d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541480, ''),
('a9160d86298bedefa00c547c486b0bf2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541423, ''),
('4e71612aacfaa15157da19f355f9497b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541474, ''),
('596a4b4175fd3fc2f1084a2d69211971', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541427, ''),
('e2df0b9b649bd10b5d4cedd8d2882942', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541460, ''),
('d4aa1fcbbe087381910c5986225b0bb2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541441, ''),
('51f00e01f664ae20e1957e7004ca1119', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541445, ''),
('7c90d2cd0b4738fd29eda2320e53aa66', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541464, ''),
('f3984547490504c12aed4d03ab485ab8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367541486, ''),
('0d27c5d663206f29b7128a7586fb10ba', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1367543404, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:17:"julie@example.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";s:5:"mr_id";s:1:"1";}'),
('9f5b01a8ce33e95bf3a83c5c74fc0ea1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888067, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('9a3d6ba1b6f68c11450336bbdc19e258', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367811878, ''),
('1c733d8a18270080f882a9d3324411de', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367811883, ''),
('1786dad51a2cbff49df9a0b1c444bdb9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367883358, ''),
('9b497d22f00fc607303ff48240f4256d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367816495, ''),
('293a77c3a0bf1ed3413bd6670f5f167a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367818965, ''),
('9a18db23bdfc900f1069fd414d8d187c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367819183, ''),
('b2fcecbedea3bfa87014fee500fee20c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367820513, ''),
('7f82bcae10dea89c7a509892463f534d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367883356, ''),
('d9ffed964dd939f7e62cdb166f7a1913', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367883399, ''),
('cf41467dcc177e5035e64494038d95cc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367883401, ''),
('e48758b82d972e1bb4d589aa68b529c7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367883426, ''),
('08ae18a696aac7cff19bbafc96a9865d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367884163, ''),
('a48c223074cdd481acb563a007370fe7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367884167, ''),
('bd601a7769f1f6f28509f14fe69cf400', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367884169, ''),
('64d5962e4a1c4219877675358e2df20b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367884176, ''),
('c21da00774ddd419f9891c70a5ce58ea', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367885713, ''),
('df76bff3781dab53b8f35f462f7433cf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887504, ''),
('3fe4cb2881e4293d5ed347466a76f34b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887522, ''),
('cbd8dbc349872fdab599a00c39d2a94e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887528, ''),
('f0058c4723cb08dda1c7f3385981f163', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887587, ''),
('c8982c44b470e951734b9da91b5b8343', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887610, ''),
('1137305748e7e260691894c103bf5e02', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887619, ''),
('308c3afe1a90b530ef59a4895699082a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887632, ''),
('4fa3402b39cb1ae1da9e938b89be64a8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887627, ''),
('b77d20ce46dea5e2abfb05c2da9fda0c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887655, ''),
('e3a7aa67efb9038acb499fb69327ae1b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887664, ''),
('1a06978cee1e6ce50ce62d72946e6568', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887670, ''),
('9bf2445810be480faac047aa44e00d15', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887751, ''),
('f5949b6eb5bfef531f16982194c5d40b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887776, ''),
('d8bc1b0ffea7332ecff255687d333a44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367887769, ''),
('0def16bccd469715038c8119e833e8fd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367997373, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:5:"mr_id";s:1:"5";}'),
('03d6e8fed2b4ebc0e69ad4d8c22d9437', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888076, ''),
('132c0cdc9c7ef76b3db455ccc3b424b5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888087, ''),
('e7a1b3fdd0a92b900fc69bf8343e2f80', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888220, ''),
('54c83584c3ba167314d79e16ee6df676', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888228, ''),
('4d934127ef331a730a0e54504a4da839', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888232, ''),
('8b684d585f3efdf665b0004577d741bb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367891346, ''),
('8a00a253afa015c9db73410e0bba702a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367888302, ''),
('70bcf8ba3e20c4bb77a2d1d3682a01d7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367891366, ''),
('063a4f8a6092a4fe0519819a7bc4a3ef', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367891368, ''),
('13c023699d8d5e4964bc0d16ef22e4a2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976704, ''),
('bff8c109ca9cca7e7c92fc7240cac4cd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976721, ''),
('db453341d467a44680dd72f09c9f2a44', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976734, ''),
('ba9fa94b542794c468f0014a7df11389', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367982987, ''),
('3190523791e9dca9c5bc8c603d56b9f6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976740, ''),
('04b31697f638f6240c8814c508f8c2b1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367992912, ''),
('96fc52ee4c1ce6077604b708f0fc3573', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976805, ''),
('851ec5e3c1af4dadd51bc3e10908caa0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976907, ''),
('7671f5f380b743a58b0c5cbb97674f40', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976814, ''),
('401839c0c953a33095e0e4b0ba9dfc3c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977108, ''),
('6717d9215ca23b735bc47ede68ae9b61', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367976934, ''),
('739da80ee34b8b9dacf0ca4dd2649b16', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977155, ''),
('89d0e8c553d842de04d5de365b275ea1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977116, '');
INSERT INTO `default_ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('6c8aee221aece24242096b30bd08e282', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977157, ''),
('d5160477ba1364ccd69fa9fc4a36b967', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977160, ''),
('73fb7b26a9a3ae8978bb3da227996da5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977274, ''),
('58860e93dfb34c7095907bea8954c2e6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977169, ''),
('286f4a6412d29e538eec24533b94f96b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367978099, ''),
('ba1ea9f70c9d5e81e998317746dec972', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367977280, ''),
('9afe13999f731401a1c5306ebecf99d7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367978101, ''),
('59a8f7438470493f15e9be1f9ad15c70', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367978180, ''),
('d34b9712c7b6a24fd3adefa1a05152b6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367978190, ''),
('c16d953100f7af36843b48634cbc3ede', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367982988, ''),
('b250448973d2eb1e19789b21be1f9df6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367982991, ''),
('7375023b3ec2c378b95f0d5782b7b484', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367983873, ''),
('8b3a246877abed957893b1962fc9a434', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367983235, ''),
('8fa6595c335e13fa05b54008f2f1de31', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984053, ''),
('97bed22f405548b9ff9f0032dcd2231c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984063, ''),
('bd43a4d3e18f9916c2701cc62cfd510a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984127, ''),
('83b4c4c6a199c33311cae0633ee78537', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984091, ''),
('7e6071a5f648efeaa6b41633b65a317e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984683, ''),
('415012e4bb604945c79bb729ffa08945', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984136, ''),
('a944f9bb4178dc7cb8b49405d32e49e1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984845, ''),
('b4c86625732401e78a29399442bed07a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984693, ''),
('409ccc216d587b82f54e6856f3021c27', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984909, ''),
('3843fd43630a36b194ba2c6d1c6763ec', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984853, ''),
('26460d76a448d26211e91a5f4cb940db', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986208, ''),
('0c26d52788c4a27075aede8ec7d13969', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367984913, ''),
('8158a11e1adc454cea9f2a6b69a357db', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986271, ''),
('8fad355858bb03634e51c714bcfedbdc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986217, ''),
('2cdb3cfb992f07b821ce242f7c040b9a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986286, ''),
('6a327b5500d9e114afacccd73279c5e7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986335, ''),
('4701a9bd958eefa3fafdd31f58c1796b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367991173, ''),
('5780458163c95be0eb583f6a2a67024a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367986343, ''),
('4ec133b3d471aeaf812745ee39eff975', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367991176, ''),
('69e7c420559b2f5c95002ecdbe1698c0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367993948, ''),
('817bc961f9cc233a398690a82b2c90e2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367993950, ''),
('d9668709352594188af2dc5bafe13968', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367994201, ''),
('2fa49c69c18212536e8e3625a4c41f28', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995016, ''),
('54f551c957cc989e8f7f9cc41f9e7297', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995252, ''),
('b1cdf93e6afec1c45958447ebef4bdf6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995254, ''),
('e7a72a6d5bf377ced4f599c6c2159279', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995260, ''),
('af776e213489f8484a5097aacac19543', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995266, ''),
('930081c1241b1641a81ece4ea1e81c9e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995272, ''),
('9d49cd757521643170704d6b545d64dc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995767, ''),
('0b1343bdb8052abb59740d5e8eae9b3a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367995770, ''),
('58382b09b2f637a9dec41ae6dfccb505', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996031, ''),
('509d7fd1a40b73459448194f63d5079a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996032, ''),
('ae3de3e0b73f4413d6a35e3b87dca12a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996035, ''),
('6fdca9c347b5885192a9e76a4a0947ab', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996046, ''),
('021cdff9b179156ade3d5920903d145f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996394, ''),
('1f5f7fa5dcd14f701883fd2d3894aeed', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996540, ''),
('909ba02e1b9770b0f37885d50dde8eea', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996554, ''),
('6e31f233774cfa1b4900ae1ba3c598df', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996688, ''),
('ba40eafd7d79d4cc6966947d81881899', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996614, ''),
('975d3dcbba600cf1e7c0fb68a7ef8fa8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996742, ''),
('e4873e545afcea962e7d4cf2bc934ab2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996697, ''),
('42b778d06383bade2aee0f954cb5412c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996812, ''),
('b509c073e1ac06205ea344d3a5db0575', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996750, ''),
('5a922b5a7459b987b95fae35223b4955', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996900, ''),
('f88280427645eeb04785e920fc1e2938', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996902, ''),
('fc8cd6b5682f08a2d09f9263390822d1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996905, ''),
('4e455e6f1ee36bd8b2dfebefa039f7e0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1367996912, ''),
('30beb78108e19b7d4dfa694aa47f0dc1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368081378, ''),
('d63ca2da322064726dcf4763d8f5dacc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368058102, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:17:"julie@example.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";s:17:"flash:old:success";s:32:"You have logged in successfully.";}'),
('9f8e6f6cab44ecf020720570e1243a64', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368078113, 'a:7:{s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:5:"mr_id";s:1:"3";}'),
('a582693218e27bb3d1345d7353330c1a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368076519, ''),
('359c51ed8c50fe71e5fd3bd2303f6675', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368076521, ''),
('084d1dd7d18ff8810987365de4e07102', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368076524, ''),
('baaedffd6e2a11f1eec5b80e1a2a9b0e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368078122, ''),
('ea8d45eb85e4d0e740bdfc0dcf923cff', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368078124, ''),
('e8f6ef40b0dfb15dc349ea89d6024b89', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368078128, ''),
('a2fadfd775ad93f0d3f476e1b263e610', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368078278, ''),
('e368e9e6c9134cdb901b1ad739b0a44a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489569, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:5:"mr_id";s:1:"3";}'),
('01fb1cef0a061ffe04a8cc65ec94d47f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489551, ''),
('b7b3cb36e4fbdc780b2c93148518a332', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489553, ''),
('196b35b1d3cf0cef85e14cfd02339517', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489686, ''),
('ce3b1cc9b28d0d82deb8e42fe5dbdfd5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489556, ''),
('86827e831750ef75441925f25a83d7d5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489560, ''),
('629dffbe6ef0a0dd90e20ac708c9b8df', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489689, ''),
('a15abcb2c77e444ee8404977817acf80', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368489692, ''),
('efb9ca5b697c7489d1777750b42c5c5e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675319, 'a:7:{s:14:"admin_redirect";s:16:"admin/approvediv";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('ecdacf97db16c43ed6930d8836b32373', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368662684, ''),
('16f04d7a72c25aaae58475dd0be1da78', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368662702, ''),
('0fce9275770dc5fe8e46a5e561db8e49', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368662732, ''),
('15a3a404352d307d1387987f8ed7f0ee', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368663334, ''),
('ee92dd777022dfabc929dbce48ec3cf7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368663336, ''),
('718b534d4c1d5da779760d34fc7842e6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368663343, ''),
('4bb2eaacf4997a424bd364041c77bf7a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675326, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:17:"flash:old:success";s:32:"You have logged in successfully.";}'),
('5db602f6ebbdaefefd4e24c2a1d6253f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368664487, ''),
('dd13530e1f96c58b4ff79a533d917345', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368667772, ''),
('cfd014ccc745c6c7d03a1d9e13f057f1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368667775, ''),
('8566707c4dbfd318f334f4ad2fa98922', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368673618, ''),
('ed71afa0f5bfd239b7b6ece797efba03', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368667778, ''),
('28cf4450ceda263644ad1350cebb0589', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368667822, ''),
('51f8feec7f2ca734d008bc64cc30f19a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368668107, ''),
('4c63082f9bf77c351d35b3dbede27b8b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368668342, ''),
('420466b828b6a86b8345bd89e28908ed', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368673599, ''),
('99e6a37035406dbba93781ab82e6ad51', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368673621, ''),
('cebacb2456f4eea1b826e33261b9bc70', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674291, ''),
('eecb315d08eed2020fb3e5eafa6f9cc1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674786, ''),
('27805d69b802a42058c7cc950cea529a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674788, ''),
('3629b1d2d66a8fa320bb99fb3d7b2eed', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674800, ''),
('1d48624738352c4f97de8cd29fa8204c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674821, ''),
('7594224b2f4ad3a99cda3b50d130d6b0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674822, ''),
('a81e3a5c5656c3a987f0b04d20960c88', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368674858, ''),
('0392cf947e2b87a7e0a4e9a03a4dda90', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675181, ''),
('b0d5699e4d660dfb4d0ec7084f328855', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675322, ''),
('78a3db1f758493f216da905f00868322', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675448, ''),
('1b78bcd0ce24e202810af07ec85ef69a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675449, ''),
('93840ef1cd7a0c76b8f742886069d986', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675476, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:21:"admin/approvedivgroup";}'),
('ca04b4dbc30e6acceed6969899584aeb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675536, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('e522be50d5ccbc4141b0660c0ec21077', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675545, ''),
('6c8c8478c038f7419b99f8fb899d26c7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368675547, ''),
('6213b6d5c5329d2afcf1b180f6e5013b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368686676, ''),
('75381a79eea1c5d8763d1d3a72b8cf0a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368676540, ''),
('0d2d9e3515d1e1a9e8636986f682dfc4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368676542, ''),
('288b22e19e86424a227081f2d02981eb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368676571, ''),
('7b74c446c8adebad3187aead24e0d62a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368676573, ''),
('fe2a0296b625947116b52c48b6ae07ad', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368676601, ''),
('c631309e78f1aec96856878116959041', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677731, ''),
('1f3b8b410af2a02f896422543dbd832f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677355, ''),
('60623da14e637bee1d4be540a0607f5b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677360, ''),
('28fdc1acbae111b008fd3552ee7298ea', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677432, ''),
('cbd2783215780e0892469ceef464a474', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677591, ''),
('8ec7b3b1b14ca78184e651ca75fc962f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677732, ''),
('cf50b3f538d5fd5b1e7fff65a699f6bd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368677736, ''),
('dd0b5a8c85b77d9890e32738402a56b4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678021, ''),
('2ec2d8c255ec78de7e32d6b0c0d3dd3c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678024, ''),
('c4664f7e9874bf70eb9421b1f27a0c77', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678053, ''),
('74537b2b58a649293a32cfe836b989d8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678059, ''),
('ea8c0e05aef842aa4aeb7c5d1ad36acf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678061, ''),
('e52652f9150bb03658477e3d65d4a832', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678307, ''),
('228c858d8bc4437b5546132b857ecfb4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678309, ''),
('2fe9243d2d99cc844276e08f53fdc088', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678366, ''),
('337c44ae9da66d714bf2fcf7fbadd81e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678444, ''),
('ed90aa3fa71b00c7862dc474ef6d093c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678449, ''),
('313de7eb46ae22cec07035501892a606', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678472, ''),
('ebace058bad413f16280c50962149507', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678497, ''),
('292b7ee4ab23b8a9da89cba8b0b0e3f4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678737, ''),
('e2b3cf0ca17cfb581af83d10bc94e504', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678623, ''),
('0daf25a3ea7a60670eebe91cb392d9b1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678696, ''),
('ff3b75b669926cc2cf6b0df7a8082462', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678738, ''),
('c6d888f6662f8a8734687bac28ae3f43', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368686676, ''),
('03b785d9e7fd90a64d67c063e0c20978', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368678749, ''),
('a88bc8b56460b9016c2a8e36bc68d7e0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679393, ''),
('5ba5410fa3c0dff3b0889dd74691ce9d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679409, ''),
('d563becb67792b3d4133577162962a29', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679414, ''),
('71c42fdaae8be35c2fa5064736e58f4f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679417, ''),
('537720ec82bea90785c1f71ba2cba36a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679425, ''),
('fa271be4b10d612ce9772489685d5851', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679429, ''),
('a20a4accdea085e5ed88b581d0a93aad', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679433, ''),
('008b7f0815b417ee1e33f1e083e871ea', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368679921, ''),
('c3e7940dfc5d7d098ee4f9f629310a8d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368680083, ''),
('11287b2b11165bb3ead4dc5e2a21a8f7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368680493, ''),
('8e33b3a02da89b5569d37e3a4eb4ffa4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368680559, ''),
('c7481de3a28db480b8ecddd7ea0c1361', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368680564, ''),
('61eac9bdc8352e67711b86eab9afe7e0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368681933, ''),
('e6c0ae173c9e17d12fd84de356cf8374', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368682241, ''),
('cd3f5084d6302e66c3f0d7ae76d0e8d7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683353, ''),
('dcfafc288871c650205efdc2cbb7d669', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683358, ''),
('0281377dfce49727b263068c25158441', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683362, ''),
('d531fb64fbb578f1e7e31e377ba63cd5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683366, ''),
('fb00b1be9dad5e56ff64e5ffd9d198f5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683622, ''),
('a83b07397b9574027f73db0f2bc364f5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683627, ''),
('a77f993ba4bcb683ce5b7c36d4165fcc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683631, ''),
('21d890baff31b12f5fb23bf6117a554f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683648, ''),
('fef983570095bce73b03858b30ef55b7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683783, ''),
('ab5ec458e4f7b4930a5295230bdd4389', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368683651, ''),
('adc4b3e9f1de02c933e421b608974483', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368684745, ''),
('1db51ee329f35954118b7f40640128a7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368686674, ''),
('0749bf2a605b7717eb31254a234a5b56', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368751976, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:15:"flash:old:error";s:57:"Oops! how did you get there? You cannot access that page.";}'),
('6767064ecddd5bea42849c2c19083827', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368686722, ''),
('71a8c2eb30ac11fab45694bdb199ebe1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368686768, ''),
('eb0fcc4e730273b31a70d5b151508f09', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368689039, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"special_app";s:5:"email";s:17:"veztsol@gmail.com";s:2:"id";s:2:"16";s:7:"user_id";s:2:"16";s:8:"group_id";s:2:"13";s:5:"group";s:6:"spec-a";}'),
('e029aaff26576b71fc37c6d81c5a04e7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368687655, ''),
('12787f8e3617edc31ea828bbbb5325c9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368687347, ''),
('a1c416340ed772ef0fed31c8c0905bf8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368687623, ''),
('ddfdde255e215e1072906370cc1679ec', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368687639, ''),
('32ade2d821ed0011d75a52dd95865f88', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688149, ''),
('d7c7e289f476c1cd1b7530a44906c7ec', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688067, ''),
('9c3cc205c41fabf3476504a1f612bcfb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688156, ''),
('45ab247f736f7af48b57251e70e9048b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688165, ''),
('e0e262af9fa9d48b85a32cbb7e8c6af7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688196, ''),
('289b6f13bcc394654b97b2532f6ac356', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688268, ''),
('6bc8516f260e3a51ad332f5d99894312', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368689039, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:22:"admin/special_approver";}'),
('0016d77aa0612e99efed56c8765fd69a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688275, ''),
('e725fb2e6737cb90946a12a45b57e899', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688719, ''),
('0185598af4427ba9d3071376686c9ed2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688722, ''),
('1db370ea8af167ca82793b4f7267e568', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368690668, ''),
('2dba03adf155ae3c117aee0884333f77', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368688735, ''),
('e8e79cba09e8fb591cc95b70099d9bc2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368754835, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";}'),
('457f89f4ed45df64de02cbed1b7504bd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1368752028, ''),
('920498cf3b4d5faf97bea556a77531c4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368754835, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:21:"admin/materialrequest";}'),
('f0a8d54b1f2994dd3def94ec41f825b3', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368755781, ''),
('77bb292dde7a8b5fe5cc17e0029fb6bf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008564, ''),
('af58206c3557aca0807cf6af282cfda4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008568, ''),
('12522ccda74d7e6da6f571ae6570adc9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368851040, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:17:"julie@example.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";}'),
('55a9f04b0d87a0fc58b2596d9eaa3dfe', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368858109, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:5:"mr_id";s:1:"4";}'),
('172394e5cdba49fbf4a007d2de9ba76b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1368859721, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:11:"special_app";s:5:"email";s:17:"veztsol@gmail.com";s:2:"id";s:2:"16";s:7:"user_id";s:2:"16";s:8:"group_id";s:2:"13";s:5:"group";s:6:"spec-a";s:5:"mr_id";s:1:"4";}'),
('e291cb4f6dcc91597f0e0d900f835f97', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014929, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:2:{i:1;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:1;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"1";}i:2;a:4:{s:7:"item_id";s:1:"4";s:4:"line";i:2;s:11:"description";s:5:"Bread";s:8:"quantity";s:1:"1";}}}'),
('25e81ce0e5dbae2b6c0a66180906ae49', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008562, ''),
('d1333ae2d73c8d72b0e631498434a962', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008605, ''),
('2e4849c2386961106dac8d6b3ed59605', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008607, ''),
('f422502bb6ef2cda20b4419589988c55', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008691, ''),
('ad066e7d1208a648a324cc00e2bb419d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008730, ''),
('b90c33e6638c87bd84308cc1dfa1b947', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008696, ''),
('501d168aa04565e0cc23c57bfe9f0512', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369010183, ''),
('997d8bb9c2580dbce1cd9b79c652204f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008733, ''),
('bf338c6976d43f442c1832789a94b52f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008737, ''),
('8ce9d015555e803ea0a2729d2bbaa82f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369010107, ''),
('2b0a8413a5c33bc3498130c338fb36a7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369008743, ''),
('dc42efc8b505918d99e2e26122cd8efd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014235, ''),
('0ee02e79532a510271be8b54fb5fd0c8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369010187, ''),
('f2a2b54ea1339f29b98994d6d0956af2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014197, ''),
('86079a2c3dba2c25fa198f979bff19ff', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369010363, ''),
('de7d53c906d6786439f9599455b54cad', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014201, ''),
('896cb9684695f17135f13a3c9d7ea690', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014239, ''),
('97a3daab1278dce99dc2722043aa9adc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014600, ''),
('ebccbd388c14f9958371bc5f9e752fcf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014292, ''),
('840e94d514d5ba3d1b1aee99bfefad00', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014603, ''),
('06db31ada86640d90e7f5d02de90e5ea', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014932, ''),
('00418658f88fd803499b006efe1130d0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014620, ''),
('be2afc4bcf6d2f3f3f8fb6e7a4df0ae4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014937, ''),
('94c1bd2dc4f4bfa400e2c3732881de9e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014940, ''),
('cb5ec6bf60b6a183d16e7821f1977f26', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369014965, ''),
('f62f32ac08dd53d881d7ff45a1252300', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369093850, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('87fc6e8276a6c0084d68100c1fd81513', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369018251, ''),
('b206dd92a66b8b6449950703dece342e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369130536, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('4a88bf5972970f8a3334616d1956705b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369195094, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:40:"admin/materialrequest/submit_requisition";}'),
('6be25b6303c0b8367338e8cd21af03f5', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369092402, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('6e03e33a00ec12676916717080d5d3e1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369131810, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:18:"venice@example.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";s:5:"mr_id";s:1:"1";}'),
('801ca20dfa72b0772e0bdd7eda05ffdc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369132347, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:11:"special_app";s:5:"email";s:17:"veztsol@gmail.com";s:2:"id";s:2:"16";s:7:"user_id";s:2:"16";s:8:"group_id";s:2:"13";s:5:"group";s:6:"spec-a";s:5:"mr_id";s:1:"5";}'),
('6eb7277eb3c09f1c568a1c7a9ffc6841', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369195087, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:2:{i:1;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:1;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"1";}i:2;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:2;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:1:"3";}}}'),
('bd9f792925cbd6db8b60553e420fd98b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369203790, 'a:10:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:21:"admin/materialrequest";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:2:{i:1;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:1;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";i:2;}i:2;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:2;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"3";}}}'),
('36eb811971e0758744099562f8028f7d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369203791, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:35:"admin/materialrequest/edit_item/2/3";}'),
('a05e4029dde4b368755ec1a3efe66dc9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369214278, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:4:"cart";a:2:{i:1;a:4:{s:7:"item_id";s:1:"6";s:4:"line";i:1;s:11:"description";s:20:"webERP Demo DVD Case";s:8:"quantity";s:1:"1";}i:2;a:4:{s:7:"item_id";s:1:"5";s:4:"line";i:2;s:11:"description";s:26:"Gastric exquisite diarrhea";s:8:"quantity";s:1:"1";}}}'),
('48de8e22f81ee69f951a237d3d860851', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369305673, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:5:"mr_id";s:1:"1";s:17:"flash:old:success";s:25:"Your settings were saved!";}'),
('576fc72550f4acea105f110066aca426', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369366131, ''),
('d1c739882a0bc20a32bea5f343f5808a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369371454, ''),
('f8029c1ecf6ddf1d812be57cdfae80dc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633759, ''),
('168e75d39384d9e4172296a4828e8732', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635628, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:5:"mr_id";s:1:"1";}'),
('248ab2a64b2a7db19a243ca1c07cf5e2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369296201, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"helen@example.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:4:"cart";a:3:{i:1;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:1;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:1:"1";}i:2;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:2;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:3:"233";}i:3;a:4:{s:7:"item_id";s:1:"5";s:4:"line";i:3;s:11:"description";s:26:"Gastric exquisite diarrhea";s:8:"quantity";s:1:"1";}}}'),
('3f2227531f0cf68207639ba20d316887', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369456439, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"veztsol@yahoo.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:4:"cart";a:3:{i:1;a:4:{s:7:"item_id";s:1:"2";s:4:"line";i:1;s:11:"description";s:34:"Big Ears and Noddy episodes on DVD";s:8:"quantity";s:4:"1123";}i:2;a:4:{s:7:"item_id";s:1:"4";s:4:"line";i:2;s:11:"description";s:5:"Bread";s:8:"quantity";s:1:"2";}i:3;a:4:{s:7:"item_id";s:2:"10";s:4:"line";i:3;s:11:"description";s:18:"Under Siege Linked";s:8:"quantity";s:1:"1";}}}'),
('5017f4690a01d1bc3c8469535c8d58e1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369386779, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('5e706bd8bfd0e9047f8f7a45af3d4951', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369366112, ''),
('d3c49ffb786871f0b0f973e13ad20ffa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369457108, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:10:"helen-cruz";s:5:"email";s:17:"veztsol@yahoo.com";s:2:"id";s:2:"10";s:7:"user_id";s:2:"10";s:8:"group_id";s:1:"6";s:5:"group";s:9:"requestor";s:5:"mr_id";s:1:"1";s:4:"cart";a:3:{i:3;a:4:{s:7:"item_id";s:1:"3";s:4:"line";i:3;s:11:"description";s:46:"12 foot birthday cake for wrestling tournament";s:8:"quantity";s:2:"64";}i:4;a:4:{s:7:"item_id";s:1:"6";s:4:"line";i:4;s:11:"description";s:20:"webERP Demo DVD Case";s:8:"quantity";s:1:"1";}i:5;a:4:{s:7:"item_id";s:2:"10";s:4:"line";i:5;s:11:"description";s:18:"Under Siege Linked";s:8:"quantity";s:1:"1";}}}'),
('bcbd68301f578a409613bba37ce69cc7', '172.30.60.12', 'Mozilla/5.0 (Windows NT 6.1; rv:20.0) Gecko/20100101 Firefox/20.0', 1369446302, ''),
('78ec6ea18ab6398f1ffd63e0748c2d29', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369456439, 'a:2:{s:9:"user_data";s:0:"";s:14:"admin_redirect";s:35:"admin/materialrequest/edit_item/3/1";}'),
('1a41e3c7e285316948f6fc67fab88b4f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633296, ''),
('07e6f01b3b73c87f5da8337b86202e22', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633754, '');
INSERT INTO `default_ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('89ec9c33f032e0ed14d8783a3e3e48b3', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633645, ''),
('679682e46415216d8217a008800edbff', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626406, ''),
('1151db9ce9ca1233259f85d36130712e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633250, ''),
('8f20f60fee48b014fe33559706b91285', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633255, ''),
('5ba97fc7726f1cdd449b7c0aa2331ae4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633156, ''),
('a32ebfbbea98c75eb27ecc6acd173240', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369632942, ''),
('6aa0f7e6010bb3939c34c36f16fa1278', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369632918, ''),
('6e86dd0745dba5da7e6d5fba535ee44e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369637099, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:27:"webdev_onbusiness@gmail.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";s:5:"mr_id";s:1:"1";s:17:"flash:old:success";s:51:"Sample Request 1 '' status was successfully updated.";}'),
('dfbf2b95eba150fc8e8c982aa99dcf2f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633266, ''),
('45fc74842c7c50fc358549480d5c5b5a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626339, ''),
('58a5e60b8004d02ae09f0447b2f18be2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369628547, ''),
('93819725faf51f1d8a877bd42b18bf78', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633177, ''),
('f6401779efb790e6469a2af0a4d87f7b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369633171, ''),
('ee39073cd8555e47a3829e69b005f64e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369608672, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:9:"james_lee";s:5:"email";s:17:"veztsol@gmail.com";s:2:"id";s:2:"13";s:7:"user_id";s:2:"13";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";s:5:"mr_id";s:1:"1";s:17:"flash:old:success";s:70:"Sample Request 1hhhhhhhhhhhhhhhhhhh '' status was successfully updated.";}'),
('1ed38b6ae0e3716e019218a8273fbddd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626345, ''),
('675de94c6f50b6f2073b99e56aabe261', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626306, ''),
('de91d794cea0ffb1bf3c5b565804daad', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626312, ''),
('8429dbdd1090c93ec0c573531855f924', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369626296, ''),
('f884bd77a5e37bc92bb0c63ddb940e92', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635025, ''),
('0a1c5c4b751d3a80a487fa599397bc0e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635028, ''),
('ccaf7dcebce668c9216ed68471684937', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635274, ''),
('0f161ffe18e7f0421d7e43feb3f49342', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635040, ''),
('ca6ac08de5d454d812245e9655b1ea20', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696624, 'a:9:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:5:"mr_id";s:1:"1";s:17:"flash:old:success";s:47:"The permissions for this group have been saved.";}'),
('6ea265485e3261e75e709e3c2e5913f0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635642, ''),
('0137f2d06320b59071d8b030093bc4c4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635651, ''),
('4b6a3df456a3af887ad04a7e9c6792f0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637395, ''),
('8cb7e11a97ae8947f2570903c0a81570', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369635666, ''),
('7e2404904812d5a79373cad50c05ead0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369715847, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:27:"webdev.onbusiness@gmail.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";}'),
('004ae3bae5e52ed95ddd5b0bc8c06b90', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696120, ''),
('de7d2ed7beb3b33092843e8630fbd7f9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637459, ''),
('b470fcefb5e706d1ad7ef41c3000e69e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637467, ''),
('ea4866b3457e0d5f4a92c16c30755380', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637503, ''),
('e91b33416a830bddb63783beb62e07df', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637482, ''),
('9f0d94cf16ad6091882c70da5bf3bcd9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637567, ''),
('59e1bd6e1397300fc1de51348fb774fe', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369638934, ''),
('6d612aa1364261933768bd30d6af45c7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637934, ''),
('037daaaddcc301ce62f9ec832c251d47', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369637969, ''),
('6305f3c24f8c1554833105f08fcc2e76', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369638937, ''),
('7393c8bd9c4d33f44f42ef9565a33adb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369639538, ''),
('b53a7eccc8ce0bc3109de54fe041ddf7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369640024, ''),
('6055d0e0ca24c328cc907c79bc38dbcb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369639785, ''),
('7fc34a2a4d05fb7d5309392c70209292', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369640021, ''),
('98ef841b0632e66b3510d255020482f9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369640288, ''),
('d099e65898f251c0d087e6f955dd9a68', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369640028, ''),
('913fb2b8eeb74802344fb38d50b0bf79', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369640554, ''),
('cbd00e5058d5c6ba694004a352524cc4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369695969, ''),
('849de66003766d40699a1658fc786871', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369695975, ''),
('c20fc863d4b5cf7c7c5ca89ed1801392', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696124, ''),
('a636b0bed4297b01864c102b1e595cdc', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696651, ''),
('0669cc0df7aa21da617bd1156b3d7504', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696265, ''),
('cd4c45a263ddd3bf35b411bbbf9bd603', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696628, ''),
('efb535255c8bab8f5281f3fd862074b2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696654, ''),
('4137685b9ed9441712ccb2af4350300a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696804, ''),
('c33c3d032a298122717c8408a88f2784', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696660, ''),
('e0a305ec15bd06f9308b37288e12cd80', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696676, ''),
('08b6d45e4fee03435e8be7530b2a3768', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369702793, ''),
('64c283688b98d28303feeee316bc302d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696806, ''),
('82e31805062286969ae1ac7e8af6ce37', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369696814, ''),
('1d2500d19ade1e89a614655699ecc14c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369702068, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:11:"special_app";s:5:"email";s:37:"venice.soliven@stfrancissquare.com.ph";s:2:"id";s:2:"16";s:7:"user_id";s:2:"16";s:8:"group_id";s:2:"13";s:5:"group";s:6:"spec-a";s:5:"mr_id";s:1:"4";}'),
('1d4845654f109c745da798ffddc0e904', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369699790, ''),
('ecb915e05b74a76a5cfc3989a66db281', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369705239, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:11:"special_app";s:5:"email";s:37:"venice.soliven@stfrancissquare.com.ph";s:2:"id";s:2:"16";s:7:"user_id";s:2:"16";s:8:"group_id";s:2:"13";s:5:"group";s:6:"spec-a";s:5:"mr_id";s:1:"5";}'),
('f54ca787a76888f9b446276e4cefe224', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369701084, ''),
('5963079a54fbe6a237a33db31df284d6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.64 Safari/537.31', 1369701086, ''),
('9adc0d885c9981c7c2ca37a5c78abe80', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369720615, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"julie_lim";s:5:"email";s:27:"webdev.onbusiness@gmail.com";s:2:"id";s:2:"12";s:7:"user_id";s:2:"12";s:8:"group_id";s:1:"8";s:5:"group";s:10:"division-a";}'),
('848b5fb821fa0453eb94542112a0dec2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369721703, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:14:"venice_soliven";s:5:"email";s:17:"veztsol@gmail.com";s:2:"id";s:1:"6";s:7:"user_id";s:1:"6";s:8:"group_id";s:2:"10";s:5:"group";s:10:"division-g";}'),
('51756833845fc77cdfe66e5eabaf9936', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1369949891, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('3a9f749f530255300b8577ccf5863379', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1369970591, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}'),
('e1077d098e28e3540d7857a3e6459c12', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1369950541, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('4454e3059eeefb1f0ca6ec7f2d891c7b', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1370050495, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}'),
('62a819fa206015bf5c03347c614fbc38', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1370026836, ''),
('2df161cf476b6140974b741a968a4cdc', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1370117882, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}'),
('bfa48c8a44739566046b7a6893e6b936', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370127726, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}'),
('b364b66626f336d5bc733434bc3182a3', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370137559, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}'),
('b67128c8cb22190d16b306f26310817f', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1370136166, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";}'),
('443e5c6d985546b485d2af4f233941d2', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36', 1370151373, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:9:"SYS_ADMIN";s:5:"email";s:19:"sfswebdev@gmail.com";s:2:"id";s:1:"1";s:7:"user_id";s:1:"1";s:8:"group_id";s:1:"1";s:5:"group";s:5:"admin";s:17:"flash:old:success";s:47:"The permissions for this group have been saved.";}'),
('6349c6b0c28693c8fa1c2c0d3f5eadd0', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370153065, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:13:"purchaser_one";s:5:"email";s:19:"purchaser1@sdsd.com";s:2:"id";s:2:"33";s:7:"user_id";s:2:"33";s:8:"group_id";s:1:"5";s:5:"group";s:17:"purchasing-office";}'),
('82619b745ba4e9e8b06dd085d9077b61', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370191909, 'a:8:{s:9:"user_data";s:0:"";s:8:"username";s:13:"purchaser_one";s:5:"email";s:19:"purchaser1@sdsd.com";s:2:"id";s:2:"33";s:7:"user_id";s:2:"33";s:8:"group_id";s:1:"5";s:5:"group";s:17:"purchasing-office";s:17:"flash:old:success";s:32:"You have logged in successfully.";}'),
('75006cb4979a4972bdeefef183c028c8', '0.0.0.0', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 1370199496, 'a:7:{s:9:"user_data";s:0:"";s:8:"username";s:11:"diane_bulfa";s:5:"email";s:14:"veez@gmail.com";s:2:"id";s:2:"32";s:7:"user_id";s:2:"32";s:8:"group_id";s:2:"14";s:5:"group";s:18:"purchasing-manager";}');

-- --------------------------------------------------------

--
-- Table structure for table `default_comments`
--

CREATE TABLE IF NOT EXISTS `default_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` int(1) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `parsed` text COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `created_on` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_company`
--

CREATE TABLE IF NOT EXISTS `default_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) NOT NULL,
  `company_approver` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_contact_log`
--

CREATE TABLE IF NOT EXISTS `default_contact_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `sender_agent` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sender_ip` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sender_os` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sent_at` int(11) NOT NULL DEFAULT '0',
  `attachments` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_data_fields`
--

CREATE TABLE IF NOT EXISTS `default_data_fields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `field_slug` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `field_namespace` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `field_data` blob,
  `view_options` blob,
  `is_locked` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `default_data_fields`
--

INSERT INTO `default_data_fields` (`id`, `field_name`, `field_slug`, `field_namespace`, `field_type`, `field_data`, `view_options`, `is_locked`) VALUES
(1, 'lang:user_first_name', 'first_name', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a35303b7d, NULL, 'no'),
(2, 'lang:user_last_name', 'last_name', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a35303b7d, NULL, 'no'),
(3, 'lang:profile_company', 'company', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a3130303b7d, NULL, 'no'),
(4, 'lang:profile_bio', 'bio', 'users', 'textarea', 0x613a303a7b7d, NULL, 'no'),
(5, 'lang:user_lang', 'lang', 'users', 'pyro_lang', 0x613a313a7b733a31323a2266696c7465725f7468656d65223b733a333a22796573223b7d, NULL, 'no'),
(6, 'lang:profile_dob', 'dob', 'users', 'datetime', 0x613a343a7b733a383a227573655f74696d65223b733a323a226e6f223b733a31303a2273746172745f64617465223b733a353a222d31303059223b733a373a2273746f72616765223b733a343a22756e6978223b733a31303a22696e7075745f74797065223b733a383a2264726f70646f776e223b7d, NULL, 'no'),
(7, 'lang:profile_gender', 'gender', 'users', 'choice', 0x613a323a7b733a31313a2263686f6963655f64617461223b733a33343a22203a204e6f742054656c6c696e670a6d203a204d616c650a66203a2046656d616c65223b733a31313a2263686f6963655f74797065223b733a383a2264726f70646f776e223b7d, NULL, 'no'),
(8, 'lang:profile_phone', 'phone', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a32303b7d, NULL, 'no'),
(9, 'lang:profile_mobile', 'mobile', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a32303b7d, NULL, 'no'),
(10, 'lang:profile_address_line1', 'address_line1', 'users', 'text', 0x613a303a7b7d, NULL, 'no'),
(11, 'lang:profile_address_line2', 'address_line2', 'users', 'text', 0x613a303a7b7d, NULL, 'no'),
(12, 'lang:profile_address_line3', 'address_line3', 'users', 'text', 0x613a303a7b7d, NULL, 'no'),
(13, 'lang:profile_address_postcode', 'postcode', 'users', 'text', 0x613a313a7b733a31303a226d61785f6c656e677468223b693a32303b7d, NULL, 'no'),
(14, 'lang:profile_website', 'website', 'users', 'url', NULL, NULL, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `default_data_field_assignments`
--

CREATE TABLE IF NOT EXISTS `default_data_field_assignments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) NOT NULL,
  `stream_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `is_required` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `is_unique` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'no',
  `instructions` text COLLATE utf8_unicode_ci,
  `field_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `default_data_field_assignments`
--

INSERT INTO `default_data_field_assignments` (`id`, `sort_order`, `stream_id`, `field_id`, `is_required`, `is_unique`, `instructions`, `field_name`) VALUES
(1, 1, 1, 1, 'yes', 'no', NULL, NULL),
(2, 2, 1, 2, 'yes', 'no', NULL, NULL),
(3, 3, 1, 3, 'no', 'no', NULL, NULL),
(4, 4, 1, 4, 'no', 'no', NULL, NULL),
(5, 5, 1, 5, 'no', 'no', NULL, NULL),
(6, 6, 1, 6, 'no', 'no', NULL, NULL),
(7, 7, 1, 7, 'no', 'no', NULL, NULL),
(8, 8, 1, 8, 'no', 'no', NULL, NULL),
(9, 9, 1, 9, 'no', 'no', NULL, NULL),
(10, 10, 1, 10, 'no', 'no', NULL, NULL),
(11, 11, 1, 11, 'no', 'no', NULL, NULL),
(12, 12, 1, 12, 'no', 'no', NULL, NULL),
(13, 13, 1, 13, 'no', 'no', NULL, NULL),
(14, 14, 1, 14, 'no', 'no', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `default_data_streams`
--

CREATE TABLE IF NOT EXISTS `default_data_streams` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `stream_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `stream_slug` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `stream_namespace` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stream_prefix` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `about` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `view_options` blob NOT NULL,
  `title_column` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sorting` enum('title','custom') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'title',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `default_data_streams`
--

INSERT INTO `default_data_streams` (`id`, `stream_name`, `stream_slug`, `stream_namespace`, `stream_prefix`, `about`, `view_options`, `title_column`, `sorting`) VALUES
(1, 'lang:user_profile_fields_label', 'profiles', 'users', NULL, 'Profiles for users module', 0x613a313a7b693a303b733a31323a22646973706c61795f6e616d65223b7d, 'display_name', 'title');

-- --------------------------------------------------------

--
-- Table structure for table `default_divisions`
--

CREATE TABLE IF NOT EXISTS `default_divisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `division_name` varchar(100) NOT NULL,
  `division_group` int(11) NOT NULL,
  `approver` int(11) NOT NULL,
  `approver_proxy` int(11) NOT NULL DEFAULT '0',
  `requestor` int(11) NOT NULL,
  `requestor_proxy` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `default_divisions`
--

INSERT INTO `default_divisions` (`id`, `division_name`, `division_group`, `approver`, `approver_proxy`, `requestor`, `requestor_proxy`) VALUES
(1, 'Makati Hope IT Dept', 1, 12, 13, 10, 0),
(2, 'sample', 3, 6, 13, 9, 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_division_groups`
--

CREATE TABLE IF NOT EXISTS `default_division_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `division_group_name` varchar(100) NOT NULL,
  `approver` int(11) NOT NULL,
  `approver_proxy` int(11) NOT NULL,
  `home_warehouse` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `default_division_groups`
--

INSERT INTO `default_division_groups` (`id`, `division_group_name`, `approver`, `approver_proxy`, `home_warehouse`) VALUES
(1, 'Makati Hope Christian School', 6, 4, 8),
(3, 'Caliraya A', 4, 1, 8),
(4, 'Caliraya', 6, 1, 8),
(7, 'Mak', 4, 5, 8),
(8, 'hkhkjhkhkmn', 6, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `default_email_templates`
--

CREATE TABLE IF NOT EXISTS `default_email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(1) NOT NULL DEFAULT '0',
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_lang` (`slug`,`lang`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `default_email_templates`
--

INSERT INTO `default_email_templates` (`id`, `slug`, `name`, `description`, `subject`, `body`, `lang`, `is_default`, `module`) VALUES
(1, 'comments', 'Comment Notification', 'Email that is sent to admin when someone creates a comment', 'You have just received a comment from {{ name }}', '<h3>You have received a comment from {{ name }}</h3>\n				<p>\n				<strong>IP Address: {{ sender_ip }}</strong><br/>\n				<strong>Operating System: {{ sender_os }}<br/>\n				<strong>User Agent: {{ sender_agent }}</strong>\n				</p>\n				<p>{{ comment }}</p>\n				<p>View Comment: {{ redirect_url }}</p>', 'en', 1, 'comments'),
(2, 'contact', 'Contact Notification', 'Template for the contact form', '{{ settings:site_name }} :: {{ subject }}', 'This message was sent via the contact form on with the following details:\n				<hr />\n				IP Address: {{ sender_ip }}\n				OS {{ sender_os }}\n				Agent {{ sender_agent }}\n				<hr />\n				{{ message }}\n\n				{{ name }},\n\n				{{ email }}', 'en', 1, 'pages'),
(3, 'registered', 'New User Registered', 'Email sent to the site contact e-mail when a new user registers', '{{ settings:site_name }} :: You have just received a registration from {{ name }}', '<h3>You have received a registration from {{ name }}</h3>\n				<p><strong>IP Address: {{ sender_ip }}</strong><br/>\n				<strong>Operating System: {{ sender_os }}</strong><br/>\n				<strong>User Agent: {{ sender_agent }}</strong>\n				</p>', 'en', 1, 'users'),
(4, 'activation', 'Activation Email', 'The email which contains the activation code that is sent to a new user', '{{ settings:site_name }} - Account Activation', '<p>Hello {{ user:first_name }},</p>\n				<p>Thank you for registering at {{ settings:site_name }}. Before we can activate your account, please complete the registration process by clicking on the following link:</p>\n				<p><a href="{{ url:site }}users/activate/{{ user:id }}/{{ activation_code }}">{{ url:site }}users/activate/{{ user:id }}/{{ activation_code }}</a></p>\n				<p>&nbsp;</p>\n				<p>In case your email program does not recognize the above link as, please direct your browser to the following URL and enter the activation code:</p>\n				<p><a href="{{ url:site }}users/activate">{{ url:site }}users/activate</a></p>\n				<p><strong>Activation Code:</strong> {{ activation_code }}</p>', 'en', 1, 'users'),
(5, 'forgotten_password', 'Forgotten Password Email', 'The email that is sent containing a password reset code', '{{ settings:site_name }} - Forgotten Password', '<p>Hello {{ user:first_name }},</p>\n				<p>It seems you have requested a password reset. Please click this link to complete the reset: <a href="{{ url:site }}users/reset_pass/{{ user:forgotten_password_code }}">{{ url:site }}users/reset_pass/{{ user:forgotten_password_code }}</a></p>\n				<p>If you did not request a password reset please disregard this message. No further action is necessary.</p>', 'en', 1, 'users'),
(6, 'new_password', 'New Password Email', 'After a password is reset this email is sent containing the new password', '{{ settings:site_name }} - New Password', '<p>Hello {{ user:first_name }},</p>\n				<p>Your new password is: {{ new_password }}</p>\n				<p>After logging in you may change your password by visiting <a href="{{ url:site }}edit-profile">{{ url:site }}edit-profile</a></p>', 'en', 1, 'users'),
(7, 'submitted_for_approval', 'Submitted For Approval', 'Mail to send to requisitioner', 'REF #{{ref_id}}  : Requisition Submitted For Approval', '<p>\r\n	<strong>{{message}}</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<table style="font-family: arial; font-size: 9pt;">\r\n	<tbody>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Ref.No.:</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				&nbsp;{{ref_id}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requisition Title</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{title}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Purpose</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{purpose}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Charge To</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{company}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>No. of Requested Items</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{total_request}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requested By</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{requested_by}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Status</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; color: red;">\r\n				{{status}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Date Needed</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; ">\r\n				{{date_needed}}</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	View this requisition <strong><a href="{{ url:base }}/{{view_link}}">here</a></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<strong>SFS Logistics</strong><br />\r\n	<em><span style="font-size:10px;">St Francis Square Group of Companies</span></em><br />\r\n	<em><span style="font-size:10px;">IT Department Business Solutions</span></em></p>', 'en', 0, ''),
(8, 'pending_for_approval', 'Pending For Approval', 'Mail to send to approvers', 'REF #{{ref_id}}  : Pending For Your Approval', '<p>\r\n	<strong>{{message}}</strong></p>\r\n<table style="font-family: arial; font-size: 9pt;">\r\n	<tbody>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Ref.No.:</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				&nbsp;{{ref_id}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requisition Title</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{title}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Purpose</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{purpose}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Charge To</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{company}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>No. of Requested Items</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{total_request}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requested By</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{requested_by}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Status</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; color: red;">\r\n				{{status}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Date Needed</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; ">\r\n				{{date_needed}}</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	View this requisition <strong><a href="{{ url:base }}/{{view_link}}">here</a></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<strong>SFS Logistics</strong><br />\r\n	<em><span style="font-size:10px;">St Francis Square Group of Companies</span></em><br />\r\n	<em><span style="font-size:10px;">IT Department Business Solutions</span></em></p>', 'en', 0, ''),
(9, 'on_hold', 'On Hold', 'mail to send  if requisition is on hold', 'REF #{{ref_id}}  :Requisition is ON HOLD', '<p>\r\n	<strong>{{message}}</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<table style="font-family: arial; font-size: 9pt;">\r\n	<tbody>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Ref.No.:</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				&nbsp;{{ref_id}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requisition Title</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{title}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Purpose</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{purpose}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Charge To</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{company}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>No. of Requested Items</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{total_request}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requested By</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{requested_by}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Status</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; color: red;">\r\n				{{status}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Date Needed</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; ">\r\n				{{date_needed}}</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	View this requisition <strong><a href="{{ url:base }}/{{view_link}}">here</a></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<strong>SFS Logistics</strong><br />\r\n	<em><span style="font-size:10px;">St Francis Square Group of Companies</span></em><br />\r\n	<em><span style="font-size:10px;">IT Department Business Solutions</span></em></p>', 'en', 0, ''),
(10, 'require_changes', 'Requires Changes', 'mail to send if requisition requires changes', 'REF #{{ref_id}} : Requisition REQUIRE CHANGES', '<b>{{message}}.</b><br />\r\n<p>\r\n	&nbsp;</p>\r\n<table style="font-family: arial; font-size: 9pt;">\r\n	<tbody>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Ref.No.:</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				&nbsp;{{ref_id}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requisition Title</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{title}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Purpose</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{purpose}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Charge To</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{company}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>No. of Requested Items</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{total_request}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requested By</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{requested_by}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Status</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; color: red;">\r\n				{{status}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Date Needed</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; ">\r\n				{{date_needed}}</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	View this requisition <strong><a href="{{ url:base }}/{{view_link}}">here</a></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<strong>SFS Logistics</strong><br />\r\n	<em><span style="font-size:10px;">St Francis Square Group of Companies</span></em><br />\r\n	<em><span style="font-size:10px;">IT Department Business Solutions</span></em></p>', 'en', 0, ''),
(11, 'approved', 'Approved', 'Mail to send if reqsuisition is approved', 'REF #{{ref_id}}  : Requisition {{status}}', '<p>\r\n	<strong>{{message}}</strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<table style="font-family: arial; font-size: 9pt;">\r\n	<tbody>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Ref.No.:</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				&nbsp;{{ref_id}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requisition Title</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{title}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Purpose</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{purpose}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Charge To</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{company}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>No. of Requested Items</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{total_request}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Requested By</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px;">\r\n				{{requested_by}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Status</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; color: red;">\r\n				{{status}}</td>\r\n		</tr>\r\n		<tr>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; width: 200px;">\r\n				<strong>Date Needed</strong></td>\r\n			<td style="font-family: arial, sans-serif; margin: 0px; ">\r\n				{{date_needed}}</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	View this requisition <strong><a href="{{ url:base }}/{{view_link}}">here</a></strong></p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	<strong>SFS Logistics</strong><br />\r\n	<em><span style="font-size:10px;">St Francis Square Group of Companies</span></em><br />\r\n	<em><span style="font-size:10px;">IT Department Business Solutions</span></em></p>', 'en', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `default_files`
--

CREATE TABLE IF NOT EXISTS `default_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '1',
  `type` enum('a','v','d','i','o') COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `mimetype` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(5) DEFAULT NULL,
  `height` int(5) DEFAULT NULL,
  `filesize` int(11) NOT NULL DEFAULT '0',
  `download_count` int(11) NOT NULL DEFAULT '0',
  `date_added` int(11) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_file_folders`
--

CREATE TABLE IF NOT EXISTS `default_file_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `remote_container` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `date_added` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_groups`
--

CREATE TABLE IF NOT EXISTS `default_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `default_groups`
--

INSERT INTO `default_groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'System Administrator'),
(2, 'user', 'User'),
(3, 'auditing-offi', 'Auditing Officer'),
(4, 'inventory-manager', 'Inventory Manager'),
(5, 'purchasing-office', 'Purchasing Officer'),
(6, 'requestor', 'Requestor'),
(8, 'division-a', 'Division Approver'),
(9, 'final-approver', 'Final Approver'),
(10, 'division-g', 'Division Group Approver'),
(11, 'administrat', 'Administrator'),
(12, 'actor', 'Actor'),
(13, 'spec-a', 'Special Approver'),
(14, 'purchasing-manager', 'Purchasing Manager');

-- --------------------------------------------------------

--
-- Table structure for table `default_keywords`
--

CREATE TABLE IF NOT EXISTS `default_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_keywords_applied`
--

CREATE TABLE IF NOT EXISTS `default_keywords_applied` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_material_requests`
--

CREATE TABLE IF NOT EXISTS `default_material_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL,
  `narrative` varchar(100) NOT NULL,
  `division` int(11) NOT NULL,
  `division_group` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `submitted` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_needed` date NOT NULL DEFAULT '0000-00-00',
  `requestor` int(11) NOT NULL DEFAULT '0',
  `division_approver` int(11) DEFAULT '0',
  `division_group_approver` int(11) DEFAULT '0',
  `force_approved` int(11) DEFAULT '0',
  `date_approved` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  `accounting_cat` int(11) NOT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `default_material_requests`
--

INSERT INTO `default_material_requests` (`id`, `title`, `narrative`, `division`, `division_group`, `created`, `submitted`, `date_needed`, `requestor`, `division_approver`, `division_group_approver`, `force_approved`, `date_approved`, `status`, `accounting_cat`, `remarks`) VALUES
(1, 'Sample Request 1', 'sampl3eeee', 1, 1, '2013-03-20 11:28:43', '2013-05-19 18:00:00', '2013-03-01', 10, 12, 6, NULL, '2013-05-27 03:47:15', 5, 5, 'chhhhhhhhhhhhhhhhhhaaaa'),
(2, 'Sample Request2', 'sample ulit', 1, 1, '2013-03-14 11:29:42', '2013-05-20 11:29:42', '2013-03-22', 10, NULL, 6, NULL, '2013-05-18 02:29:55', 2, 10, 're quire changessssss'),
(3, 'Sample Request3', 'sasasas', 1, 1, '2013-03-14 11:56:42', '2013-03-14 11:56:42', '2013-03-28', 10, NULL, 16, NULL, '2013-05-16 03:42:37', 4, 10, NULL),
(4, 'Sample Request4', 'sample lang', 1, 1, '2013-03-15 05:36:29', '2013-03-15 05:36:29', '2013-03-16', 10, NULL, 16, 16, '2013-05-27 20:08:13', 6, 10, 'appprove require changes'),
(5, 'Sample Request5', 'narrative ako sfdfddfsdfds', 1, 1, '2013-03-15 07:25:58', '2013-03-15 07:25:58', '2013-05-24', 10, 12, 16, 16, '2013-05-27 21:19:56', 3, 1, 'return to requisitioner'),
(6, 'MY NEW REQUISITION', 'qweqwe', 1, 3, '2013-05-31 08:20:33', '2013-05-31 08:20:33', '2013-06-30', 10, NULL, NULL, NULL, NULL, 1, 1, NULL),
(7, 'food for all', 'adadfsdf', 1, 1, '2013-05-31 08:24:21', '2013-05-31 08:24:21', '2013-06-08', 10, NULL, NULL, NULL, NULL, 2, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `default_material_requests_items`
--

CREATE TABLE IF NOT EXISTS `default_material_requests_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mr_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `quantity_issued` int(11) DEFAULT NULL,
  `completed` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=270 ;

--
-- Dumping data for table `default_material_requests_items`
--

INSERT INTO `default_material_requests_items` (`id`, `mr_id`, `item_code`, `quantity`, `quantity_issued`, `completed`) VALUES
(24, 4, '5', 5, NULL, NULL),
(25, 4, '6', 2, NULL, NULL),
(26, 3, '4', 3, NULL, NULL),
(27, 3, '5', 2, NULL, NULL),
(28, 3, '3', 21, NULL, NULL),
(66, 5, '12', 12, NULL, NULL),
(67, 5, '2', 4, NULL, NULL),
(68, 5, '7', 6, NULL, NULL),
(114, 2, '3', 1, NULL, NULL),
(115, 2, '10', 4, NULL, NULL),
(132, 6, '7', 1, NULL, NULL),
(133, 6, '10', 1, NULL, NULL),
(265, 1, '2', 1, NULL, NULL),
(266, 1, '7', 1, NULL, NULL),
(267, 1, '8', 1, NULL, NULL),
(268, 7, '15', 1, NULL, NULL),
(269, 7, '2', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `default_material_requests_statuses`
--

CREATE TABLE IF NOT EXISTS `default_material_requests_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `default_material_requests_statuses`
--

INSERT INTO `default_material_requests_statuses` (`id`, `desc`) VALUES
(1, 'Draft'),
(2, 'For Division Approval'),
(3, 'For Division Group Approval'),
(4, 'Division Group Approved'),
(5, 'Require Changes'),
(6, 'Division: On Hold'),
(7, 'Division Group: On Hold');

-- --------------------------------------------------------

--
-- Table structure for table `default_migrations`
--

CREATE TABLE IF NOT EXISTS `default_migrations` (
  `version` int(3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `default_migrations`
--

INSERT INTO `default_migrations` (`version`) VALUES
(96);

-- --------------------------------------------------------

--
-- Table structure for table `default_modules`
--

CREATE TABLE IF NOT EXISTS `default_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `skip_xss` tinyint(1) NOT NULL,
  `is_frontend` tinyint(1) NOT NULL,
  `is_backend` tinyint(1) NOT NULL,
  `menu` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `installed` tinyint(1) NOT NULL,
  `is_core` tinyint(1) NOT NULL,
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `enabled` (`enabled`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=50 ;

--
-- Dumping data for table `default_modules`
--

INSERT INTO `default_modules` (`id`, `name`, `slug`, `version`, `type`, `description`, `skip_xss`, `is_frontend`, `is_backend`, `menu`, `enabled`, `installed`, `is_core`, `updated_on`) VALUES
(1, 'a:15:{s:2:"en";s:4:"Blog";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'blog', '2.0', NULL, 'a:23:{s:2:"en";s:18:"Post blog entries.";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 1, 1, 'content', 1, 1, 1, 1368693934),
(2, 'a:23:{s:2:"en";s:8:"Comments";s:2:"ar";s:18:"التعليقات";s:2:"br";s:12:"Comentários";s:2:"pt";s:12:"Comentários";s:2:"cs";s:11:"Komentáře";s:2:"da";s:11:"Kommentarer";s:2:"de";s:10:"Kommentare";s:2:"el";s:12:"Σχόλια";s:2:"es";s:11:"Comentarios";s:2:"fi";s:9:"Kommentit";s:2:"fr";s:12:"Commentaires";s:2:"he";s:12:"תגובות";s:2:"id";s:8:"Komentar";s:2:"it";s:8:"Commenti";s:2:"lt";s:10:"Komentarai";s:2:"nl";s:8:"Reacties";s:2:"pl";s:10:"Komentarze";s:2:"ru";s:22:"Комментарии";s:2:"sl";s:10:"Komentarji";s:2:"zh";s:6:"回應";s:2:"hu";s:16:"Hozzászólások";s:2:"th";s:33:"ความคิดเห็น";s:2:"se";s:11:"Kommentarer";}', 'comments', '1.0', NULL, 'a:23:{s:2:"en";s:76:"Users and guests can write comments for content like blog, pages and photos.";s:2:"ar";s:152:"يستطيع الأعضاء والزوّار كتابة التعليقات على المُحتوى كالأخبار، والصفحات والصّوَر.";s:2:"br";s:97:"Usuários e convidados podem escrever comentários para quase tudo com suporte nativo ao captcha.";s:2:"pt";s:100:"Utilizadores e convidados podem escrever comentários para quase tudo com suporte nativo ao captcha.";s:2:"cs";s:100:"Uživatelé a hosté mohou psát komentáře k obsahu, např. neovinkám, stránkám a fotografiím.";s:2:"da";s:83:"Brugere og besøgende kan skrive kommentarer til indhold som blog, sider og fotoer.";s:2:"de";s:65:"Benutzer und Gäste können für fast alles Kommentare schreiben.";s:2:"el";s:224:"Οι χρήστες και οι επισκέπτες μπορούν να αφήνουν σχόλια για περιεχόμενο όπως το ιστολόγιο, τις σελίδες και τις φωτογραφίες.";s:2:"es";s:130:"Los usuarios y visitantes pueden escribir comentarios en casi todo el contenido con el soporte de un sistema de captcha incluído.";s:2:"fi";s:107:"Käyttäjät ja vieraat voivat kirjoittaa kommentteja eri sisältöihin kuten uutisiin, sivuihin ja kuviin.";s:2:"fr";s:130:"Les utilisateurs et les invités peuvent écrire des commentaires pour quasiment tout grâce au générateur de captcha intégré.";s:2:"he";s:94:"משתמשי האתר יכולים לרשום תגובות למאמרים, תמונות וכו";s:2:"id";s:100:"Pengguna dan pengunjung dapat menuliskan komentaruntuk setiap konten seperti blog, halaman dan foto.";s:2:"it";s:85:"Utenti e visitatori possono scrivere commenti ai contenuti quali blog, pagine e foto.";s:2:"lt";s:75:"Vartotojai ir svečiai gali komentuoti jūsų naujienas, puslapius ar foto.";s:2:"nl";s:52:"Gebruikers en gasten kunnen reageren op bijna alles.";s:2:"pl";s:93:"Użytkownicy i goście mogą dodawać komentarze z wbudowanym systemem zabezpieczeń captcha.";s:2:"ru";s:187:"Пользователи и гости могут добавлять комментарии к новостям, информационным страницам и фотографиям.";s:2:"sl";s:89:"Uporabniki in obiskovalci lahko vnesejo komentarje na vsebino kot je blok, stra ali slike";s:2:"zh";s:75:"用戶和訪客可以針對新聞、頁面與照片等內容發表回應。";s:2:"hu";s:117:"A felhasználók és a vendégek hozzászólásokat írhatnak a tartalomhoz (bejegyzésekhez, oldalakhoz, fotókhoz).";s:2:"th";s:240:"ผู้ใช้งานและผู้เยี่ยมชมสามารถเขียนความคิดเห็นในเนื้อหาของหน้าเว็บบล็อกและภาพถ่าย";s:2:"se";s:98:"Användare och besökare kan skriva kommentarer till innehåll som blogginlägg, sidor och bilder.";}', 0, 0, 1, 'content', 1, 1, 1, 1368693934),
(3, 'a:23:{s:2:"en";s:7:"Contact";s:2:"ar";s:14:"الإتصال";s:2:"br";s:7:"Contato";s:2:"pt";s:8:"Contacto";s:2:"cs";s:7:"Kontakt";s:2:"da";s:7:"Kontakt";s:2:"de";s:7:"Kontakt";s:2:"el";s:22:"Επικοινωνία";s:2:"es";s:8:"Contacto";s:2:"fi";s:13:"Ota yhteyttä";s:2:"fr";s:7:"Contact";s:2:"he";s:17:"יצירת קשר";s:2:"id";s:6:"Kontak";s:2:"it";s:10:"Contattaci";s:2:"lt";s:18:"Kontaktinė formą";s:2:"nl";s:7:"Contact";s:2:"pl";s:7:"Kontakt";s:2:"ru";s:27:"Обратная связь";s:2:"sl";s:7:"Kontakt";s:2:"zh";s:12:"聯絡我們";s:2:"hu";s:9:"Kapcsolat";s:2:"th";s:18:"ติดต่อ";s:2:"se";s:7:"Kontakt";}', 'contact', '0.9', NULL, 'a:23:{s:2:"en";s:112:"Adds a form to your site that allows visitors to send emails to you without disclosing an email address to them.";s:2:"ar";s:157:"إضافة استمارة إلى موقعك تُمكّن الزوّار من مراسلتك دون علمهم بعنوان البريد الإلكتروني.";s:2:"br";s:139:"Adiciona um formulário para o seu site permitir aos visitantes que enviem e-mails para voce sem divulgar um endereço de e-mail para eles.";s:2:"pt";s:116:"Adiciona um formulário ao seu site que permite aos visitantes enviarem e-mails sem divulgar um endereço de e-mail.";s:2:"cs";s:149:"Přidá na web kontaktní formulář pro návštěvníky a uživatele, díky kterému vás mohou kontaktovat i bez znalosti vaší e-mailové adresy.";s:2:"da";s:123:"Tilføjer en formular på din side som tillader besøgende at sende mails til dig, uden at du skal opgive din email-adresse";s:2:"de";s:119:"Fügt ein Formular hinzu, welches Besuchern erlaubt Emails zu schreiben, ohne die Kontakt Email-Adresse offen zu legen.";s:2:"el";s:273:"Προσθέτει μια φόρμα στον ιστότοπό σας που επιτρέπει σε επισκέπτες να σας στέλνουν μηνύμα μέσω email χωρίς να τους αποκαλύπτεται η διεύθυνση του email σας.";s:2:"es";s:156:"Añade un formulario a tu sitio que permitirá a los visitantes enviarte correos electrónicos a ti sin darles tu dirección de correo directamente a ellos.";s:2:"fi";s:128:"Luo lomakkeen sivustollesi, josta kävijät voivat lähettää sähköpostia tietämättä vastaanottajan sähköpostiosoitetta.";s:2:"fr";s:122:"Ajoute un formulaire à votre site qui permet aux visiteurs de vous envoyer un e-mail sans révéler votre adresse e-mail.";s:2:"he";s:155:"מוסיף תופס יצירת קשר לאתר על מנת לא לחסוף כתובת דואר האלקטרוני של האתר למנועי פרסומות";s:2:"id";s:149:"Menambahkan formulir ke dalam situs Anda yang memungkinkan pengunjung untuk mengirimkan email kepada Anda tanpa memberikan alamat email kepada mereka";s:2:"it";s:119:"Aggiunge un modulo al tuo sito che permette ai visitatori di inviarti email senza mostrare loro il tuo indirizzo email.";s:2:"lt";s:124:"Prideda jūsų puslapyje formą leidžianti lankytojams siūsti jums el. laiškus neatskleidžiant jūsų el. pašto adreso.";s:2:"nl";s:125:"Voegt een formulier aan de site toe waarmee bezoekers een email kunnen sturen, zonder dat u ze een emailadres hoeft te tonen.";s:2:"pl";s:126:"Dodaje formularz kontaktowy do Twojej strony, który pozwala użytkownikom wysłanie maila za pomocą formularza kontaktowego.";s:2:"ru";s:234:"Добавляет форму обратной связи на сайт, через которую посетители могут отправлять вам письма, при этом адрес Email остаётся скрыт.";s:2:"sl";s:113:"Dodaj obrazec za kontakt da vam lahko obiskovalci pošljejo sporočilo brez da bi jim razkrili vaš email naslov.";s:2:"zh";s:147:"為您的網站新增「聯絡我們」的功能，對訪客是較為清楚便捷的聯絡方式，也無須您將電子郵件公開在網站上。";s:2:"th";s:316:"เพิ่มแบบฟอร์มในเว็บไซต์ของคุณ ช่วยให้ผู้เยี่ยมชมสามารถส่งอีเมลถึงคุณโดยไม่ต้องเปิดเผยที่อยู่อีเมลของพวกเขา";s:2:"hu";s:156:"Létrehozható vele olyan űrlap, amely lehetővé teszi a látogatók számára, hogy e-mailt küldjenek neked úgy, hogy nem feded fel az e-mail címedet.";s:2:"se";s:53:"Lägger till ett kontaktformulär till din webbplats.";}', 0, 0, 0, '0', 1, 1, 1, 1368693934),
(4, 'a:22:{s:2:"en";s:5:"Files";s:2:"ar";s:16:"الملفّات";s:2:"br";s:8:"Arquivos";s:2:"pt";s:9:"Ficheiros";s:2:"cs";s:7:"Soubory";s:2:"da";s:5:"Filer";s:2:"de";s:7:"Dateien";s:2:"el";s:12:"Αρχεία";s:2:"es";s:8:"Archivos";s:2:"fi";s:9:"Tiedostot";s:2:"fr";s:8:"Fichiers";s:2:"he";s:10:"קבצים";s:2:"id";s:4:"File";s:2:"it";s:4:"File";s:2:"lt";s:6:"Failai";s:2:"nl";s:9:"Bestanden";s:2:"ru";s:10:"Файлы";s:2:"sl";s:8:"Datoteke";s:2:"zh";s:6:"檔案";s:2:"hu";s:7:"Fájlok";s:2:"th";s:12:"ไฟล์";s:2:"se";s:5:"Filer";}', 'files', '2.0', NULL, 'a:22:{s:2:"en";s:40:"Manages files and folders for your site.";s:2:"ar";s:50:"إدارة ملفات ومجلّدات موقعك.";s:2:"br";s:53:"Permite gerenciar facilmente os arquivos de seu site.";s:2:"pt";s:59:"Permite gerir facilmente os ficheiros e pastas do seu site.";s:2:"cs";s:43:"Spravujte soubory a složky na vašem webu.";s:2:"da";s:41:"Administrer filer og mapper for dit site.";s:2:"de";s:35:"Verwalte Dateien und Verzeichnisse.";s:2:"el";s:100:"Διαχειρίζεται αρχεία και φακέλους για το ιστότοπό σας.";s:2:"es";s:43:"Administra archivos y carpetas en tu sitio.";s:2:"fi";s:43:"Hallitse sivustosi tiedostoja ja kansioita.";s:2:"fr";s:46:"Gérer les fichiers et dossiers de votre site.";s:2:"he";s:47:"ניהול תיקיות וקבצים שבאתר";s:2:"id";s:42:"Mengatur file dan folder dalam situs Anda.";s:2:"it";s:38:"Gestisci file e cartelle del tuo sito.";s:2:"lt";s:28:"Katalogų ir bylų valdymas.";s:2:"nl";s:41:"Beheer bestanden en mappen op uw website.";s:2:"ru";s:78:"Управление файлами и папками вашего сайта.";s:2:"sl";s:38:"Uredi datoteke in mape na vaši strani";s:2:"zh";s:33:"管理網站中的檔案與目錄";s:2:"hu";s:41:"Fájlok és mappák kezelése az oldalon.";s:2:"th";s:141:"บริหารจัดการไฟล์และโฟลเดอร์สำหรับเว็บไซต์ของคุณ";s:2:"se";s:45:"Hanterar filer och mappar för din webbplats.";}', 0, 0, 1, 'content', 1, 1, 1, 1368693934),
(5, 'a:22:{s:2:"en";s:6:"Groups";s:2:"ar";s:18:"المجموعات";s:2:"br";s:6:"Grupos";s:2:"pt";s:6:"Grupos";s:2:"cs";s:7:"Skupiny";s:2:"da";s:7:"Grupper";s:2:"de";s:7:"Gruppen";s:2:"el";s:12:"Ομάδες";s:2:"es";s:6:"Grupos";s:2:"fi";s:7:"Ryhmät";s:2:"fr";s:7:"Groupes";s:2:"he";s:12:"קבוצות";s:2:"id";s:4:"Grup";s:2:"it";s:6:"Gruppi";s:2:"lt";s:7:"Grupės";s:2:"nl";s:7:"Groepen";s:2:"ru";s:12:"Группы";s:2:"sl";s:7:"Skupine";s:2:"zh";s:6:"群組";s:2:"hu";s:9:"Csoportok";s:2:"th";s:15:"กลุ่ม";s:2:"se";s:7:"Grupper";}', 'groups', '1.0', NULL, 'a:22:{s:2:"en";s:54:"Users can be placed into groups to manage permissions.";s:2:"ar";s:100:"يمكن وضع المستخدمين في مجموعات لتسهيل إدارة صلاحياتهم.";s:2:"br";s:72:"Usuários podem ser inseridos em grupos para gerenciar suas permissões.";s:2:"pt";s:74:"Utilizadores podem ser inseridos em grupos para gerir as suas permissões.";s:2:"cs";s:77:"Uživatelé mohou být rozřazeni do skupin pro lepší správu oprávnění.";s:2:"da";s:49:"Brugere kan inddeles i grupper for adgangskontrol";s:2:"de";s:85:"Benutzer können zu Gruppen zusammengefasst werden um diesen Zugriffsrechte zu geben.";s:2:"el";s:168:"Οι χρήστες μπορούν να τοποθετηθούν σε ομάδες και έτσι να διαχειριστείτε τα δικαιώματά τους.";s:2:"es";s:75:"Los usuarios podrán ser colocados en grupos para administrar sus permisos.";s:2:"fi";s:84:"Käyttäjät voidaan liittää ryhmiin, jotta käyttöoikeuksia voidaan hallinnoida.";s:2:"fr";s:82:"Les utilisateurs peuvent appartenir à des groupes afin de gérer les permissions.";s:2:"he";s:62:"נותן אפשרות לאסוף משתמשים לקבוצות";s:2:"id";s:68:"Pengguna dapat dikelompokkan ke dalam grup untuk mengatur perizinan.";s:2:"it";s:69:"Gli utenti possono essere inseriti in gruppi per gestirne i permessi.";s:2:"lt";s:67:"Vartotojai gali būti priskirti grupei tam, kad valdyti jų teises.";s:2:"nl";s:73:"Gebruikers kunnen in groepen geplaatst worden om rechten te kunnen geven.";s:2:"ru";s:134:"Пользователей можно объединять в группы, для управления правами доступа.";s:2:"sl";s:64:"Uporabniki so lahko razvrščeni v skupine za urejanje dovoljenj";s:2:"zh";s:45:"用戶可以依群組分類並管理其權限";s:2:"hu";s:73:"A felhasználók csoportokba rendezhetőek a jogosultságok kezelésére.";s:2:"th";s:84:"สามารถวางผู้ใช้ลงในกลุ่มเพื่";s:2:"se";s:76:"Användare kan delas in i grupper för att hantera roller och behörigheter.";}', 0, 0, 1, 'users', 1, 1, 1, 1368693934),
(6, 'a:15:{s:2:"en";s:8:"Keywords";s:2:"ar";s:21:"كلمات البحث";s:2:"br";s:14:"Palavras-chave";s:2:"pt";s:14:"Palavras-chave";s:2:"da";s:9:"Nøgleord";s:2:"el";s:27:"Λέξεις Κλειδιά";s:2:"fr";s:10:"Mots-Clés";s:2:"id";s:10:"Kata Kunci";s:2:"nl";s:14:"Sleutelwoorden";s:2:"zh";s:6:"鍵詞";s:2:"hu";s:11:"Kulcsszavak";s:2:"fi";s:10:"Avainsanat";s:2:"sl";s:15:"Ključne besede";s:2:"th";s:15:"คำค้น";s:2:"se";s:9:"Nyckelord";}', 'keywords', '1.0', NULL, 'a:15:{s:2:"en";s:71:"Maintain a central list of keywords to label and organize your content.";s:2:"ar";s:124:"أنشئ مجموعة من كلمات البحث التي تستطيع من خلالها وسم وتنظيم المحتوى.";s:2:"br";s:85:"Mantém uma lista central de palavras-chave para rotular e organizar o seu conteúdo.";s:2:"pt";s:85:"Mantém uma lista central de palavras-chave para rotular e organizar o seu conteúdo.";s:2:"da";s:72:"Vedligehold en central liste af nøgleord for at organisere dit indhold.";s:2:"el";s:181:"Συντηρεί μια κεντρική λίστα από λέξεις κλειδιά για να οργανώνετε μέσω ετικετών το περιεχόμενό σας.";s:2:"fr";s:87:"Maintenir une liste centralisée de Mots-Clés pour libeller et organiser vos contenus.";s:2:"id";s:71:"Memantau daftar kata kunci untuk melabeli dan mengorganisasikan konten.";s:2:"nl";s:91:"Beheer een centrale lijst van sleutelwoorden om uw content te categoriseren en organiseren.";s:2:"zh";s:64:"集中管理可用於標題與內容的鍵詞(keywords)列表。";s:2:"hu";s:65:"Ez egy központi kulcsszó lista a cimkékhez és a tartalmakhoz.";s:2:"fi";s:92:"Hallinnoi keskitettyä listaa avainsanoista merkitäksesi ja järjestelläksesi sisältöä.";s:2:"sl";s:82:"Vzdržuj centralni seznam ključnih besed za označevanje in ogranizacijo vsebine.";s:2:"th";s:189:"ศูนย์กลางการปรับปรุงคำค้นในการติดฉลากและจัดระเบียบเนื้อหาของคุณ";s:2:"se";s:61:"Hantera nyckelord för att organisera webbplatsens innehåll.";}', 0, 0, 1, 'content', 1, 1, 1, 1368693934),
(7, 'a:12:{s:2:"en";s:11:"Maintenance";s:2:"pt";s:12:"Manutenção";s:2:"ar";s:14:"الصيانة";s:2:"el";s:18:"Συντήρηση";s:2:"hu";s:13:"Karbantartás";s:2:"fi";s:9:"Ylläpito";s:2:"fr";s:11:"Maintenance";s:2:"id";s:12:"Pemeliharaan";s:2:"se";s:10:"Underhåll";s:2:"sl";s:12:"Vzdrževanje";s:2:"th";s:39:"การบำรุงรักษา";s:2:"zh";s:6:"維護";}', 'maintenance', '1.0', NULL, 'a:12:{s:2:"en";s:63:"Manage the site cache and export information from the database.";s:2:"pt";s:68:"Gerir o cache do seu site e exportar informações da base de dados.";s:2:"ar";s:81:"حذف عناصر الذاكرة المخبأة عبر واجهة الإدارة.";s:2:"el";s:142:"Διαγραφή αντικειμένων προσωρινής αποθήκευσης μέσω της περιοχής διαχείρισης.";s:2:"id";s:60:"Mengatur cache situs dan mengexport informasi dari database.";s:2:"fr";s:71:"Gérer le cache du site et exporter les contenus de la base de données";s:2:"fi";s:59:"Hallinoi sivuston välimuistia ja vie tietoa tietokannasta.";s:2:"hu";s:66:"Az oldal gyorsítótár kezelése és az adatbázis exportálása.";s:2:"se";s:76:"Underhåll webbplatsens cache och exportera data från webbplatsens databas.";s:2:"sl";s:69:"Upravljaj s predpomnilnikom strani (cache) in izvozi podatke iz baze.";s:2:"th";s:150:"การจัดการแคชเว็บไซต์และข้อมูลการส่งออกจากฐานข้อมูล";s:2:"zh";s:45:"經由管理介面手動刪除暫存資料。";}', 0, 0, 1, 'utilities', 1, 1, 1, 1368693934),
(8, 'a:23:{s:2:"en";s:7:"Modules";s:2:"ar";s:14:"الوحدات";s:2:"br";s:8:"Módulos";s:2:"pt";s:8:"Módulos";s:2:"cs";s:6:"Moduly";s:2:"da";s:7:"Moduler";s:2:"de";s:6:"Module";s:2:"el";s:16:"Πρόσθετα";s:2:"es";s:8:"Módulos";s:2:"fi";s:8:"Moduulit";s:2:"fr";s:7:"Modules";s:2:"he";s:14:"מודולים";s:2:"id";s:5:"Modul";s:2:"it";s:6:"Moduli";s:2:"lt";s:8:"Moduliai";s:2:"nl";s:7:"Modules";s:2:"pl";s:7:"Moduły";s:2:"ru";s:12:"Модули";s:2:"sl";s:6:"Moduli";s:2:"zh";s:6:"模組";s:2:"hu";s:7:"Modulok";s:2:"th";s:15:"โมดูล";s:2:"se";s:7:"Moduler";}', 'modules', '1.0', NULL, 'a:23:{s:2:"en";s:59:"Allows admins to see a list of currently installed modules.";s:2:"ar";s:91:"تُمكّن المُدراء من معاينة جميع الوحدات المُثبّتة.";s:2:"br";s:75:"Permite aos administradores ver a lista dos módulos instalados atualmente.";s:2:"pt";s:75:"Permite aos administradores ver a lista dos módulos instalados atualmente.";s:2:"cs";s:68:"Umožňuje administrátorům vidět seznam nainstalovaných modulů.";s:2:"da";s:63:"Lader administratorer se en liste over de installerede moduler.";s:2:"de";s:56:"Zeigt Administratoren alle aktuell installierten Module.";s:2:"el";s:152:"Επιτρέπει στους διαχειριστές να προβάλουν μια λίστα των εγκατεστημένων πρόσθετων.";s:2:"es";s:71:"Permite a los administradores ver una lista de los módulos instalados.";s:2:"fi";s:60:"Listaa järjestelmänvalvojalle käytössä olevat moduulit.";s:2:"fr";s:66:"Permet aux administrateurs de voir la liste des modules installés";s:2:"he";s:160:"נותן אופציה למנהל לראות רשימה של המודולים אשר מותקנים כעת באתר או להתקין מודולים נוספים";s:2:"id";s:57:"Memperlihatkan kepada admin daftar modul yang terinstall.";s:2:"it";s:83:"Permette agli amministratori di vedere una lista dei moduli attualmente installati.";s:2:"lt";s:75:"Vartotojai ir svečiai gali komentuoti jūsų naujienas, puslapius ar foto.";s:2:"nl";s:79:"Stelt admins in staat om een overzicht van geinstalleerde modules te genereren.";s:2:"pl";s:81:"Umożliwiają administratorowi wgląd do listy obecnie zainstalowanych modułów.";s:2:"ru";s:83:"Список модулей, которые установлены на сайте.";s:2:"sl";s:65:"Dovoljuje administratorjem pregled trenutno nameščenih modulov.";s:2:"zh";s:54:"管理員可以檢視目前已經安裝模組的列表";s:2:"hu";s:79:"Lehetővé teszi az adminoknak, hogy lássák a telepített modulok listáját.";s:2:"th";s:162:"ช่วยให้ผู้ดูแลระบบดูรายการของโมดูลที่ติดตั้งในปัจจุบัน";s:2:"se";s:67:"Gör det möjligt för administratören att se installerade mouler.";}', 0, 0, 1, '0', 1, 1, 1, 1368693934),
(9, 'a:23:{s:2:"en";s:19:"Inventory Locations";s:2:"ar";s:14:"الروابط";s:2:"br";s:11:"Navegação";s:2:"pt";s:11:"Navegação";s:2:"cs";s:8:"Navigace";s:2:"da";s:10:"Navigation";s:2:"de";s:10:"Navigation";s:2:"el";s:16:"Πλοήγηση";s:2:"es";s:11:"Navegación";s:2:"fi";s:10:"Navigointi";s:2:"fr";s:10:"Navigation";s:2:"he";s:10:"ניווט";s:2:"id";s:8:"Navigasi";s:2:"it";s:11:"Navigazione";s:2:"lt";s:10:"Navigacija";s:2:"nl";s:9:"Navigatie";s:2:"pl";s:9:"Nawigacja";s:2:"ru";s:18:"Навигация";s:2:"sl";s:10:"Navigacija";s:2:"zh";s:12:"導航選單";s:2:"th";s:36:"ตัวช่วยนำทาง";s:2:"hu";s:11:"Navigáció";s:2:"se";s:10:"Navigation";}', 'navigation', '1.1', NULL, 'a:23:{s:2:"en";s:25:"Manage Inventory Location";s:2:"ar";s:85:"إدارة روابط وقوائم ومجموعات الروابط في الموقع.";s:2:"br";s:91:"Gerenciar links do menu de navegação e todos os grupos de navegação pertencentes a ele.";s:2:"pt";s:93:"Gerir todos os grupos dos menus de navegação e os links de navegação pertencentes a eles.";s:2:"cs";s:73:"Správa odkazů v navigaci a všech souvisejících navigačních skupin.";s:2:"da";s:82:"Håndtér links på navigationsmenuerne og alle navigationsgrupperne de tilhører.";s:2:"de";s:76:"Verwalte Links in Navigationsmenüs und alle zugehörigen Navigationsgruppen";s:2:"el";s:207:"Διαχειριστείτε τους συνδέσμους στα μενού πλοήγησης και όλες τις ομάδες συνδέσμων πλοήγησης στις οποίες ανήκουν.";s:2:"es";s:102:"Administra links en los menús de navegación y en todos los grupos de navegación al cual pertenecen.";s:2:"fi";s:91:"Hallitse linkkejä navigointi valikoissa ja kaikkia navigointi ryhmiä, joihin ne kuuluvat.";s:2:"fr";s:97:"Gérer les liens du menu Navigation et tous les groupes de navigation auxquels ils appartiennent.";s:2:"he";s:73:"ניהול שלוחות תפריטי ניווט וקבוצות ניווט";s:2:"id";s:73:"Mengatur tautan pada menu navigasi dan semua pengelompokan grup navigasi.";s:2:"it";s:97:"Gestisci i collegamenti dei menu di navigazione e tutti i gruppi di navigazione da cui dipendono.";s:2:"lt";s:95:"Tvarkyk nuorodas navigacijų menių ir visas navigacijų grupes kurioms tos nuorodos priklauso.";s:2:"nl";s:92:"Beheer koppelingen op de navigatiemenu&apos;s en alle navigatiegroepen waar ze onder vallen.";s:2:"pl";s:95:"Zarządzaj linkami w menu nawigacji oraz wszystkimi grupami nawigacji do których one należą.";s:2:"ru";s:136:"Управление ссылками в меню навигации и группах, к которым они принадлежат.";s:2:"sl";s:64:"Uredi povezave v meniju in vse skupine povezav ki jim pripadajo.";s:2:"zh";s:72:"管理導航選單中的連結，以及它們所隸屬的導航群組。";s:2:"th";s:108:"จัดการการเชื่อมโยงนำทางและกลุ่มนำทาง";s:2:"hu";s:100:"Linkek kezelése a navigációs menükben és a navigációs csoportok kezelése, amikhez tartoznak.";s:2:"se";s:33:"Hantera länkar och länkgrupper.";}', 0, 0, 1, 'Maintenance', 1, 1, 1, 1368693934),
(10, 'a:23:{s:2:"en";s:5:"Pages";s:2:"ar";s:14:"الصفحات";s:2:"br";s:8:"Páginas";s:2:"pt";s:8:"Páginas";s:2:"cs";s:8:"Stránky";s:2:"da";s:5:"Sider";s:2:"de";s:6:"Seiten";s:2:"el";s:14:"Σελίδες";s:2:"es";s:8:"Páginas";s:2:"fi";s:5:"Sivut";s:2:"fr";s:5:"Pages";s:2:"he";s:8:"דפים";s:2:"id";s:7:"Halaman";s:2:"it";s:6:"Pagine";s:2:"lt";s:9:"Puslapiai";s:2:"nl";s:13:"Pagina&apos;s";s:2:"pl";s:6:"Strony";s:2:"ru";s:16:"Страницы";s:2:"sl";s:6:"Strani";s:2:"zh";s:6:"頁面";s:2:"hu";s:7:"Oldalak";s:2:"th";s:21:"หน้าเพจ";s:2:"se";s:5:"Sidor";}', 'pages', '2.2.0', NULL, 'a:23:{s:2:"en";s:55:"Add custom pages to the site with any content you want.";s:2:"ar";s:99:"إضافة صفحات مُخصّصة إلى الموقع تحتوي أية مُحتوى تريده.";s:2:"br";s:82:"Adicionar páginas personalizadas ao site com qualquer conteúdo que você queira.";s:2:"pt";s:86:"Adicionar páginas personalizadas ao seu site com qualquer conteúdo que você queira.";s:2:"cs";s:74:"Přidávejte vlastní stránky na web s jakýmkoliv obsahem budete chtít.";s:2:"da";s:71:"Tilføj brugerdefinerede sider til dit site med det indhold du ønsker.";s:2:"de";s:49:"Füge eigene Seiten mit anpassbaren Inhalt hinzu.";s:2:"el";s:152:"Προσθέστε και επεξεργαστείτε σελίδες στον ιστότοπό σας με ό,τι περιεχόμενο θέλετε.";s:2:"es";s:77:"Agrega páginas customizadas al sitio con cualquier contenido que tu quieras.";s:2:"fi";s:47:"Lisää mitä tahansa sisältöä sivustollesi.";s:2:"fr";s:89:"Permet d''ajouter sur le site des pages personalisées avec le contenu que vous souhaitez.";s:2:"he";s:35:"ניהול דפי תוכן האתר";s:2:"id";s:75:"Menambahkan halaman ke dalam situs dengan konten apapun yang Anda perlukan.";s:2:"it";s:73:"Aggiungi pagine personalizzate al sito con qualsiesi contenuto tu voglia.";s:2:"lt";s:46:"Pridėkite nuosavus puslapius betkokio turinio";s:2:"nl";s:70:"Voeg aangepaste pagina&apos;s met willekeurige inhoud aan de site toe.";s:2:"pl";s:53:"Dodaj własne strony z dowolną treścią do witryny.";s:2:"ru";s:134:"Управление информационными страницами сайта, с произвольным содержимым.";s:2:"sl";s:44:"Dodaj stran s kakršno koli vsebino želite.";s:2:"zh";s:39:"為您的網站新增自定的頁面。";s:2:"th";s:168:"เพิ่มหน้าเว็บที่กำหนดเองไปยังเว็บไซต์ของคุณตามที่ต้องการ";s:2:"hu";s:67:"Saját oldalak hozzáadása a weboldalhoz, akármilyen tartalommal.";s:2:"se";s:39:"Lägg till egna sidor till webbplatsen.";}', 1, 1, 1, 'content', 1, 1, 1, 1368693934),
(11, 'a:23:{s:2:"en";s:11:"Permissions";s:2:"ar";s:18:"الصلاحيات";s:2:"br";s:11:"Permissões";s:2:"pt";s:11:"Permissões";s:2:"cs";s:12:"Oprávnění";s:2:"da";s:14:"Adgangskontrol";s:2:"de";s:14:"Zugriffsrechte";s:2:"el";s:20:"Δικαιώματα";s:2:"es";s:8:"Permisos";s:2:"fi";s:16:"Käyttöoikeudet";s:2:"fr";s:11:"Permissions";s:2:"he";s:12:"הרשאות";s:2:"id";s:9:"Perizinan";s:2:"it";s:8:"Permessi";s:2:"lt";s:7:"Teisės";s:2:"nl";s:15:"Toegangsrechten";s:2:"pl";s:11:"Uprawnienia";s:2:"ru";s:25:"Права доступа";s:2:"sl";s:10:"Dovoljenja";s:2:"zh";s:6:"權限";s:2:"hu";s:14:"Jogosultságok";s:2:"th";s:18:"สิทธิ์";s:2:"se";s:13:"Behörigheter";}', 'permissions', '0.6', NULL, 'a:23:{s:2:"en";s:68:"Control what type of users can see certain sections within the site.";s:2:"ar";s:127:"التحكم بإعطاء الصلاحيات للمستخدمين للوصول إلى أقسام الموقع المختلفة.";s:2:"br";s:68:"Controle quais tipos de usuários podem ver certas seções no site.";s:2:"pt";s:75:"Controle quais os tipos de utilizadores podem ver certas secções no site.";s:2:"cs";s:93:"Spravujte oprávnění pro jednotlivé typy uživatelů a ke kterým sekcím mají přístup.";s:2:"da";s:72:"Kontroller hvilken type brugere der kan se bestemte sektioner på sitet.";s:2:"de";s:70:"Regelt welche Art von Benutzer welche Sektion in der Seite sehen kann.";s:2:"el";s:180:"Ελέγξτε τα δικαιώματα χρηστών και ομάδων χρηστών όσο αφορά σε διάφορες λειτουργίες του ιστοτόπου.";s:2:"es";s:81:"Controla que tipo de usuarios pueden ver secciones específicas dentro del sitio.";s:2:"fi";s:72:"Hallitse minkä tyyppisiin osioihin käyttäjät pääsevät sivustolla.";s:2:"fr";s:104:"Permet de définir les autorisations des groupes d''utilisateurs pour afficher les différentes sections.";s:2:"he";s:75:"ניהול הרשאות כניסה לאיזורים מסוימים באתר";s:2:"id";s:76:"Mengontrol tipe pengguna mana yang dapat mengakses suatu bagian dalam situs.";s:2:"it";s:78:"Controlla che tipo di utenti posssono accedere a determinate sezioni del sito.";s:2:"lt";s:72:"Kontroliuokite kokio tipo varotojai kokią dalį puslapio gali pasiekti.";s:2:"nl";s:71:"Bepaal welke typen gebruikers toegang hebben tot gedeeltes van de site.";s:2:"pl";s:79:"Ustaw, którzy użytkownicy mogą mieć dostęp do odpowiednich sekcji witryny.";s:2:"ru";s:209:"Управление правами доступа, ограничение доступа определённых групп пользователей к произвольным разделам сайта.";s:2:"sl";s:85:"Uredite dovoljenja kateri tip uporabnika lahko vidi določena področja vaše strani.";s:2:"zh";s:81:"用來控制不同類別的用戶，設定其瀏覽特定網站內容的權限。";s:2:"hu";s:129:"A felhasználók felügyelet alatt tartására, hogy milyen típusú felhasználók, mit láthatnak, mely szakaszain az oldalnak.";s:2:"th";s:117:"ควบคุมว่าผู้ใช้งานจะเห็นหมวดหมู่ไหนบ้าง";s:2:"se";s:27:"Hantera gruppbehörigheter.";}', 0, 0, 1, 'users', 1, 1, 1, 1368693934),
(12, 'a:21:{s:2:"en";s:9:"Redirects";s:2:"ar";s:18:"التوجيهات";s:2:"br";s:17:"Redirecionamentos";s:2:"pt";s:17:"Redirecionamentos";s:2:"cs";s:16:"Přesměrování";s:2:"da";s:13:"Omadressering";s:2:"el";s:30:"Ανακατευθύνσεις";s:2:"es";s:13:"Redirecciones";s:2:"fi";s:18:"Uudelleenohjaukset";s:2:"fr";s:12:"Redirections";s:2:"he";s:12:"הפניות";s:2:"id";s:8:"Redirect";s:2:"it";s:11:"Reindirizzi";s:2:"lt";s:14:"Peradresavimai";s:2:"nl";s:12:"Verwijzingen";s:2:"ru";s:30:"Перенаправления";s:2:"sl";s:12:"Preusmeritve";s:2:"zh";s:6:"轉址";s:2:"hu";s:17:"Átirányítások";s:2:"th";s:42:"เปลี่ยนเส้นทาง";s:2:"se";s:14:"Omdirigeringar";}', 'redirects', '1.0', NULL, 'a:21:{s:2:"en";s:33:"Redirect from one URL to another.";s:2:"ar";s:47:"التوجيه من رابط URL إلى آخر.";s:2:"br";s:39:"Redirecionamento de uma URL para outra.";s:2:"pt";s:40:"Redirecionamentos de uma URL para outra.";s:2:"cs";s:43:"Přesměrujte z jedné adresy URL na jinou.";s:2:"da";s:35:"Omadresser fra en URL til en anden.";s:2:"el";s:81:"Ανακατευθείνετε μια διεύθυνση URL σε μια άλλη";s:2:"es";s:34:"Redireccionar desde una URL a otra";s:2:"fi";s:45:"Uudelleenohjaa käyttäjän paikasta toiseen.";s:2:"fr";s:34:"Redirection d''une URL à un autre.";s:2:"he";s:43:"הפניות מכתובת אחת לאחרת";s:2:"id";s:40:"Redirect dari satu URL ke URL yang lain.";s:2:"it";s:35:"Reindirizza da una URL ad un altra.";s:2:"lt";s:56:"Peradresuokite puslapį iš vieno adreso (URL) į kitą.";s:2:"nl";s:38:"Verwijs vanaf een URL naar een andere.";s:2:"ru";s:78:"Перенаправления с одного адреса на другой.";s:2:"sl";s:44:"Preusmeritev iz enega URL naslova na drugega";s:2:"zh";s:33:"將網址轉址、重新定向。";s:2:"hu";s:38:"Egy URL átirányítása egy másikra.";s:2:"th";s:123:"เปลี่ยนเส้นทางจากที่หนึ่งไปยังอีกที่หนึ่ง";s:2:"se";s:38:"Omdirigera från en URL till en annan.";}', 0, 0, 1, 'utilities', 1, 1, 1, 1368693934),
(13, 'a:23:{s:2:"en";s:8:"Settings";s:2:"ar";s:18:"الإعدادات";s:2:"br";s:15:"Configurações";s:2:"pt";s:15:"Configurações";s:2:"cs";s:10:"Nastavení";s:2:"da";s:13:"Indstillinger";s:2:"de";s:13:"Einstellungen";s:2:"el";s:18:"Ρυθμίσεις";s:2:"es";s:15:"Configuraciones";s:2:"fi";s:9:"Asetukset";s:2:"fr";s:11:"Paramètres";s:2:"he";s:12:"הגדרות";s:2:"id";s:10:"Pengaturan";s:2:"it";s:12:"Impostazioni";s:2:"lt";s:10:"Nustatymai";s:2:"nl";s:12:"Instellingen";s:2:"pl";s:10:"Ustawienia";s:2:"ru";s:18:"Настройки";s:2:"sl";s:10:"Nastavitve";s:2:"zh";s:12:"網站設定";s:2:"hu";s:14:"Beállítások";s:2:"th";s:21:"ตั้งค่า";s:2:"se";s:14:"Inställningar";}', 'settings', '1.0', NULL, 'a:23:{s:2:"en";s:89:"Allows administrators to update settings like Site Name, messages and email address, etc.";s:2:"ar";s:161:"تمكن المدراء من تحديث الإعدادات كإسم الموقع، والرسائل وعناوين البريد الإلكتروني، .. إلخ.";s:2:"br";s:120:"Permite com que administradores e a equipe consigam trocar as configurações do website incluindo o nome e descrição.";s:2:"pt";s:113:"Permite com que os administradores consigam alterar as configurações do website incluindo o nome e descrição.";s:2:"cs";s:102:"Umožňuje administrátorům měnit nastavení webu jako jeho jméno, zprávy a emailovou adresu apod.";s:2:"da";s:90:"Lader administratorer opdatere indstillinger som sidenavn, beskeder og email adresse, etc.";s:2:"de";s:92:"Erlaubt es Administratoren die Einstellungen der Seite wie Name und Beschreibung zu ändern.";s:2:"el";s:230:"Επιτρέπει στους διαχειριστές να τροποποιήσουν ρυθμίσεις όπως το Όνομα του Ιστοτόπου, τα μηνύματα και τις διευθύνσεις email, κ.α.";s:2:"es";s:131:"Permite a los administradores y al personal configurar los detalles del sitio como el nombre del sitio y la descripción del mismo.";s:2:"fi";s:105:"Mahdollistaa sivuston asetusten muokkaamisen, kuten sivuston nimen, viestit ja sähköpostiosoitteet yms.";s:2:"fr";s:105:"Permet aux admistrateurs et au personnel de modifier les paramètres du site : nom du site et description";s:2:"he";s:116:"ניהול הגדרות שונות של האתר כגון: שם האתר, הודעות, כתובות דואר וכו";s:2:"id";s:112:"Memungkinkan administrator untuk dapat memperbaharui pengaturan seperti nama situs, pesan dan alamat email, dsb.";s:2:"it";s:109:"Permette agli amministratori di aggiornare impostazioni quali Nome del Sito, messaggi e indirizzo email, etc.";s:2:"lt";s:104:"Leidžia administratoriams keisti puslapio vavadinimą, žinutes, administratoriaus el. pašta ir kitą.";s:2:"nl";s:114:"Maakt het administratoren en medewerkers mogelijk om websiteinstellingen zoals naam en beschrijving te veranderen.";s:2:"pl";s:103:"Umożliwia administratorom zmianę ustawień strony jak nazwa strony, opis, e-mail administratora, itd.";s:2:"ru";s:135:"Управление настройками сайта - Имя сайта, сообщения, почтовые адреса и т.п.";s:2:"sl";s:98:"Dovoljuje administratorjem posodobitev nastavitev kot je Ime strani, sporočil, email naslova itd.";s:2:"zh";s:99:"網站管理者可更新的重要網站設定。例如：網站名稱、訊息、電子郵件等。";s:2:"hu";s:125:"Lehetővé teszi az adminok számára a beállítások frissítését, mint a weboldal neve, üzenetek, e-mail címek, stb...";s:2:"th";s:232:"ให้ผู้ดูแลระบบสามารถปรับปรุงการตั้งค่าเช่นชื่อเว็บไซต์ ข้อความและอีเมล์เป็นต้น";s:2:"se";s:84:"Administratören kan uppdatera webbplatsens titel, meddelanden och E-postadress etc.";}', 1, 0, 1, '0', 1, 1, 1, 1368693934),
(14, 'a:18:{s:2:"en";s:7:"Sitemap";s:2:"ar";s:23:"خريطة الموقع";s:2:"br";s:12:"Mapa do Site";s:2:"pt";s:12:"Mapa do Site";s:2:"de";s:7:"Sitemap";s:2:"el";s:31:"Χάρτης Ιστότοπου";s:2:"es";s:14:"Mapa del Sitio";s:2:"fi";s:10:"Sivukartta";s:2:"fr";s:12:"Plan du site";s:2:"id";s:10:"Peta Situs";s:2:"it";s:14:"Mappa del sito";s:2:"lt";s:16:"Svetainės medis";s:2:"nl";s:7:"Sitemap";s:2:"ru";s:21:"Карта сайта";s:2:"zh";s:12:"網站地圖";s:2:"th";s:21:"ไซต์แมพ";s:2:"hu";s:13:"Oldaltérkép";s:2:"se";s:9:"Sajtkarta";}', 'sitemap', '1.2', NULL, 'a:19:{s:2:"en";s:87:"The sitemap module creates an index of all pages and an XML sitemap for search engines.";s:2:"ar";s:120:"وحدة خريطة الموقع تنشئ فهرساً لجميع الصفحات وملف XML لمحركات البحث.";s:2:"br";s:102:"O módulo de mapa do site cria um índice de todas as páginas e um sitemap XML para motores de busca.";s:2:"pt";s:102:"O módulo do mapa do site cria um índice de todas as páginas e um sitemap XML para motores de busca.";s:2:"da";s:86:"Sitemapmodulet opretter et indeks over alle sider og et XML sitemap til søgemaskiner.";s:2:"de";s:92:"Die Sitemap Modul erstellt einen Index aller Seiten und eine XML-Sitemap für Suchmaschinen.";s:2:"el";s:190:"Δημιουργεί έναν κατάλογο όλων των σελίδων και έναν χάρτη σελίδων σε μορφή XML για τις μηχανές αναζήτησης.";s:2:"es";s:111:"El módulo de mapa crea un índice de todas las páginas y un mapa del sitio XML para los motores de búsqueda.";s:2:"fi";s:82:"sivukartta moduuli luo hakemisto kaikista sivuista ja XML sivukartta hakukoneille.";s:2:"fr";s:106:"Le module sitemap crée un index de toutes les pages et un plan de site XML pour les moteurs de recherche.";s:2:"id";s:110:"Modul peta situs ini membuat indeks dari setiap halaman dan sebuah format XML untuk mempermudah mesin pencari.";s:2:"it";s:104:"Il modulo mappa del sito crea un indice di tutte le pagine e una sitemap in XML per i motori di ricerca.";s:2:"lt";s:86:"struktūra modulis sukuria visų puslapių ir XML Sitemap paieškos sistemų indeksas.";s:2:"nl";s:89:"De sitemap module maakt een index van alle pagina''s en een XML sitemap voor zoekmachines.";s:2:"ru";s:144:"Карта модуль создает индекс всех страниц и карта сайта XML для поисковых систем.";s:2:"zh";s:84:"站點地圖模塊創建一個索引的所有網頁和XML網站地圖搜索引擎。";s:2:"th";s:202:"โมดูลไซต์แมพสามารถสร้างดัชนีของหน้าเว็บทั้งหมดสำหรับเครื่องมือค้นหา.";s:2:"hu";s:94:"Ez a modul indexeli az összes oldalt és egy XML oldaltéképet generál a keresőmotoroknak.";s:2:"se";s:86:"Sajtkarta, modulen skapar ett index av alla sidor och en XML-sitemap för sökmotorer.";}', 0, 1, 0, 'content', 1, 1, 1, 1368693934),
(15, 'a:5:{s:2:"en";s:12:"Streams Core";s:2:"pt";s:14:"Núcleo Fluxos";s:2:"fr";s:10:"Noyau Flux";s:2:"el";s:23:"Πυρήνας Ροών";s:2:"se";s:18:"Streams grundmodul";}', 'streams_core', '1.0.0', NULL, 'a:5:{s:2:"en";s:29:"Core data module for streams.";s:2:"pt";s:37:"Módulo central de dados para fluxos.";s:2:"fr";s:32:"Noyau de données pour les Flux.";s:2:"el";s:113:"Προγραμματιστικός πυρήνας για την λειτουργία ροών δεδομένων.";s:2:"se";s:50:"Streams grundmodul för enklare hantering av data.";}', 1, 0, 0, '0', 1, 1, 1, 1368693934),
(16, 'a:19:{s:2:"en";s:15:"Email Templates";s:2:"ar";s:48:"قوالب الرسائل الإلكترونية";s:2:"br";s:17:"Modelos de e-mail";s:2:"pt";s:17:"Modelos de e-mail";s:2:"da";s:16:"Email skabeloner";s:2:"el";s:22:"Δυναμικά email";s:2:"es";s:19:"Plantillas de email";s:2:"fr";s:17:"Modèles d''emails";s:2:"he";s:12:"תבניות";s:2:"id";s:14:"Template Email";s:2:"lt";s:22:"El. laiškų šablonai";s:2:"nl";s:15:"Email sjablonen";s:2:"ru";s:25:"Шаблоны почты";s:2:"sl";s:14:"Email predloge";s:2:"zh";s:12:"郵件範本";s:2:"hu";s:15:"E-mail sablonok";s:2:"fi";s:25:"Sähköposti viestipohjat";s:2:"th";s:33:"แม่แบบอีเมล";s:2:"se";s:12:"E-postmallar";}', 'templates', '1.1.0', NULL, 'a:19:{s:2:"en";s:46:"Create, edit, and save dynamic email templates";s:2:"ar";s:97:"أنشئ، عدّل واحفظ قوالب البريد الإلكترني الديناميكية.";s:2:"br";s:51:"Criar, editar e salvar modelos de e-mail dinâmicos";s:2:"pt";s:51:"Criar, editar e salvar modelos de e-mail dinâmicos";s:2:"da";s:49:"Opret, redigér og gem dynamiske emailskabeloner.";s:2:"el";s:108:"Δημιουργήστε, επεξεργαστείτε και αποθηκεύστε δυναμικά email.";s:2:"es";s:54:"Crear, editar y guardar plantillas de email dinámicas";s:2:"fr";s:61:"Créer, éditer et sauver dynamiquement des modèles d''emails";s:2:"he";s:54:"ניהול של תבניות דואר אלקטרוני";s:2:"id";s:55:"Membuat, mengedit, dan menyimpan template email dinamis";s:2:"lt";s:58:"Kurk, tvarkyk ir saugok dinaminius el. laiškų šablonus.";s:2:"nl";s:49:"Maak, bewerk, en beheer dynamische emailsjablonen";s:2:"ru";s:127:"Создавайте, редактируйте и сохраняйте динамические почтовые шаблоны";s:2:"sl";s:52:"Ustvari, uredi in shrani spremenljive email predloge";s:2:"zh";s:61:"新增、編輯與儲存可顯示動態資料的 email 範本";s:2:"hu";s:63:"Csináld, szerkeszd és mentsd el a dinamikus e-mail sablonokat";s:2:"fi";s:66:"Lisää, muokkaa ja tallenna dynaamisia sähköposti viestipohjia.";s:2:"th";s:129:"การสร้างแก้ไขและบันทึกแม่แบบอีเมลแบบไดนามิก";s:2:"se";s:49:"Skapa, redigera och spara dynamiska E-postmallar.";}', 1, 0, 1, 'design', 1, 1, 1, 1368693934),
(17, 'a:23:{s:2:"en";s:6:"Themes";s:2:"ar";s:14:"السّمات";s:2:"br";s:5:"Temas";s:2:"pt";s:5:"Temas";s:2:"cs";s:14:"Motivy vzhledu";s:2:"da";s:6:"Temaer";s:2:"de";s:6:"Themen";s:2:"el";s:31:"Θέματα Εμφάνισης";s:2:"es";s:5:"Temas";s:2:"fi";s:6:"Teemat";s:2:"fr";s:7:"Thèmes";s:2:"he";s:23:"ערכות נושאים";s:2:"id";s:4:"Tema";s:2:"it";s:4:"Temi";s:2:"lt";s:5:"Temos";s:2:"nl";s:7:"Thema''s";s:2:"pl";s:6:"Motywy";s:2:"ru";s:8:"Темы";s:2:"sl";s:8:"Predloge";s:2:"zh";s:12:"佈景主題";s:2:"hu";s:8:"Sablonok";s:2:"th";s:9:"ธีม";s:2:"se";s:5:"Teman";}', 'themes', '1.0', NULL, 'a:23:{s:2:"en";s:86:"Allows admins and staff to switch themes, upload new themes, and manage theme options.";s:2:"ar";s:170:"تمكّن الإدارة وأعضاء الموقع تغيير سِمة الموقع، وتحميل سمات جديدة وإدارتها بطريقة مرئية سلسة.";s:2:"br";s:125:"Permite aos administradores e membros da equipe fazer upload de novos temas e gerenciá-los através de uma interface visual.";s:2:"pt";s:100:"Permite aos administradores fazer upload de novos temas e geri-los através de uma interface visual.";s:2:"cs";s:106:"Umožňuje administrátorům a dalším osobám měnit vzhled webu, nahrávat nové motivy a spravovat je.";s:2:"da";s:108:"Lader administratore ændre websidens tema, uploade nye temaer og håndtére dem med en mere visual tilgang.";s:2:"de";s:121:"Ermöglicht es dem Administrator das Seiten Thema auszuwählen, neue Themen hochzulanden oder diese visuell zu verwalten.";s:2:"el";s:222:"Επιτρέπει στους διαχειριστές να αλλάξουν το θέμα προβολής του ιστοτόπου να ανεβάσουν νέα θέματα και να τα διαχειριστούν.";s:2:"es";s:132:"Permite a los administradores y miembros del personal cambiar el tema del sitio web, subir nuevos temas y manejar los ya existentes.";s:2:"fi";s:129:"Mahdollistaa sivuston teeman vaihtamisen, uusien teemojen lataamisen ja niiden hallinnoinnin visuaalisella käyttöliittymällä.";s:2:"fr";s:144:"Permet aux administrateurs et au personnel de modifier le thème du site, de charger de nouveaux thèmes et de le gérer de façon plus visuelle";s:2:"he";s:63:"ניהול של ערכות נושאים שונות - עיצוב";s:2:"id";s:104:"Memungkinkan admin dan staff untuk mengubah tema tampilan, mengupload tema baru, dan mengatur opsi tema.";s:2:"it";s:120:"Permette ad amministratori e staff di cambiare il tema del sito, carica nuovi temi e gestiscili in um modo più visuale.";s:2:"lt";s:105:"Leidžiama administratoriams ir personalui keisti puslapio temą, įkraunant naują temą ir valdyti ją.";s:2:"nl";s:153:"Maakt het voor administratoren en medewerkers mogelijk om het thema van de website te wijzigen, nieuwe thema&apos;s te uploaden en ze visueel te beheren.";s:2:"pl";s:100:"Umożliwia administratorowi zmianę motywu strony, wgrywanie nowych motywów oraz zarządzanie nimi.";s:2:"ru";s:102:"Управление темами оформления сайта, загрузка новых тем.";s:2:"sl";s:133:"Dovoljuje adminom in osebju spremembo izgleda spletne strani, namestitev novega izgleda in urejanja le tega v bolj vizualnem pristopu";s:2:"zh";s:108:"讓管理者可以更改網站顯示風貌，以視覺化的操作上傳並管理這些網站佈景主題。";s:2:"th";s:219:"ช่วยให้ผู้ดูแลระบบสามารถอัปโหลดรูปแบบใหม่และการจัดการตัวเลือกชุดรูปแบบได้";s:2:"hu";s:107:"Az adminok megváltoztathatják az oldal kinézetét, feltölthetnek új kinézeteket és kezelhetik őket.";s:2:"se";s:94:"Hantera webbplatsens utseende genom teman, ladda upp nya teman och hantera temainställningar.";}', 0, 0, 1, 'design', 1, 1, 1, 1368693934);
INSERT INTO `default_modules` (`id`, `name`, `slug`, `version`, `type`, `description`, `skip_xss`, `is_frontend`, `is_backend`, `menu`, `enabled`, `installed`, `is_core`, `updated_on`) VALUES
(18, 'a:23:{s:2:"en";s:5:"Users";s:2:"ar";s:20:"المستخدمون";s:2:"br";s:9:"Usuários";s:2:"pt";s:12:"Utilizadores";s:2:"cs";s:11:"Uživatelé";s:2:"da";s:7:"Brugere";s:2:"de";s:8:"Benutzer";s:2:"el";s:14:"Χρήστες";s:2:"es";s:8:"Usuarios";s:2:"fi";s:12:"Käyttäjät";s:2:"fr";s:12:"Utilisateurs";s:2:"he";s:14:"משתמשים";s:2:"id";s:8:"Pengguna";s:2:"it";s:6:"Utenti";s:2:"lt";s:10:"Vartotojai";s:2:"nl";s:10:"Gebruikers";s:2:"pl";s:12:"Użytkownicy";s:2:"ru";s:24:"Пользователи";s:2:"sl";s:10:"Uporabniki";s:2:"zh";s:6:"用戶";s:2:"hu";s:14:"Felhasználók";s:2:"th";s:27:"ผู้ใช้งาน";s:2:"se";s:10:"Användare";}', 'users', '0.9', NULL, 'a:23:{s:2:"en";s:81:"Let users register and log in to the site, and manage them via the control panel.";s:2:"ar";s:133:"تمكين المستخدمين من التسجيل والدخول إلى الموقع، وإدارتهم من لوحة التحكم.";s:2:"br";s:125:"Permite com que usuários se registrem e entrem no site e também que eles sejam gerenciáveis apartir do painel de controle.";s:2:"pt";s:125:"Permite com que os utilizadores se registem e entrem no site e também que eles sejam geriveis apartir do painel de controlo.";s:2:"cs";s:103:"Umožňuje uživatelům se registrovat a přihlašovat a zároveň jejich správu v Kontrolním panelu.";s:2:"da";s:89:"Lader brugere registrere sig og logge ind på sitet, og håndtér dem via kontrolpanelet.";s:2:"de";s:108:"Erlaube Benutzern das Registrieren und Einloggen auf der Seite und verwalte sie über die Admin-Oberfläche.";s:2:"el";s:208:"Παρέχει λειτουργίες εγγραφής και σύνδεσης στους επισκέπτες. Επίσης από εδώ γίνεται η διαχείριση των λογαριασμών.";s:2:"es";s:138:"Permite el registro de nuevos usuarios quienes podrán loguearse en el sitio. Estos podrán controlarse desde el panel de administración.";s:2:"fi";s:126:"Antaa käyttäjien rekisteröityä ja kirjautua sisään sivustolle sekä mahdollistaa niiden muokkaamisen hallintapaneelista.";s:2:"fr";s:112:"Permet aux utilisateurs de s''enregistrer et de se connecter au site et de les gérer via le panneau de contrôle";s:2:"he";s:62:"ניהול משתמשים: רישום, הפעלה ומחיקה";s:2:"id";s:102:"Memungkinkan pengguna untuk mendaftar dan masuk ke dalam situs, dan mengaturnya melalui control panel.";s:2:"it";s:95:"Fai iscrivere de entrare nel sito gli utenti, e gestiscili attraverso il pannello di controllo.";s:2:"lt";s:106:"Leidžia vartotojams registruotis ir prisijungti prie puslapio, ir valdyti juos per administravimo panele.";s:2:"nl";s:88:"Laat gebruikers registreren en inloggen op de site, en beheer ze via het controlepaneel.";s:2:"pl";s:87:"Pozwól użytkownikom na logowanie się na stronie i zarządzaj nimi za pomocą panelu.";s:2:"ru";s:155:"Управление зарегистрированными пользователями, активирование новых пользователей.";s:2:"sl";s:96:"Dovoli uporabnikom za registracijo in prijavo na strani, urejanje le teh preko nadzorne plošče";s:2:"zh";s:87:"讓用戶可以註冊並登入網站，並且管理者可在控制台內進行管理。";s:2:"th";s:210:"ให้ผู้ใช้ลงทะเบียนและเข้าสู่เว็บไซต์และจัดการกับพวกเขาผ่านทางแผงควบคุม";s:2:"hu";s:120:"Hogy a felhasználók tudjanak az oldalra regisztrálni és belépni, valamint lehessen őket kezelni a vezérlőpulton.";s:2:"se";s:111:"Låt dina besökare registrera sig och logga in på webbplatsen. Hantera sedan användarna via kontrollpanelen.";}', 0, 0, 1, '0', 1, 1, 1, 1368693934),
(19, 'a:23:{s:2:"en";s:9:"Variables";s:2:"ar";s:20:"المتغيّرات";s:2:"br";s:10:"Variáveis";s:2:"pt";s:10:"Variáveis";s:2:"cs";s:10:"Proměnné";s:2:"da";s:8:"Variable";s:2:"de";s:9:"Variablen";s:2:"el";s:20:"Μεταβλητές";s:2:"es";s:9:"Variables";s:2:"fi";s:9:"Muuttujat";s:2:"fr";s:9:"Variables";s:2:"he";s:12:"משתנים";s:2:"id";s:8:"Variabel";s:2:"it";s:9:"Variabili";s:2:"lt";s:10:"Kintamieji";s:2:"nl";s:10:"Variabelen";s:2:"pl";s:7:"Zmienne";s:2:"ru";s:20:"Переменные";s:2:"sl";s:13:"Spremenljivke";s:2:"zh";s:12:"系統變數";s:2:"hu";s:10:"Változók";s:2:"th";s:18:"ตัวแปร";s:2:"se";s:9:"Variabler";}', 'variables', '0.4', NULL, 'a:23:{s:2:"en";s:59:"Manage global variables that can be accessed from anywhere.";s:2:"ar";s:97:"إدارة المُتغيّرات العامة لاستخدامها في أرجاء الموقع.";s:2:"br";s:61:"Gerencia as variáveis globais acessíveis de qualquer lugar.";s:2:"pt";s:58:"Gerir as variáveis globais acessíveis de qualquer lugar.";s:2:"cs";s:56:"Spravujte globální proměnné přístupné odkudkoliv.";s:2:"da";s:51:"Håndtér globale variable som kan tilgås overalt.";s:2:"de";s:74:"Verwaltet globale Variablen, auf die von überall zugegriffen werden kann.";s:2:"el";s:129:"Διαχείριση μεταβλητών που είναι προσβάσιμες από παντού στον ιστότοπο.";s:2:"es";s:50:"Manage global variables to access from everywhere.";s:2:"fi";s:66:"Hallitse globaali muuttujia, joihin pääsee käsiksi mistä vain.";s:2:"fr";s:50:"Manage global variables to access from everywhere.";s:2:"he";s:96:"ניהול משתנים גלובליים אשר ניתנים להמרה בכל חלקי האתר";s:2:"id";s:59:"Mengatur variabel global yang dapat diakses dari mana saja.";s:2:"it";s:58:"Gestisci le variabili globali per accedervi da ogni parte.";s:2:"lt";s:64:"Globalių kintamujų tvarkymas kurie yra pasiekiami iš bet kur.";s:2:"nl";s:54:"Beheer globale variabelen die overal beschikbaar zijn.";s:2:"pl";s:86:"Zarządzaj globalnymi zmiennymi do których masz dostęp z każdego miejsca aplikacji.";s:2:"ru";s:136:"Управление глобальными переменными, которые доступны в любом месте сайта.";s:2:"sl";s:53:"Urejanje globalnih spremenljivk za dostop od kjerkoli";s:2:"th";s:148:"จัดการตัวแปรทั่วไปโดยที่สามารถเข้าถึงได้จากทุกที่.";s:2:"zh";s:45:"管理此網站內可存取的全局變數。";s:2:"hu";s:62:"Globális változók kezelése a hozzáféréshez, bárhonnan.";s:2:"se";s:66:"Hantera globala variabler som kan avändas över hela webbplatsen.";}', 0, 0, 1, 'content', 1, 1, 1, 1368693934),
(20, 'a:20:{s:2:"en";s:7:"Widgets";s:2:"ar";s:12:"الودجت";s:2:"br";s:7:"Widgets";s:2:"pt";s:7:"Widgets";s:2:"cs";s:7:"Widgety";s:2:"de";s:7:"Widgets";s:2:"el";s:7:"Widgets";s:2:"es";s:7:"Widgets";s:2:"fi";s:8:"Widgetit";s:2:"fr";s:7:"Widgets";s:2:"id";s:6:"Widget";s:2:"it";s:7:"Widgets";s:2:"lt";s:11:"Papildiniai";s:2:"nl";s:7:"Widgets";s:2:"ru";s:14:"Виджеты";s:2:"sl";s:9:"Vtičniki";s:2:"zh";s:9:"小組件";s:2:"hu";s:9:"Widget-ek";s:2:"th";s:21:"วิดเจ็ต";s:2:"se";s:8:"Widgetar";}', 'widgets', '1.1', NULL, 'a:21:{s:2:"en";s:69:"Manage small sections of self-contained logic in blocks or "Widgets".";s:2:"ar";s:138:"إدارة أقسام صغيرة من البرمجيات في مساحات الموقع أو ما يُسمّى بالـ"وِدْجِتْ".";s:2:"br";s:77:"Gerenciar pequenas seções de conteúdos em bloco conhecidos como "Widgets".";s:2:"pt";s:74:"Gerir pequenas secções de conteúdos em bloco conhecidos como "Widgets".";s:2:"cs";s:56:"Spravujte malé funkční části webu neboli "Widgety".";s:2:"da";s:74:"Håndter små sektioner af selv-opretholdt logik i blokke eller "Widgets".";s:2:"de";s:62:"Verwaltet kleine, eigentständige Bereiche, genannt "Widgets".";s:2:"el";s:149:"Διαχείριση μικρών τμημάτων αυτόνομης προγραμματιστικής λογικής σε πεδία ή "Widgets".";s:2:"es";s:75:"Manejar pequeñas secciones de lógica autocontenida en bloques o "Widgets"";s:2:"fi";s:83:"Hallitse pieniä osioita, jotka sisältävät erillisiä lohkoja tai "Widgettejä".";s:2:"fr";s:41:"Gérer des mini application ou "Widgets".";s:2:"id";s:101:"Mengatur bagian-bagian kecil dari blok-blok yang memuat sesuatu atau dikenal dengan istilah "Widget".";s:2:"it";s:70:"Gestisci piccole sezioni di logica a se stante in blocchi o "Widgets".";s:2:"lt";s:43:"Nedidelių, savarankiškų blokų valdymas.";s:2:"nl";s:75:"Beheer kleine onderdelen die zelfstandige logica bevatten, ofwel "Widgets".";s:2:"ru";s:91:"Управление небольшими, самостоятельными блоками.";s:2:"sl";s:61:"Urejanje manjših delov blokov strani ti. Vtičniki (Widgets)";s:2:"zh";s:103:"可將小段的程式碼透過小組件來管理。即所謂 "Widgets"，或稱為小工具、部件。";s:2:"hu";s:56:"Önálló kis logikai tömbök vagy widget-ek kezelése.";s:2:"th";s:152:"จัดการส่วนเล็ก ๆ ในรูปแบบของตัวเองในบล็อกหรือวิดเจ็ต";s:2:"se";s:83:"Hantera små sektioner med egen logik och innehåll på olika delar av webbplatsen.";}', 1, 0, 1, 'content', 1, 1, 1, 1368693934),
(21, 'a:3:{s:2:"en";s:7:"WYSIWYG";s:2:"pt";s:7:"WYSIWYG";s:2:"se";s:15:"HTML-redigerare";}', 'wysiwyg', '1.0', NULL, 'a:4:{s:2:"en";s:60:"Provides the WYSIWYG editor for PyroCMS powered by CKEditor.";s:2:"pt";s:61:"Fornece o editor WYSIWYG para o PyroCMS, powered by CKEditor.";s:2:"el";s:113:"Παρέχει τον επεξεργαστή WYSIWYG για το PyroCMS, χρησιμοποιεί το CKEDitor.";s:2:"se";s:37:"Redigeringsmodul för HTML, CKEditor.";}', 0, 0, 0, '0', 1, 1, 1, 1368693934),
(22, 'a:15:{s:2:"en";s:9:"Inventory";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'inventory', '1.0', NULL, 'a:23:{s:2:"en";s:53:"SFS Logistics System Module for Inventory Management ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'inventory', 0, 1, 0, 1368693934),
(23, 'a:15:{s:2:"en";s:9:"Purchases";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'purchases', '1.0', NULL, 'a:23:{s:2:"en";s:42:"SFS Logistics System Module for Purchases ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'purchases', 0, 1, 0, 1368693934),
(24, 'a:15:{s:2:"en";s:15:"Inventory Items";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'items', '1.0', NULL, 'a:23:{s:2:"en";s:23:"Manage Inventory Items ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1368693934),
(25, 'a:15:{s:2:"en";s:20:"Inventory Categories";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'categories', '1.0', NULL, 'a:23:{s:2:"en";s:28:"Manage Inventory Categories ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1368693934),
(27, 'a:15:{s:2:"en";s:19:"Inventory Locations";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'locations', '1.0', NULL, 'a:23:{s:2:"en";s:27:"Manage Inventory Locations ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1354607219),
(30, 'a:23:{s:2:"en";s:19:"Inventory Locations";s:2:"ar";s:14:"الروابط";s:2:"br";s:11:"Navegação";s:2:"pt";s:11:"Navegação";s:2:"cs";s:8:"Navigace";s:2:"da";s:10:"Navigation";s:2:"de";s:10:"Navigation";s:2:"el";s:16:"Πλοήγηση";s:2:"es";s:11:"Navegación";s:2:"fi";s:10:"Navigointi";s:2:"fr";s:10:"Navigation";s:2:"he";s:10:"ניווט";s:2:"id";s:8:"Navigasi";s:2:"it";s:11:"Navigazione";s:2:"lt";s:10:"Navigacija";s:2:"nl";s:9:"Navigatie";s:2:"pl";s:9:"Nawigacja";s:2:"ru";s:18:"Навигация";s:2:"sl";s:10:"Navigacija";s:2:"zh";s:12:"導航選單";s:2:"th";s:36:"ตัวช่วยนำทาง";s:2:"hu";s:11:"Navigáció";s:2:"se";s:10:"Navigation";}', 'location', '1.1', NULL, 'a:23:{s:2:"en";s:26:"Manage Inventory Locations";s:2:"ar";s:85:"إدارة روابط وقوائم ومجموعات الروابط في الموقع.";s:2:"br";s:91:"Gerenciar links do menu de navegação e todos os grupos de navegação pertencentes a ele.";s:2:"pt";s:93:"Gerir todos os grupos dos menus de navegação e os links de navegação pertencentes a eles.";s:2:"cs";s:73:"Správa odkazů v navigaci a všech souvisejících navigačních skupin.";s:2:"da";s:82:"Håndtér links på navigationsmenuerne og alle navigationsgrupperne de tilhører.";s:2:"de";s:76:"Verwalte Links in Navigationsmenüs und alle zugehörigen Navigationsgruppen";s:2:"el";s:207:"Διαχειριστείτε τους συνδέσμους στα μενού πλοήγησης και όλες τις ομάδες συνδέσμων πλοήγησης στις οποίες ανήκουν.";s:2:"es";s:102:"Administra links en los menús de navegación y en todos los grupos de navegación al cual pertenecen.";s:2:"fi";s:91:"Hallitse linkkejä navigointi valikoissa ja kaikkia navigointi ryhmiä, joihin ne kuuluvat.";s:2:"fr";s:97:"Gérer les liens du menu Navigation et tous les groupes de navigation auxquels ils appartiennent.";s:2:"he";s:73:"ניהול שלוחות תפריטי ניווט וקבוצות ניווט";s:2:"id";s:73:"Mengatur tautan pada menu navigasi dan semua pengelompokan grup navigasi.";s:2:"it";s:97:"Gestisci i collegamenti dei menu di navigazione e tutti i gruppi di navigazione da cui dipendono.";s:2:"lt";s:95:"Tvarkyk nuorodas navigacijų menių ir visas navigacijų grupes kurioms tos nuorodos priklauso.";s:2:"nl";s:92:"Beheer koppelingen op de navigatiemenu&apos;s en alle navigatiegroepen waar ze onder vallen.";s:2:"pl";s:95:"Zarządzaj linkami w menu nawigacji oraz wszystkimi grupami nawigacji do których one należą.";s:2:"ru";s:136:"Управление ссылками в меню навигации и группах, к которым они принадлежат.";s:2:"sl";s:64:"Uredi povezave v meniju in vse skupine povezav ki jim pripadajo.";s:2:"zh";s:72:"管理導航選單中的連結，以及它們所隸屬的導航群組。";s:2:"th";s:108:"จัดการการเชื่อมโยงนำทางและกลุ่มนำทาง";s:2:"hu";s:100:"Linkek kezelése a navigációs menükben és a navigációs csoportok kezelése, amikhez tartoznak.";s:2:"se";s:33:"Hantera länkar och länkgrupper.";}', 0, 0, 1, 'Maintenance', 1, 1, 0, 1358267333),
(39, 'a:15:{s:2:"en";s:20:"Material Requesition";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'materialrequest', '2.0', NULL, 'a:23:{s:2:"en";s:27:"Material Requesition Module";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 1, 1, 'Transactions', 1, 1, 0, 1368693934),
(37, 'a:15:{s:2:"en";s:9:"Divisions";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:9:"Divisions";s:2:"pt";s:9:"Divisions";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:9:"Divisions";s:2:"lt";s:9:"Divisions";s:2:"pl";s:9:"Divisions";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:8:"Division";s:2:"fi";s:8:"Division";s:2:"th";s:15:"บล็อก";s:2:"se";s:8:"Division";}', 'divisions', '1.0', NULL, 'a:23:{s:2:"en";s:42:"This module allows you to manage Divisions";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1368693934),
(38, 'a:1:{s:2:"en";s:6:"Sample";}', 'sample', '2.1', NULL, 'a:1:{s:2:"en";s:32:"This is a PyroCMS module sample.";}', 0, 1, 1, 'content', 0, 1, 0, 1368693934),
(36, 'a:15:{s:2:"en";s:15:"Division Groups";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:15:"Division Groups";s:2:"pt";s:15:"Division Groups";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:15:"Division Groups";s:2:"lt";s:15:"Division Groups";s:2:"pl";s:15:"Division Groups";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:15:"Division Groups";s:2:"fi";s:15:"Division Groups";s:2:"th";s:15:"บล็อก";s:2:"se";s:15:"Division Groups";}', 'divgroups', '1.0', NULL, 'a:23:{s:2:"en";s:121:"Manage Division Groups. This module allows you to group division that would determine charging for every stock movement. ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1368693934),
(42, 'a:15:{s:2:"en";s:25:"Approve Division Requests";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:25:"Approve Division Requests";s:2:"pt";s:25:"Approve Division Requests";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:25:"Approve Division Requests";s:2:"lt";s:25:"Approve Division Requests";s:2:"pl";s:25:"Approve Division Requests";s:2:"ru";s:25:"Approve Division Requests";s:2:"zh";s:6:"文章";s:2:"hu";s:25:"Approve Division Requests";s:2:"fi";s:25:"Approve Division Requests";s:2:"th";s:15:"บล็อก";s:2:"se";s:25:"Approve Division Requests";}', 'approvediv', '1.0', NULL, 'a:23:{s:2:"en";s:52:"Review and approve Material Request in your Division";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Approve Requests', 1, 1, 0, 1368693934),
(46, 'a:15:{s:2:"en";s:30:"Approve Division Group Request";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:30:"Approve Division Group Request";s:2:"pt";s:30:"Approve Division Group Request";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:30:"Approve Division Group Request";s:2:"lt";s:30:"Approve Division Group Request";s:2:"pl";s:30:"Approve Division Group Request";s:2:"ru";s:30:"Approve Division Group Request";s:2:"zh";s:6:"文章";s:2:"hu";s:30:"Approve Division Group Request";s:2:"fi";s:30:"Approve Division Group Request";s:2:"th";s:15:"บล็อก";s:2:"se";s:30:"Approve Division Group Request";}', 'approvedivgroup', '1.0', NULL, 'a:23:{s:2:"en";s:58:"Review and approve Material Request in your Division Group";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Approve Requests', 1, 1, 0, 1368687580),
(44, 'a:15:{s:2:"en";s:15:"Unit of Measure";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:4:"Blog";s:2:"pt";s:4:"Blog";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:4:"Blog";s:2:"lt";s:6:"Blogas";s:2:"pl";s:4:"Blog";s:2:"ru";s:8:"Блог";s:2:"zh";s:6:"文章";s:2:"hu";s:4:"Blog";s:2:"fi";s:5:"Blogi";s:2:"th";s:15:"บล็อก";s:2:"se";s:5:"Blogg";}', 'unit_of_measure', '1.0', NULL, 'a:23:{s:2:"en";s:23:"Manage Unit of Measure ";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1368693966),
(45, 'a:15:{s:2:"en";s:38:"Special Approve Division Group Request";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:38:"Special Approve Division Group Request";s:2:"pt";s:38:"Special Approve Division Group Request";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:38:"Special Approve Division Group Request";s:2:"lt";s:38:"Special Approve Division Group Request";s:2:"pl";s:38:"Special Approve Division Group Request";s:2:"ru";s:38:"Special Approve Division Group Request";s:2:"zh";s:6:"文章";s:2:"hu";s:38:"Special Approve Division Group Request";s:2:"fi";s:38:"Special Approve Division Group Request";s:2:"th";s:15:"บล็อก";s:2:"se";s:38:"Special Approve Division Group Request";}', 'special_approver', '1.0', NULL, 'a:23:{s:2:"en";s:57:"Review and approve Material Request IN ANY Division Group";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Approve Requests', 1, 1, 0, 1368694806),
(47, 'a:15:{s:2:"en";s:11:"Audit Trail";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:11:"Audit Trail";s:2:"pt";s:11:"Audit Trail";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:11:"Audit Trail";s:2:"lt";s:11:"Audit Trail";s:2:"pl";s:11:"Audit Trail";s:2:"ru";s:11:"Audit Trail";s:2:"zh";s:6:"文章";s:2:"hu";s:11:"Audit Trail";s:2:"fi";s:11:"Audit Trail";s:2:"th";s:15:"บล็อก";s:2:"se";s:11:"Audit Trail";}', 'audit_trail', '1.0', NULL, 'a:23:{s:2:"en";s:35:"Track material requisitions history";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Maintenance', 1, 1, 0, 1369105134),
(48, 'a:15:{s:2:"en";s:18:"Product Assignment";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:18:"Product Assignment";s:2:"pt";s:18:"Product Assignment";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:18:"Product Assignment";s:2:"lt";s:18:"Product Assignment";s:2:"pl";s:18:"Product Assignment";s:2:"ru";s:18:"Product Assignment";s:2:"zh";s:6:"文章";s:2:"hu";s:18:"Product Assignment";s:2:"fi";s:18:"Product Assignment";s:2:"th";s:15:"บล็อก";s:2:"se";s:18:"Product Assignment";}', 'product_assignment', '1.0', NULL, 'a:23:{s:2:"en";s:48:"Review and assign products to purchasing officer";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Purchasing', 1, 1, 0, 1370180173),
(49, 'a:15:{s:2:"en";s:13:"Canvass Items";s:2:"ar";s:16:"المدوّنة";s:2:"br";s:13:"Canvass Items";s:2:"pt";s:13:"Canvass Items";s:2:"el";s:18:"Ιστολόγιο";s:2:"he";s:8:"בלוג";s:2:"id";s:13:"Canvass Items";s:2:"lt";s:13:"Canvass Items";s:2:"pl";s:13:"Canvass Items";s:2:"ru";s:13:"Canvass Items";s:2:"zh";s:6:"文章";s:2:"hu";s:13:"Canvass Items";s:2:"fi";s:13:"Canvass Items";s:2:"th";s:15:"บล็อก";s:2:"se";s:13:"Canvass Items";}', 'canvass_items', '1.0', NULL, 'a:23:{s:2:"en";s:53:"Canvass item''s price, quantity and  prospect supplier";s:2:"ar";s:48:"أنشر المقالات على مدوّنتك.";s:2:"br";s:30:"Escrever publicações de blog";s:2:"pt";s:39:"Escrever e editar publicações no blog";s:2:"cs";s:49:"Publikujte nové články a příspěvky na blog.";s:2:"da";s:17:"Skriv blogindlæg";s:2:"de";s:47:"Veröffentliche neue Artikel und Blog-Einträge";s:2:"sl";s:23:"Objavite blog prispevke";s:2:"fi";s:28:"Kirjoita blogi artikkeleita.";s:2:"el";s:93:"Δημιουργήστε άρθρα και εγγραφές στο ιστολόγιο σας.";s:2:"es";s:54:"Escribe entradas para los artículos y blog (web log).";s:2:"fr";s:46:"Envoyez de nouveaux posts et messages de blog.";s:2:"he";s:19:"ניהול בלוג";s:2:"id";s:15:"Post entri blog";s:2:"it";s:36:"Pubblica notizie e post per il blog.";s:2:"lt";s:40:"Rašykite naujienas bei blog''o įrašus.";s:2:"nl";s:41:"Post nieuwsartikelen en blogs op uw site.";s:2:"pl";s:27:"Dodawaj nowe wpisy na blogu";s:2:"ru";s:49:"Управление записями блога.";s:2:"zh";s:42:"發表新聞訊息、部落格等文章。";s:2:"th";s:48:"โพสต์รายการบล็อก";s:2:"hu";s:32:"Blog bejegyzések létrehozása.";s:2:"se";s:18:"Inlägg i bloggen.";}', 1, 0, 1, 'Purchasing', 1, 1, 0, 1370180284);

-- --------------------------------------------------------

--
-- Table structure for table `default_navigation_groups`
--

CREATE TABLE IF NOT EXISTS `default_navigation_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `abbrev` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `del_add1` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tel` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contact` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `inventory_manager` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abbrev` (`del_add1`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `default_navigation_groups`
--

INSERT INTO `default_navigation_groups` (`id`, `title`, `abbrev`, `del_add1`, `tel`, `contact`, `inventory_manager`) VALUES
(2, 'Warehouse 1', '', '0', '34242432', 'sam bilmy', 3),
(8, 'Warehouse Boom', '', 'WB', '4566543', '4566543', 0),
(10, 'Warehouse 2', 'ab', '0938 theresa st. magdalo game', '0998098709', 'HJKKJJNN', 0),
(11, 'warehouse makati', 'ab', '069 adb lfdkafdafsd', '3432432', 'ven', 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_navigation_links`
--

CREATE TABLE IF NOT EXISTS `default_navigation_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent` int(11) DEFAULT NULL,
  `link_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'uri',
  `page_id` int(11) DEFAULT NULL,
  `module_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `navigation_group_id` int(5) NOT NULL DEFAULT '0',
  `position` int(5) NOT NULL DEFAULT '0',
  `target` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `restricted_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `navigation_group_id` (`navigation_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `default_navigation_links`
--

INSERT INTO `default_navigation_links` (`id`, `title`, `parent`, `link_type`, `page_id`, `module_name`, `url`, `uri`, `navigation_group_id`, `position`, `target`, `restricted_to`, `class`, `description`) VALUES
(3, 'Section C', 0, 'page', 3, '', '', '', 1, 1, '', '0', '', ''),
(4, 'Row 1', 2, 'page', 1, '', '', '', 1, 0, '', '0', '', 'kaliwang rack'),
(12, 'Section B', 14, 'page', 1, '', '', '', 2, 1, '', '0', '', 'sample storage'),
(13, 'Section A-1', 14, 'page', 1, '', '', '', 2, 0, '', '0', '', 'Sample Child Storage'),
(14, 'Section A-2', 0, 'page', 1, '', '', '', 2, 1, '', '0', '', 'Sample Child Storage');

-- --------------------------------------------------------

--
-- Table structure for table `default_notifications`
--

CREATE TABLE IF NOT EXISTS `default_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `relative_id` int(11) NOT NULL,
  `action` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `remarks` varchar(10000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=135 ;

--
-- Dumping data for table `default_notifications`
--

INSERT INTO `default_notifications` (`id`, `relative_id`, `action`, `created`, `user_id`, `remarks`) VALUES
(106, 1, 1, '2013-05-27 06:21:45', 10, ''),
(107, 1, 1, '2013-05-27 06:27:59', 10, ''),
(108, 1, 3, '2013-05-27 06:32:17', 12, ''),
(109, 1, 1, '2013-05-27 06:46:33', 10, ''),
(110, 1, 3, '2013-05-27 07:01:06', 12, 'i need more changes'),
(111, 1, 1, '2013-05-27 07:06:09', 10, ''),
(112, 1, 3, '2013-05-27 07:12:24', 13, 'this require changes'),
(113, 1, 2, '2013-05-27 08:08:42', 12, ''),
(114, 1, 2, '2013-05-27 08:15:05', 12, ''),
(115, 1, 4, '2013-05-27 08:17:10', 12, ''),
(116, 1, 4, '2013-05-27 08:29:43', 12, ''),
(117, 1, 4, '2013-05-27 08:39:10', 12, ''),
(118, 1, 4, '2013-05-27 08:41:39', 12, ''),
(119, 1, 2, '2013-05-27 08:45:18', 12, ''),
(120, 1, 4, '2013-05-27 08:48:30', 12, ''),
(121, 1, 2, '2013-05-27 08:52:26', 12, ''),
(122, 1, 4, '2013-05-27 08:53:45', 12, ''),
(123, 1, 4, '2013-05-27 09:20:13', 6, ''),
(124, 1, 4, '2013-05-27 09:22:42', 6, ''),
(125, 1, 4, '2013-05-27 09:24:52', 6, ''),
(126, 1, 4, '2013-05-27 09:28:09', 6, ''),
(127, 1, 2, '2013-05-27 09:31:46', 6, ''),
(128, 1, 3, '2013-05-27 09:45:45', 6, 'i neeeed me'),
(129, 1, 3, '2013-05-27 09:47:15', 6, 'chhhhhhhhhhhhhhhhhhaaaa'),
(130, 4, 3, '2013-05-28 01:23:05', 16, ''),
(131, 4, 3, '2013-05-28 01:48:24', 16, ''),
(132, 4, 3, '2013-05-28 02:08:13', 16, 'appprove require changes'),
(133, 5, 5, '2013-05-28 03:19:56', 16, ''),
(134, 7, 1, '2013-05-31 08:24:43', 10, '');

-- --------------------------------------------------------

--
-- Table structure for table `default_notification_types`
--

CREATE TABLE IF NOT EXISTS `default_notification_types` (
  `id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `relative_type` varchar(2) NOT NULL,
  `mail_template_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `default_notification_types`
--

INSERT INTO `default_notification_types` (`id`, `description`, `relative_type`, `mail_template_id`) VALUES
(1, 'Submitted for Approval', 'MR', 0),
(2, 'Hold', 'MR', 0),
(3, 'Require Changes', 'MR', 0),
(4, 'Approved', 'MR', 0),
(5, 'Force Approved', 'MR', 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_pages`
--

CREATE TABLE IF NOT EXISTS `default_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uri` text COLLATE utf8_unicode_ci,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `revision_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `layout_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `css` text COLLATE utf8_unicode_ci,
  `js` text COLLATE utf8_unicode_ci,
  `meta_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_keywords` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8_unicode_ci,
  `rss_enabled` int(1) NOT NULL DEFAULT '0',
  `comments_enabled` int(1) NOT NULL DEFAULT '0',
  `status` enum('draft','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  `restricted_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_home` int(1) NOT NULL DEFAULT '0',
  `strict_uri` tinyint(1) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `default_pages`
--

INSERT INTO `default_pages` (`id`, `slug`, `class`, `title`, `uri`, `parent_id`, `revision_id`, `layout_id`, `css`, `js`, `meta_title`, `meta_keywords`, `meta_description`, `rss_enabled`, `comments_enabled`, `status`, `created_on`, `updated_on`, `restricted_to`, `is_home`, `strict_uri`, `order`) VALUES
(1, 'home', '', 'Home', 'home', 0, '1', '1', NULL, NULL, NULL, NULL, NULL, 0, 0, 'live', 1354594249, 0, '', 1, 1, 1354594249),
(2, '404', '', 'Page missing', '404', 0, '1', '1', NULL, NULL, NULL, NULL, NULL, 0, 0, 'live', 1354594249, 0, '', 0, 1, 1354594249),
(3, 'contact', '', 'Contact', 'contact', 0, '1', '1', NULL, NULL, NULL, NULL, NULL, 0, 0, 'live', 1354594249, 0, '', 0, 1, 1354594249);

-- --------------------------------------------------------

--
-- Table structure for table `default_page_chunks`
--

CREATE TABLE IF NOT EXISTS `default_page_chunks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `page_id` int(11) NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `parsed` text COLLATE utf8_unicode_ci,
  `type` set('html','markdown','wysiwyg-advanced','wysiwyg-simple') COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `default_page_chunks`
--

INSERT INTO `default_page_chunks` (`id`, `slug`, `class`, `page_id`, `body`, `parsed`, `type`, `sort`) VALUES
(1, 'default', '', 1, '<p>Welcome to our homepage. We have not quite finished setting up our website yet, but please add us to your bookmarks and come back soon.</p>', '', 'wysiwyg-advanced', 1),
(2, 'default', '', 2, '<p>We cannot find the page you are looking for, please click <a title="Home" href="{{ pages:url id=''1'' }}">here</a> to go to the homepage.</p>', '', 'html', 1),
(3, 'default', '', 3, '<p>To contact us please fill out the form below.</p>\n					{{ contact:form name="text|required" email="text|required|valid_email" subject="dropdown|Support|Sales|Feedback|Other" message="textarea" attachment="file|zip" }}\n						<div><label for="name">Name:</label>{{ name }}</div>\n						<div><label for="email">Email:</label>{{ email }}</div>\n						<div><label for="subject">Subject:</label>{{ subject }}</div>\n						<div><label for="message">Message:</label>{{ message }}</div>\n						<div><label for="attachment">Attach  a zip file:</label>{{ attachment }}</div>\n					{{ /contact:form }}', '', 'html', 1);

-- --------------------------------------------------------

--
-- Table structure for table `default_page_layouts`
--

CREATE TABLE IF NOT EXISTS `default_page_layouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `css` text COLLATE utf8_unicode_ci,
  `js` text COLLATE utf8_unicode_ci,
  `theme_layout` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `updated_on` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `default_page_layouts`
--

INSERT INTO `default_page_layouts` (`id`, `title`, `body`, `css`, `js`, `theme_layout`, `updated_on`) VALUES
(1, 'Default', '<h2>{{ page:title }}</h2>\r\n{{ page:body }}', '', '', 'default', 1354594249);

-- --------------------------------------------------------

--
-- Table structure for table `default_permissions`
--

CREATE TABLE IF NOT EXISTS `default_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `roles` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=60 ;

--
-- Dumping data for table `default_permissions`
--

INSERT INTO `default_permissions` (`id`, `group_id`, `module`, `roles`) VALUES
(4, 2, 'inventory', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(5, 2, 'categories', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(6, 2, 'items', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(7, 2, 'locations', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(8, 2, 'purchases', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(12, 4, 'categories', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(13, 4, 'items', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(14, 4, 'navigation', NULL),
(15, 4, 'maintenance', NULL),
(16, 4, 'users', '{"admin_profile_fields":"1"}'),
(37, 11, 'divgroups', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(38, 11, 'groups', NULL),
(39, 11, 'categories', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(40, 11, 'items', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(41, 11, 'navigation', NULL),
(42, 11, 'materialrequest', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(43, 11, 'permissions', NULL),
(44, 11, 'purchases', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(45, 11, 'settings', NULL),
(46, 11, 'users', '{"admin_profile_fields":"1"}'),
(48, 6, 'materialrequest', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(49, 8, 'approvediv', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(54, 10, 'approvedivgroup', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(57, 13, 'special_approver', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(58, 14, 'product_assignment', '{"put_live":"1","edit_live":"1","delete_live":"1"}'),
(59, 5, 'canvass_items', '{"put_live":"1","edit_live":"1","delete_live":"1"}');

-- --------------------------------------------------------

--
-- Table structure for table `default_profiles`
--

CREATE TABLE IF NOT EXISTS `default_profiles` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `ordering_count` int(11) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `display_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `bio` text COLLATE utf8_unicode_ci,
  `dob` int(11) DEFAULT NULL,
  `gender` set('m','f','') COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_on` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

--
-- Dumping data for table `default_profiles`
--

INSERT INTO `default_profiles` (`id`, `created`, `updated`, `created_by`, `ordering_count`, `user_id`, `display_name`, `first_name`, `last_name`, `company`, `lang`, `bio`, `dob`, `gender`, `phone`, `mobile`, `address_line1`, `address_line2`, `address_line3`, `postcode`, `website`, `updated_on`) VALUES
(1, NULL, NULL, NULL, NULL, 1, 'System Administrator', 'System', 'Administrator', NULL, 'en', NULL, 0, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1369458954),
(2, '2012-12-04 07:33:04', NULL, 1, 1, 2, 'user', 'sample', 'user', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, '2013-01-25 10:29:19', NULL, 1, 2, 3, 'Juan Ekis ', 'juan', 'ekis', 'ekis group co', 'en', NULL, 1233615600, NULL, '9032187', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '2013-03-12 03:18:12', NULL, 1, 3, 4, 'Claire Laxamana', 'Claire', 'Laxamana', 'St. Francis Group of Companies', 'en', NULL, 569458800, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, '2013-03-12 03:20:24', NULL, 1, 4, 5, 'Jane Parubrub', 'Jane', 'Parubrub', 'St. Francis Square Holdings', 'en', NULL, 287017200, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, '2013-03-12 03:25:28', NULL, 1, 5, 6, 'Venice Soliven ', 'Venice', 'Soliven', 'St. Francis Square Group of Companies', 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, '2013-03-12 03:28:34', NULL, 1, 6, 7, 'Princess Riel', 'Princess', 'Riel', 'St. Francis Square', 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, '2013-03-12 06:48:57', NULL, 1, 7, 8, 'User Admin', 'Juan', 'Dela Cruz', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, '2013-03-12 17:36:30', NULL, 1, 8, 9, 'Red Alcantara', 'Red', 'Alcantara', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, '2013-03-12 17:37:57', NULL, 1, 9, 10, 'Helen Cruz', 'Helen', 'Cruz', NULL, 'en', 'Requisitonerer', -3600, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1369548151),
(11, '2013-03-12 17:39:09', NULL, 1, 10, 11, 'Jhasta Val', 'Jhasta', 'Val', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, '2013-03-12 17:48:45', NULL, 1, 11, 12, 'Julie Lim', 'Julie', 'Lim', NULL, 'en', NULL, -3600, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1369556426),
(13, '2013-03-12 17:49:41', NULL, 1, 12, 13, 'James Lim', 'James', 'Lim', NULL, 'en', NULL, -3600, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1369556520),
(14, '2013-03-12 17:50:42', NULL, 1, 13, 14, 'Joan Reyes', 'Joan', 'Reyes', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, '2013-03-20 07:23:06', NULL, 1, 14, 15, 'user division approver', 'sample', 'user', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, '2013-05-16 11:11:14', NULL, 1, 15, 16, 'Joie Cubid', 'Joie', 'Cubid', 'St Francis Holdings', 'en', 'I am joie. Yeah!', 1372975200, 'f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, '2013-05-25 09:33:18', NULL, 1, 16, 17, '2', '2', '2', '2', '2', '2', 0, 'f', '2', '2', '2', '2', '2', '2', '2', NULL),
(18, '2013-05-25 10:07:09', NULL, 1, 17, 18, '2', '2', '2', '2', '2', '2', 0, 'f', '2', '2', '2', '2', '2', '2', '2', NULL),
(28, '2013-05-26 08:31:27', NULL, 1, 18, 28, 'sdfgqsf', 'fds', 'sdf', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, '2013-05-31 13:19:59', NULL, 1, 19, 32, 'Dianne Bulfa', 'Diane', 'Bulfa', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, '2013-06-02 17:21:30', NULL, 1, 20, 33, 'Purchaser one', 'Purchaser', 'Purchaser Namw', 'SSSS', 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, '2013-06-02 17:25:36', NULL, 1, 21, 34, 'purchaser theree', 'purchadser', 'threee', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, '2013-06-02 19:33:52', NULL, 1, 22, 35, 'purchaser 2', 'purchaser 2', 'wewee', NULL, 'en', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `default_purchase_request`
--

CREATE TABLE IF NOT EXISTS `default_purchase_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mr_id` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `default_purchase_request`
--

INSERT INTO `default_purchase_request` (`id`, `mr_id`, `status`, `date_created`, `created_by`) VALUES
(1, 1, '2', '2013-05-30 16:00:00', ''),
(2, 6, '2', '2013-05-30 16:00:00', ''),
(3, 1, '2', '2013-05-31 11:13:54', '');

-- --------------------------------------------------------

--
-- Table structure for table `default_purchase_request_items`
--

CREATE TABLE IF NOT EXISTS `default_purchase_request_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pr_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `is_new` tinyint(1) NOT NULL,
  `canvassed_by` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `default_purchase_request_items`
--

INSERT INTO `default_purchase_request_items` (`id`, `pr_id`, `item_id`, `is_new`, `canvassed_by`) VALUES
(1, 1, 5, 0, '35'),
(2, 1, 9, 0, '33'),
(3, 2, 8, 0, ''),
(4, 1, 9, 0, ''),
(5, 2, 6, 0, ''),
(6, 2, 9, 0, ''),
(7, 1, 9, 0, ''),
(8, 2, 7, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `default_purchase_request_status`
--

CREATE TABLE IF NOT EXISTS `default_purchase_request_status` (
  `id` int(11) NOT NULL,
  `desc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `default_purchase_request_status`
--

INSERT INTO `default_purchase_request_status` (`id`, `desc`) VALUES
(1, 'Assigned'),
(2, 'Canvassed');

-- --------------------------------------------------------

--
-- Table structure for table `default_redirects`
--

CREATE TABLE IF NOT EXISTS `default_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `to` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(3) NOT NULL DEFAULT '302',
  PRIMARY KEY (`id`),
  KEY `from` (`from`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_sample`
--

CREATE TABLE IF NOT EXISTS `default_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_settings`
--

CREATE TABLE IF NOT EXISTS `default_settings` (
  `slug` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` set('text','textarea','password','select','select-multiple','radio','checkbox') COLLATE utf8_unicode_ci NOT NULL,
  `default` text COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_required` int(1) NOT NULL,
  `is_gui` int(1) NOT NULL,
  `module` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slug`),
  UNIQUE KEY `unique_slug` (`slug`),
  KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `default_settings`
--

INSERT INTO `default_settings` (`slug`, `title`, `description`, `type`, `default`, `value`, `options`, `is_required`, `is_gui`, `module`, `order`) VALUES
('activation_email', 'Activation Email', 'Send out an e-mail with an activation link when a user signs up. Disable this so that admins must manually activate each account.', 'radio', '1', '0', '1=Enabled|0=Disabled', 0, 1, 'users', 961),
('addons_upload', 'Addons Upload Permissions', 'Keeps mere admins from uploading addons by default', 'text', '0', '1', '', 1, 0, '', 0),
('admin_force_https', 'Force HTTPS for Control Panel?', 'Allow only the HTTPS protocol when using the Control Panel?', 'radio', '0', '', '1=Yes|0=No', 1, 1, '', 0),
('admin_theme', 'Control Panel Theme', 'Select the theme for the control panel.', '', '', 'pyrocms', 'func:get_themes', 1, 0, '', 0),
('akismet_api_key', 'Akismet API Key', 'Akismet is a spam-blocker from the WordPress team. It keeps spam under control without forcing users to get past human-checking CAPTCHA forms.', 'text', '', '', '', 0, 1, 'integration', 981),
('api_enabled', 'API Enabled', 'Allow API access to all modules which have an API controller.', 'select', '0', '0', '0=Disabled|1=Enabled', 0, 0, 'api', 0),
('api_user_keys', 'API User Keys', 'Allow users to sign up for API keys (if the API is Enabled).', 'select', '0', '0', '0=Disabled|1=Enabled', 0, 0, 'api', 0),
('auto_username', 'Auto Username', 'Create the username automatically, meaning users can skip making one on registration.', 'radio', '1', '', '1=Enabled|0=Disabled', 0, 1, 'users', 964),
('cdn_domain', 'CDN Domain', 'CDN domains allow you to offload static content to various edge servers, like Amazon CloudFront or MaxCDN.', 'text', '', '', '', 0, 1, 'integration', 1000),
('ckeditor_config', 'CKEditor Config', 'You can find a list of valid configuration items in <a target="_blank" href="http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html">CKEditor''s documentation.</a>', 'textarea', '', '{{# this is a wysiwyg-simple editor customized for the blog module (it allows images to be inserted) #}}\r\n$(''textarea.blog.wysiwyg-simple'').ckeditor({\r\n	toolbar: [\r\n		[''pyroimages''],\r\n		[''Bold'', ''Italic'', ''-'', ''NumberedList'', ''BulletedList'', ''-'', ''Link'', ''Unlink'']\r\n	  ],\r\n	extraPlugins: ''pyroimages'',\r\n	width: ''99%'',\r\n	height: 100,\r\n	dialog_backgroundCoverColor: ''#000'',\r\n	defaultLanguage: ''{{ helper:config item="default_language" }}'',\r\n	language: ''{{ global:current_language }}''\r\n});\r\n\r\n{{# this is the config for all wysiwyg-simple textareas #}}\r\n$(''textarea.wysiwyg-simple'').ckeditor({\r\n	toolbar: [\r\n		[''Bold'', ''Italic'', ''-'', ''NumberedList'', ''BulletedList'', ''-'', ''Link'', ''Unlink'']\r\n	  ],\r\n	width: ''99%'',\r\n	height: 100,\r\n	dialog_backgroundCoverColor: ''#000'',\r\n	defaultLanguage: ''{{ helper:config item="default_language" }}'',\r\n	language: ''{{ global:current_language }}''\r\n});\r\n\r\n{{# and this is the advanced editor #}}\r\n$(''textarea.wysiwyg-advanced'').ckeditor({\r\n	toolbar: [\r\n		[''Maximize''],\r\n		[''pyroimages'', ''pyrofiles''],\r\n		[''Cut'',''Copy'',''Paste'',''PasteFromWord''],\r\n		[''Undo'',''Redo'',''-'',''Find'',''Replace''],\r\n		[''Link'',''Unlink''],\r\n		[''Table'',''HorizontalRule'',''SpecialChar''],\r\n		[''Bold'',''Italic'',''StrikeThrough''],\r\n		[''JustifyLeft'',''JustifyCenter'',''JustifyRight'',''JustifyBlock'',''-'',''BidiLtr'',''BidiRtl''],\r\n		[''Format'', ''FontSize'', ''Subscript'',''Superscript'', ''NumberedList'',''BulletedList'',''Outdent'',''Indent'',''Blockquote''],\r\n		[''ShowBlocks'', ''RemoveFormat'', ''Source'']\r\n	],\r\n	extraPlugins: ''pyroimages,pyrofiles'',\r\n	width: ''99%'',\r\n	height: 400,\r\n	dialog_backgroundCoverColor: ''#000'',\r\n	removePlugins: ''elementspath'',\r\n	defaultLanguage: ''{{ helper:config item="default_language" }}'',\r\n	language: ''{{ global:current_language }}''\r\n});', '', 1, 1, 'wysiwyg', 993),
('comment_markdown', 'Allow Markdown', 'Do you want to allow visitors to post comments using Markdown?', 'select', '0', '0', '0=Text Only|1=Allow Markdown', 1, 1, 'comments', 965),
('comment_order', 'Comment Order', 'Sort order in which to display comments.', 'select', 'ASC', 'ASC', 'ASC=Oldest First|DESC=Newest First', 1, 1, 'comments', 966),
('contact_email', 'Contact E-mail', 'All e-mails from users, guests and the site will go to this e-mail address.', 'text', 'sfswebdev@gmail.com', 'sfs.webdevelopment@gmail.com', '', 1, 1, 'email', 979),
('currency', 'Currency', 'The currency symbol for use on products, services, etc.', 'text', '&pound;', '', '', 1, 1, '', 994),
('dashboard_rss', 'Dashboard RSS Feed', 'Link to an RSS feed that will be displayed on the dashboard.', 'text', 'https://www.pyrocms.com/blog/rss/all.rss', '', '', 0, 1, '', 990),
('dashboard_rss_count', 'Dashboard RSS Items', 'How many RSS items would you like to display on the dashboard?', 'text', '5', '5', '', 1, 1, '', 989),
('date_format', 'Date Format', 'How should dates be displayed across the website and control panel? Using the <a target=\\"_blank\\" href=\\"http://php.net/manual/en/function.date.php\\">date format</a> from PHP - OR - Using the format of <a target=\\"_blank\\" href=\\"http://php.net/manual/en/function.strftime.php\\">strings formatted as date</a> from PHP.', 'text', 'Y-m-d', '', '', 1, 1, '', 995),
('default_theme', 'Default Theme', 'Select the theme you want users to see by default.', '', 'default', 'default', 'func:get_themes', 1, 0, '', 0),
('enable_comments', 'Enable Comments', 'Enable comments.', 'radio', '1', '1', '1=Enabled|0=Disabled', 1, 1, 'comments', 968),
('enable_profiles', 'Enable profiles', 'Allow users to add and edit profiles.', 'radio', '1', '', '1=Enabled|0=Disabled', 1, 1, 'users', 963),
('enable_registration', 'Enable user registration', 'Allow users to register in your site.', 'radio', '1', '0', '1=Enabled|0=Disabled', 0, 1, 'users', 961),
('files_cache', 'Files Cache', 'When outputting an image via site.com/files what shall we set the cache expiration for?', 'select', '480', '480', '0=no-cache|1=1-minute|60=1-hour|180=3-hour|480=8-hour|1440=1-day|43200=30-days', 1, 1, 'files', 986),
('files_cf_api_key', 'Rackspace Cloud Files API Key', 'You also must provide your Cloud Files API Key. You will find it at the same location as your Username in your Rackspace account.', 'text', '', '', '', 0, 1, 'files', 989),
('files_cf_username', 'Rackspace Cloud Files Username', 'To enable cloud file storage in your Rackspace Cloud Files account please enter your Cloud Files Username. <a href=\\"https://manage.rackspacecloud.com/APIAccess.do\\">Find your credentials</a>', 'text', '', '', '', 0, 1, 'files', 990),
('files_enabled_providers', 'Enabled File Storage Providers', 'Which file storage providers do you want to enable? (If you enable a cloud provider you must provide valid auth keys below', 'checkbox', '0', '0', 'amazon-s3=Amazon S3|rackspace-cf=Rackspace Cloud Files', 0, 1, 'files', 994),
('files_s3_access_key', 'Amazon S3 Access Key', 'To enable cloud file storage in your Amazon S3 account provide your Access Key. <a href=\\"https://aws-portal.amazon.com/gp/aws/securityCredentials#access_credentials\\">Find your credentials</a>', 'text', '', '', '', 0, 1, 'files', 993),
('files_s3_geographic_location', 'Amazon S3 Geographic Location', 'Either US or EU. If you change this you must also change the S3 URL.', 'radio', 'US', 'US', 'US=United States|EU=Europe', 1, 1, 'files', 991),
('files_s3_secret_key', 'Amazon S3 Secret Key', 'You also must provide your Amazon S3 Secret Key. You will find it at the same location as your Access Key in your Amazon account.', 'text', '', '', '', 0, 1, 'files', 992),
('files_s3_url', 'Amazon S3 URL', 'Change this if using one of Amazon''s EU locations or a custom domain.', 'text', 'http://{{ bucket }}.s3.amazonaws.com/', 'http://{{ bucket }}.s3.amazonaws.com/', '', 0, 1, 'files', 991),
('files_upload_limit', 'Filesize Limit', 'Maximum filesize to allow when uploading. Specify the size in MB. Example: 5', 'text', '5', '5', '', 1, 1, 'files', 987),
('frontend_enabled', 'Site Status', 'Use this option to the user-facing part of the site on or off. Useful when you want to take the site down for maintenance.', 'radio', '1', '1', '1=Open|0=Closed', 1, 1, '', 988),
('ga_email', 'Google Analytic E-mail', 'E-mail address used for Google Analytics, we need this to show the graph on the dashboard.', 'text', '', '', '', 0, 1, 'integration', 983),
('ga_password', 'Google Analytic Password', 'This is also needed this to show the graph on the dashboard.', 'password', '', '', '', 0, 1, 'integration', 982),
('ga_profile', 'Google Analytic Profile ID', 'Profile ID for this website in Google Analytics', 'text', '', '', '', 0, 1, 'integration', 984),
('ga_tracking', 'Google Tracking Code', 'Enter your Google Analytic Tracking Code to activate Google Analytics view data capturing. E.g: UA-19483569-6', 'text', '', '', '', 0, 1, 'integration', 985),
('mail_protocol', 'Mail Protocol', 'Select desired email protocol.', 'select', 'mail', 'smtp', 'mail=Mail|sendmail=Sendmail|smtp=SMTP', 1, 1, 'email', 977),
('mail_sendmail_path', 'Sendmail Path', 'Path to server sendmail binary.', 'text', '', '', '', 0, 1, 'email', 972),
('mail_smtp_host', 'SMTP Host Name', 'The host name of your smtp server.', 'text', '', 'ssl://smtp.googlemail.com', '', 0, 1, 'email', 976),
('mail_smtp_pass', 'SMTP password', 'SMTP password.', 'password', '', 'sfswebdev', '', 0, 1, 'email', 975),
('mail_smtp_port', 'SMTP Port', 'SMTP port number.', 'text', '', '465', '', 0, 1, 'email', 974),
('mail_smtp_user', 'SMTP User Name', 'SMTP user name.', 'text', '', 'sfs.webdevelopment@gmail.com', '', 0, 1, 'email', 973),
('meta_topic', 'Meta Topic', 'Two or three words describing this type of company/website.', 'text', 'Content Management', 'Add your slogan here', '', 0, 1, '', 998),
('moderate_comments', 'Moderate Comments', 'Force comments to be approved before they appear on the site.', 'radio', '1', '1', '1=Enabled|0=Disabled', 1, 1, 'comments', 967),
('records_per_page', 'Records Per Page', 'How many records should we show per page in the admin section?', 'select', '25', '10', '10=10|25=25|50=50|100=100', 1, 1, '', 992),
('registered_email', 'User Registered Email', 'Send a notification email to the contact e-mail when someone registers.', 'radio', '1', '', '1=Enabled|0=Disabled', 0, 1, 'users', 962),
('require_lastname', 'Require last names?', 'For some situations, a last name may not be required. Do you want to force users to enter one or not?', 'radio', '1', '', '1=Required|0=Optional', 1, 1, 'users', 962),
('rss_feed_items', 'Feed item count', 'How many items should we show in RSS/blog feeds?', 'select', '25', '10', '10=10|25=25|50=50|100=100', 1, 1, '', 991),
('sample_setting', 'Sample Setting', 'A Yes or No option for the Sample module', 'select', '1', '0', '1=Yes|0=No', 1, 1, 'sample', 0),
('server_email', 'Server E-mail', 'All e-mails to users will come from this e-mail address.', 'text', 'admin@localhost', 'sfs.webdevelopment@gmail.com', '', 1, 1, 'email', 978),
('site_lang', 'Site Language', 'The native language of the website, used to choose templates of e-mail notifications, contact form, and other features that should not depend on the language of a user.', 'select', 'en', 'en', 'func:get_supported_lang', 1, 1, '', 997),
('site_name', 'Site Name', 'The name of the website for page titles and for use around the site.', 'text', 'Un-named Website', 'SFS Logistics', '', 1, 1, '', 1000),
('site_public_lang', 'Public Languages', 'Which are the languages really supported and offered on the front-end of your website?', 'checkbox', 'en', 'en', 'func:get_supported_lang', 1, 1, '', 996),
('site_slogan', 'Site Slogan', 'The slogan of the website for page titles and for use around the site', 'text', '', 'St. Francis Square Group of Companies', '', 0, 1, '', 999),
('twitter_cache', 'Cache time', 'How many minutes should your Tweets be stored?', 'text', '300', '', '', 0, 1, 'twitter', 969),
('twitter_feed_count', 'Feed Count', 'How many tweets should be returned to the Twitter feed block?', 'text', '5', '', '', 0, 1, 'twitter', 970),
('twitter_username', 'Username', 'Twitter username.', 'text', '', '', '', 0, 1, 'twitter', 971),
('unavailable_message', 'Unavailable Message', 'When the site is turned off or there is a major problem, this message will show to users.', 'textarea', 'Sorry, this website is currently unavailable.', '', '', 0, 1, '', 987);

-- --------------------------------------------------------

--
-- Table structure for table `default_stockcategory`
--

CREATE TABLE IF NOT EXISTS `default_stockcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` char(50) NOT NULL DEFAULT '',
  `is_stocking` int(1) NOT NULL DEFAULT '1',
  `description` varchar(100) NOT NULL DEFAULT 'Not available',
  `category_code` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CategoryDescription` (`cat_name`),
  KEY `StockType` (`is_stocking`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `default_stockcategory`
--

INSERT INTO `default_stockcategory` (`id`, `cat_name`, `is_stocking`, `description`, `category_code`) VALUES
(6, 'Office Furnitures and Fixtures', 1, 'Tables, chairs', 'OFF'),
(7, 'Computer &amp; Accessories', 1, 'Computer hardware', 'COM'),
(8, 'Marketing', 0, 'Flyers, Stickers', 'MKG'),
(9, 'Building Equipment', 1, 'Equipments', 'BES'),
(10, 'Transportation', 1, 'Vehicles', 'TRA'),
(16, 'sample', 1, 'sample lang', 'SAM');

-- --------------------------------------------------------

--
-- Table structure for table `default_stocklocation`
--

CREATE TABLE IF NOT EXISTS `default_stocklocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `abbrev` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `location_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_add1` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_add2` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT ' ',
  `tel` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contact_person` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `inventory_manager` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `abbrev` (`delivery_add1`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `default_stocklocation`
--

INSERT INTO `default_stocklocation` (`id`, `title`, `abbrev`, `location_name`, `delivery_add1`, `delivery_add2`, `tel`, `contact_person`, `inventory_manager`) VALUES
(1, '', '', 'Warehouse 1', 'warehouse1', ' ', '', '', 0),
(2, '', '', 'Warehouse 2', 'warehouse2', ' ', '', '', 0),
(3, '', '', 'Warehouse 3', 'warehouse3', ' ', '', '', 0),
(8, '', '', 'Warehouse Boom', 'WB', '099 Pinya St. Malate, Manila', '4566543', '4566543', 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_stocklocation_storage`
--

CREATE TABLE IF NOT EXISTS `default_stocklocation_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `parent` int(11) DEFAULT NULL,
  `link_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'uri',
  `page_id` int(11) DEFAULT NULL,
  `module_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `stocklocation_id` int(5) NOT NULL DEFAULT '0',
  `position` int(5) NOT NULL DEFAULT '0',
  `target` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `restricted_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `navigation_group_id` (`stocklocation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `default_stocklocation_storage`
--

INSERT INTO `default_stocklocation_storage` (`id`, `name`, `parent`, `link_type`, `page_id`, `module_name`, `url`, `uri`, `stocklocation_id`, `position`, `target`, `restricted_to`, `class`) VALUES
(1, 'Section A', 0, 'page', 1, '', '', '', 1, 0, '', '0', ''),
(2, 'Section B', 0, 'module', 0, 'blog', '', '', 1, 1, '', '0', ''),
(3, 'Section C', 0, 'page', 3, '', '', '', 1, 2, '', '0', ''),
(4, 'Row 1', 1, 'page', 1, '', '', '', 1, 0, '', '0', ''),
(5, 'Section E', NULL, 'page', 1, '', '', '', 2, 1, '', '0', '');

-- --------------------------------------------------------

--
-- Table structure for table `default_stockmaster`
--

CREATE TABLE IF NOT EXISTS `default_stockmaster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `category_id` varchar(6) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `long_description` varchar(500) NOT NULL,
  `unit` varchar(20) NOT NULL DEFAULT 'each',
  `actual_cost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `last_cost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lowest_level` smallint(6) NOT NULL DEFAULT '0',
  `discontinued` tinyint(4) NOT NULL DEFAULT '0',
  `controlled` tinyint(4) NOT NULL DEFAULT '0',
  `volume` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `weight` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `barcode` varchar(50) NOT NULL DEFAULT '',
  `barcode_alpha` varchar(6) NOT NULL,
  `barcode_num` int(5) NOT NULL,
  `last_barcode` varchar(15) DEFAULT NULL,
  `is_serialized` tinyint(1) NOT NULL DEFAULT '0',
  `decimal_places` tinyint(4) NOT NULL DEFAULT '0',
  `shrink_factor` double NOT NULL DEFAULT '0',
  `next_serial_no` bigint(20) NOT NULL DEFAULT '0',
  `net_weight` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `last_cost_update` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`),
  KEY `CategoryID` (`category_id`),
  KEY `Description` (`description`),
  KEY `StockID` (`stockid`,`category_id`),
  KEY `Controlled` (`controlled`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `default_stockmaster`
--

INSERT INTO `default_stockmaster` (`id`, `stockid`, `category_id`, `description`, `long_description`, `unit`, `actual_cost`, `last_cost`, `lowest_level`, `discontinued`, `controlled`, `volume`, `weight`, `barcode`, `barcode_alpha`, `barcode_num`, `last_barcode`, `is_serialized`, `decimal_places`, `shrink_factor`, `next_serial_no`, `net_weight`, `last_cost_update`) VALUES
(1, 'ABC123', '8', 'sample new item ', 'sample item', 'kgs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 2.0000, 'MKG1', '', 0, '', 0, 0, 0, 0, 0.0000, '2012-11-13'),
(2, 'BIGEARS12', '8', 'Big Ears and Noddy episodes on DVD', 'Big Ears and Noddy episodes on DVD', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG2', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(3, 'BirthdayCakeConstruc', '8', '12 foot birthday cake for wrestling tournament', '12 foot birthday cake for wrestling tournament', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG3', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(4, 'BREAD', '8', 'Bread', 'Bread', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG4', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(5, 'DR_TUMMY', '8', 'Gastric exquisite diarrhea', 'Gastric exquisite diarrhea', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG5', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(6, 'DVD-CASE', '8', 'webERP Demo DVD Case', 'webERP Demo DVD Case', 'each', 0.0000, 0.0000, 0, 1, 0, 0.0000, 0.0000, 'MKG6', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(7, 'DVD-DHWV', '8', 'Die Hard With A Vengeance Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa). &lt;br /&gt;Languages: English, Deutsch. &lt;br /&gt;Subtitles: English, Deutsch, Spanish. &lt;br /&gt;Audio: Dolby Surround 5.1. &lt;br /&gt;Picture Format: 16:9 Wide-Screen. &lt;br /&gt;Length: (approx) 122 minutes. &lt;br /&gt;Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 7.0000, 'MKG7', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(8, 'DVD-LTWP', '8', 'Lethal Weapon Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n<br />\r\nLanguages: English, Deutsch.\r\n<br />\r\nSubtitles: English, Deutsch, Spanish.\r\n<br />\r\nAudio: Dolby Surround 5.1.\r\n<br />\r\nPicture Format: 16:9 Wide-Screen.\r\n<br />\r\nLength: (approx) 100 minutes.\r\n<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 7.0000, 'MKG8', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(9, 'DVD-TOPGUN', '8', 'Top Gun DVD', 'Top Gun DVD', 'each', 0.0000, 0.0000, 0, 0, 1, 0.0000, 0.0000, 'MKG9', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(10, 'DVD-UNSG', '16', 'Under Siege Linked', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa). <br />Languages: English, Deutsch. <br />Subtitles: English, Deutsch, Spanish. <br />Audio: Dolby Surround 5.1. <br />Picture Format: 16:9 Wide-Screen. <br />Length: (approx) 98 minutes. <br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 7.0000, 'MKG10', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(11, 'DVD-UNSG2', '8', 'Under Siege 2 - Dark Territory', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r<br />\nLanguages: English, Deutsch.\r<br />\nSubtitles: English, Deutsch, Spanish.\r<br />\nAudio: Dolby Surround 5.1.\r<br />\nPicture Format: 16:9 Wide-Screen.\r<br />\nLength: (approx) 98 minutes.\r<br />\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 7.0000, 'MKG11', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(12, 'DVD_ACTION', '8', 'Action Series Bundle', 'Under Seige I and Under Seige II\r\n', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG12', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(13, 'FLOUR', '7', 'High Grade Flour', 'High Grade Flour', 'kgs', 0.0000, 0.0000, 0, 0, 1, 0.0000, 0.0000, 'COM3', '', 0, '', 0, 1, 0, 0, 0.0000, '0000-00-00'),
(14, 'FREIGHT', '8', 'Freight', 'Freight', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG13', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(15, 'FROAYLANDO', '10', 'Fried Orange Yoke Flan D''Or', 'Fried Orange Yoke Flan D''Or', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'TRA1', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(16, 'FUJI990101', '9', 'Fujitsu 990101 Split type Indoor Unit 3.5kw', 'Fujitsu 990101 Split type Indoor Unit 3.5kw Heat Pump with mounting screws and isolating switch', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'BES1', '', 0, '', 0, 4, 0, 0, 0.0000, '0000-00-00'),
(17, 'FUJI990102', '10', 'Fujitsu 990102 split type A/C Outdoor unit 3.5kw', 'Fujitsu 990102 split type A/C Outdoor unit 3.5kw with 5m piping & insulation', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'TRA2', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(18, 'FUJI9901ASS', '16', 'Fujitsu 990101 Split type A/C 3.5kw complete', 'Fujitsu 990101 Split type A/C 3.5kw complete with indoor and outdoor units 5m pipe and insulation isolating switch. 5 year warranty', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'SAM1', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(19, 'HIT3042-4', '10', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor Unit - wall hung complete with brackets and screws. 220V-240V AC\r\n5 year guaranttee', 'each', 0.0000, 0.0000, 0, 0, 1, 0.4000, 7.8000, 'TRA3', '', 0, '', 1, 0, 0, 0, 0.0000, '0000-00-00'),
(20, 'HIT3043-5', '9', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor', 'Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor unit - including 5m piping for fitting to HIT3042-4 indoor unit\r\n5 year guaranttee', 'each', 0.0000, 0.0000, 0, 0, 1, 0.8500, 16.0000, 'BES2', '', 0, '', 1, 0, 0, 0, 0.0000, '0000-00-00'),
(21, 'SALT', '7', 'Salt', 'Salt', 'kgs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'COM4', '', 0, '', 0, 3, 0, 0, 0.0000, '0000-00-00'),
(22, 'SLICE', '16', 'Slice Of Bread', 'Slice Of Bread', 'each', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'SAM2', '', 0, '', 0, 0, 0, 0, 0.0000, '0000-00-00'),
(23, 'YEAST', '9', 'Yeast', 'Yeast', 'kgs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'BES3', '', 0, '', 0, 3, 0, 0, 0.0000, '0000-00-00'),
(29, '', '8', 'sample', 'sample lanf ito chos', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'MKG1', 'MKG', 1, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(30, '', '7', 'Asahi Aircon', 'Asahi Aircon 2.9HP', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'COM1', 'COM', 1, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(31, '', '6', 'Asahi Aircon', 'Asahi Aircon', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'OFF1', 'OFF', 1, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(32, '', '6', 'HBW Sticky note', 'HBW Sticky note 4x4', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'OFF2', 'OFF', 2, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(33, '', '7', 'HBW Sticky note', 'HBW Sticky note pink', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'COM2', 'COM', 2, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(34, '', '6', 'A4 Tech Keyboard', 'A4 Tech Keyboard', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'OFF3', 'OFF', 3, NULL, 1, 0, 0, 0, 0.0000, '0000-00-00'),
(35, '', '6', 'Adobe Photoshop cs2', 'Adobe Photoshop licensed', 'pcs', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'OFF4', 'OFF', 4, NULL, 2, 0, 0, 0, 0.0000, '0000-00-00'),
(36, '', '6', 'Lips Lollipop', 'Lips Lollipop Blue', 'kg', 0.0000, 0.0000, 0, 0, 0, 0.0000, 0.0000, 'OFF5', 'OFF', 5, NULL, 2, 0, 0, 0, 0.0000, '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `default_stock_adjustments`
--

CREATE TABLE IF NOT EXISTS `default_stock_adjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `transaction_no` int(11) NOT NULL,
  `location` int(11) NOT NULL,
  `price` decimal(20,4) NOT NULL,
  `reference` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `newqoh` int(11) NOT NULL,
  `hide` int(1) NOT NULL,
  `narrative` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_stock_on_location`
--

CREATE TABLE IF NOT EXISTS `default_stock_on_location` (
  `location_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `default_stock_on_location`
--

INSERT INTO `default_stock_on_location` (`location_id`, `stock_id`, `quantity`) VALUES
(3, 1, 45);

-- --------------------------------------------------------

--
-- Table structure for table `default_stock_serialized_item`
--

CREATE TABLE IF NOT EXISTS `default_stock_serialized_item` (
  `stock_id` int(11) NOT NULL,
  `loc_id` int(11) NOT NULL,
  `serial_no` varchar(40) NOT NULL,
  `expiration_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `quantity` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `default_theme_options`
--

CREATE TABLE IF NOT EXISTS `default_theme_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` set('text','textarea','password','select','select-multiple','radio','checkbox') COLLATE utf8_unicode_ci NOT NULL,
  `default` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_required` int(1) NOT NULL,
  `theme` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `default_theme_options`
--

INSERT INTO `default_theme_options` (`id`, `slug`, `title`, `description`, `type`, `default`, `value`, `options`, `is_required`, `theme`) VALUES
(1, 'pyrocms_recent_comments', 'Recent Comments', 'Would you like to display recent comments on the dashboard?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'pyrocms'),
(2, 'pyrocms_news_feed', 'News Feed', 'Would you like to display the news feed on the dashboard?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'pyrocms'),
(3, 'pyrocms_quick_links', 'Quick Links', 'Would you like to display quick links on the dashboard?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'pyrocms'),
(4, 'pyrocms_analytics_graph', 'Analytics Graph', 'Would you like to display the graph on the dashboard?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'pyrocms'),
(5, 'show_breadcrumbs', 'Show Breadcrumbs', 'Would you like to display breadcrumbs?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'default'),
(6, 'layout', 'Layout', 'Which type of layout shall we use?', 'select', '2 column', '2 column', '2 column=Two Column|full-width=Full Width|full-width-home=Full Width Home Page', 1, 'default'),
(7, 'cufon_enabled', 'Use Cufon', 'Would you like to use Cufon for titles?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'default'),
(8, 'background', 'Background', 'Choose the default background for the theme.', 'select', 'fabric', 'fabric', 'black=Black|fabric=Fabric|graph=Graph|leather=Leather|noise=Noise|texture=Texture', 1, 'base'),
(9, 'slider', 'Slider', 'Would you like to display the slider on the homepage?', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'base'),
(10, 'color', 'Default Theme Color', 'This changes things like background color, link colors etc…', 'select', 'pink', 'pink', 'red=Red|orange=Orange|yellow=Yellow|green=Green|blue=Blue|pink=Pink', 1, 'base'),
(11, 'show_breadcrumbs', 'Do you want to show breadcrumbs?', 'If selected it shows a string of breadcrumbs at the top of the page.', 'radio', 'yes', 'yes', 'yes=Yes|no=No', 1, 'base');

-- --------------------------------------------------------

--
-- Table structure for table `default_unit_of_measure`
--

CREATE TABLE IF NOT EXISTS `default_unit_of_measure` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(20) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `default_unit_of_measure`
--

INSERT INTO `default_unit_of_measure` (`id`, `unit_name`, `deleted`) VALUES
(1, 'pcs', 0),
(2, 'kg', 0),
(3, 'liter', 0),
(4, 'meter', 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_users`
--

CREATE TABLE IF NOT EXISTS `default_users` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `group_id` int(11) DEFAULT NULL,
  `ip_address` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `activation_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_on` int(11) NOT NULL,
  `last_login` int(11) NOT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `forgotten_password_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_notification` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Registered User Information' AUTO_INCREMENT=36 ;

--
-- Dumping data for table `default_users`
--

INSERT INTO `default_users` (`id`, `email`, `password`, `salt`, `group_id`, `ip_address`, `active`, `activation_code`, `created_on`, `last_login`, `username`, `forgotten_password_code`, `remember_code`, `allow_notification`) VALUES
(1, 'sfswebdev@gmail.com', '0a20eb795bf71b411eb25e7d908e99be3b7bf942', 'ce047', 1, '', 1, '', 1354594245, 1370136176, 'SYS_ADMIN', NULL, NULL, NULL),
(2, 'user@example.com', 'a236c78ec9a8adc73c4cc9dd2c424499b0f33a95', '71a57d', 2, '0.0.0.0', 1, NULL, 1354599184, 1354606251, 'user', NULL, NULL, NULL),
(3, 'juan@gmail.com', 'c4d995c9cac5e7b5e90681993bb91bbbfca251e5', '37d586', 4, '0.0.0.0', 1, NULL, 1359102559, 1359102583, 'juanEkis', NULL, NULL, NULL),
(4, 'claire@example.com', 'a1257fa8f3c9e3b4b13f06dff163f02d7d4a7867', '9b42bd', 10, '0.0.0.0', 1, NULL, 1363051092, 1368678734, 'claire_laxamana', NULL, NULL, NULL),
(5, 'jane@example.com', '1aeced92b0d1cf97d1667c3e14f85da3939ea65c', '6f70cc', 10, '0.0.0.0', 1, NULL, 1363051223, 1367882683, 'jane_parubrub', NULL, NULL, NULL),
(6, 'veztsol@gmail.com', 'a855dddd00cba527efe164ace210980e2466dcec', '1b1e02', 10, '0.0.0.0', 1, NULL, 1363051528, 1369721776, 'venice_soliven', NULL, NULL, 1),
(7, 'princess@example.com', '12b76ce10f10074fa2cc127aa1a3c45a253aab84', '911194', 10, '0.0.0.0', 1, NULL, 1363051714, 1368678365, 'princess_riel', NULL, NULL, NULL),
(8, 'admin@example.com', 'cee0fa681f0712489a3c089881898e6ee7c2c614', '1919af', 11, '0.0.0.0', 1, NULL, 1363063737, 1367887522, 'admin_user', NULL, NULL, NULL),
(9, 'red@example.com', 'a8445afd422a1a49ce54c18d165f03a723b3e510', '06e5c3', 6, '0.0.0.0', 1, NULL, 1363102590, 1363253186, 'red_alcantara', NULL, NULL, NULL),
(10, 'veztsol@yahoo.com', '550e2a40b37161893546ea00adc125b23989751b', 'f4434a', 6, '0.0.0.0', 1, NULL, 1363102677, 1369959482, 'helen-cruz', NULL, NULL, 1),
(11, 'jhasta@example.com', '988b0a0585829c84cec91e916c224884b11ac2f9', 'a076b1', 6, '0.0.0.0', 1, NULL, 1363102749, 1367125595, 'jhasta_val', NULL, NULL, NULL),
(12, 'webdev.onbusiness@gmail.com', 'c425b935537015aef5be1393790d224ce4839985', '97c1e6', 8, '0.0.0.0', 1, NULL, 1363103325, 1369968547, 'julie_lim', NULL, NULL, 1),
(13, 'veztsol@gmail.com', 'e9f1950409ef20dad501916f0eeacd705f064d64', '3bb2f5', 8, '0.0.0.0', 1, NULL, 1363103380, 1369631527, 'james_lee', NULL, NULL, 1),
(14, 'joan@example.com', '1c626afe61307f6ed82f7b60ab5c7dca8727e6d4', '37bf5c', 8, '0.0.0.0', 1, NULL, 1363103442, 1363103442, 'joan_reyes', NULL, NULL, NULL),
(15, 'divapp@example.com', '16bee2fb629cd4eb35271f78a056a4a08e8623fc', 'd51536', 8, '0.0.0.0', 1, NULL, 1363756986, 1363757946, 'user_divapp', NULL, NULL, NULL),
(16, 'venice.soliven@stfrancissquare.com.ph', '8119f9cb802b98cd11db0720bd9c735834d06304', '2620a3', 13, '127.0.0.1', 1, NULL, 1368688274, 1370196576, 'special_app', NULL, NULL, 1),
(32, 'veez@gmail.com', '5cb2bd70da67d140ec5f24c1bb8738995ab4e1cf', '4a69cf', 14, '0.0.0.0', 1, NULL, 1369948799, 1370196603, 'diane_bulfa', NULL, '8fde0ed0b4300b6a11096e949e1aceb24a091b0a', 1),
(33, 'purchaser1@sdsd.com', 'b44cfe4f0c4071e4f88dbc0531e00ce32364c201', '3b15b8', 5, '0.0.0.0', 1, NULL, 1370136090, 1370196539, 'purchaser_one', NULL, NULL, 0),
(34, 'purchaser3@example.com', '64dd6b6424ed5795d73c7a51d6b6491e8d6c2b2e', '453104', 5, '0.0.0.0', 1, NULL, 1370136336, 1370136336, 'purchaser_three', NULL, NULL, 1),
(35, 'purchaser2@example.com', 'f3be1f0c16dc2a77300079b8f4ec2126d23dd16e', '969f0c', 5, '0.0.0.0', 1, NULL, 1370144032, 1370144032, 'purchaser2', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `default_variables`
--

CREATE TABLE IF NOT EXISTS `default_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `default_widgets`
--

CREATE TABLE IF NOT EXISTS `default_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `version` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1',
  `order` int(10) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `default_widgets`
--

INSERT INTO `default_widgets` (`id`, `slug`, `title`, `description`, `author`, `website`, `version`, `enabled`, `order`, `updated_on`) VALUES
(1, 'google_maps', 'a:8:{s:2:"en";s:11:"Google Maps";s:2:"el";s:19:"Χάρτης Google";s:2:"nl";s:11:"Google Maps";s:2:"br";s:11:"Google Maps";s:2:"pt";s:11:"Google Maps";s:2:"ru";s:17:"Карты Google";s:2:"id";s:11:"Google Maps";s:2:"fi";s:11:"Google Maps";}', 'a:8:{s:2:"en";s:32:"Display Google Maps on your site";s:2:"el";s:78:"Προβάλετε έναν Χάρτη Google στον ιστότοπό σας";s:2:"nl";s:27:"Toon Google Maps in uw site";s:2:"br";s:34:"Mostra mapas do Google no seu site";s:2:"pt";s:34:"Mostra mapas do Google no seu site";s:2:"ru";s:80:"Выводит карты Google на страницах вашего сайта";s:2:"id";s:37:"Menampilkan Google Maps di Situs Anda";s:2:"fi";s:39:"Näytä Google Maps kartta sivustollasi";}', 'Gregory Athons', 'http://www.gregathons.com', '1.0', 1, 1, 1354605422),
(2, 'html', 's:4:"HTML";', 'a:8:{s:2:"en";s:28:"Create blocks of custom HTML";s:2:"el";s:80:"Δημιουργήστε περιοχές με δικό σας κώδικα HTML";s:2:"br";s:41:"Permite criar blocos de HTML customizados";s:2:"pt";s:41:"Permite criar blocos de HTML customizados";s:2:"nl";s:30:"Maak blokken met maatwerk HTML";s:2:"ru";s:83:"Создание HTML-блоков с произвольным содержимым";s:2:"id";s:24:"Membuat blok HTML apapun";s:2:"fi";s:32:"Luo lohkoja omasta HTML koodista";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.0', 1, 2, 1354605422),
(3, 'login', 'a:8:{s:2:"en";s:5:"Login";s:2:"el";s:14:"Σύνδεση";s:2:"nl";s:5:"Login";s:2:"br";s:5:"Login";s:2:"pt";s:5:"Login";s:2:"ru";s:22:"Вход на сайт";s:2:"id";s:5:"Login";s:2:"fi";s:13:"Kirjautuminen";}', 'a:8:{s:2:"en";s:36:"Display a simple login form anywhere";s:2:"el";s:96:"Προβάλετε μια απλή φόρμα σύνδεσης χρήστη οπουδήποτε";s:2:"br";s:69:"Permite colocar um formulário de login em qualquer lugar do seu site";s:2:"pt";s:69:"Permite colocar um formulário de login em qualquer lugar do seu site";s:2:"nl";s:32:"Toon overal een simpele loginbox";s:2:"ru";s:72:"Выводит простую форму для входа на сайт";s:2:"id";s:32:"Menampilkan form login sederhana";s:2:"fi";s:52:"Näytä yksinkertainen kirjautumislomake missä vain";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.0', 1, 3, 1354605422),
(4, 'navigation', 'a:8:{s:2:"en";s:10:"Navigation";s:2:"el";s:16:"Πλοήγηση";s:2:"nl";s:9:"Navigatie";s:2:"br";s:11:"Navegação";s:2:"pt";s:11:"Navegação";s:2:"ru";s:18:"Навигация";s:2:"id";s:8:"Navigasi";s:2:"fi";s:10:"Navigaatio";}', 'a:8:{s:2:"en";s:40:"Display a navigation group with a widget";s:2:"el";s:100:"Προβάλετε μια ομάδα στοιχείων πλοήγησης στον ιστότοπο";s:2:"nl";s:38:"Toon een navigatiegroep met een widget";s:2:"br";s:62:"Exibe um grupo de links de navegação como widget em seu site";s:2:"pt";s:62:"Exibe um grupo de links de navegação como widget no seu site";s:2:"ru";s:88:"Отображает навигационную группу внутри виджета";s:2:"id";s:44:"Menampilkan grup navigasi menggunakan widget";s:2:"fi";s:37:"Näytä widgetillä navigaatio ryhmä";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.2', 1, 4, 1354605422),
(5, 'rss_feed', 'a:8:{s:2:"en";s:8:"RSS Feed";s:2:"el";s:24:"Τροφοδοσία RSS";s:2:"nl";s:8:"RSS Feed";s:2:"br";s:8:"Feed RSS";s:2:"pt";s:8:"Feed RSS";s:2:"ru";s:31:"Лента новостей RSS";s:2:"id";s:8:"RSS Feed";s:2:"fi";s:10:"RSS Syöte";}', 'a:8:{s:2:"en";s:41:"Display parsed RSS feeds on your websites";s:2:"el";s:82:"Προβάλετε τα περιεχόμενα μιας τροφοδοσίας RSS";s:2:"nl";s:28:"Toon RSS feeds op uw website";s:2:"br";s:48:"Interpreta e exibe qualquer feed RSS no seu site";s:2:"pt";s:48:"Interpreta e exibe qualquer feed RSS no seu site";s:2:"ru";s:94:"Выводит обработанную ленту новостей на вашем сайте";s:2:"id";s:42:"Menampilkan kutipan RSS feed di situs Anda";s:2:"fi";s:39:"Näytä purettu RSS syöte sivustollasi";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.2', 1, 5, 1354605422),
(6, 'social_bookmark', 'a:8:{s:2:"en";s:15:"Social Bookmark";s:2:"el";s:35:"Κοινωνική δικτύωση";s:2:"nl";s:19:"Sociale Bladwijzers";s:2:"br";s:15:"Social Bookmark";s:2:"pt";s:15:"Social Bookmark";s:2:"ru";s:37:"Социальные закладки";s:2:"id";s:15:"Social Bookmark";s:2:"fi";s:24:"Sosiaalinen kirjanmerkki";}', 'a:8:{s:2:"en";s:47:"Configurable social bookmark links from AddThis";s:2:"el";s:111:"Παραμετροποιήσιμα στοιχεία κοινωνικής δικτυώσης από το AddThis";s:2:"nl";s:43:"Voeg sociale bladwijzers toe vanuit AddThis";s:2:"br";s:87:"Adiciona links de redes sociais usando o AddThis, podendo fazer algumas configurações";s:2:"pt";s:87:"Adiciona links de redes sociais usando o AddThis, podendo fazer algumas configurações";s:2:"ru";s:90:"Конфигурируемые социальные закладки с сайта AddThis";s:2:"id";s:60:"Tautan social bookmark yang dapat dikonfigurasi dari AddThis";s:2:"fi";s:59:"Konfiguroitava sosiaalinen kirjanmerkki linkit AddThis:stä";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.0', 1, 6, 1354605422),
(7, 'twitter_feed', 'a:8:{s:2:"en";s:12:"Twitter Feed";s:2:"el";s:14:"Ροή Twitter";s:2:"nl";s:11:"Twitterfeed";s:2:"br";s:15:"Feed do Twitter";s:2:"pt";s:15:"Feed do Twitter";s:2:"ru";s:21:"Лента Twitter''а";s:2:"id";s:12:"Twitter Feed";s:2:"fi";s:14:"Twitter Syöte";}', 'a:8:{s:2:"en";s:37:"Display Twitter feeds on your website";s:2:"el";s:69:"Προβολή των τελευταίων tweets από το Twitter";s:2:"nl";s:31:"Toon Twitterfeeds op uw website";s:2:"br";s:64:"Mostra os últimos tweets de um usuário do Twitter no seu site.";s:2:"pt";s:66:"Mostra os últimos tweets de um utilizador do Twitter no seu site.";s:2:"ru";s:98:"Выводит ленту новостей Twitter на страницах вашего сайта";s:2:"id";s:39:"Menampilkan koleksi Tweet di situs Anda";s:2:"fi";s:35:"Näytä Twitter syöte sivustollasi";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.2', 1, 7, 1354605422),
(8, 'archive', 'a:7:{s:2:"en";s:7:"Archive";s:2:"br";s:15:"Arquivo do Blog";s:2:"pt";s:15:"Arquivo do Blog";s:2:"el";s:33:"Αρχείο Ιστολογίου";s:2:"fr";s:16:"Archives du Blog";s:2:"ru";s:10:"Архив";s:2:"id";s:7:"Archive";}', 'a:7:{s:2:"en";s:64:"Display a list of old months with links to posts in those months";s:2:"br";s:95:"Mostra uma lista navegação cronológica contendo o índice dos artigos publicados mensalmente";s:2:"pt";s:95:"Mostra uma lista navegação cronológica contendo o índice dos artigos publicados mensalmente";s:2:"el";s:155:"Προβάλλει μια λίστα μηνών και συνδέσμους σε αναρτήσεις που έγιναν σε κάθε από αυτούς";s:2:"fr";s:95:"Permet d''afficher une liste des mois passés avec des liens vers les posts relatifs à ces mois";s:2:"ru";s:114:"Выводит список по месяцам со ссылками на записи в этих месяцах";s:2:"id";s:63:"Menampilkan daftar bulan beserta tautan post di setiap bulannya";}', 'Phil Sturgeon', 'http://philsturgeon.co.uk/', '1.0', 1, 8, 1354605422),
(9, 'blog_categories', 'a:7:{s:2:"en";s:15:"Blog Categories";s:2:"br";s:18:"Categorias do Blog";s:2:"pt";s:18:"Categorias do Blog";s:2:"el";s:41:"Κατηγορίες Ιστολογίου";s:2:"fr";s:19:"Catégories du Blog";s:2:"ru";s:29:"Категории Блога";s:2:"id";s:12:"Kateori Blog";}', 'a:7:{s:2:"en";s:30:"Show a list of blog categories";s:2:"br";s:57:"Mostra uma lista de navegação com as categorias do Blog";s:2:"pt";s:57:"Mostra uma lista de navegação com as categorias do Blog";s:2:"el";s:97:"Προβάλει την λίστα των κατηγοριών του ιστολογίου σας";s:2:"fr";s:49:"Permet d''afficher la liste de Catégories du Blog";s:2:"ru";s:57:"Выводит список категорий блога";s:2:"id";s:35:"Menampilkan daftar kategori tulisan";}', 'Stephen Cozart', 'http://github.com/clip/', '1.0', 1, 9, 1354605422),
(10, 'latest_posts', 'a:7:{s:2:"en";s:12:"Latest posts";s:2:"br";s:24:"Artigos recentes do Blog";s:2:"pt";s:24:"Artigos recentes do Blog";s:2:"el";s:62:"Τελευταίες αναρτήσεις ιστολογίου";s:2:"fr";s:17:"Derniers articles";s:2:"ru";s:31:"Последние записи";s:2:"id";s:12:"Post Terbaru";}', 'a:7:{s:2:"en";s:39:"Display latest blog posts with a widget";s:2:"br";s:81:"Mostra uma lista de navegação para abrir os últimos artigos publicados no Blog";s:2:"pt";s:81:"Mostra uma lista de navegação para abrir os últimos artigos publicados no Blog";s:2:"el";s:103:"Προβάλει τις πιο πρόσφατες αναρτήσεις στο ιστολόγιό σας";s:2:"fr";s:68:"Permet d''afficher la liste des derniers posts du blog dans un Widget";s:2:"ru";s:100:"Выводит список последних записей блога внутри виджета";s:2:"id";s:51:"Menampilkan posting blog terbaru menggunakan widget";}', 'Erik Berman', 'http://www.nukleo.fr', '1.0', 1, 10, 1354605422);

-- --------------------------------------------------------

--
-- Table structure for table `default_widget_areas`
--

CREATE TABLE IF NOT EXISTS `default_widget_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `default_widget_areas`
--

INSERT INTO `default_widget_areas` (`id`, `slug`, `title`) VALUES
(1, 'sidebar', 'Sidebar');

-- --------------------------------------------------------

--
-- Table structure for table `default_widget_instances`
--

CREATE TABLE IF NOT EXISTS `default_widget_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `widget_id` int(11) DEFAULT NULL,
  `widget_area_id` int(11) DEFAULT NULL,
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  `order` int(10) NOT NULL DEFAULT '0',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `locationname` varchar(50) NOT NULL DEFAULT '',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) NOT NULL DEFAULT '',
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `taxprovinceid` tinyint(4) NOT NULL DEFAULT '1',
  `cashsalecustomer` varchar(10) DEFAULT '',
  `managed` int(11) DEFAULT '0',
  `cashsalebranch` varchar(10) DEFAULT '',
  `internalrequest` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Allow (1) or not (0) internal request from this location',
  PRIMARY KEY (`loccode`),
  UNIQUE KEY `locationname` (`locationname`),
  KEY `taxprovinceid` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`loccode`, `locationname`, `deladd1`, `deladd2`, `deladd3`, `deladd4`, `deladd5`, `deladd6`, `tel`, `fax`, `email`, `contact`, `taxprovinceid`, `cashsalecustomer`, `managed`, `cashsalebranch`, `internalrequest`) VALUES
('MEL', 'Melbourne', '1234 Collins Street', 'Melbourne', 'Victoria 2345', '', '', 'Australia', '+61 3 56789012', '+61 3 56789013', 'jacko@webdemo.com', 'Jack Roberts', 1, 'ANGRY', 0, 'ANGRY', 1),
('TOR', 'Toronto', 'Level 100 ', 'CN Tower', 'Toronto', '', '', '', '', '', '', 'Clive Contrary', 1, '', 1, '', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
