-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 04, 2021 at 01:38 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `appointo`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  `house_no` int(10) UNSIGNED DEFAULT NULL,
  `address_line` longtext COLLATE utf8_unicode_ci,
  `city` text COLLATE utf8_unicode_ci,
  `state` text COLLATE utf8_unicode_ci,
  `pin_code` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_user_id_foreign` (`user_id`),
  KEY `addresses_country_id_foreign` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deal_id` int(10) UNSIGNED DEFAULT NULL,
  `deal_quantity` double DEFAULT NULL,
  `coupon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `status` enum('pending','approved','in progress','completed','canceled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_gateway` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `original_amount` double(8,2) NOT NULL,
  `product_amount` double(8,2) DEFAULT NULL,
  `discount` double(8,2) NOT NULL,
  `coupon_discount` double DEFAULT NULL,
  `discount_percent` double NOT NULL,
  `tax_name` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tax_percent` double(8,2) DEFAULT NULL,
  `tax_amount` double(8,2) DEFAULT NULL,
  `amount_to_pay` double(8,2) NOT NULL,
  `payment_status` enum('pending','completed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `source` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pos',
  `additional_notes` text COLLATE utf8_unicode_ci,
  `notify_at` timestamp NULL DEFAULT NULL,
  `event_id` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_coupon_id_foreign` (`coupon_id`),
  KEY `bookings_deal_id_foreign` (`deal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_items`
--

DROP TABLE IF EXISTS `booking_items`;
CREATE TABLE IF NOT EXISTS `booking_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `business_service_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` tinyint(4) NOT NULL,
  `unit_price` double NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_items_booking_id_foreign` (`booking_id`),
  KEY `booking_items_business_service_id_foreign` (`business_service_id`),
  KEY `booking_items_product_id_foreign` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_notifactions`
--

DROP TABLE IF EXISTS `booking_notifactions`;
CREATE TABLE IF NOT EXISTS `booking_notifactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `duration` int(11) NOT NULL DEFAULT '1',
  `duration_type` enum('minutes','hours','days','weeks') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'minutes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_times`
--

DROP TABLE IF EXISTS `booking_times`;
CREATE TABLE IF NOT EXISTS `booking_times` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `day` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `multiple_booking` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  `max_booking` int(11) NOT NULL DEFAULT '0',
  `max_booking_per_day` int(11) NOT NULL,
  `max_booking_per_slot` int(11) NOT NULL,
  `status` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enabled',
  `slot_duration` int(11) NOT NULL DEFAULT '30',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `booking_times`
--

INSERT INTO `booking_times` (`id`, `day`, `start_time`, `end_time`, `multiple_booking`, `max_booking`, `max_booking_per_day`, `max_booking_per_slot`, `status`, `slot_duration`, `created_at`, `updated_at`) VALUES
(1, 'monday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(2, 'tuesday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(3, 'wednesday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(4, 'thursday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(5, 'friday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(6, 'saturday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL),
(7, 'sunday', '10:00:00', '20:00:00', 'yes', 0, 0, 0, 'enabled', 30, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `booking_user`
--

DROP TABLE IF EXISTS `booking_user`;
CREATE TABLE IF NOT EXISTS `booking_user` (
  `booking_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`booking_id`,`user_id`),
  KEY `booking_user_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_services`
--

DROP TABLE IF EXISTS `business_services`;
CREATE TABLE IF NOT EXISTS `business_services` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `time` double(8,2) NOT NULL,
  `time_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `discount` double(8,2) NOT NULL,
  `discount_type` enum('percent','fixed') COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `location_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `image` text COLLATE utf8_unicode_ci,
  `default_image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_services_category_id_foreign` (`category_id`),
  KEY `business_services_location_id_foreign` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_service_user`
--

DROP TABLE IF EXISTS `business_service_user`;
CREATE TABLE IF NOT EXISTS `business_service_user` (
  `business_service_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`business_service_id`,`user_id`),
  KEY `business_service_user_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Parking', 'parking', 'e885c678625830439806765d28ea1d07.png', 'active', '2021-12-03 00:09:30', '2021-12-03 00:09:30');

-- --------------------------------------------------------

--
-- Table structure for table `company_settings`
--

DROP TABLE IF EXISTS `company_settings`;
CREATE TABLE IF NOT EXISTS `company_settings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `company_email` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `company_phone` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `date_format` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y-m-d',
  `time_format` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'h:i A',
  `website` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `purchase_code` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `supported_until` timestamp NULL DEFAULT NULL,
  `multi_task_user` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `booking_per_day` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_selection` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disabled',
  `disable_slot` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disabled',
  `booking_time_type` enum('sum','avg','max','min') COLLATE utf8_unicode_ci NOT NULL,
  `get_started_title` text COLLATE utf8_unicode_ci,
  `get_started_note` text COLLATE utf8_unicode_ci,
  `cron_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `duration` int(11) NOT NULL DEFAULT '1',
  `duration_type` enum('minutes','hours','days','weeks') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'minutes',
  `google_calendar` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `google_client_id` text COLLATE utf8_unicode_ci,
  `google_client_secret` text COLLATE utf8_unicode_ci,
  `google_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `company_settings_currency_id_foreign` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_settings`
--

INSERT INTO `company_settings` (`id`, `company_name`, `company_email`, `company_phone`, `logo`, `address`, `date_format`, `time_format`, `website`, `timezone`, `locale`, `latitude`, `longitude`, `currency_id`, `created_at`, `updated_at`, `purchase_code`, `supported_until`, `multi_task_user`, `booking_per_day`, `employee_selection`, `disable_slot`, `booking_time_type`, `get_started_title`, `get_started_note`, `cron_status`, `duration`, `duration_type`, `google_calendar`, `google_client_id`, `google_client_secret`, `google_id`, `name`, `token`) VALUES
(1, 'Froiden Technologies Pvt Ltd', 'company@example.com', '1234512345', 'd753326d85742fc51e46dbbebda51195.png', 'Jaipur, India', 'Y-m-d', 'h:i A', 'http://localhost/appointo-use/public', 'Asia/Kolkata', 'en', '26.91243360', '75.78727090', 1, NULL, '2021-12-03 00:08:13', NULL, NULL, NULL, NULL, 'disabled', 'disabled', 'sum', 'Lorem Ipsum Dolor', 'Lorem ipsum dolor sit amet, consectetur adipiscing elitaccumsan lacus.', 'deactive', 1, 'minutes', 'deactive', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `iso` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `nicename` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `iso3` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`) VALUES
(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93),
(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355),
(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213),
(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684),
(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376),
(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244),
(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264),
(8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, 0),
(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268),
(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54),
(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374),
(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297),
(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61),
(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43),
(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994),
(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242),
(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973),
(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880),
(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246),
(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375),
(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32),
(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501),
(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229),
(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441),
(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975),
(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591),
(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387),
(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267),
(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, 0),
(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, 246),
(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673),
(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359),
(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226),
(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257),
(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855),
(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237),
(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1),
(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238),
(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236),
(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235),
(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56),
(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86),
(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, 61),
(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, 672),
(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57),
(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269),
(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242),
(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242),
(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682),
(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506),
(53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV', 384, 225),
(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385),
(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53),
(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357),
(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420),
(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45),
(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253),
(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767),
(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809),
(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593),
(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20),
(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503),
(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240),
(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291),
(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372),
(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500),
(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298),
(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679),
(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358),
(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33),
(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594),
(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, 0),
(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241),
(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220),
(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995),
(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49),
(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233),
(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350),
(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30),
(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299),
(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473),
(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590),
(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671),
(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502),
(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224),
(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245),
(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592),
(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, 0),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39),
(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504),
(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852),
(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36),
(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354),
(99, 'IN', 'INDIA', 'India', 'IND', 356, 91),
(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98),
(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964),
(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353),
(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972),
(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39),
(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876),
(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81),
(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962),
(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7),
(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254),
(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686),
(112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK', 408, 850),
(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82),
(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965),
(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996),
(116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO', 418, 856),
(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371),
(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961),
(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266),
(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218),
(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423),
(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370),
(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352),
(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853),
(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389),
(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261),
(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265),
(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60),
(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960),
(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223),
(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356),
(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692),
(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596),
(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222),
(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230),
(137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, 269),
(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691),
(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373),
(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377),
(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976),
(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664),
(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212),
(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258),
(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95),
(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264),
(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674),
(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977),
(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31),
(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599),
(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687),
(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64),
(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505),
(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227),
(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234),
(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683),
(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672),
(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670),
(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47),
(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968),
(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92),
(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, 970),
(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507),
(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675),
(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595),
(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51),
(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63),
(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0),
(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48),
(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351),
(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787),
(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974),
(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262),
(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40),
(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70),
(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250),
(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290),
(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869),
(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758),
(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784),
(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684),
(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378),
(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239),
(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966),
(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221),
(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, 381),
(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248),
(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232),
(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65),
(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421),
(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386),
(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677),
(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252),
(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27),
(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, 0),
(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34),
(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94),
(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249),
(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597),
(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47),
(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268),
(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46),
(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41),
(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886),
(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255),
(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66),
(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, 670),
(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228),
(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690),
(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676),
(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868),
(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216),
(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90),
(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370),
(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649),
(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688),
(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256),
(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380),
(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971),
(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44),
(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, 1),
(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598),
(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998),
(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678),
(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58),
(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284),
(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340),
(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681),
(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212),
(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967),
(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260),
(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263),
(240, 'RS', 'SERBIA', 'Serbia', 'SRB', 688, 381),
(241, 'AP', 'ASIA PACIFIC REGION', 'Asia / Pacific Region', '0', 0, 0),
(242, 'ME', 'MONTENEGRO', 'Montenegro', 'MNE', 499, 382),
(243, 'AX', 'ALAND ISLANDS', 'Aland Islands', 'ALA', 248, 358),
(244, 'BQ', 'BONAIRE, SINT EUSTATIUS AND SABA', 'Bonaire, Sint Eustatius and Saba', 'BES', 535, 599),
(245, 'CW', 'CURACAO', 'Curacao', 'CUW', 531, 599),
(246, 'GG', 'GUERNSEY', 'Guernsey', 'GGY', 831, 44),
(247, 'IM', 'ISLE OF MAN', 'Isle of Man', 'IMN', 833, 44),
(248, 'JE', 'JERSEY', 'Jersey', 'JEY', 832, 44),
(249, 'XK', 'KOSOVO', 'Kosovo', '---', 0, 381),
(250, 'BL', 'SAINT BARTHELEMY', 'Saint Barthelemy', 'BLM', 652, 590),
(251, 'MF', 'SAINT MARTIN', 'Saint Martin', 'MAF', 663, 590),
(252, 'SX', 'SINT MAARTEN', 'Sint Maarten', 'SXM', 534, 1),
(253, 'SS', 'SOUTH SUDAN', 'South Sudan', 'SSD', 728, 211);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime DEFAULT NULL,
  `uses_limit` int(11) DEFAULT NULL,
  `used_time` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `percent` int(11) DEFAULT NULL,
  `minimum_purchase_amount` int(11) NOT NULL DEFAULT '0',
  `days` text COLLATE utf8_unicode_ci,
  `status` enum('active','inactive','expire') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_users`
--

DROP TABLE IF EXISTS `coupon_users`;
CREATE TABLE IF NOT EXISTS `coupon_users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_users_coupon_id_foreign` (`coupon_id`),
  KEY `coupon_users_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `currency_code` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `currency_name`, `currency_symbol`, `currency_code`, `created_at`, `updated_at`) VALUES
(1, 'US Dollars', '$', 'USD', '2021-12-02 23:53:22', '2021-12-02 23:53:22');

-- --------------------------------------------------------

--
-- Table structure for table `currency_format_settings`
--

DROP TABLE IF EXISTS `currency_format_settings`;
CREATE TABLE IF NOT EXISTS `currency_format_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_position` enum('left','right','left_with_space','right_with_space') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'right',
  `no_of_decimal` int(10) UNSIGNED NOT NULL,
  `thousand_separator` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `decimal_separator` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `currency_format_settings`
--

INSERT INTO `currency_format_settings` (`id`, `currency_position`, `no_of_decimal`, `thousand_separator`, `decimal_separator`) VALUES
(1, 'right', 2, ',', '.');

-- --------------------------------------------------------

--
-- Table structure for table `customer_feedback`
--

DROP TABLE IF EXISTS `customer_feedback`;
CREATE TABLE IF NOT EXISTS `customer_feedback` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `booking_id` int(10) UNSIGNED DEFAULT NULL,
  `customer_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `feedback_message` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_feedback_user_id_foreign` (`user_id`),
  KEY `customer_feedback_booking_id_foreign` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer_feedback`
--

INSERT INTO `customer_feedback` (`id`, `user_id`, `booking_id`, `customer_name`, `feedback_message`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'Henry Dube', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti\n                atque corrupti\n                quos. At vero eos et accusamus et iusto odio.', 'active', '2021-12-02 23:53:28', '2021-12-02 23:53:28'),
(2, NULL, NULL, 'John Doe', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti\n                atque corrupti\n                quos. At vero eos et accusamus et iusto odio.', 'active', '2021-12-02 23:53:28', '2021-12-02 23:53:28'),
(3, NULL, NULL, 'Celena Gomez', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti\n                atque corrupti\n                quos. At vero eos et accusamus et iusto odio.', 'active', '2021-12-02 23:53:28', '2021-12-02 23:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `deals`
--

DROP TABLE IF EXISTS `deals`;
CREATE TABLE IF NOT EXISTS `deals` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  `deal_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime DEFAULT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  `uses_limit` int(11) DEFAULT NULL,
  `used_time` int(11) DEFAULT NULL,
  `original_amount` double DEFAULT NULL,
  `deal_amount` double DEFAULT NULL,
  `days` text COLLATE utf8_unicode_ci,
  `image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','expire') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `description` text COLLATE utf8_unicode_ci,
  `discount_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `percentage` int(11) DEFAULT NULL,
  `deal_applied_on` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `max_order_per_customer` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deal_items`
--

DROP TABLE IF EXISTS `deal_items`;
CREATE TABLE IF NOT EXISTS `deal_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deal_id` int(10) UNSIGNED DEFAULT NULL,
  `business_service_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` tinyint(4) NOT NULL,
  `unit_price` double NOT NULL,
  `discount_amount` double NOT NULL,
  `total_amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_items_deal_id_foreign` (`deal_id`),
  KEY `deal_items_business_service_id_foreign` (`business_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_groups`
--

DROP TABLE IF EXISTS `employee_groups`;
CREATE TABLE IF NOT EXISTS `employee_groups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_group_services`
--

DROP TABLE IF EXISTS `employee_group_services`;
CREATE TABLE IF NOT EXISTS `employee_group_services` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_groups_id` int(10) UNSIGNED DEFAULT NULL,
  `business_service_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_group_services_employee_groups_id_foreign` (`employee_groups_id`),
  KEY `employee_group_services_business_service_id_foreign` (`business_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_schedules`
--

DROP TABLE IF EXISTS `employee_schedules`;
CREATE TABLE IF NOT EXISTS `employee_schedules` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `is_working` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `days` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_schedules_employee_id_foreign` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `footer_settings`
--

DROP TABLE IF EXISTS `footer_settings`;
CREATE TABLE IF NOT EXISTS `footer_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `social_links` text COLLATE utf8_unicode_ci,
  `footer_text` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `footer_settings`
--

INSERT INTO `footer_settings` (`id`, `social_links`, `footer_text`, `created_at`, `updated_at`) VALUES
(1, '[{\"name\":\"facebook\",\"link\":\"https:\\/\\/facebook.com\"},{\"name\":\"twitter\",\"link\":\"https:\\/\\/twitter.com\"},{\"name\":\"youtube\",\"link\":\"https:\\/\\/youtube.com\"},{\"name\":\"instagram\",\"link\":\"https:\\/\\/instagram.com\"},{\"name\":\"linkedin\",\"link\":\"https:\\/\\/linkedin.com\"}]', 'Froiden Technologies Pvt. Ltd. © 2020 - 2025 All Rights Reserved.', '2021-12-02 23:53:28', '2021-12-02 23:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `front_theme_settings`
--

DROP TABLE IF EXISTS `front_theme_settings`;
CREATE TABLE IF NOT EXISTS `front_theme_settings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `secondary_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `custom_css` longtext COLLATE utf8_unicode_ci,
  `custom_js` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carousel_status` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'enabled',
  `seo_description` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `seo_keywords` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `front_theme` enum('theme-1','theme-2') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'theme-2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `front_theme_settings`
--

INSERT INTO `front_theme_settings` (`id`, `title`, `primary_color`, `secondary_color`, `custom_css`, `custom_js`, `logo`, `favicon`, `carousel_status`, `seo_description`, `seo_keywords`, `front_theme`, `created_at`, `updated_at`) VALUES
(1, 'Appointo', '#414552', '#788AE2', NULL, NULL, NULL, NULL, 'enabled', '', '', 'theme-1', NULL, '2021-12-03 00:06:50');

-- --------------------------------------------------------

--
-- Table structure for table `google_captcha_settings`
--

DROP TABLE IF EXISTS `google_captcha_settings`;
CREATE TABLE IF NOT EXISTS `google_captcha_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `v2_status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `v2_site_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `v2_secret_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `v3_status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `v3_site_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `v3_secret_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `google_captcha_settings`
--

INSERT INTO `google_captcha_settings` (`id`, `status`, `v2_status`, `v2_site_key`, `v2_secret_key`, `v3_status`, `v3_site_key`, `v3_secret_key`, `created_at`, `updated_at`) VALUES
(1, 'inactive', 'inactive', NULL, NULL, 'inactive', NULL, NULL, '2021-12-02 23:53:29', '2021-12-02 23:53:29');

-- --------------------------------------------------------

--
-- Table structure for table `item_taxes`
--

DROP TABLE IF EXISTS `item_taxes`;
CREATE TABLE IF NOT EXISTS `item_taxes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `service_id` int(10) UNSIGNED DEFAULT NULL,
  `deal_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_taxes_tax_id_foreign` (`tax_id`),
  KEY `item_taxes_service_id_foreign` (`service_id`),
  KEY `item_taxes_deal_id_foreign` (`deal_id`),
  KEY `item_taxes_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item_taxes`
--

INSERT INTO `item_taxes` (`id`, `tax_id`, `service_id`, `deal_id`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 1, '2021-12-03 01:13:57', '2021-12-03 01:13:57');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_code` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `language_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `language_code`, `language_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'es', 'Spanish', 'disabled', '2021-12-02 23:53:22', '2021-12-02 23:53:22'),
(2, 'en', 'English', 'enabled', '2021-12-02 23:53:25', '2021-12-02 23:53:25');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
CREATE TABLE IF NOT EXISTS `leaves` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `leave_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8_unicode_ci NOT NULL,
  `reason` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approved_by` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leaves_employee_id_foreign` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Jaipur, India', '2021-12-02 23:53:23', '2021-12-02 23:53:23');

-- --------------------------------------------------------

--
-- Table structure for table `ltm_translations`
--

DROP TABLE IF EXISTS `ltm_translations`;
CREATE TABLE IF NOT EXISTS `ltm_translations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `key` text COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `is_section_content` enum('yes','no') COLLATE utf8_unicode_ci DEFAULT 'no',
  `have_content` enum('yes','no') COLLATE utf8_unicode_ci DEFAULT 'no',
  `section_title` longtext COLLATE utf8_unicode_ci,
  `title_note` longtext COLLATE utf8_unicode_ci,
  `section_content` longtext COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `content_alignment` enum('left','right') COLLATE utf8_unicode_ci DEFAULT 'left',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `file_name`, `is_section_content`, `have_content`, `section_title`, `title_note`, `section_content`, `created_at`, `updated_at`, `content_alignment`) VALUES
(1, 'section_image.jpg', 'yes', 'yes', 'Hair Spa and Hair Cut', 'Lorem ipsum dolor sut amet', '<p><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla feugiat hendrerit lectus vitae ornare. Maecenas mauris turpis, pellentesque nec dictum consectetur, s</span><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">emper vitae tortor. Aliquam nunc turpis, tristique at felis eget, dapibus aliquet massa. Fusce nec feugiat arcu, quis varius libero.</span></p><p><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 11px; text-align: justify;\"><br></span></p><ul><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Quisque orci sapien, aliquet sit amet fringilla quis, efficitur eu est. Suspendisse at dictum purus</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Phasellus sit amet enim sed sem maximus lobortis. Nam vehicula facilisis fringilla.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Nunc et quam id sem pharetra feugiat. Nullam imperdiet congue diam, vel tempor sit amet.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Aenean a mi eu ipsum ullamcorper venenatis. Nulla dictum libero, eu cursus leo lacinia sed.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Nulla ipsum lorem, maximus in risus sit amet, bibendum molestie dolor.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Pellentesque vestibulum dapibus ipsum id aliquet.</span></li></ul>', '2021-12-02 23:53:28', '2021-12-02 23:53:28', 'left'),
(2, 'section_image_1.jpg', 'yes', 'yes', 'Hair Spa and Hair Cut', 'Lorem ipsum dolor sut amet', '<p><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">Donec id nunc nulla. Praesent ac ligula ut augue mollis sollicitudin. Vestibulum sit amet nisl auctor, finibus odio id, pretium nunc. Praesent ut pellentesque ligula. Sed vitae lorem tempus, aliquet magna ac, scelerisque dui. Integer sed nunc eu sem porta faucibus. Donec vel vestibulum orci&nbsp;</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">&nbsp;</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">pellentesque ligula.</span></p><p><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\"><br></span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">Praesent ac ligula ut augue mollis sollicitudin. Vestibulum sit amet nisl auctor, finibus odio id, pretium nunc. Praesent ut.</span></p><p><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\"><br></span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">Donec iaculis justo arcu, ac egestas dui molestie eu. Curabitur sodales placerat eros vitae cursus.</span></p>', '2021-12-02 23:53:28', '2021-12-02 23:53:28', 'right'),
(3, 'section_image.jpg', 'yes', 'yes', 'Hair Spa and Hair Cut', 'Lorem ipsum dolor sut amet', '<p><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla feugiat hendrerit lectus vitae ornare. Maecenas mauris turpis, pellentesque nec dictum consectetur, s</span><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">emper vitae tortor. Aliquam nunc turpis, tristique at felis eget, dapibus aliquet massa. Fusce nec feugiat arcu, quis varius libero.</span></p><p><span style=\"font-size: 12px;\">﻿</span><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 11px; text-align: justify;\"><br></span></p><ul><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Quisque orci sapien, aliquet sit amet fringilla quis, efficitur eu est. Suspendisse at dictum purus</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Phasellus sit amet enim sed sem maximus lobortis. Nam vehicula facilisis fringilla.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Nunc et quam id sem pharetra feugiat. Nullam imperdiet congue diam, vel tempor sit amet.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Aenean a mi eu ipsum ullamcorper venenatis. Nulla dictum libero, eu cursus leo lacinia sed.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Nulla ipsum lorem, maximus in risus sit amet, bibendum molestie dolor.</span></li><li><span style=\"font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 12px; text-align: justify;\">Pellentesque vestibulum dapibus ipsum id aliquet.</span></li></ul>', '2021-12-02 23:53:28', '2021-12-02 23:53:28', 'left');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_04_02_193005_create_translations_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2018_09_06_071923_create_categories_table', 1),
(5, '2018_09_11_093015_create_business_services_table', 1),
(6, '2018_09_11_173520_create_bookings_table', 1),
(7, '2018_09_11_174709_add_discount_column_serices_table', 1),
(8, '2018_09_11_184348_create_tax_settings_table', 1),
(9, '2018_09_12_151158_create_booking_times_table', 1),
(10, '2018_09_18_064516_add_mobile_column_users_table', 1),
(11, '2018_09_19_095300_add_status_column_categories_table', 1),
(12, '2018_09_19_095530_add_status_column_booking_services_table', 1),
(13, '2018_09_20_130124_create_currencies_table', 1),
(14, '2018_09_20_131417_create_company_settings_table', 1),
(15, '2018_09_25_112040_create_booking_items_table', 1),
(16, '2018_09_28_074544_add_columns_bookings_table', 1),
(17, '2018_10_03_182207_create_languages_table', 1),
(18, '2018_10_04_100225_add_spanish_language', 1),
(19, '2018_10_04_112244_create_smtp_settings_table', 1),
(20, '2018_10_08_122033_add_image_users_table', 1),
(21, '2018_10_09_121006_create_theme_settings_table', 1),
(22, '2018_10_15_123811_add_time_slot_duration_booing_times_table', 1),
(23, '2018_11_01_091108_add_is_admin_column_users_table', 1),
(24, '2018_11_02_052534_add_topbar_textcolor_column_theme_settings', 1),
(25, '2018_12_03_104905_change_tax_column_nullable_bookings_table', 1),
(26, '2018_12_19_192042_add_source_column_bookings_table', 1),
(27, '2018_12_20_115707_allow_soft_delete_user', 1),
(28, '2018_12_27_053940_create_payment_gateway_credential_table', 1),
(29, '2018_12_27_064431_create_payments_table', 1),
(30, '2019_01_03_192042_alter_credential_table', 1),
(31, '2019_01_31_111812_add_multiple_booking_column_booking_times_table', 1),
(32, '2019_02_10_075422_add_addition_notes_column_bookings_table', 1),
(33, '2019_04_08_053940_create_employee_groups_table', 1),
(34, '2019_04_08_075422_alter_user_employee_table', 1),
(35, '2019_04_08_085422_alter_booking_group_table', 1),
(36, '2019_08_06_104829_create_media_table', 1),
(37, '2019_08_08_071516_create_locations_table', 1),
(38, '2019_08_08_095010_add_location_id_column_in_business_services_table', 1),
(39, '2019_08_13_073129_update_settings_add_envato_key', 1),
(40, '2019_08_13_073129_update_settings_add_support_key', 1),
(41, '2019_08_14_093126_alter_booking_times_and_bookings_table', 1),
(42, '2019_08_14_121322_create_front_theme_settings_table', 1),
(43, '2019_08_27_043810_create_pages_table', 1),
(44, '2019_08_28_081847_update_smtp_setting_verified', 1),
(45, '2019_09_03_110646_add_slug_field_in_categories_and_business_services_table', 1),
(46, '2019_09_17_083105_create_sms_settings_table', 1),
(47, '2019_09_18_115145_add_mobile_verified_column_in_users_table', 1),
(48, '2019_09_23_064129_create_universal_search_table', 1),
(49, '2019_10_07_073041_add_status_column_in_languages_table', 1),
(50, '2019_10_14_084220_alter_foreign_key_in_business_services_table', 1),
(51, '2019_11_07_065036_alter_status_of_payments_table', 1),
(52, '2019_11_13_090143_add_date_and_time_format_columns_in_company_settings_table', 1),
(53, '2019_11_14_085440_add_unique_slugs_to_categories_and_services_tables', 1),
(54, '2019_11_14_121846_laratrust_setup_tables', 1),
(55, '2019_11_18_121633_create_modules_table', 1),
(56, '2019_11_25_043859_remove_is_admin_and_is_employee_columns_from_users_table', 1),
(57, '2019_11_25_092025_seed_booking_times_table', 1),
(58, '2019_11_26_092726_create_payments_for_pos_bookings', 1),
(59, '2019_11_27_065035_add_max_booking_column_in_booking_times_table', 1),
(60, '2019_11_28_075109_add_razorpay_details_in_payment_gateway_credentials_table', 1),
(61, '2019_12_02_085713_add_paypal_mode_column_in_payment_gateway_credentials_table', 1),
(62, '2019_12_02_112618_alter_status_column_in_bookings_table', 1),
(63, '2019_12_04_063825_run_permission_change_command', 1),
(64, '2019_12_04_071454_add_english_row_in_languages_table', 1),
(65, '2019_12_05_102158_add_default_image_column_in_business_services_table', 1),
(66, '2019_12_06_071155_alter_image_column_to_text_in_business_services_table', 1),
(67, '2019_12_12_083028_remove_pos_module_from_modules_table', 1),
(68, '2019_12_12_110226_add_show_payment_column_in_payment_gateway_credentials_table', 1),
(69, '2019_12_12_121633_create_coupons_table', 1),
(70, '2019_12_13_053737_add_custom_css_column_in_front_and_admin_theme_settings_tables', 1),
(71, '2019_12_13_081452_create_todo_items_table', 1),
(72, '2019_12_13_121633_create_coupon_users_table', 1),
(73, '2019_12_18_085713_add_coupon_id_column_in_bookings_table', 1),
(74, '2019_12_23_085713_remove_field_in_coupon_table', 1),
(75, '2020_01_16_084419_change_customers_to_employees_in_universal_searches_table', 1),
(76, '2020_02_03_123340_alter_foreign_key_in_company_settings_table', 1),
(77, '2020_03_02_121855_alter_employees_and_customers_in_universal_searches_table', 1),
(78, '2020_03_20_102434_create_booking_user_table', 1),
(79, '2020_03_21_130010_create_business_service_user_table', 1),
(80, '2020_03_23_083957_add_multi_task_user_to_company_settings', 1),
(81, '2020_04_03_122036_remove_employee_id_column_bookings_table', 1),
(82, '2020_04_10_155242_create_deals_table', 1),
(83, '2020_04_17_083036_add_deal_id_column_to_bookings_table', 1),
(84, '2020_04_17_083138_create_deal_items_table', 1),
(85, '2020_04_29_103926_add_slug_column_to_deal_table', 1),
(86, '2020_05_11_112146_add_booking_per_day_column_to_company_settings_table', 1),
(87, '2020_05_18_052041_add_employee_selection_column_to_company_settings_table', 1),
(88, '2020_05_28_061604_add_two_columns_to_company_settings_table', 1),
(89, '2020_06_02_031736_create_employee_group_services_table', 1),
(90, '2020_06_30_082856_add_7_columns_to_deals_table', 1),
(91, '2020_07_07_101959_create_coupon_and_deal_module', 1),
(92, '2020_10_27_113311_add_carousel_status_column_to_front_theme_settings_table', 1),
(93, '2020_11_03_111316_seo_details_in_front_theme_settings', 1),
(94, '2020_11_04_090145_create_leaves_table', 1),
(95, '2020_12_03_071029_create_employee_schedules_table', 1),
(96, '2020_12_14_050828_add_schedule', 1),
(97, '2021_02_05_070704_add_leaves_columns_table', 1),
(98, '2021_02_12_092251_create_products_table', 1),
(99, '2021_02_16_121052_add_product_id_in_booking_items', 1),
(100, '2021_02_17_083722_add_product_amount_in_booking_table', 1),
(101, '2021_04_07_085532_add_paystack_to_payment_table', 1),
(102, '2021_04_12_064148_add_choose_theme_option_in_front_theme_settings_table', 1),
(103, '2021_04_12_114507_add_blog_and_terms_conditions_in_universal_searches_table', 1),
(104, '2021_04_14_051737_add_front_section_content_in_media_table', 1),
(105, '2021_04_16_064541_create_customer_feedback_table', 1),
(106, '2021_04_16_094147_add_getstarted_note_column_in_company_settings_table', 1),
(107, '2021_04_16_110055_create_footer_settings_table', 1),
(108, '2021_05_27_065105_create_office__leaves_table', 1),
(109, '2021_06_01_114624_add_two_columns_in_company_settings', 1),
(110, '2021_06_09_055655_add_new_column_to_booking_times', 1),
(111, '2021_06_14_085715_create_currency_format_settings_table', 1),
(112, '2021_06_30_114051_add_google_o_auth_ids_to_company_settings_table', 1),
(113, '2021_06_30_114052_add_google_event_id_to_bookings_table', 1),
(114, '2021_07_02_054512_add_favicon_column_in_front_theme_settings_table', 1),
(115, '2021_07_06_100049_create_booking_notifactions_table', 1),
(116, '2021_07_06_112554_create_item_taxes_table', 1),
(117, '2021_07_06_112726_change_tax_settings_table_name', 1),
(118, '2021_07_06_112923_add_tax_for_services_and_deals_in_tax_settings_table', 1),
(119, '2021_07_09_053020_add_notifaction_column_to_bookings_table', 1),
(120, '2021_07_15_091656_add_msg91_column_to_sms_settings_table', 1),
(121, '2021_08_16_045608_create_google_captcha_settings_table', 1),
(122, '2021_08_23_062919_create_social_auth_settings_table', 1),
(123, '2021_09_03_091733_add_rtl_column_in_users_table', 1),
(124, '2021_09_20_063352_create_countries_table', 1),
(125, '2021_09_21_080945_create_addresses_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE IF NOT EXISTS `modules` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'location', 'Location', 'modules.module.locationDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(2, 'category', 'Category', 'modules.module.categoryDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(3, 'business_service', 'Business Service', 'modules.module.businessServiceDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(4, 'customer', 'Customer', 'modules.module.customerDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(5, 'employee', 'Employee', 'modules.module.employeeDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(6, 'employee_group', 'Employee Group', 'modules.module.employeeGroupDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(7, 'coupon', 'Coupon', 'modules.module.couponDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(8, 'deal', 'Deal', 'modules.module.dealDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(9, 'booking', 'Booking', 'modules.module.bookingDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(10, 'report', 'Report', 'modules.module.reportDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(11, 'settings', 'Settings', 'modules.module.settingsDescription', '2021-12-02 23:53:25', '2021-12-02 23:53:25');

-- --------------------------------------------------------

--
-- Table structure for table `office_leaves`
--

DROP TABLE IF EXISTS `office_leaves`;
CREATE TABLE IF NOT EXISTS `office_leaves` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `content`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'About Us', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'about-us', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(2, 'Contact Us', '<h2>Contact Us</h2>\n\n                <p>How can we help you? We will try to get back to you as soon as possible.</p>', 'contact-us', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(3, 'How It Works', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'how-it-works', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(4, 'Privacy Policy', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'privacy-policy', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(5, 'Blog', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'blog', '2021-12-02 23:53:28', '2021-12-02 23:53:28'),
(6, 'Terms And Conditions', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'terms-and-conditions', '2021-12-02 23:53:28', '2021-12-02 23:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) DEFAULT NULL,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `gateway` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('completed','pending') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `paid_on` datetime DEFAULT NULL,
  `customer_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_transaction_id_unique` (`transaction_id`),
  UNIQUE KEY `payments_event_id_unique` (`event_id`),
  KEY `payments_booking_id_foreign` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateway_credentials`
--

DROP TABLE IF EXISTS `payment_gateway_credentials`;
CREATE TABLE IF NOT EXISTS `payment_gateway_credentials` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `paypal_client_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paypal_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_client_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_webhook_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `paystack_public_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paystack_secret_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paystack_webhook_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paystack_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `paypal_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `paypal_mode` enum('sandbox','live') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sandbox',
  `offline_payment` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `show_payment_options` enum('hide','show') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'show',
  `razorpay_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `razorpay_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `razorpay_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_gateway_credentials`
--

INSERT INTO `payment_gateway_credentials` (`id`, `paypal_client_id`, `paypal_secret`, `stripe_client_id`, `stripe_secret`, `stripe_webhook_secret`, `stripe_status`, `paystack_public_id`, `paystack_secret_id`, `paystack_webhook_secret`, `paystack_status`, `paypal_status`, `paypal_mode`, `offline_payment`, `show_payment_options`, `razorpay_key`, `razorpay_secret`, `razorpay_status`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, 'active', NULL, NULL, NULL, 'deactive', 'active', 'sandbox', '1', 'show', NULL, NULL, 'deactive', '2021-12-02 23:53:22', '2021-12-02 23:53:22');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `module_id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'create_location', 'Create Location', 'Create Location', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(2, 1, 'read_location', 'Read Location', 'Read Location', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(3, 1, 'update_location', 'Update Location', 'Update Location', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(4, 1, 'delete_location', 'Delete Location', 'Delete Location', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(5, 2, 'create_category', 'Create Category', 'Create Category', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(6, 2, 'read_category', 'Read Category', 'Read Category', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(7, 2, 'update_category', 'Update Category', 'Update Category', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(8, 2, 'delete_category', 'Delete Category', 'Delete Category', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(9, 3, 'create_business_service', 'Create Business Service', 'Create Business Service', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(10, 3, 'read_business_service', 'Read Business Service', 'Read Business Service', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(11, 3, 'update_business_service', 'Update Business Service', 'Update Business Service', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(12, 3, 'delete_business_service', 'Delete Business Service', 'Delete Business Service', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(13, 4, 'create_customer', 'Create Customer', 'Create Customer', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(14, 4, 'read_customer', 'Read Customer', 'Read Customer', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(15, 4, 'update_customer', 'Update Customer', 'Update Customer', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(16, 4, 'delete_customer', 'Delete Customer', 'Delete Customer', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(17, 5, 'create_employee', 'Create Employee', 'Create Employee', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(18, 5, 'read_employee', 'Read Employee', 'Read Employee', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(19, 5, 'update_employee', 'Update Employee', 'Update Employee', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(20, 5, 'delete_employee', 'Delete Employee', 'Delete Employee', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(21, 6, 'create_employee_group', 'Create Employee Group', 'Create Employee Group', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(22, 6, 'read_employee_group', 'Read Employee Group', 'Read Employee Group', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(23, 6, 'update_employee_group', 'Update Employee Group', 'Update Employee Group', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(24, 6, 'delete_employee_group', 'Delete Employee Group', 'Delete Employee Group', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(25, 7, 'create_coupon', 'Create Coupon', 'Create Coupon', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(26, 7, 'read_coupon', 'Read Coupon', 'Read Coupon', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(27, 7, 'update_coupon', 'Update Coupon', 'Update Coupon', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(28, 7, 'delete_coupon', 'Delete Coupon', 'Delete Coupon', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(29, 8, 'create_deal', 'Create Deal', 'Create Deal', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(30, 8, 'read_deal', 'Read Deal', 'Read Deal', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(31, 8, 'update_deal', 'Update Deal', 'Update Deal', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(32, 8, 'delete_deal', 'Delete Deal', 'Delete Deal', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(33, 9, 'create_booking', 'Create Booking', 'Create Booking', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(34, 9, 'read_booking', 'Read Booking', 'Read Booking', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(35, 9, 'update_booking', 'Update Booking', 'Update Booking', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(36, 9, 'delete_booking', 'Delete Booking', 'Delete Booking', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(37, 10, 'create_report', 'Create Report', 'Create Report', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(38, 10, 'read_report', 'Read Report', 'Read Report', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(39, 10, 'update_report', 'Update Report', 'Update Report', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(40, 10, 'delete_report', 'Delete Report', 'Delete Report', '2021-12-02 23:53:25', '2021-12-02 23:53:25'),
(41, 11, 'manage_settings', 'Manage Settings', 'Manage Settings', '2021-12-02 23:53:25', '2021-12-02 23:53:25');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(34, 2),
(35, 2),
(34, 3),
(35, 3);

-- --------------------------------------------------------

--
-- Table structure for table `permission_user`
--

DROP TABLE IF EXISTS `permission_user`;
CREATE TABLE IF NOT EXISTS `permission_user` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`permission_id`,`user_type`),
  KEY `permission_user_permission_id_foreign` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `discount` double(8,2) NOT NULL,
  `discount_type` enum('percent','fixed') COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_location_id_foreign` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `location_id`, `name`, `description`, `price`, `discount`, `discount_type`, `image`, `default_image`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cook', '<p>Whate we do</p>', 10.00, 10.00, 'percent', '[\"94b97fc643285555387783733a16b7e2.jpg\"]', '94b97fc643285555387783733a16b7e2.jpg', 'active', '2021-12-03 01:13:57', '2021-12-03 01:13:58');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'administrator', 'Administrator', 'Administrator', '2021-12-02 23:53:24', '2021-12-02 23:53:24'),
(2, 'employee', 'Employee', 'Employee', '2021-12-02 23:53:24', '2021-12-02 23:53:24'),
(3, 'customer', 'Customer', 'Customer', '2021-12-02 23:53:24', '2021-12-02 23:53:24');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
CREATE TABLE IF NOT EXISTS `role_user` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`,`user_type`),
  KEY `role_user_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`role_id`, `user_id`, `user_type`) VALUES
(1, 1, 'App\\User');

-- --------------------------------------------------------

--
-- Table structure for table `sms_settings`
--

DROP TABLE IF EXISTS `sms_settings`;
CREATE TABLE IF NOT EXISTS `sms_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nexmo_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `nexmo_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nexmo_secret` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nexmo_from` varchar(191) COLLATE utf8_unicode_ci DEFAULT 'NEXMO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `msg91_status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'deactive',
  `msg91_key` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `msg91_from` varchar(191) COLLATE utf8_unicode_ci DEFAULT 'msgind',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sms_settings`
--

INSERT INTO `sms_settings` (`id`, `nexmo_status`, `nexmo_key`, `nexmo_secret`, `nexmo_from`, `created_at`, `updated_at`, `msg91_status`, `msg91_key`, `msg91_from`) VALUES
(1, 'deactive', NULL, NULL, 'NEXMO', '2021-12-02 23:53:23', '2021-12-02 23:53:23', 'deactive', NULL, 'msgind');

-- --------------------------------------------------------

--
-- Table structure for table `smtp_settings`
--

DROP TABLE IF EXISTS `smtp_settings`;
CREATE TABLE IF NOT EXISTS `smtp_settings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mail_driver` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_host` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_port` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_username` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_password` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_from_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_from_email` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `mail_encryption` enum('none','tls','ssl') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `smtp_settings`
--

INSERT INTO `smtp_settings` (`id`, `mail_driver`, `mail_host`, `mail_port`, `mail_username`, `mail_password`, `mail_from_name`, `mail_from_email`, `mail_encryption`, `created_at`, `updated_at`, `verified`) VALUES
(1, 'mail', 'smtp.gmail.com', '587', 'myemail@gmail.com', 'mypassword', 'Appointo', 'myemail@gmail.com', 'none', '2021-12-02 23:53:22', '2021-12-02 23:53:22', 0);

-- --------------------------------------------------------

--
-- Table structure for table `socials`
--

DROP TABLE IF EXISTS `socials`;
CREATE TABLE IF NOT EXISTS `socials` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `social_id` text COLLATE utf8_unicode_ci NOT NULL,
  `social_service` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_settings`
--

DROP TABLE IF EXISTS `social_auth_settings`;
CREATE TABLE IF NOT EXISTS `social_auth_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `google_client_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `google_secret_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `google_status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `facebook_client_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_secret_id` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook_status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `social_auth_settings`
--

INSERT INTO `social_auth_settings` (`id`, `google_client_id`, `google_secret_id`, `google_status`, `facebook_client_id`, `facebook_secret_id`, `facebook_status`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'inactive', NULL, NULL, 'inactive', '2021-12-02 23:53:29', '2021-12-02 23:53:29');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
CREATE TABLE IF NOT EXISTS `taxes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `percent` double(8,2) NOT NULL,
  `status` enum('active','deactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `tax_name`, `percent`, `status`, `created_at`, `updated_at`) VALUES
(1, 'GST', 18.00, 'active', '2021-12-02 23:53:21', '2021-12-02 23:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `theme_settings`
--

DROP TABLE IF EXISTS `theme_settings`;
CREATE TABLE IF NOT EXISTS `theme_settings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `primary_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `secondary_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `sidebar_bg_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `sidebar_text_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `topbar_text_color` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#FFFFFF',
  `custom_css` longtext COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `theme_settings`
--

INSERT INTO `theme_settings` (`id`, `primary_color`, `secondary_color`, `sidebar_bg_color`, `sidebar_text_color`, `topbar_text_color`, `custom_css`, `created_at`, `updated_at`) VALUES
(1, '#414552', '#788AE2', '#FFFFFF', '#5C5C62', '#FFFFFF', '/*Enter your custom css after this line*/', NULL, '2021-12-03 00:06:40');

-- --------------------------------------------------------

--
-- Table structure for table `todo_items`
--

DROP TABLE IF EXISTS `todo_items`;
CREATE TABLE IF NOT EXISTS `todo_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('pending','completed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `position` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `todo_items_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `universal_searches`
--

DROP TABLE IF EXISTS `universal_searches`;
CREATE TABLE IF NOT EXISTS `universal_searches` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `searchable_id` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `searchable_type` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `route_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `universal_searches`
--

INSERT INTO `universal_searches` (`id`, `searchable_id`, `searchable_type`, `title`, `route_name`, `created_at`, `updated_at`) VALUES
(1, '1', 'Location', 'Jaipur, India', 'admin.locations.edit', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(2, 'about-us', 'Page', 'About Us', 'admin.pages.edit', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(3, 'contact-us', 'Page', 'Contact Us', 'admin.pages.edit', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(4, 'how-it-works', 'Page', 'How It Works', 'admin.pages.edit', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(5, 'privacy-policy', 'Page', 'Privacy Policy', 'admin.pages.edit', '2021-12-02 23:53:23', '2021-12-02 23:53:23'),
(6, 'blog', 'Page', 'Blog', 'admin.pages.edit', '2021-12-02 23:53:28', '2021-12-02 23:53:28'),
(7, 'terms-and-conditions', 'Page', 'Terms And Conditions', 'admin.pages.edit', '2021-12-02 23:53:28', '2021-12-02 23:53:28'),
(8, '1', 'Category', 'Parking', 'admin.categories.edit', '2021-12-03 00:09:30', '2021-12-03 00:09:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `calling_code` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_verified` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rtl` enum('enabled','disabled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'disabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_country_id_foreign` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `group_id`, `name`, `email`, `calling_code`, `mobile`, `mobile_verified`, `password`, `image`, `remember_token`, `rtl`, `created_at`, `updated_at`, `deleted_at`, `country_id`) VALUES
(1, NULL, 'M.S.Dhoni', 'admin@example.com', NULL, '1919191919', 0, '$2y$10$m1hx6rCSRXvMpzRQwVRr5OMveg0wPwGnTe77K2QYi9xQgpGFlzZj6', NULL, 'trrHYaqs6tKZEZwEtr6uvaNy6xPv9fPcgQPWeoSacrq5zodCfagMJeYMknry', 'disabled', '2021-12-02 23:55:02', '2021-12-02 23:55:02', NULL, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_deal_id_foreign` FOREIGN KEY (`deal_id`) REFERENCES `deals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_items`
--
ALTER TABLE `booking_items`
  ADD CONSTRAINT `booking_items_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_items_business_service_id_foreign` FOREIGN KEY (`business_service_id`) REFERENCES `business_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_user`
--
ALTER TABLE `booking_user`
  ADD CONSTRAINT `booking_user_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `business_services`
--
ALTER TABLE `business_services`
  ADD CONSTRAINT `business_services_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `business_services_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `business_service_user`
--
ALTER TABLE `business_service_user`
  ADD CONSTRAINT `business_service_user_business_service_id_foreign` FOREIGN KEY (`business_service_id`) REFERENCES `business_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `business_service_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `company_settings`
--
ALTER TABLE `company_settings`
  ADD CONSTRAINT `company_settings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `coupon_users`
--
ALTER TABLE `coupon_users`
  ADD CONSTRAINT `coupon_users_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `coupon_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_feedback`
--
ALTER TABLE `customer_feedback`
  ADD CONSTRAINT `customer_feedback_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_feedback_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deal_items`
--
ALTER TABLE `deal_items`
  ADD CONSTRAINT `deal_items_business_service_id_foreign` FOREIGN KEY (`business_service_id`) REFERENCES `business_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `deal_items_deal_id_foreign` FOREIGN KEY (`deal_id`) REFERENCES `deals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_group_services`
--
ALTER TABLE `employee_group_services`
  ADD CONSTRAINT `employee_group_services_business_service_id_foreign` FOREIGN KEY (`business_service_id`) REFERENCES `business_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_group_services_employee_groups_id_foreign` FOREIGN KEY (`employee_groups_id`) REFERENCES `employee_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_schedules`
--
ALTER TABLE `employee_schedules`
  ADD CONSTRAINT `employee_schedules_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_taxes`
--
ALTER TABLE `item_taxes`
  ADD CONSTRAINT `item_taxes_deal_id_foreign` FOREIGN KEY (`deal_id`) REFERENCES `deals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_taxes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_taxes_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `business_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `item_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leaves`
--
ALTER TABLE `leaves`
  ADD CONSTRAINT `leaves_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_user`
--
ALTER TABLE `permission_user`
  ADD CONSTRAINT `permission_user_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `todo_items`
--
ALTER TABLE `todo_items`
  ADD CONSTRAINT `todo_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
