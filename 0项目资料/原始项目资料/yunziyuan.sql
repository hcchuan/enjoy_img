-- phpMyAdmin SQL Dump
-- version 4.7.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2018-01-13 17:34:39
-- 服务器版本： 5.5.54-log
-- PHP Version: 7.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `meishi_uwen_cn_`
--

-- --------------------------------------------------------

--
-- 表的结构 `admin_settings`
--

CREATE TABLE `admin_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `welcome_text` varchar(200) NOT NULL,
  `welcome_subtitle` text NOT NULL,
  `keywords` varchar(255) NOT NULL,
  `result_request` int(10) UNSIGNED NOT NULL COMMENT 'The max number of images per request',
  `limit_upload_user` int(10) UNSIGNED NOT NULL,
  `status_page` enum('0','1') NOT NULL DEFAULT '1' COMMENT '0 Offline, 1 Online',
  `message_length` int(11) UNSIGNED NOT NULL,
  `comment_length` int(11) UNSIGNED NOT NULL,
  `registration_active` enum('0','1') NOT NULL DEFAULT '1' COMMENT '0 No, 1 Yes',
  `email_verification` enum('0','1') NOT NULL COMMENT '0 Off, 1 On',
  `email_no_reply` varchar(200) NOT NULL,
  `email_admin` varchar(200) NOT NULL,
  `captcha` enum('on','off') NOT NULL DEFAULT 'on',
  `file_size_allowed` int(11) UNSIGNED NOT NULL COMMENT 'Size in Bytes',
  `facebook_login` enum('on','off') NOT NULL DEFAULT 'off',
  `google_analytics` text NOT NULL,
  `invitations_by_email` enum('on','off') NOT NULL DEFAULT 'on',
  `twitter` varchar(200) NOT NULL,
  `facebook` varchar(200) NOT NULL,
  `googleplus` varchar(200) NOT NULL,
  `linkedin` varchar(200) NOT NULL,
  `instagram` varchar(200) NOT NULL,
  `google_adsense` text NOT NULL,
  `auto_approve_images` enum('on','off') NOT NULL DEFAULT 'off',
  `tags_limit` int(10) UNSIGNED NOT NULL,
  `downloads` enum('all','users') NOT NULL DEFAULT 'all',
  `google_ads_index` enum('on','off') NOT NULL DEFAULT 'off',
  `description_length` int(10) UNSIGNED NOT NULL,
  `min_width_height_image` varchar(25) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `admin_settings`
--

INSERT INTO `admin_settings` (`id`, `title`, `description`, `welcome_text`, `welcome_subtitle`, `keywords`, `result_request`, `limit_upload_user`, `status_page`, `message_length`, `comment_length`, `registration_active`, `email_verification`, `email_no_reply`, `email_admin`, `captcha`, `file_size_allowed`, `facebook_login`, `google_analytics`, `invitations_by_email`, `twitter`, `facebook`, `googleplus`, `linkedin`, `instagram`, `google_adsense`, `auto_approve_images`, `tags_limit`, `downloads`, `google_ads_index`, `description_length`, `min_width_height_image`) VALUES
(1, '佳音布吉—免费高清图片上传下载', '佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 'HD清图片上传下载', '精选海量的高清美图', '高清图片,HD图标,图片上传', 36, 2, '1', 180, 180, '1', '0', '18581281315@163.com', '18581281315@163.com', 'off', 5120, 'off', '', 'off', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', '', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', '', 'on', 10, 'users', 'off', 160, '1024x768');

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `thumbnail` varchar(150) NOT NULL,
  `mode` enum('on','off') NOT NULL DEFAULT 'on'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `thumbnail`, `mode`) VALUES
(1, '花卉/植物', 'uncategorized', '', 'on'),
(2, '动物', 'animals', '', 'on'),
(3, '建筑', 'architecture', '', 'on'),
(4, '食品 & 饮料', 'foods-drinks', '', 'on'),
(5, '音乐', 'music', '', 'on'),
(6, '人物', 'people', '', 'on'),
(7, '城市', 'places', '', 'on'),
(8, '体育/运动', 'sports', '', 'on'),
(9, '旅游', 'travel', '', 'on'),
(10, '时装', 'fashion', '', 'on'),
(11, '交通汽车', 'cars', '', 'on'),
(12, '自然 / 风景', 'nature-landscapes', '', 'on'),
(13, '背景/纹理', 'backgrounds', '', 'on'),
(14, '金融 / 财务', 'business', '', 'on'),
(15, '电脑 / 通讯', 'computer', '', 'on'),
(16, '教育', 'education', '', 'on'),
(17, '情感', 'emotions', '', 'on'),
(18, '卫生 / 医疗', 'health', '', 'on'),
(19, '工业 / 工艺', 'industry', '', 'on'),
(20, '宗教', 'religion', '', 'on'),
(21, '科学 / 技术', 'science-technology', '', 'on');

-- --------------------------------------------------------

--
-- 表的结构 `collections`
--

CREATE TABLE `collections` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` enum('public','private') NOT NULL DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `collections_images`
--

CREATE TABLE `collections_images` (
  `id` int(11) UNSIGNED NOT NULL,
  `collections_id` int(10) UNSIGNED NOT NULL,
  `images_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `comments`
--

CREATE TABLE `comments` (
  `id` int(11) UNSIGNED NOT NULL,
  `images_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `reply` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '0 Trash, 1 Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `comments`
--

INSERT INTO `comments` (`id`, `images_id`, `user_id`, `reply`, `date`, `status`) VALUES
(1, 1, 1, '7777777777777777', '2018-01-11 10:12:41', '1'),
(2, 20, 1, '非常感谢', '2018-01-13 07:08:23', '1');

-- --------------------------------------------------------

--
-- 表的结构 `comments_likes`
--

CREATE TABLE `comments_likes` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `comment_id` int(11) UNSIGNED NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '0 trash, 1 active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name`) VALUES
(1, 'US', 'United States'),
(2, 'CA', 'Canada'),
(3, 'AF', 'Afghanistan'),
(4, 'AL', 'Albania'),
(5, 'DZ', 'Algeria'),
(6, 'DS', 'American Samoa'),
(7, 'AD', 'Andorra'),
(8, 'AO', 'Angola'),
(9, 'AI', 'Anguilla'),
(10, 'AQ', 'Antarctica'),
(11, 'AG', 'Antigua and/or Barbuda'),
(12, 'AR', 'Argentina'),
(13, 'AM', 'Armenia'),
(14, 'AW', 'Aruba'),
(15, 'AU', 'Australia'),
(16, 'AT', 'Austria'),
(17, 'AZ', 'Azerbaijan'),
(18, 'BS', 'Bahamas'),
(19, 'BH', 'Bahrain'),
(20, 'BD', 'Bangladesh'),
(21, 'BB', 'Barbados'),
(22, 'BY', 'Belarus'),
(23, 'BE', 'Belgium'),
(24, 'BZ', 'Belize'),
(25, 'BJ', 'Benin'),
(26, 'BM', 'Bermuda'),
(27, 'BT', 'Bhutan'),
(28, 'BO', 'Bolivia'),
(29, 'BA', 'Bosnia and Herzegovina'),
(30, 'BW', 'Botswana'),
(31, 'BV', 'Bouvet Island'),
(32, 'BR', 'Brazil'),
(33, 'IO', 'British lndian Ocean Territory'),
(34, 'BN', 'Brunei Darussalam'),
(35, 'BG', 'Bulgaria'),
(36, 'BF', 'Burkina Faso'),
(37, 'BI', 'Burundi'),
(38, 'KH', 'Cambodia'),
(39, 'CM', 'Cameroon'),
(40, 'CV', 'Cape Verde'),
(41, 'KY', 'Cayman Islands'),
(42, 'CF', 'Central African Republic'),
(43, 'TD', 'Chad'),
(44, 'CL', 'Chile'),
(45, 'CN', 'China'),
(46, 'CX', 'Christmas Island'),
(47, 'CC', 'Cocos (Keeling) Islands'),
(48, 'CO', 'Colombia'),
(49, 'KM', 'Comoros'),
(50, 'CG', 'Congo'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'HR', 'Croatia (Hrvatska)'),
(54, 'CU', 'Cuba'),
(55, 'CY', 'Cyprus'),
(56, 'CZ', 'Czech Republic'),
(57, 'DK', 'Denmark'),
(58, 'DJ', 'Djibouti'),
(59, 'DM', 'Dominica'),
(60, 'DO', 'Dominican Republic'),
(61, 'TP', 'East Timor'),
(62, 'EC', 'Ecuador'),
(63, 'EG', 'Egypt'),
(64, 'SV', 'El Salvador'),
(65, 'GQ', 'Equatorial Guinea'),
(66, 'ER', 'Eritrea'),
(67, 'EE', 'Estonia'),
(68, 'ET', 'Ethiopia'),
(69, 'FK', 'Falkland Islands (Malvinas)'),
(70, 'FO', 'Faroe Islands'),
(71, 'FJ', 'Fiji'),
(72, 'FI', 'Finland'),
(73, 'FR', 'France'),
(74, 'FX', 'France, Metropolitan'),
(75, 'GF', 'French Guiana'),
(76, 'PF', 'French Polynesia'),
(77, 'TF', 'French Southern Territories'),
(78, 'GA', 'Gabon'),
(79, 'GM', 'Gambia'),
(80, 'GE', 'Georgia'),
(81, 'DE', 'Germany'),
(82, 'GH', 'Ghana'),
(83, 'GI', 'Gibraltar'),
(84, 'GR', 'Greece'),
(85, 'GL', 'Greenland'),
(86, 'GD', 'Grenada'),
(87, 'GP', 'Guadeloupe'),
(88, 'GU', 'Guam'),
(89, 'GT', 'Guatemala'),
(90, 'GN', 'Guinea'),
(91, 'GW', 'Guinea-Bissau'),
(92, 'GY', 'Guyana'),
(93, 'HT', 'Haiti'),
(94, 'HM', 'Heard and Mc Donald Islands'),
(95, 'HN', 'Honduras'),
(96, 'HK', 'Hong Kong'),
(97, 'HU', 'Hungary'),
(98, 'IS', 'Iceland'),
(99, 'IN', 'India'),
(100, 'ID', 'Indonesia'),
(101, 'IR', 'Iran (Islamic Republic of)'),
(102, 'IQ', 'Iraq'),
(103, 'IE', 'Ireland'),
(104, 'IL', 'Israel'),
(105, 'IT', 'Italy'),
(106, 'CI', 'Ivory Coast'),
(107, 'JM', 'Jamaica'),
(108, 'JP', 'Japan'),
(109, 'JO', 'Jordan'),
(110, 'KZ', 'Kazakhstan'),
(111, 'KE', 'Kenya'),
(112, 'KI', 'Kiribati'),
(113, 'KP', 'Korea, Democratic People\'s Republic of'),
(114, 'KR', 'Korea, Republic of'),
(115, 'XK', 'Kosovo'),
(116, 'KW', 'Kuwait'),
(117, 'KG', 'Kyrgyzstan'),
(118, 'LA', 'Lao People\'s Democratic Republic'),
(119, 'LV', 'Latvia'),
(120, 'LB', 'Lebanon'),
(121, 'LS', 'Lesotho'),
(122, 'LR', 'Liberia'),
(123, 'LY', 'Libyan Arab Jamahiriya'),
(124, 'LI', 'Liechtenstein'),
(125, 'LT', 'Lithuania'),
(126, 'LU', 'Luxembourg'),
(127, 'MO', 'Macau'),
(128, 'MK', 'Macedonia'),
(129, 'MG', 'Madagascar'),
(130, 'MW', 'Malawi'),
(131, 'MY', 'Malaysia'),
(132, 'MV', 'Maldives'),
(133, 'ML', 'Mali'),
(134, 'MT', 'Malta'),
(135, 'MH', 'Marshall Islands'),
(136, 'MQ', 'Martinique'),
(137, 'MR', 'Mauritania'),
(138, 'MU', 'Mauritius'),
(139, 'TY', 'Mayotte'),
(140, 'MX', 'Mexico'),
(141, 'FM', 'Micronesia, Federated States of'),
(142, 'MD', 'Moldova, Republic of'),
(143, 'MC', 'Monaco'),
(144, 'MN', 'Mongolia'),
(145, 'ME', 'Montenegro'),
(146, 'MS', 'Montserrat'),
(147, 'MA', 'Morocco'),
(148, 'MZ', 'Mozambique'),
(149, 'MM', 'Myanmar'),
(150, 'NA', 'Namibia'),
(151, 'NR', 'Nauru'),
(152, 'NP', 'Nepal'),
(153, 'NL', 'Netherlands'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NC', 'New Caledonia'),
(156, 'NZ', 'New Zealand'),
(157, 'NI', 'Nicaragua'),
(158, 'NE', 'Niger'),
(159, 'NG', 'Nigeria'),
(160, 'NU', 'Niue'),
(161, 'NF', 'Norfork Island'),
(162, 'MP', 'Northern Mariana Islands'),
(163, 'NO', 'Norway'),
(164, 'OM', 'Oman'),
(165, 'PK', 'Pakistan'),
(166, 'PW', 'Palau'),
(167, 'PA', 'Panama'),
(168, 'PG', 'Papua New Guinea'),
(169, 'PY', 'Paraguay'),
(170, 'PE', 'Peru'),
(171, 'PH', 'Philippines'),
(172, 'PN', 'Pitcairn'),
(173, 'PL', 'Poland'),
(174, 'PT', 'Portugal'),
(175, 'PR', 'Puerto Rico'),
(176, 'QA', 'Qatar'),
(177, 'RE', 'Reunion'),
(178, 'RO', 'Romania'),
(179, 'RU', 'Russian Federation'),
(180, 'RW', 'Rwanda'),
(181, 'KN', 'Saint Kitts and Nevis'),
(182, 'LC', 'Saint Lucia'),
(183, 'VC', 'Saint Vincent and the Grenadines'),
(184, 'WS', 'Samoa'),
(185, 'SM', 'San Marino'),
(186, 'ST', 'Sao Tome and Principe'),
(187, 'SA', 'Saudi Arabia'),
(188, 'SN', 'Senegal'),
(189, 'RS', 'Serbia'),
(190, 'SC', 'Seychelles'),
(191, 'SL', 'Sierra Leone'),
(192, 'SG', 'Singapore'),
(193, 'SK', 'Slovakia'),
(194, 'SI', 'Slovenia'),
(195, 'SB', 'Solomon Islands'),
(196, 'SO', 'Somalia'),
(197, 'ZA', 'South Africa'),
(198, 'GS', 'South Georgia South Sandwich Islands'),
(199, 'ES', 'Spain'),
(200, 'LK', 'Sri Lanka'),
(201, 'SH', 'St. Helena'),
(202, 'PM', 'St. Pierre and Miquelon'),
(203, 'SD', 'Sudan'),
(204, 'SR', 'Suriname'),
(205, 'SJ', 'Svalbarn and Jan Mayen Islands'),
(206, 'SZ', 'Swaziland'),
(207, 'SE', 'Sweden'),
(208, 'CH', 'Switzerland'),
(209, 'SY', 'Syrian Arab Republic'),
(210, 'TW', 'Taiwan'),
(211, 'TJ', 'Tajikistan'),
(212, 'TZ', 'Tanzania, United Republic of'),
(213, 'TH', 'Thailand'),
(214, 'TG', 'Togo'),
(215, 'TK', 'Tokelau'),
(216, 'TO', 'Tonga'),
(217, 'TT', 'Trinidad and Tobago'),
(218, 'TN', 'Tunisia'),
(219, 'TR', 'Turkey'),
(220, 'TM', 'Turkmenistan'),
(221, 'TC', 'Turks and Caicos Islands'),
(222, 'TV', 'Tuvalu'),
(223, 'UG', 'Uganda'),
(224, 'UA', 'Ukraine'),
(225, 'AE', 'United Arab Emirates'),
(226, 'GB', 'United Kingdom'),
(227, 'UM', 'United States minor outlying islands'),
(228, 'UY', 'Uruguay'),
(229, 'UZ', 'Uzbekistan'),
(230, 'VU', 'Vanuatu'),
(231, 'VA', 'Vatican City State'),
(232, 'VE', 'Venezuela'),
(233, 'VN', 'Vietnam'),
(234, 'VG', 'Virgin Islands (British)'),
(235, 'VI', 'Virgin Islands (U.S.)'),
(236, 'WF', 'Wallis and Futuna Islands'),
(237, 'EH', 'Western Sahara'),
(238, 'YE', 'Yemen'),
(239, 'YU', 'Yugoslavia'),
(240, 'ZR', 'Zaire'),
(241, 'ZM', 'Zambia'),
(242, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- 表的结构 `downloads`
--

CREATE TABLE `downloads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `images_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(25) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `downloads`
--

INSERT INTO `downloads` (`id`, `images_id`, `user_id`, `ip`, `date`) VALUES
(1, 1, 0, '114.218.116.188', '2018-01-12 02:32:44'),
(2, 1, 0, '106.120.161.66', '2018-01-12 02:33:33');

-- --------------------------------------------------------

--
-- 表的结构 `followers`
--

CREATE TABLE `followers` (
  `id` int(10) UNSIGNED NOT NULL,
  `follower` int(11) UNSIGNED NOT NULL,
  `following` int(10) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '0 Delete, 1 Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `followers`
--

INSERT INTO `followers` (`id`, `follower`, `following`, `date`, `status`) VALUES
(1, 4, 1, '2018-01-13 06:25:11', '1');

-- --------------------------------------------------------

--
-- 表的结构 `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `preview` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `categories_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','pending') NOT NULL DEFAULT 'pending',
  `token_id` varchar(255) NOT NULL,
  `tags` text NOT NULL,
  `extension` varchar(25) NOT NULL,
  `colors` text NOT NULL,
  `exif` varchar(255) NOT NULL,
  `camera` varchar(255) NOT NULL,
  `featured` enum('yes','no') NOT NULL DEFAULT 'no',
  `featured_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `how_use_image` enum('free','free_personal','editorial_only','web_only') NOT NULL DEFAULT 'free',
  `attribution_required` enum('yes','no') NOT NULL DEFAULT 'no',
  `original_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `images`
--

INSERT INTO `images` (`id`, `thumbnail`, `preview`, `title`, `description`, `categories_id`, `user_id`, `date`, `status`, `token_id`, `tags`, `extension`, `colors`, `exif`, `camera`, `featured`, `featured_date`, `how_use_image`, `attribution_required`, `original_name`) VALUES
(1, '1515813379133-11515813413mcdoe1fjrp.jpg', '1515813379133-11515813413fyysaasppw.jpg', '1515813379133', '', 13, 1, '2018-01-13 03:16:56', 'active', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg', '77', 'jpg', '7275EA,CBB1FB,EA8A71,573C5B,8C6A69', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '1515813379133'),
(2, '-115158135380eb2dw90my.jpg', '-11515813538uczijpxr2z.jpg', '上海哦哦哦', '', 13, 1, '2018-01-13 03:19:01', 'active', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A', '7788', 'jpg', '0A2037,022A9B,984FC5,F786EE,E86D0F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '上海哦哦哦'),
(3, '-11515815836y8xz84r2qe.jpg', '-11515815836ikxjihwgk2.jpg', '北极的冰天雪地', '', 13, 1, '2018-01-13 03:57:18', 'active', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM', '冰天雪地', 'jpg', '689ABD,004DB9,CAE6EA,00045F,DA0404', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '北极的冰天雪地'),
(4, '-11515822626hxpply1ixf.jpg', '-115158226264fddpvmvnr.jpg', '北极风光图片', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:50:29', 'active', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u', '北极', 'jpg', '44558B,0B0D19,36656F,8C6441,C0B77E', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '北极风光图片'),
(5, '-11515822693nekqp7tfx1.jpg', '-11515822693dtazp6nsw4.jpg', '草丛里的蘑菇', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:51:37', 'active', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX', '蘑菇', 'jpg', '447B03,DAC900,1E3D02,593712,70BA4B', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '草丛里的蘑菇'),
(6, '-11515822733gqctyfzilx.jpg', '-11515822733m9h83udzqb.jpg', '大自然风景', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:52:16', 'active', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA', '大自然', 'jpg', '8AA9D7,344767,D03612,650F0E,6A4A19', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '大自然风景'),
(7, '-11515822780bq7o4ukxhn.jpg', '-11515822780yxef4m5no1.jpg', '非常漂亮的大峡谷', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:53:03', 'active', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy', '大峡谷', 'jpg', '4591EF,053566,324B2E,7B893E,AFC7ED', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '非常漂亮的大峡谷'),
(8, '-115158228792it5y7fcp1.jpg', '-11515822879dnkjdwjctx.jpg', '好看大海沙滩', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:54:43', 'active', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts', '沙滩', 'jpg', '138AA8,1E5F95,424C2A,C1BBA1,2A303C', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '好看大海沙滩'),
(9, '-11515822953rcuqvxlolt.jpg', '-11515822953i8ekcwf84o.jpg', '好看的松鼠风景图片', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:55:55', 'active', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c', '松鼠', 'jpg', '888343,AF9B94,875524,391600,FAD5A8', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '好看的风景图片'),
(10, '-11515822998lqta4sa6kg.jpg', '-11515822998t3curomwhu.jpg', '蓝天白云下的植物', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:56:41', 'active', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv', '植物', 'jpg', '66A8F4,3870CF,436D21,BEC517,F8F2DC', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '蓝天白云下的植物'),
(11, '-11515823043cqvojypkat.jpg', '-115158230431srrklyqkv.jpg', '蓝天白云与大海', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:57:31', 'active', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j', '大海', 'jpg', '7394DB,2B5C85,081639,C7A7BF,866F5F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '蓝天白云与大海'),
(12, '-11515823091jars4fn0dk.jpg', '-11515823091ezmqq03hkm.jpg', '美丽的大峡谷', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:58:15', 'active', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3', '大峡谷', 'jpg', 'C2CBDA,949025,473100,000417,34416B', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的大峡谷'),
(13, '-11515823149sagpb0qfrw.jpg', '-11515823149ximkeg1pbe.jpg', '美丽的大自然风光', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 05:59:18', 'active', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm', '大自然', 'jpg', '7E7BAA,CACDF0,0E0B28,D68872,955049', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的大自然风光'),
(14, '-11515823198iockxbkqaz.jpg', '-11515823198oxyf6aadnt.jpg', '美丽的星空', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 11, 1, '2018-01-13 06:00:00', 'active', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg', '星空', 'jpg', '473370,8E6D9A,C06C3D,7F3E2C,31051E', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的星空'),
(15, '-11515823238xxooj2iq5o.jpg', '-11515823238wudfvj6lmj.jpg', '树丛里面的蘑菇', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 06:00:42', 'active', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb', '蘑菇', 'jpg', '7FAE7A,4E7340,D87404,A93C13,2A3827', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '树丛里面的蘑菇'),
(16, '-11515823277atfsw28j6a.jpg', '-11515823277yn8qjyhkpp.jpg', '夕阳西下的草地', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 06:01:21', 'active', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ', '草地', 'jpg', '2780D0,FEC425,505F02,F29A68,632300', '', '', 'yes', '2018-01-12 22:47:10', 'free', 'no', '夕阳西下的草地'),
(17, '-11515823318sezzuaty6a.jpg', '-11515823318qsumy71qah.jpg', '一望无际的大草原', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 06:02:01', 'active', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH', '草原', 'jpg', 'BDC615,2B4504,3384D5,6D7F11,012B41', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '一望无际的大草原'),
(18, '-115158233500ze2xx7yrf.jpg', '-11515823350ohl08euevc.jpg', '中国南沙群岛', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 06:02:32', 'active', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3', '南沙群岛', 'jpg', '1B52AD,091A48,5488D1,1C526C,509167', '', '', 'yes', '2018-01-12 22:46:55', 'free', 'no', '中国南沙群岛'),
(21, '-11515831707kmxsvvn77n.jpg', '-11515831707b0sm54uloa.jpg', '美丽的乡间小路', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 08:21:51', 'active', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R', '乡间小路', 'jpg', '5C96A2,545C11,F0E5C9,81A817,E1B72F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '1515815321909');

-- --------------------------------------------------------

--
-- 表的结构 `images_reporteds`
--

CREATE TABLE `images_reporteds` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `reason` enum('copyright','privacy_issue','violent_sexual_content') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `likes`
--

CREATE TABLE `likes` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `images_id` int(11) UNSIGNED NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 NOT NULL DEFAULT '1' COMMENT '0 trash, 1 active',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `images_id`, `status`, `date`) VALUES
(1, 1, 1, '1', '2018-01-11 10:12:09'),
(2, 4, 18, '1', '2018-01-13 06:25:03');

-- --------------------------------------------------------

--
-- 表的结构 `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `destination` int(10) UNSIGNED NOT NULL,
  `author` int(10) UNSIGNED NOT NULL,
  `target` int(10) UNSIGNED NOT NULL,
  `type` enum('1','2','3','4','5','6','7') NOT NULL COMMENT '1 Follow, 2  Like, 3 reply, 4 Like Comment',
  `status` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0 unseen, 1 seen',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT '''0 No'',''1Yes'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `notifications`
--

INSERT INTO `notifications` (`id`, `destination`, `author`, `target`, `type`, `status`, `created_at`, `trash`) VALUES
(1, 1, 4, 18, '2', '1', '2018-01-13 06:25:03', '0'),
(2, 1, 4, 4, '1', '1', '2018-01-13 06:25:11', '0');

-- --------------------------------------------------------

--
-- 表的结构 `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pages`
--

INSERT INTO `pages` (`id`, `title`, `content`, `slug`) VALUES
(1, '帮助', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'help'),
(2, '条款', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'terms-of-service'),
(3, '隐私', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'privacy'),
(4, '广告', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'advertising'),
(5, '关于', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'about'),
(7, '支持', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'support');

-- --------------------------------------------------------

--
-- 表的结构 `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `token` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `password_resets`
--

INSERT INTO `password_resets` (`id`, `token`, `email`, `created_at`) VALUES
(10, '453ebd9fe88e4611f3645cf18b84a8993e00c23cef2dd48855ecf9d96dc05288', '1990672233@qq.com', '2018-01-12 18:17:06');

-- --------------------------------------------------------

--
-- 表的结构 `replies`
--

CREATE TABLE `replies` (
  `id` int(11) UNSIGNED NOT NULL,
  `comment_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `reply` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT '0 Trash, 1 Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `reserved`
--

CREATE TABLE `reserved` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `reserved`
--

INSERT INTO `reserved` (`id`, `name`) VALUES
(14, 'account'),
(31, 'api'),
(2, 'app'),
(30, 'bootstrap'),
(34, 'categories'),
(36, 'collections'),
(29, 'comment'),
(25, 'contact'),
(35, 'featured'),
(38, 'feed'),
(32, 'freebies'),
(9, 'goods'),
(1, 'gostock1'),
(11, 'jobs'),
(21, 'join'),
(16, 'latest'),
(37, 'likes'),
(20, 'login'),
(33, 'logout'),
(27, 'members'),
(13, 'messages'),
(19, 'notifications'),
(15, 'popular'),
(6, 'porn'),
(26, 'programs'),
(12, 'projects'),
(3, 'public'),
(23, 'register'),
(17, 'search'),
(7, 'sex'),
(8, 'tags'),
(24, 'upgrade'),
(28, 'upload'),
(4, 'vendor'),
(5, 'xxx');

-- --------------------------------------------------------

--
-- 表的结构 `stock`
--

CREATE TABLE `stock` (
  `id` int(10) UNSIGNED NOT NULL,
  `images_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('small','medium','large') NOT NULL,
  `extension` varchar(25) NOT NULL,
  `resolution` varchar(100) NOT NULL,
  `size` varchar(50) NOT NULL,
  `token` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `stock`
--

INSERT INTO `stock` (`id`, `images_id`, `name`, `type`, `extension`, `resolution`, `size`, `token`) VALUES
(1, 1, '11515813413u80torbvnwbv0eeg1scpmy5igfo2sewcsdqqfsh3p6hdeqzopzfw8ghbjznxzgsye6olvrxdgxxfktnmsske72xtk0fyytv6wfol.jpg', 'large', 'jpg', '1366x768', '145.1kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg'),
(2, 1, '11515813413izair5iwyeky2tdhtwqj7yqssdzy4xxpefbmsqhzqrhwynd2dqvx8gefsqc6kirzbbdj8jhtavcjlsov0hwegxvedp99oy2qyxau.jpg', 'medium', 'jpg', '1280x720', '120.5kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg'),
(3, 1, '11515813413za0tp89xp0l7ij8yveut6vtmyigbqx4cn7gdico1xbkvplzkaxxq5fsgtbjt6qsf5xkkwixnagagoscxzgt9wyozgyet6xh6vebl.jpg', 'small', 'jpg', '640x360', '36.7kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg'),
(4, 2, '11515813538du7frmbdrgfnecvfz28lj4je5xcgogshe5wyzpfnfhkmbcbkncalhrsnzzpdfgcqj5fkapyptelcsvkvnagxycqhdja3coe6pegu.jpg', 'large', 'jpg', '1366x768', '145.8kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A'),
(5, 2, '11515813538bq0ysppzjusgxfm3far1mfkovc8sx8wkstreglczdwhdoibhx5znyeymteamib2uuv2j40s0rjpgczf6zsq8zcnihmizedwx2wsq.jpg', 'medium', 'jpg', '1280x720', '120.6kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A'),
(6, 2, '11515813538s9vvdustlzofrjiqqe0c30qazvjedn1ozg8zblb6zc0qmnyl3l654mgnrxosdplor4pml59rqovzeux1bmsvkwwbsnvtmacrnjgg.jpg', 'small', 'jpg', '640x360', '37.2kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A'),
(7, 3, '115158158369bsvdlamiryifn55al6rlx8thbyja8k5mf3hya3s8ubwroabccmpxfm0udymvdynmivqlsqldgzbhu44uxdz0izdynve2kjpiyyf.jpg', 'large', 'jpg', '1366x768', '314.2kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM'),
(8, 3, '11515815836nbaougqo8dtnpzmzrvgtozpnfjfayc13bvpp26iqgag9lftlyekj8l10cx0n45weusah4ufoot4cojcb0auu7wk6u2kvvsoxjjzb.jpg', 'medium', 'jpg', '1280x720', '189.1kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM'),
(9, 3, '11515815836axgqd6ga4wejl1cpxrp6resyqsgnf86hxhp78z82krmmyjwglrp86dfcyeac5thhvygme3sg9fnqiagponxnfgs4ie4w8q4lg6im.jpg', 'small', 'jpg', '640x360', '53.1kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM'),
(10, 4, '11515822626cafvap6sraehgihysl8ovdkn6hxkyr1b1xlnjpzylda9ywn8rt0vtezapapdvwx1wvjbkwt7xd55varqvdbbvfdyc6n77fuf6qv5.jpg', 'large', 'jpg', '1366x768', '174.2kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u'),
(11, 4, '11515822626ptlzlt560ize7iyhpeetin88rsmcv39ecqkkkt7gz0nelpy70idwwa5jgnpfybniggpm0cd2wnow4ic8rugvogwfi2h1o4uqmc7n.jpg', 'medium', 'jpg', '1280x720', '112.6kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u'),
(12, 4, '11515822626hkvcobdudxup9loqsgasfs6p2lcvmd5ulastjcd4fr776na5spumyxhpx6jym2mufwht3lw1cqjjme1bgwk1vrofkss6zqwczs6j.jpg', 'small', 'jpg', '640x360', '34.7kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u'),
(13, 5, '1151582269306g8ijjnbiovgi3gdk9obwenabct3wpe8gdmqnfr4nqyklxlmtzx5eyljdpzsjspyu5hcrhiov3q3jxfol1fnjtbrcpjs599zv2d.jpg', 'large', 'jpg', '1366x768', '288.4kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX'),
(14, 5, '11515822693n6uk4qyf3ilm0rvgucvyxqf5k0tktntsxa6wzeis0cqyhnvhtxv8n9tonvdz63boizbnjyuyen4mdjgs2fxhhygan5zfsf5ullam.jpg', 'medium', 'jpg', '1280x720', '180.2kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX'),
(15, 5, '11515822693pp4zsrbabpbqujvxogdfnyxwpkugywifgrhls7pk9c2bj3mxtbzlttt54pesitshagod84awefwlyydgl9kvbojctjtrdipjpvkc.jpg', 'small', 'jpg', '640x360', '57.1kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX'),
(16, 6, '11515822733yp5au852ydcncyumbxiipizxriuqlhskaivbn1q01oeov9a5heghpkimwifoe0lwbnaxpqchimkzo2zivdlxz0d4ijywlqlsihuf.jpg', 'large', 'jpg', '1366x768', '220.6kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA'),
(17, 6, '11515822733zdnhw17hsrxpxc7md8pfbzirx1wgpzef90xy6sbq2x1dk7xwsqaeq2a6youcp6tcdx5bhypexrnwuhtjlsibv4ubrioumlvwo6qs.jpg', 'medium', 'jpg', '1280x720', '141.6kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA'),
(18, 6, '11515822733s9vwdmmfxsisrxypbbzwqsztzqvnjwnd3gl35dpipcndjhp10ifjysaysuuv66flam5rcmluv6jew7ktb0wr2ar8yhyl3zupu2ul.jpg', 'small', 'jpg', '640x360', '42.9kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA'),
(19, 7, '11515822780pqwrrrkbyzhawd7erztbzfkstgdcoxiw7fqhbv3yomhpectuub1ee9ykez7m65wjmxp8z09vqoojsd6vjjic42a4iy6hszj24ase.jpg', 'large', 'jpg', '1366x768', '325.3kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy'),
(20, 7, '11515822780xqrwmj940rua2ypu0mgwz2hvvrahovm9wsdp05n7hkgp5xstkmanxosu1gblrj7zhndlufgxyps8phaxd4dudbd6sre9pawpiqkp.jpg', 'medium', 'jpg', '1280x720', '226.7kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy'),
(21, 7, '11515822780jxmjjgqvwbf3hvrrhdbq6oe1x3rjg4ocjanfri4uptxlnyqukjphees9iad9tdfcke5tqfzpnldgnst8fignaxskaj7hpyai9bwp.jpg', 'small', 'jpg', '640x360', '74.5kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy'),
(22, 8, '11515822879mmx20cjvj0m7eihyzrciouifqkbarmvddp52omnvug7cnzf9g1ws1lgjayic3segkqyri2sjz2f45jpqyak7fcmxbglqm4ljes44.jpg', 'large', 'jpg', '1366x768', '646.9kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts'),
(23, 8, '11515822879kwqwnocm4hm7zdynnvap8tabmcujw4rctgqbsucpfsjpmrem5hybxc0ykoqmwvejv01y1jzkqwstqrqyvodfs6vvkawkesyibtac.jpg', 'medium', 'jpg', '1280x720', '378.8kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts'),
(24, 8, '115158228791iikb7ckaoqefwpzbq3hjow7dmki3inro2gj35ixpgvd5hxg83xsj5bh1ndhnwig3vneaf3p1trjewpblatd3b45zeaonxu8godh.jpg', 'small', 'jpg', '640x360', '95.1kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts'),
(25, 9, '115158229535dhfgqzvzmei50yeimz7q7u2uscb2yxur9pwulvoohsax8tyrhu6s4ic0trfxzj1mzprf9wqnwdexkwjzrjbnzssgv0oiptcwjz1.jpg', 'large', 'jpg', '1366x768', '233.9kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c'),
(26, 9, '11515822953itlirtw1ak7se5tlzgaaitlmtx45pnysizzljvetjg2uxo46np3dldofyvrz1umdfjqlsomwvv863gnt76vafb9kymhnrx9x8xaj.jpg', 'medium', 'jpg', '1280x720', '161.7kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c'),
(27, 9, '11515822953fjq0gthtz3h8qfhjwh6bzs8awjcderhcshcay0yoilu3tk3wkyyqwpbr7onoozo5hwyhhncpnhfq2dquibwdqtogfxujx5wnydlc.jpg', 'small', 'jpg', '640x360', '41.8kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c'),
(28, 10, '11515822998pzvnonjtrwoeyruqzpnr1boe3kjjm2rljeevnezrpwys7jqc5p78cdjeqp8a2ivhuxnhnbygbevnvx5boit2rdfylal2cr0ppyns.jpg', 'large', 'jpg', '1366x768', '274.7kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv'),
(29, 10, '11515822998ag0ymjszilkdii0p59tdxvhsimbsqnwvwsg2e38jkmzjrfthj5tynnpv2hcbvzwu9lmxlcsezpzzoq6ie4epbnrwkf1tgpni4shh.jpg', 'medium', 'jpg', '1280x720', '214.2kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv'),
(30, 10, '115158229980t5i2df46f42x8ghjt7phtjam9iojeslawaghhitwh67c9igxzc5avo6y0pnu19sdowujri3tve40caw8h3yenmz7rirvzelyjqr.jpg', 'small', 'jpg', '640x360', '59.9kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv'),
(31, 11, '11515823043grolrchkvz3bnmdv5kt5xo5bpu8lzuoor8d33xhxl7jblupexyxgs4ab42msm2nqtla2jp4uytwiqsezdobdnstlko9pxa03ss6f.jpg', 'large', 'jpg', '1366x768', '206.5kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j'),
(32, 11, '115158230434jvzg0oyf0hulc2eurxmrv4egorusdjnvjrstbh7uqee7w05eca3vwxjrw63xn6kzmd6gxitejozyblr5yy4egch65thsbj1peq2.jpg', 'medium', 'jpg', '1280x720', '135.3kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j'),
(33, 11, '11515823043zk4l7yk5cwrclzmpfyhanhzozfvpsx65tngxp7xrwwk1w09wllydkwutiry9a3vspd74ejryghor2nthgbezwneqmx7ebqfsxgfc.jpg', 'small', 'jpg', '640x360', '39.7kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j'),
(34, 12, '11515823091pbcoj7ecdchilucn70n7i8dgw0uefpjjpx9ysosx4wzx2cxmint2uhv3uzdr5nfxjfrxfvpgscuihklpaqkcxvtnudlvlrvjeqe1.jpg', 'large', 'jpg', '1366x768', '534.2kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3'),
(35, 12, '11515823091zcgoioubmuvpuy2pq1si7x7bn1feocufcuwlxpxvywuulw9foqmmorg2e8dgct3yekjw4zxhy3ul9iqozosglbdumwdbs7pgcys4.jpg', 'medium', 'jpg', '1280x720', '333.1kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3'),
(36, 12, '11515823091ehnqm2rerljnkjw6jqurrh1daxn8u3injue5n2wkqswanfumccxvnglacnfhvcfm09ddcyxqhck32j1jq0sodk9eerhfznrqj28u.jpg', 'small', 'jpg', '640x360', '96.3kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3'),
(37, 13, '11515823149jh0axwqdacbb8bmy9rrtsdabpkuhfc8uxx8xniesq5dmxuxq1m6djcwolch3vsmpojzu124plz32bp0v97cdtxf8c5ncn33glv1p.jpg', 'large', 'jpg', '1366x768', '332.1kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm'),
(38, 13, '11515823149i3blfnd9uskanmfjdtwxiusacv1pwvb9us2majufh93naakm2gqa4yxcdlv4ze7dwbjqtkdaezx76pcc8trv7lgybdqdcbmhlgtd.jpg', 'medium', 'jpg', '1280x720', '187.9kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm'),
(39, 13, '115158231494ottvmdhhuinos4fqj6n4bffslnjisybvk2qwz6egq32zvtk6tgvorziqqijnao2gamx6odfmtdfzq4ly9t1ascgh49mvzoxon2m.jpg', 'small', 'jpg', '640x360', '56.4kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm'),
(40, 14, '11515823198fkayku3cifdtavl59kjhuwdh7nmrtyh21qwlfppp1jncmdgrexpvza7d2mo8nbp6xn3sq8ed23nofkhihgdw0b5wblnxkqc2apdu.jpg', 'large', 'jpg', '1366x768', '171.6kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg'),
(41, 14, '11515823198vqkuqzap2vaaxynybckuszz9u61ltmewggwjlypqnnyfbxceuhv0yu3x8zb6jxwgmr62iac41ai45afgqf9qkhzwut5qy2vdjiaz.jpg', 'medium', 'jpg', '1280x720', '107.9kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg'),
(42, 14, '115158231986icidrdd1r4jpmurfbaiwdhoijs1ohh3o2dwzhghx8a9zpx3t6ogqogw8rr5mosv44gatxgzdai0nqph6rupctdzcznei4um11un.jpg', 'small', 'jpg', '640x360', '34.2kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg'),
(43, 15, '11515823238pfyjq1xagl83dlcmwres9byjj3c3tc7ooc8s6bjjhjlaqqe5exqiuqif6ovtghvkkbfhlzuijekiyaa61gl2f10yineee2soiiq0.jpg', 'large', 'jpg', '1366x768', '314.2kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb'),
(44, 15, '11515823238gjfnpym4rvkwkypyjgltoqlfqnla7hsintlai5uv1k8kdtkaunjukiomek7ezg5wwvbvqzboxrvzeew33bk8fe73fopfyhjx9xy1.jpg', 'medium', 'jpg', '1280x720', '204kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb'),
(45, 15, '115158232385g6402mfbomxrb8ispxyozhpwuhm9ggfbww5mw0ig0h3evshx5ysipeytazff3dha15uf2sbuvhkin2en5pexvlvcyn5mcmyznep.jpg', 'small', 'jpg', '640x360', '64.6kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb'),
(46, 16, '11515823277t3drgjbz2l0ddkwkycn9gz42gxdtgp2z1nbmwx02dp2uj7g0toxm7x0uetobzjekjc44txcmwfydhhy8s0lshih9hywcujn6ituy.jpg', 'large', 'jpg', '1365x768', '358.8kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ'),
(47, 16, '11515823277bjfy6sugvwvdfrbmlqbpnrlovfufdezlpku8m8ga8yzsq1rjwrn486qksij5gfyhf9ps4pusds9nxj0fqgrrmgxy9pwxpkqtdvir.jpg', 'medium', 'jpg', '1280x721', '282.7kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ'),
(48, 16, '11515823277bkqgyb7zakp3zt2cghfksfkvggwz1zv9fc8kgrhv3hyj5jnbt8uiyyitdarputciv3k2oojtssrgbgmuravyaiipa0csardzyqql.jpg', 'small', 'jpg', '640x361', '77.7kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ'),
(49, 17, '11515823318bdtiae7ljxiwcmgvbh5s0nwd145yyouahenwepqf8euktmomrm5rzppi4x0fa0rxbgrwuxollt10hytorlpcbsmpf5glgqtizkim.jpg', 'large', 'jpg', '1365x768', '312.8kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH'),
(50, 17, '11515823318izhuscnr6w054b7lkqwmyc1bqiweyolrzzun8ebmeewx9uhfspqw9pztife2ke6l63qobet7zhi2fmjiw9xjoy6rxael1o19i4dp.jpg', 'medium', 'jpg', '1280x721', '239.7kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH'),
(51, 17, '11515823318w3xzxmrycccnzg5fqgnyimspuq6gpgqg3tegukhlf7w7lhuwhk2uq60yo8eng8jlxvole6x7g8tho8kamntzyke8djhqz3amfzem.jpg', 'small', 'jpg', '640x361', '64.6kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH'),
(52, 18, '11515823350tlh6knzye4z680tveuj8zhlggcxjshmwcjhuuznkxbbrew6ueklyoczola1ibwme5w4rmyo7qc4orshpsoe421bn1ntgofjgfpik.jpg', 'large', 'jpg', '1366x768', '162.9kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3'),
(53, 18, '11515823350k99lek5eaxeixlce1sdikdstk3kuul6o3audvtnmbqj8fqlvgk4tztfnxeocss9hwmiyfsw2zw3ao8zyplo2ynj98j0bccpdqzoi.jpg', 'medium', 'jpg', '1280x720', '103.6kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3'),
(54, 18, '1151582335078ps9qhdbevdcdlylmdkrkdnz0g3zse4outtlazhskn62zvegiygd6rpducfdjg2k8edd78qkgnt3stlqcptkvebupe1qpn6ajua.jpg', 'small', 'jpg', '640x360', '31.4kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3'),
(61, 21, '11515831707ijfsffb7ndgnrjoxdp0cobzvzxsahxmcogilak8sr0aqwsthlowsmpfu6jqprpdsic4zsekpltw2rwdcqwdqp4o5l148vfme2udg.jpg', 'large', 'jpg', '1365x768', '330.3kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R'),
(62, 21, '115158317071mfzqyq9xy0snxvdn4ddcwthmifiv1hsu5oi6xz6tc6yfpujba2ubcnemooldhrpysrdomll32uum9hrnmxksxjkkuo1op1vvnyv.jpg', 'medium', 'jpg', '1280x721', '262.7kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R'),
(63, 21, '11515831707pkbxbfvi8o6vqeg7xnnq66qrjaomk7m18lpdbuwlxqv19tivtxx17gsmonk1wjvyeov2mzimhjwb6zox7xglxodkenqclfy2fedm.jpg', 'small', 'jpg', '640x361', '77kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R');

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `bio` varchar(200) NOT NULL,
  `countries_id` char(25) NOT NULL,
  `password` char(60) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `avatar` varchar(70) NOT NULL,
  `cover` varchar(255) NOT NULL,
  `status` enum('pending','active','suspended','delete') NOT NULL DEFAULT 'pending',
  `type_account` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1 Buyer, 2 Seller',
  `role` enum('normal','admin') NOT NULL DEFAULT 'normal',
  `website` varchar(255) NOT NULL,
  `remember_token` varchar(100) NOT NULL,
  `twitter` varchar(200) NOT NULL,
  `facebook` varchar(200) NOT NULL,
  `google` varchar(200) NOT NULL,
  `paypal_account` varchar(200) NOT NULL,
  `activation_code` varchar(150) NOT NULL,
  `oauth_uid` varchar(200) DEFAULT NULL,
  `oauth_provider` varchar(200) DEFAULT NULL,
  `token` varchar(80) NOT NULL,
  `authorized_to_upload` enum('yes','no') NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `bio`, `countries_id`, `password`, `email`, `date`, `avatar`, `cover`, `status`, `type_account`, `role`, `website`, `remember_token`, `twitter`, `facebook`, `google`, `paypal_account`, `activation_code`, `oauth_uid`, `oauth_provider`, `token`, `authorized_to_upload`) VALUES
(1, 'Admin', '佳音布吉', '我们不应该不惜任何代价地去保持友谊，从而使它受到玷污。如果为了那更伟大的爱，必须牺牲友谊，那也是没有办法的事；不过如果能够保持下去，那么，它就能真的达到完美的境界了。 —— 泰戈尔\r\n', '45', '$2y$10$wjbCfnJZ07JcBEb4aGD58.Urd0yAFfHsAyofPE3w9W61y05MgZBJa', 'admin@example.com', '2016-12-15 23:16:43', 'admin-11515824136rlrmhnhnkj.jpg', 'cover.jpg', 'active', '1', 'admin', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'ilFHKXsxqH4L9GgMLFq4HSXfPB2BMU7EJjlfn7gWBh81ldEa1uLB7agiHcNj', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'miguelvasquezweb@gmail.com', '', NULL, NULL, '', 'yes'),
(4, 'test520', '', '', '', '$2y$10$176Qt..6ZqHsi7j1K.uKHOS40wyjsmDZniJ5V7zKfv3OLbjfnycqS', '1990672233@qq.com', '2018-01-13 06:21:17', 'default.jpg', 'cover.jpg', 'active', '1', 'normal', '', 'oFsOSlzFj2PHimPyioGKbIQJczJcVQrKZ7pDYvvjk2TtmPkqKhE7wJg87WMP', '', '', '', '', '', NULL, NULL, 'XxnsfxiVXfFzNPtVR7OQNjiPRSPOburp6vtCbHTLY7EZps8M3jcTe0qcXR89vpHp48upC8WNTFW', 'yes');

-- --------------------------------------------------------

--
-- 表的结构 `users_reporteds`
--

CREATE TABLE `users_reporteds` (
  `id` int(10) UNSIGNED NOT NULL,
  `reason` enum('copyright','privacy_issue','violent_sexual_content','spoofing') NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `id_reported` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `visits`
--

CREATE TABLE `visits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `images_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(25) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `visits`
--

INSERT INTO `visits` (`id`, `images_id`, `user_id`, `ip`, `date`) VALUES
(1, 1, 0, '183.226.120.154', '2018-01-11 03:49:23'),
(2, 1, 0, '114.218.116.188', '2018-01-12 02:32:33'),
(3, 1, 0, '106.120.161.66', '2018-01-12 02:33:05'),
(4, 1, 0, '220.181.132.194', '2018-01-12 02:33:30'),
(5, 1, 2, '114.218.116.188', '2018-01-12 02:35:45'),
(6, 1, 0, '183.226.121.4', '2018-01-12 12:05:08'),
(7, 2, 0, '183.226.121.4', '2018-01-13 03:36:58'),
(8, 15, 0, '183.226.121.4', '2018-01-13 06:05:26'),
(9, 17, 0, '183.226.121.4', '2018-01-13 06:05:42'),
(10, 11, 0, '183.226.121.4', '2018-01-13 06:06:34'),
(11, 18, 0, '183.226.121.4', '2018-01-13 06:08:49'),
(12, 18, 4, '183.226.121.4', '2018-01-13 06:25:00'),
(13, 16, 0, '183.226.121.4', '2018-01-13 06:29:18'),
(14, 13, 0, '183.226.121.4', '2018-01-13 09:15:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_settings`
--
ALTER TABLE `admin_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slug` (`slug`);

--
-- Indexes for table `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `collections_images`
--
ALTER TABLE `collections_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `list_id` (`collections_id`,`images_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post` (`images_id`,`user_id`,`status`);

--
-- Indexes for table `comments_likes`
--
ALTER TABLE `comments_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`comment_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `downloads`
--
ALTER TABLE `downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publicacion_id` (`images_id`),
  ADD KEY `usr_id` (`user_id`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `followers`
--
ALTER TABLE `followers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follower` (`follower`,`following`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_id` (`token_id`),
  ADD KEY `author_id` (`user_id`,`status`,`token_id`),
  ADD KEY `image` (`preview`),
  ADD KEY `category_id` (`categories_id`);

--
-- Indexes for table `images_reporteds`
--
ALTER TABLE `images_reporteds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user_id`,`image_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usr` (`user_id`,`images_id`,`status`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `destination` (`destination`,`author`,`target`,`status`),
  ADD KEY `trash` (`trash`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_hash` (`token`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post` (`comment_id`,`user_id`,`status`);

--
-- Indexes for table `reserved`
--
ALTER TABLE `reserved`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`) USING BTREE;

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_shot` (`images_id`,`type`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `username` (`username`,`status`),
  ADD KEY `activation_code` (`activation_code`),
  ADD KEY `role` (`role`);

--
-- Indexes for table `users_reporteds`
--
ALTER TABLE `users_reporteds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user_id`,`id_reported`);

--
-- Indexes for table `visits`
--
ALTER TABLE `visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publicacion_id` (`images_id`),
  ADD KEY `usr_id` (`user_id`),
  ADD KEY `ip` (`ip`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `admin_settings`
--
ALTER TABLE `admin_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `collections`
--
ALTER TABLE `collections`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `collections_images`
--
ALTER TABLE `collections_images`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `comments_likes`
--
ALTER TABLE `comments_likes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- 使用表AUTO_INCREMENT `downloads`
--
ALTER TABLE `downloads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `followers`
--
ALTER TABLE `followers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `images_reporteds`
--
ALTER TABLE `images_reporteds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `replies`
--
ALTER TABLE `replies`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `reserved`
--
ALTER TABLE `reserved`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- 使用表AUTO_INCREMENT `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- 使用表AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `users_reporteds`
--
ALTER TABLE `users_reporteds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `visits`
--
ALTER TABLE `visits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
