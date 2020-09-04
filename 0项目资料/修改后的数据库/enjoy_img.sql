/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : enjoy_img

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 04/09/2020 14:23:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `welcome_text` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `welcome_subtitle` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `result_request` int(0) UNSIGNED NOT NULL COMMENT 'The max number of images per request',
  `limit_upload_user` int(0) UNSIGNED NOT NULL,
  `status_page` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 Offline, 1 Online',
  `message_length` int(0) UNSIGNED NOT NULL,
  `comment_length` int(0) UNSIGNED NOT NULL,
  `registration_active` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 No, 1 Yes',
  `email_verification` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '0 Off, 1 On',
  `email_no_reply` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email_admin` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `captcha` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'on',
  `file_size_allowed` int(0) UNSIGNED NOT NULL COMMENT 'Size in Bytes',
  `facebook_login` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off',
  `google_analytics` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invitations_by_email` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'on',
  `twitter` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `facebook` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `googleplus` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `linkedin` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instagram` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `google_adsense` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `auto_approve_images` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off',
  `tags_limit` int(0) UNSIGNED NOT NULL,
  `downloads` enum('all','users') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'all',
  `google_ads_index` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off',
  `description_length` int(0) UNSIGNED NOT NULL,
  `min_width_height_image` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------
INSERT INTO `admin_settings` VALUES (1, '佳音布吉—免费高清图片上传下载', '佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 'HD清图片上传下载', '精选海量的高清美图', '高清图片,HD图标,图片上传', 36, 2, '1', 180, 180, '1', '0', '18581281315@163.com', '18581281315@163.com', 'off', 1024, 'off', '', 'off', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', '', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vB5z&id=564099222906', '', 'on', 3, 'users', 'off', 160, '100x100');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `thumbnail` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mode` enum('on','off') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'on',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `slug`(`slug`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '花卉/植物', 'uncategorized', '', 'off');
INSERT INTO `categories` VALUES (2, '动物', 'animals', '', 'off');
INSERT INTO `categories` VALUES (3, '建筑', 'architecture', '', 'off');
INSERT INTO `categories` VALUES (4, '食品 & 饮料', 'foods-drinks', '', 'off');
INSERT INTO `categories` VALUES (5, '音乐', 'music', '', 'off');
INSERT INTO `categories` VALUES (6, '汽车', 'cars', '', 'off');
INSERT INTO `categories` VALUES (7, '城市', 'places', '', 'off');
INSERT INTO `categories` VALUES (8, '体育/运动', 'sports', '', 'off');
INSERT INTO `categories` VALUES (9, '旅游', 'travel', '', 'off');
INSERT INTO `categories` VALUES (10, '时装', 'fashion', '', 'off');
INSERT INTO `categories` VALUES (11, '美女', 'beauty', '', 'on');
INSERT INTO `categories` VALUES (12, '自然 / 风景', 'nature-landscapes', '', 'off');
INSERT INTO `categories` VALUES (13, '背景/纹理', 'backgrounds', '', 'off');
INSERT INTO `categories` VALUES (14, '金融 / 财务', 'business', '', 'off');
INSERT INTO `categories` VALUES (15, '电脑 / 通讯', 'computer', '', 'off');
INSERT INTO `categories` VALUES (16, '教育', 'education', '', 'off');
INSERT INTO `categories` VALUES (17, '情感', 'emotions', '', 'off');
INSERT INTO `categories` VALUES (18, '卫生 / 医疗', 'health', '', 'off');
INSERT INTO `categories` VALUES (19, '工业 / 工艺', 'industry', '', 'off');
INSERT INTO `categories` VALUES (20, '宗教', 'religion', '', 'off');
INSERT INTO `categories` VALUES (21, '科学 / 技术', 'science-technology', '', 'off');

-- ----------------------------
-- Table structure for collections
-- ----------------------------
DROP TABLE IF EXISTS `collections`;
CREATE TABLE `collections`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(0) UNSIGNED NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `update_at` timestamp(0) NOT NULL,
  `type` enum('public','private') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'public',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for collections_images
-- ----------------------------
DROP TABLE IF EXISTS `collections_images`;
CREATE TABLE `collections_images`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `collections_id` int(0) UNSIGNED NOT NULL,
  `images_id` int(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `list_id`(`collections_id`, `images_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `images_id` int(0) UNSIGNED NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `reply` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 Trash, 1 Active',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post`(`images_id`, `user_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 1, 1, '7777777777777777', '2018-01-11 18:12:41', '1');
INSERT INTO `comments` VALUES (2, 20, 1, '非常感谢', '2018-01-13 15:08:23', '1');
INSERT INTO `comments` VALUES (3, 22, 5, '111', '2020-09-04 13:33:07', '1');

-- ----------------------------
-- Table structure for comments_likes
-- ----------------------------
DROP TABLE IF EXISTS `comments_likes`;
CREATE TABLE `comments_likes`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(0) UNSIGNED NOT NULL,
  `comment_id` int(0) UNSIGNED NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 trash, 1 active',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`, `comment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `country_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 243 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of countries
-- ----------------------------
INSERT INTO `countries` VALUES (1, 'US', 'United States');
INSERT INTO `countries` VALUES (2, 'CA', 'Canada');
INSERT INTO `countries` VALUES (3, 'AF', 'Afghanistan');
INSERT INTO `countries` VALUES (4, 'AL', 'Albania');
INSERT INTO `countries` VALUES (5, 'DZ', 'Algeria');
INSERT INTO `countries` VALUES (6, 'DS', 'American Samoa');
INSERT INTO `countries` VALUES (7, 'AD', 'Andorra');
INSERT INTO `countries` VALUES (8, 'AO', 'Angola');
INSERT INTO `countries` VALUES (9, 'AI', 'Anguilla');
INSERT INTO `countries` VALUES (10, 'AQ', 'Antarctica');
INSERT INTO `countries` VALUES (11, 'AG', 'Antigua and/or Barbuda');
INSERT INTO `countries` VALUES (12, 'AR', 'Argentina');
INSERT INTO `countries` VALUES (13, 'AM', 'Armenia');
INSERT INTO `countries` VALUES (14, 'AW', 'Aruba');
INSERT INTO `countries` VALUES (15, 'AU', 'Australia');
INSERT INTO `countries` VALUES (16, 'AT', 'Austria');
INSERT INTO `countries` VALUES (17, 'AZ', 'Azerbaijan');
INSERT INTO `countries` VALUES (18, 'BS', 'Bahamas');
INSERT INTO `countries` VALUES (19, 'BH', 'Bahrain');
INSERT INTO `countries` VALUES (20, 'BD', 'Bangladesh');
INSERT INTO `countries` VALUES (21, 'BB', 'Barbados');
INSERT INTO `countries` VALUES (22, 'BY', 'Belarus');
INSERT INTO `countries` VALUES (23, 'BE', 'Belgium');
INSERT INTO `countries` VALUES (24, 'BZ', 'Belize');
INSERT INTO `countries` VALUES (25, 'BJ', 'Benin');
INSERT INTO `countries` VALUES (26, 'BM', 'Bermuda');
INSERT INTO `countries` VALUES (27, 'BT', 'Bhutan');
INSERT INTO `countries` VALUES (28, 'BO', 'Bolivia');
INSERT INTO `countries` VALUES (29, 'BA', 'Bosnia and Herzegovina');
INSERT INTO `countries` VALUES (30, 'BW', 'Botswana');
INSERT INTO `countries` VALUES (31, 'BV', 'Bouvet Island');
INSERT INTO `countries` VALUES (32, 'BR', 'Brazil');
INSERT INTO `countries` VALUES (33, 'IO', 'British lndian Ocean Territory');
INSERT INTO `countries` VALUES (34, 'BN', 'Brunei Darussalam');
INSERT INTO `countries` VALUES (35, 'BG', 'Bulgaria');
INSERT INTO `countries` VALUES (36, 'BF', 'Burkina Faso');
INSERT INTO `countries` VALUES (37, 'BI', 'Burundi');
INSERT INTO `countries` VALUES (38, 'KH', 'Cambodia');
INSERT INTO `countries` VALUES (39, 'CM', 'Cameroon');
INSERT INTO `countries` VALUES (40, 'CV', 'Cape Verde');
INSERT INTO `countries` VALUES (41, 'KY', 'Cayman Islands');
INSERT INTO `countries` VALUES (42, 'CF', 'Central African Republic');
INSERT INTO `countries` VALUES (43, 'TD', 'Chad');
INSERT INTO `countries` VALUES (44, 'CL', 'Chile');
INSERT INTO `countries` VALUES (45, 'CN', 'China');
INSERT INTO `countries` VALUES (46, 'CX', 'Christmas Island');
INSERT INTO `countries` VALUES (47, 'CC', 'Cocos (Keeling) Islands');
INSERT INTO `countries` VALUES (48, 'CO', 'Colombia');
INSERT INTO `countries` VALUES (49, 'KM', 'Comoros');
INSERT INTO `countries` VALUES (50, 'CG', 'Congo');
INSERT INTO `countries` VALUES (51, 'CK', 'Cook Islands');
INSERT INTO `countries` VALUES (52, 'CR', 'Costa Rica');
INSERT INTO `countries` VALUES (53, 'HR', 'Croatia (Hrvatska)');
INSERT INTO `countries` VALUES (54, 'CU', 'Cuba');
INSERT INTO `countries` VALUES (55, 'CY', 'Cyprus');
INSERT INTO `countries` VALUES (56, 'CZ', 'Czech Republic');
INSERT INTO `countries` VALUES (57, 'DK', 'Denmark');
INSERT INTO `countries` VALUES (58, 'DJ', 'Djibouti');
INSERT INTO `countries` VALUES (59, 'DM', 'Dominica');
INSERT INTO `countries` VALUES (60, 'DO', 'Dominican Republic');
INSERT INTO `countries` VALUES (61, 'TP', 'East Timor');
INSERT INTO `countries` VALUES (62, 'EC', 'Ecuador');
INSERT INTO `countries` VALUES (63, 'EG', 'Egypt');
INSERT INTO `countries` VALUES (64, 'SV', 'El Salvador');
INSERT INTO `countries` VALUES (65, 'GQ', 'Equatorial Guinea');
INSERT INTO `countries` VALUES (66, 'ER', 'Eritrea');
INSERT INTO `countries` VALUES (67, 'EE', 'Estonia');
INSERT INTO `countries` VALUES (68, 'ET', 'Ethiopia');
INSERT INTO `countries` VALUES (69, 'FK', 'Falkland Islands (Malvinas)');
INSERT INTO `countries` VALUES (70, 'FO', 'Faroe Islands');
INSERT INTO `countries` VALUES (71, 'FJ', 'Fiji');
INSERT INTO `countries` VALUES (72, 'FI', 'Finland');
INSERT INTO `countries` VALUES (73, 'FR', 'France');
INSERT INTO `countries` VALUES (74, 'FX', 'France, Metropolitan');
INSERT INTO `countries` VALUES (75, 'GF', 'French Guiana');
INSERT INTO `countries` VALUES (76, 'PF', 'French Polynesia');
INSERT INTO `countries` VALUES (77, 'TF', 'French Southern Territories');
INSERT INTO `countries` VALUES (78, 'GA', 'Gabon');
INSERT INTO `countries` VALUES (79, 'GM', 'Gambia');
INSERT INTO `countries` VALUES (80, 'GE', 'Georgia');
INSERT INTO `countries` VALUES (81, 'DE', 'Germany');
INSERT INTO `countries` VALUES (82, 'GH', 'Ghana');
INSERT INTO `countries` VALUES (83, 'GI', 'Gibraltar');
INSERT INTO `countries` VALUES (84, 'GR', 'Greece');
INSERT INTO `countries` VALUES (85, 'GL', 'Greenland');
INSERT INTO `countries` VALUES (86, 'GD', 'Grenada');
INSERT INTO `countries` VALUES (87, 'GP', 'Guadeloupe');
INSERT INTO `countries` VALUES (88, 'GU', 'Guam');
INSERT INTO `countries` VALUES (89, 'GT', 'Guatemala');
INSERT INTO `countries` VALUES (90, 'GN', 'Guinea');
INSERT INTO `countries` VALUES (91, 'GW', 'Guinea-Bissau');
INSERT INTO `countries` VALUES (92, 'GY', 'Guyana');
INSERT INTO `countries` VALUES (93, 'HT', 'Haiti');
INSERT INTO `countries` VALUES (94, 'HM', 'Heard and Mc Donald Islands');
INSERT INTO `countries` VALUES (95, 'HN', 'Honduras');
INSERT INTO `countries` VALUES (96, 'HK', 'Hong Kong');
INSERT INTO `countries` VALUES (97, 'HU', 'Hungary');
INSERT INTO `countries` VALUES (98, 'IS', 'Iceland');
INSERT INTO `countries` VALUES (99, 'IN', 'India');
INSERT INTO `countries` VALUES (100, 'ID', 'Indonesia');
INSERT INTO `countries` VALUES (101, 'IR', 'Iran (Islamic Republic of)');
INSERT INTO `countries` VALUES (102, 'IQ', 'Iraq');
INSERT INTO `countries` VALUES (103, 'IE', 'Ireland');
INSERT INTO `countries` VALUES (104, 'IL', 'Israel');
INSERT INTO `countries` VALUES (105, 'IT', 'Italy');
INSERT INTO `countries` VALUES (106, 'CI', 'Ivory Coast');
INSERT INTO `countries` VALUES (107, 'JM', 'Jamaica');
INSERT INTO `countries` VALUES (108, 'JP', 'Japan');
INSERT INTO `countries` VALUES (109, 'JO', 'Jordan');
INSERT INTO `countries` VALUES (110, 'KZ', 'Kazakhstan');
INSERT INTO `countries` VALUES (111, 'KE', 'Kenya');
INSERT INTO `countries` VALUES (112, 'KI', 'Kiribati');
INSERT INTO `countries` VALUES (113, 'KP', 'Korea, Democratic People\'s Republic of');
INSERT INTO `countries` VALUES (114, 'KR', 'Korea, Republic of');
INSERT INTO `countries` VALUES (115, 'XK', 'Kosovo');
INSERT INTO `countries` VALUES (116, 'KW', 'Kuwait');
INSERT INTO `countries` VALUES (117, 'KG', 'Kyrgyzstan');
INSERT INTO `countries` VALUES (118, 'LA', 'Lao People\'s Democratic Republic');
INSERT INTO `countries` VALUES (119, 'LV', 'Latvia');
INSERT INTO `countries` VALUES (120, 'LB', 'Lebanon');
INSERT INTO `countries` VALUES (121, 'LS', 'Lesotho');
INSERT INTO `countries` VALUES (122, 'LR', 'Liberia');
INSERT INTO `countries` VALUES (123, 'LY', 'Libyan Arab Jamahiriya');
INSERT INTO `countries` VALUES (124, 'LI', 'Liechtenstein');
INSERT INTO `countries` VALUES (125, 'LT', 'Lithuania');
INSERT INTO `countries` VALUES (126, 'LU', 'Luxembourg');
INSERT INTO `countries` VALUES (127, 'MO', 'Macau');
INSERT INTO `countries` VALUES (128, 'MK', 'Macedonia');
INSERT INTO `countries` VALUES (129, 'MG', 'Madagascar');
INSERT INTO `countries` VALUES (130, 'MW', 'Malawi');
INSERT INTO `countries` VALUES (131, 'MY', 'Malaysia');
INSERT INTO `countries` VALUES (132, 'MV', 'Maldives');
INSERT INTO `countries` VALUES (133, 'ML', 'Mali');
INSERT INTO `countries` VALUES (134, 'MT', 'Malta');
INSERT INTO `countries` VALUES (135, 'MH', 'Marshall Islands');
INSERT INTO `countries` VALUES (136, 'MQ', 'Martinique');
INSERT INTO `countries` VALUES (137, 'MR', 'Mauritania');
INSERT INTO `countries` VALUES (138, 'MU', 'Mauritius');
INSERT INTO `countries` VALUES (139, 'TY', 'Mayotte');
INSERT INTO `countries` VALUES (140, 'MX', 'Mexico');
INSERT INTO `countries` VALUES (141, 'FM', 'Micronesia, Federated States of');
INSERT INTO `countries` VALUES (142, 'MD', 'Moldova, Republic of');
INSERT INTO `countries` VALUES (143, 'MC', 'Monaco');
INSERT INTO `countries` VALUES (144, 'MN', 'Mongolia');
INSERT INTO `countries` VALUES (145, 'ME', 'Montenegro');
INSERT INTO `countries` VALUES (146, 'MS', 'Montserrat');
INSERT INTO `countries` VALUES (147, 'MA', 'Morocco');
INSERT INTO `countries` VALUES (148, 'MZ', 'Mozambique');
INSERT INTO `countries` VALUES (149, 'MM', 'Myanmar');
INSERT INTO `countries` VALUES (150, 'NA', 'Namibia');
INSERT INTO `countries` VALUES (151, 'NR', 'Nauru');
INSERT INTO `countries` VALUES (152, 'NP', 'Nepal');
INSERT INTO `countries` VALUES (153, 'NL', 'Netherlands');
INSERT INTO `countries` VALUES (154, 'AN', 'Netherlands Antilles');
INSERT INTO `countries` VALUES (155, 'NC', 'New Caledonia');
INSERT INTO `countries` VALUES (156, 'NZ', 'New Zealand');
INSERT INTO `countries` VALUES (157, 'NI', 'Nicaragua');
INSERT INTO `countries` VALUES (158, 'NE', 'Niger');
INSERT INTO `countries` VALUES (159, 'NG', 'Nigeria');
INSERT INTO `countries` VALUES (160, 'NU', 'Niue');
INSERT INTO `countries` VALUES (161, 'NF', 'Norfork Island');
INSERT INTO `countries` VALUES (162, 'MP', 'Northern Mariana Islands');
INSERT INTO `countries` VALUES (163, 'NO', 'Norway');
INSERT INTO `countries` VALUES (164, 'OM', 'Oman');
INSERT INTO `countries` VALUES (165, 'PK', 'Pakistan');
INSERT INTO `countries` VALUES (166, 'PW', 'Palau');
INSERT INTO `countries` VALUES (167, 'PA', 'Panama');
INSERT INTO `countries` VALUES (168, 'PG', 'Papua New Guinea');
INSERT INTO `countries` VALUES (169, 'PY', 'Paraguay');
INSERT INTO `countries` VALUES (170, 'PE', 'Peru');
INSERT INTO `countries` VALUES (171, 'PH', 'Philippines');
INSERT INTO `countries` VALUES (172, 'PN', 'Pitcairn');
INSERT INTO `countries` VALUES (173, 'PL', 'Poland');
INSERT INTO `countries` VALUES (174, 'PT', 'Portugal');
INSERT INTO `countries` VALUES (175, 'PR', 'Puerto Rico');
INSERT INTO `countries` VALUES (176, 'QA', 'Qatar');
INSERT INTO `countries` VALUES (177, 'RE', 'Reunion');
INSERT INTO `countries` VALUES (178, 'RO', 'Romania');
INSERT INTO `countries` VALUES (179, 'RU', 'Russian Federation');
INSERT INTO `countries` VALUES (180, 'RW', 'Rwanda');
INSERT INTO `countries` VALUES (181, 'KN', 'Saint Kitts and Nevis');
INSERT INTO `countries` VALUES (182, 'LC', 'Saint Lucia');
INSERT INTO `countries` VALUES (183, 'VC', 'Saint Vincent and the Grenadines');
INSERT INTO `countries` VALUES (184, 'WS', 'Samoa');
INSERT INTO `countries` VALUES (185, 'SM', 'San Marino');
INSERT INTO `countries` VALUES (186, 'ST', 'Sao Tome and Principe');
INSERT INTO `countries` VALUES (187, 'SA', 'Saudi Arabia');
INSERT INTO `countries` VALUES (188, 'SN', 'Senegal');
INSERT INTO `countries` VALUES (189, 'RS', 'Serbia');
INSERT INTO `countries` VALUES (190, 'SC', 'Seychelles');
INSERT INTO `countries` VALUES (191, 'SL', 'Sierra Leone');
INSERT INTO `countries` VALUES (192, 'SG', 'Singapore');
INSERT INTO `countries` VALUES (193, 'SK', 'Slovakia');
INSERT INTO `countries` VALUES (194, 'SI', 'Slovenia');
INSERT INTO `countries` VALUES (195, 'SB', 'Solomon Islands');
INSERT INTO `countries` VALUES (196, 'SO', 'Somalia');
INSERT INTO `countries` VALUES (197, 'ZA', 'South Africa');
INSERT INTO `countries` VALUES (198, 'GS', 'South Georgia South Sandwich Islands');
INSERT INTO `countries` VALUES (199, 'ES', 'Spain');
INSERT INTO `countries` VALUES (200, 'LK', 'Sri Lanka');
INSERT INTO `countries` VALUES (201, 'SH', 'St. Helena');
INSERT INTO `countries` VALUES (202, 'PM', 'St. Pierre and Miquelon');
INSERT INTO `countries` VALUES (203, 'SD', 'Sudan');
INSERT INTO `countries` VALUES (204, 'SR', 'Suriname');
INSERT INTO `countries` VALUES (205, 'SJ', 'Svalbarn and Jan Mayen Islands');
INSERT INTO `countries` VALUES (206, 'SZ', 'Swaziland');
INSERT INTO `countries` VALUES (207, 'SE', 'Sweden');
INSERT INTO `countries` VALUES (208, 'CH', 'Switzerland');
INSERT INTO `countries` VALUES (209, 'SY', 'Syrian Arab Republic');
INSERT INTO `countries` VALUES (210, 'TW', 'Taiwan');
INSERT INTO `countries` VALUES (211, 'TJ', 'Tajikistan');
INSERT INTO `countries` VALUES (212, 'TZ', 'Tanzania, United Republic of');
INSERT INTO `countries` VALUES (213, 'TH', 'Thailand');
INSERT INTO `countries` VALUES (214, 'TG', 'Togo');
INSERT INTO `countries` VALUES (215, 'TK', 'Tokelau');
INSERT INTO `countries` VALUES (216, 'TO', 'Tonga');
INSERT INTO `countries` VALUES (217, 'TT', 'Trinidad and Tobago');
INSERT INTO `countries` VALUES (218, 'TN', 'Tunisia');
INSERT INTO `countries` VALUES (219, 'TR', 'Turkey');
INSERT INTO `countries` VALUES (220, 'TM', 'Turkmenistan');
INSERT INTO `countries` VALUES (221, 'TC', 'Turks and Caicos Islands');
INSERT INTO `countries` VALUES (222, 'TV', 'Tuvalu');
INSERT INTO `countries` VALUES (223, 'UG', 'Uganda');
INSERT INTO `countries` VALUES (224, 'UA', 'Ukraine');
INSERT INTO `countries` VALUES (225, 'AE', 'United Arab Emirates');
INSERT INTO `countries` VALUES (226, 'GB', 'United Kingdom');
INSERT INTO `countries` VALUES (227, 'UM', 'United States minor outlying islands');
INSERT INTO `countries` VALUES (228, 'UY', 'Uruguay');
INSERT INTO `countries` VALUES (229, 'UZ', 'Uzbekistan');
INSERT INTO `countries` VALUES (230, 'VU', 'Vanuatu');
INSERT INTO `countries` VALUES (231, 'VA', 'Vatican City State');
INSERT INTO `countries` VALUES (232, 'VE', 'Venezuela');
INSERT INTO `countries` VALUES (233, 'VN', 'Vietnam');
INSERT INTO `countries` VALUES (234, 'VG', 'Virgin Islands (British)');
INSERT INTO `countries` VALUES (235, 'VI', 'Virgin Islands (U.S.)');
INSERT INTO `countries` VALUES (236, 'WF', 'Wallis and Futuna Islands');
INSERT INTO `countries` VALUES (237, 'EH', 'Western Sahara');
INSERT INTO `countries` VALUES (238, 'YE', 'Yemen');
INSERT INTO `countries` VALUES (239, 'YU', 'Yugoslavia');
INSERT INTO `countries` VALUES (240, 'ZR', 'Zaire');
INSERT INTO `countries` VALUES (241, 'ZM', 'Zambia');
INSERT INTO `countries` VALUES (242, 'ZW', 'Zimbabwe');

-- ----------------------------
-- Table structure for downloads
-- ----------------------------
DROP TABLE IF EXISTS `downloads`;
CREATE TABLE `downloads`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `images_id` int(0) UNSIGNED NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `ip` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `publicacion_id`(`images_id`) USING BTREE,
  INDEX `usr_id`(`user_id`) USING BTREE,
  INDEX `ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of downloads
-- ----------------------------
INSERT INTO `downloads` VALUES (1, 1, 0, '114.218.116.188', '2018-01-12 10:32:44');
INSERT INTO `downloads` VALUES (2, 1, 0, '106.120.161.66', '2018-01-12 10:33:33');

-- ----------------------------
-- Table structure for followers
-- ----------------------------
DROP TABLE IF EXISTS `followers`;
CREATE TABLE `followers`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `follower` int(0) UNSIGNED NOT NULL,
  `following` int(0) UNSIGNED NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '0 Delete, 1 Active',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `follower`(`follower`, `following`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of followers
-- ----------------------------
INSERT INTO `followers` VALUES (1, 4, 1, '2018-01-13 14:25:11', '1');

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `preview` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `categories_id` int(0) UNSIGNED NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `status` enum('active','pending') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'pending',
  `token_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tags` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `extension` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `colors` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `exif` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `camera` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `featured` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'no',
  `featured_date` timestamp(0) NOT NULL,
  `how_use_image` enum('free','free_personal','editorial_only','web_only') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'free',
  `attribution_required` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'no',
  `original_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `token_id`(`token_id`) USING BTREE,
  INDEX `author_id`(`user_id`, `status`, `token_id`) USING BTREE,
  INDEX `image`(`preview`) USING BTREE,
  INDEX `category_id`(`categories_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES (1, '1515813379133-11515813413mcdoe1fjrp.jpg', '1515813379133-11515813413fyysaasppw.jpg', '1515813379133', '', 13, 1, '2018-01-13 11:16:56', 'active', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg', '77', 'jpg', '7275EA,CBB1FB,EA8A71,573C5B,8C6A69', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '1515813379133');
INSERT INTO `images` VALUES (2, '-115158135380eb2dw90my.jpg', '-11515813538uczijpxr2z.jpg', '上海哦哦哦', '', 13, 1, '2018-01-13 11:19:01', 'active', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A', '7788', 'jpg', '0A2037,022A9B,984FC5,F786EE,E86D0F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '上海哦哦哦');
INSERT INTO `images` VALUES (3, '-11515815836y8xz84r2qe.jpg', '-11515815836ikxjihwgk2.jpg', '北极的冰天雪地', '', 13, 1, '2018-01-13 11:57:18', 'active', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM', '冰天雪地', 'jpg', '689ABD,004DB9,CAE6EA,00045F,DA0404', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '北极的冰天雪地');
INSERT INTO `images` VALUES (4, '-11515822626hxpply1ixf.jpg', '-115158226264fddpvmvnr.jpg', '北极风光图片', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:50:29', 'active', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u', '北极', 'jpg', '44558B,0B0D19,36656F,8C6441,C0B77E', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '北极风光图片');
INSERT INTO `images` VALUES (5, '-11515822693nekqp7tfx1.jpg', '-11515822693dtazp6nsw4.jpg', '草丛里的蘑菇', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:51:37', 'active', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX', '蘑菇', 'jpg', '447B03,DAC900,1E3D02,593712,70BA4B', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '草丛里的蘑菇');
INSERT INTO `images` VALUES (6, '-11515822733gqctyfzilx.jpg', '-11515822733m9h83udzqb.jpg', '大自然风景', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:52:16', 'active', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA', '大自然', 'jpg', '8AA9D7,344767,D03612,650F0E,6A4A19', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '大自然风景');
INSERT INTO `images` VALUES (7, '-11515822780bq7o4ukxhn.jpg', '-11515822780yxef4m5no1.jpg', '非常漂亮的大峡谷', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:53:03', 'active', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy', '大峡谷', 'jpg', '4591EF,053566,324B2E,7B893E,AFC7ED', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '非常漂亮的大峡谷');
INSERT INTO `images` VALUES (8, '-115158228792it5y7fcp1.jpg', '-11515822879dnkjdwjctx.jpg', '好看大海沙滩', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:54:43', 'active', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts', '沙滩', 'jpg', '138AA8,1E5F95,424C2A,C1BBA1,2A303C', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '好看大海沙滩');
INSERT INTO `images` VALUES (9, '-11515822953rcuqvxlolt.jpg', '-11515822953i8ekcwf84o.jpg', '好看的松鼠风景图片', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:55:55', 'active', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c', '松鼠', 'jpg', '888343,AF9B94,875524,391600,FAD5A8', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '好看的风景图片');
INSERT INTO `images` VALUES (10, '-11515822998lqta4sa6kg.jpg', '-11515822998t3curomwhu.jpg', '蓝天白云下的植物', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:56:41', 'active', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv', '植物', 'jpg', '66A8F4,3870CF,436D21,BEC517,F8F2DC', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '蓝天白云下的植物');
INSERT INTO `images` VALUES (11, '-11515823043cqvojypkat.jpg', '-115158230431srrklyqkv.jpg', '蓝天白云与大海', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:57:31', 'active', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j', '大海', 'jpg', '7394DB,2B5C85,081639,C7A7BF,866F5F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '蓝天白云与大海');
INSERT INTO `images` VALUES (12, '-11515823091jars4fn0dk.jpg', '-11515823091ezmqq03hkm.jpg', '美丽的大峡谷', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:58:15', 'active', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3', '大峡谷', 'jpg', 'C2CBDA,949025,473100,000417,34416B', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的大峡谷');
INSERT INTO `images` VALUES (13, '-11515823149sagpb0qfrw.jpg', '-11515823149ximkeg1pbe.jpg', '美丽的大自然风光', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 13:59:18', 'active', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm', '大自然', 'jpg', '7E7BAA,CACDF0,0E0B28,D68872,955049', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的大自然风光');
INSERT INTO `images` VALUES (14, '-11515823198iockxbkqaz.jpg', '-11515823198oxyf6aadnt.jpg', '美丽的星空', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 11, 1, '2018-01-13 14:00:00', 'active', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg', '星空', 'jpg', '473370,8E6D9A,C06C3D,7F3E2C,31051E', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '美丽的星空');
INSERT INTO `images` VALUES (15, '-11515823238xxooj2iq5o.jpg', '-11515823238wudfvj6lmj.jpg', '树丛里面的蘑菇', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 14:00:42', 'active', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb', '蘑菇', 'jpg', '7FAE7A,4E7340,D87404,A93C13,2A3827', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '树丛里面的蘑菇');
INSERT INTO `images` VALUES (16, '-11515823277atfsw28j6a.jpg', '-11515823277yn8qjyhkpp.jpg', '夕阳西下的草地', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 14:01:21', 'active', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ', '草地', 'jpg', '2780D0,FEC425,505F02,F29A68,632300', '', '', 'yes', '2018-01-13 06:47:10', 'free', 'no', '夕阳西下的草地');
INSERT INTO `images` VALUES (17, '-11515823318sezzuaty6a.jpg', '-11515823318qsumy71qah.jpg', '一望无际的大草原', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 14:02:01', 'active', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH', '草原', 'jpg', 'BDC615,2B4504,3384D5,6D7F11,012B41', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '一望无际的大草原');
INSERT INTO `images` VALUES (18, '-115158233500ze2xx7yrf.jpg', '-11515823350ohl08euevc.jpg', '中国南沙群岛', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 14:02:32', 'active', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3', '南沙群岛', 'jpg', '1B52AD,091A48,5488D1,1C526C,509167', '', '', 'yes', '2018-01-13 06:46:55', 'free', 'no', '中国南沙群岛');
INSERT INTO `images` VALUES (21, '-11515831707kmxsvvn77n.jpg', '-11515831707b0sm54uloa.jpg', '美丽的乡间小路', '这里是图片描述，在上传时候可以进行填写，佳音图片使用世界前沿的人工智能技术,为用户甄选海量的高清美图,用更流畅、更快捷、更精准的搜索体验,带你去发现多彩的世界。', 12, 1, '2018-01-13 16:21:51', 'active', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R', '乡间小路', 'jpg', '5C96A2,545C11,F0E5C9,81A817,E1B72F', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '1515815321909');
INSERT INTO `images` VALUES (22, '220x165-0-2013082608552885566-51599197575jyxu2llfv2.jpg', '220x165-0-2013082608552885566-51599197575eql6l3akno.jpg', '220x165_0_2013082608552885566', '', 11, 5, '2020-09-04 13:32:57', 'active', 'yqoWiKjBYMaeoPpFjbs440rhnhuCyXrdt09CudBaZlm3Zgttg5NMxXg1gdZf7sK22yfY2rXUsy7mktML3VogbdHGdnd5Ycm2Fpp33EdsfKzMaRFqsoHgYRiRkem3kigspM0HwXHaywxOveqCF6ELJ57a6mkzkgtGkDl0COZnDlzIAXt97M7s5CFgkwk3Gmgruqw69nRE', 'first', 'jpg', '0A0019,A23A21,E76C4A,4F2026,60A9D2', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '220x165_0_2013082608552885566');
INSERT INTO `images` VALUES (23, '220x165-0-2013091105023733144-51599199777tvrdpwd5iy.jpg', '220x165-0-2013091105023733144-51599199777hnd9b0hsb7.jpg', '220x165_0_2013091105023733144', '', 11, 5, '2020-09-04 14:09:38', 'active', '98oayBSIfsZpIKVg1hTBCF3IK8BgaOmhX9A5656VHWq9A47SISiCOoaNuptLUmMnL2B1DLsUVUIcSxE9ewN5k99nEDyXEbN81xIvswqWnkpyIKNwD2AcnqlC2NIAHQd5jVGiQT2ECx33el6TBvjUe9HoDA1aAQj3YMKicdlsOfqHktzChiGRrEdSbw9JRTcyXIASy5sV', '美女', 'jpg', '28382E,C7142A,89A1AB,FF529D,C9A827', '', '', 'no', '0000-00-00 00:00:00', 'free', 'no', '220x165_0_2013091105023733144');

-- ----------------------------
-- Table structure for images_reporteds
-- ----------------------------
DROP TABLE IF EXISTS `images_reporteds`;
CREATE TABLE `images_reporteds`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(0) UNSIGNED NOT NULL,
  `image_id` int(0) UNSIGNED NOT NULL,
  `reason` enum('copyright','privacy_issue','violent_sexual_content') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user`(`user_id`, `image_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(0) UNSIGNED NOT NULL,
  `images_id` int(0) UNSIGNED NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 trash, 1 active',
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_usr`(`user_id`, `images_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (1, 1, 1, '1', '2018-01-11 18:12:09');
INSERT INTO `likes` VALUES (2, 4, 18, '1', '2018-01-13 14:25:03');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `migration` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `destination` int(0) UNSIGNED NOT NULL,
  `author` int(0) UNSIGNED NOT NULL,
  `target` int(0) UNSIGNED NOT NULL,
  `type` enum('1','2','3','4','5','6','7') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '1 Follow, 2  Like, 3 reply, 4 Like Comment',
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '0 unseen, 1 seen',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `trash` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '\'0 No\',\'1Yes\'',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `destination`(`destination`, `author`, `target`, `status`) USING BTREE,
  INDEX `trash`(`trash`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notifications
-- ----------------------------
INSERT INTO `notifications` VALUES (1, 1, 4, 18, '2', '1', '2018-01-13 14:25:03', '0');
INSERT INTO `notifications` VALUES (2, 1, 4, 4, '1', '1', '2018-01-13 14:25:11', '0');

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pages
-- ----------------------------
INSERT INTO `pages` VALUES (1, '帮助', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'help');
INSERT INTO `pages` VALUES (2, '条款', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'terms-of-service');
INSERT INTO `pages` VALUES (3, '隐私', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'privacy');
INSERT INTO `pages` VALUES (4, '广告', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'advertising');
INSERT INTO `pages` VALUES (5, '关于', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'about');
INSERT INTO `pages` VALUES (7, '支持', '<p>北京全景视觉网络科技股份有限公司，自2005年创建起始终专注于视觉价值的提升。从传统的图片代理成功转型为&ldquo;图片搜索+图片电子商务&rdquo;新型互联网模式，全景不断打造广告/传媒人视觉工作的新平台。</p>\r\n\r\n<p>作为中国杰出的本土大型图片库机构之一，全景最大的优势在于图片资源的整合与贴近用户的增值服务。全景独家代理世界范围内100多家著名图片品牌和数百位国内知名摄影师，为用户提供八千多万张品质图片和上百万条视频短片，从创意图片、编辑图片、东方元素图片、图片版权服务等各方面为用户提供所需。</p>\r\n\r\n<p>全景总部设在北京，并在上海、广州、深圳、香港四大创意传媒中心城市设有运营机构，更便于快速回应用户需求。根据创意工作特点，全景提供7X24小时全天候服务，并在业内首创大图支持，便于广告比稿与提案，同时提供小图、找图、修图的增值服务，令创意表现呈现完美。针对用户特殊需求而设的定向化拍摄与专业化视觉解决方案，有力地满足了企业主的传播要求，提高行销效率。</p>\r\n\r\n<p>致力于&ldquo;创意视觉经济&rdquo;的企业定位，全景将以市场为导向，以满足用户需求为根本，以销售为中心，为中国与世界各地的创意/传媒人提供更宽广平台，为中国创意视觉经济的发展助力。</p>\r\n', 'support');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_hash`(`token`) USING BTREE,
  INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
INSERT INTO `password_resets` VALUES (10, '453ebd9fe88e4611f3645cf18b84a8993e00c23cef2dd48855ecf9d96dc05288', '1990672233@qq.com', '2018-01-13 02:17:06');

-- ----------------------------
-- Table structure for replies
-- ----------------------------
DROP TABLE IF EXISTS `replies`;
CREATE TABLE `replies`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_id` int(0) UNSIGNED NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `reply` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '0 Trash, 1 Active',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `post`(`comment_id`, `user_id`, `status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reserved
-- ----------------------------
DROP TABLE IF EXISTS `reserved`;
CREATE TABLE `reserved`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserved
-- ----------------------------
INSERT INTO `reserved` VALUES (14, 'account');
INSERT INTO `reserved` VALUES (31, 'api');
INSERT INTO `reserved` VALUES (2, 'app');
INSERT INTO `reserved` VALUES (30, 'bootstrap');
INSERT INTO `reserved` VALUES (34, 'categories');
INSERT INTO `reserved` VALUES (36, 'collections');
INSERT INTO `reserved` VALUES (29, 'comment');
INSERT INTO `reserved` VALUES (25, 'contact');
INSERT INTO `reserved` VALUES (35, 'featured');
INSERT INTO `reserved` VALUES (38, 'feed');
INSERT INTO `reserved` VALUES (32, 'freebies');
INSERT INTO `reserved` VALUES (9, 'goods');
INSERT INTO `reserved` VALUES (1, 'gostock1');
INSERT INTO `reserved` VALUES (11, 'jobs');
INSERT INTO `reserved` VALUES (21, 'join');
INSERT INTO `reserved` VALUES (16, 'latest');
INSERT INTO `reserved` VALUES (37, 'likes');
INSERT INTO `reserved` VALUES (20, 'login');
INSERT INTO `reserved` VALUES (33, 'logout');
INSERT INTO `reserved` VALUES (27, 'members');
INSERT INTO `reserved` VALUES (13, 'messages');
INSERT INTO `reserved` VALUES (19, 'notifications');
INSERT INTO `reserved` VALUES (15, 'popular');
INSERT INTO `reserved` VALUES (6, 'porn');
INSERT INTO `reserved` VALUES (26, 'programs');
INSERT INTO `reserved` VALUES (12, 'projects');
INSERT INTO `reserved` VALUES (3, 'public');
INSERT INTO `reserved` VALUES (23, 'register');
INSERT INTO `reserved` VALUES (17, 'search');
INSERT INTO `reserved` VALUES (7, 'sex');
INSERT INTO `reserved` VALUES (8, 'tags');
INSERT INTO `reserved` VALUES (24, 'upgrade');
INSERT INTO `reserved` VALUES (28, 'upload');
INSERT INTO `reserved` VALUES (4, 'vendor');
INSERT INTO `reserved` VALUES (5, 'xxx');

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `images_id` int(0) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` enum('small','medium','large') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `extension` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resolution` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `size` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_shot`(`images_id`, `type`) USING BTREE,
  INDEX `token`(`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES (1, 1, '11515813413u80torbvnwbv0eeg1scpmy5igfo2sewcsdqqfsh3p6hdeqzopzfw8ghbjznxzgsye6olvrxdgxxfktnmsske72xtk0fyytv6wfol.jpg', 'large', 'jpg', '1366x768', '145.1kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg');
INSERT INTO `stock` VALUES (2, 1, '11515813413izair5iwyeky2tdhtwqj7yqssdzy4xxpefbmsqhzqrhwynd2dqvx8gefsqc6kirzbbdj8jhtavcjlsov0hwegxvedp99oy2qyxau.jpg', 'medium', 'jpg', '1280x720', '120.5kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg');
INSERT INTO `stock` VALUES (3, 1, '11515813413za0tp89xp0l7ij8yveut6vtmyigbqx4cn7gdico1xbkvplzkaxxq5fsgtbjt6qsf5xkkwixnagagoscxzgt9wyozgyet6xh6vebl.jpg', 'small', 'jpg', '640x360', '36.7kB', 'D8trlJmBk3Mo6ZvSBDnP8ANS001KDHilceFrEX4o6GOcSrf95b0Eea3c9FwLmNfz8Yp9PRBkFbEh46CTh3DaaOQbLAP1v7Na4oLBLAj2frdjO3BpE5ibDBzr1apJWxbYlKHDZSPOSxW0cA5TSQXdFv3Cp9Ek7IgKv1FCLcUPhM6Jv9EXL1jOR72PIWjSf4cMHzj3jphg');
INSERT INTO `stock` VALUES (4, 2, '11515813538du7frmbdrgfnecvfz28lj4je5xcgogshe5wyzpfnfhkmbcbkncalhrsnzzpdfgcqj5fkapyptelcsvkvnagxycqhdja3coe6pegu.jpg', 'large', 'jpg', '1366x768', '145.8kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A');
INSERT INTO `stock` VALUES (5, 2, '11515813538bq0ysppzjusgxfm3far1mfkovc8sx8wkstreglczdwhdoibhx5znyeymteamib2uuv2j40s0rjpgczf6zsq8zcnihmizedwx2wsq.jpg', 'medium', 'jpg', '1280x720', '120.6kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A');
INSERT INTO `stock` VALUES (6, 2, '11515813538s9vvdustlzofrjiqqe0c30qazvjedn1ozg8zblb6zc0qmnyl3l654mgnrxosdplor4pml59rqovzeux1bmsvkwwbsnvtmacrnjgg.jpg', 'small', 'jpg', '640x360', '37.2kB', 'ajclC9XmVjVuJTEyBGE7HXfHtS5GEGrX0dgvA7hLn8L0wdAlmZQwOGuGiDpMmIxZq2zs4tA4LNbBCL34JZR28xk6HHr7zJbkKzNRpDnRO8V91CE4vNQvXLZrEvXF6GbYfBoQcRjn6WtcOcyRZFtwNUGQOVxDTFHEvChOem2C3rSXiKuvV9rWhZrPW6wZrbJ7sGLCsI9A');
INSERT INTO `stock` VALUES (7, 3, '115158158369bsvdlamiryifn55al6rlx8thbyja8k5mf3hya3s8ubwroabccmpxfm0udymvdynmivqlsqldgzbhu44uxdz0izdynve2kjpiyyf.jpg', 'large', 'jpg', '1366x768', '314.2kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM');
INSERT INTO `stock` VALUES (8, 3, '11515815836nbaougqo8dtnpzmzrvgtozpnfjfayc13bvpp26iqgag9lftlyekj8l10cx0n45weusah4ufoot4cojcb0auu7wk6u2kvvsoxjjzb.jpg', 'medium', 'jpg', '1280x720', '189.1kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM');
INSERT INTO `stock` VALUES (9, 3, '11515815836axgqd6ga4wejl1cpxrp6resyqsgnf86hxhp78z82krmmyjwglrp86dfcyeac5thhvygme3sg9fnqiagponxnfgs4ie4w8q4lg6im.jpg', 'small', 'jpg', '640x360', '53.1kB', 'nsofbUHeq1cfTV7BzRXbkid4V5KI1sNZIlfmTSkZc6pAnBub9BWgin6bxjZGLxAoi3GP6u6A5GFlWFrVyD8Ce6cDxOovCLIg8X0H7TcN5PPBYmNtq8E1eXMLplmDNIkuMSSr9KRnjQk0MFkeRQcqw2CnodPdpkLp5mUogWjkppJQYKH8y9F5tJPUynCmpgujS7WOMoHM');
INSERT INTO `stock` VALUES (10, 4, '11515822626cafvap6sraehgihysl8ovdkn6hxkyr1b1xlnjpzylda9ywn8rt0vtezapapdvwx1wvjbkwt7xd55varqvdbbvfdyc6n77fuf6qv5.jpg', 'large', 'jpg', '1366x768', '174.2kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u');
INSERT INTO `stock` VALUES (11, 4, '11515822626ptlzlt560ize7iyhpeetin88rsmcv39ecqkkkt7gz0nelpy70idwwa5jgnpfybniggpm0cd2wnow4ic8rugvogwfi2h1o4uqmc7n.jpg', 'medium', 'jpg', '1280x720', '112.6kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u');
INSERT INTO `stock` VALUES (12, 4, '11515822626hkvcobdudxup9loqsgasfs6p2lcvmd5ulastjcd4fr776na5spumyxhpx6jym2mufwht3lw1cqjjme1bgwk1vrofkss6zqwczs6j.jpg', 'small', 'jpg', '640x360', '34.7kB', 'zh0MSm4jic3PLG9ycgBN7af70FO0T3LI1BhxbXOWQ7TRFgFIlO0iXUxiW7CeAIRNFcPlF6uvNLGpNjUHb7SDCQEUSnSjBgkgNmr3naGFKmEPUDggsE9mhHWpk1BJXxqFY6ysgZ9SJeoN8pcXgTtfK0bXQqKB1Fhw7MCfZqaHfPyRrQSSeimQ2MonUdjoxVkeLTVGax3u');
INSERT INTO `stock` VALUES (13, 5, '1151582269306g8ijjnbiovgi3gdk9obwenabct3wpe8gdmqnfr4nqyklxlmtzx5eyljdpzsjspyu5hcrhiov3q3jxfol1fnjtbrcpjs599zv2d.jpg', 'large', 'jpg', '1366x768', '288.4kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX');
INSERT INTO `stock` VALUES (14, 5, '11515822693n6uk4qyf3ilm0rvgucvyxqf5k0tktntsxa6wzeis0cqyhnvhtxv8n9tonvdz63boizbnjyuyen4mdjgs2fxhhygan5zfsf5ullam.jpg', 'medium', 'jpg', '1280x720', '180.2kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX');
INSERT INTO `stock` VALUES (15, 5, '11515822693pp4zsrbabpbqujvxogdfnyxwpkugywifgrhls7pk9c2bj3mxtbzlttt54pesitshagod84awefwlyydgl9kvbojctjtrdipjpvkc.jpg', 'small', 'jpg', '640x360', '57.1kB', 'M4OxbMgCIqpo3AE7VvS40Y8V1GeYJefElF9Fn2AE4um4oDzN6A8COMTK5anwMDdl4QKIdwpS73jEJsYDnUJc2UXQCwPhZAPEFDeqWmRoN2LrKXmEShszk20e63SnIreBdVcyPpG0Z97tqIuga0GO32fFtq3OM0nTG8APmsaehHdRdn93hFLHTE9PFP9v1HtNTgw2RMsX');
INSERT INTO `stock` VALUES (16, 6, '11515822733yp5au852ydcncyumbxiipizxriuqlhskaivbn1q01oeov9a5heghpkimwifoe0lwbnaxpqchimkzo2zivdlxz0d4ijywlqlsihuf.jpg', 'large', 'jpg', '1366x768', '220.6kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA');
INSERT INTO `stock` VALUES (17, 6, '11515822733zdnhw17hsrxpxc7md8pfbzirx1wgpzef90xy6sbq2x1dk7xwsqaeq2a6youcp6tcdx5bhypexrnwuhtjlsibv4ubrioumlvwo6qs.jpg', 'medium', 'jpg', '1280x720', '141.6kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA');
INSERT INTO `stock` VALUES (18, 6, '11515822733s9vwdmmfxsisrxypbbzwqsztzqvnjwnd3gl35dpipcndjhp10ifjysaysuuv66flam5rcmluv6jew7ktb0wr2ar8yhyl3zupu2ul.jpg', 'small', 'jpg', '640x360', '42.9kB', 'ufQN5AmRvOxZI2KcRBLHoHFyaVoej9kPimoNDGnYMr8CS94YH7iR1xN10TVgS4XGlTQVwlyCOwqxd30D3zkEHZcIlqhi3dK2ZQR4DUioUYIQhFb4WKffDwQwJmoGLccnaGWF0a5CdC08YZeEwgPjtMdR51dsxXJ0qPmfKiDkO9eADtJMou7YQOCGAehIFiLjfe80XQCA');
INSERT INTO `stock` VALUES (19, 7, '11515822780pqwrrrkbyzhawd7erztbzfkstgdcoxiw7fqhbv3yomhpectuub1ee9ykez7m65wjmxp8z09vqoojsd6vjjic42a4iy6hszj24ase.jpg', 'large', 'jpg', '1366x768', '325.3kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy');
INSERT INTO `stock` VALUES (20, 7, '11515822780xqrwmj940rua2ypu0mgwz2hvvrahovm9wsdp05n7hkgp5xstkmanxosu1gblrj7zhndlufgxyps8phaxd4dudbd6sre9pawpiqkp.jpg', 'medium', 'jpg', '1280x720', '226.7kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy');
INSERT INTO `stock` VALUES (21, 7, '11515822780jxmjjgqvwbf3hvrrhdbq6oe1x3rjg4ocjanfri4uptxlnyqukjphees9iad9tdfcke5tqfzpnldgnst8fignaxskaj7hpyai9bwp.jpg', 'small', 'jpg', '640x360', '74.5kB', 'zaMj2liBZExNZGfHuQtLmUbdyEWJHKQJHBbtWLLd90ij59UJ2xO2VOAKaevTXRFNtL8I7XpCwQB8SbLYBxplBlrv2xBuXtPMHyB3WrpYTBjxgTlRNN4mhs37XFZHcXuQDa9JVozRULD2hRviGsEXbUM04UbE6830cKVwA1mI0ORz1aKDVxN2NvKeud8AAAp171Gjhhiy');
INSERT INTO `stock` VALUES (22, 8, '11515822879mmx20cjvj0m7eihyzrciouifqkbarmvddp52omnvug7cnzf9g1ws1lgjayic3segkqyri2sjz2f45jpqyak7fcmxbglqm4ljes44.jpg', 'large', 'jpg', '1366x768', '646.9kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts');
INSERT INTO `stock` VALUES (23, 8, '11515822879kwqwnocm4hm7zdynnvap8tabmcujw4rctgqbsucpfsjpmrem5hybxc0ykoqmwvejv01y1jzkqwstqrqyvodfs6vvkawkesyibtac.jpg', 'medium', 'jpg', '1280x720', '378.8kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts');
INSERT INTO `stock` VALUES (24, 8, '115158228791iikb7ckaoqefwpzbq3hjow7dmki3inro2gj35ixpgvd5hxg83xsj5bh1ndhnwig3vneaf3p1trjewpblatd3b45zeaonxu8godh.jpg', 'small', 'jpg', '640x360', '95.1kB', 'xes6VwYkor4ZlTvfjzMMJtgI0PRgeGkehuHumekYTsud3miHHVtR1xSOHo4nM1HS32xUsnbxCVlDoxCY2pzr121tRHzNTNDHXKP4xqPSJYWMg9nVwIHHyxysDVUL7WwILTdO6FKjJsyWslkz0NJb95SyMcMhyz1c5n8A86c7schiE56gMMiJz6AKbyHCKzvHDRAN3Zts');
INSERT INTO `stock` VALUES (25, 9, '115158229535dhfgqzvzmei50yeimz7q7u2uscb2yxur9pwulvoohsax8tyrhu6s4ic0trfxzj1mzprf9wqnwdexkwjzrjbnzssgv0oiptcwjz1.jpg', 'large', 'jpg', '1366x768', '233.9kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c');
INSERT INTO `stock` VALUES (26, 9, '11515822953itlirtw1ak7se5tlzgaaitlmtx45pnysizzljvetjg2uxo46np3dldofyvrz1umdfjqlsomwvv863gnt76vafb9kymhnrx9x8xaj.jpg', 'medium', 'jpg', '1280x720', '161.7kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c');
INSERT INTO `stock` VALUES (27, 9, '11515822953fjq0gthtz3h8qfhjwh6bzs8awjcderhcshcay0yoilu3tk3wkyyqwpbr7onoozo5hwyhhncpnhfq2dquibwdqtogfxujx5wnydlc.jpg', 'small', 'jpg', '640x360', '41.8kB', 'sqMeQAcqApfCGOPC0NqPPyB3oWbxtRAYSsp5cih8RfiDI9NcZDfsImXzmXGE7YUAAty9wj0qVtTlSzA18VEfGKz2o2p6mrxMsKIlRuQmPBciVqBZRSu6nBE8EgBc1zqZUjXZDlb6qOSkC5UCmRaMMCSkXcfjo8SuI8IxlHu3ifJ5IXyrfJKUeHLlReWuxI4nDefY230c');
INSERT INTO `stock` VALUES (28, 10, '11515822998pzvnonjtrwoeyruqzpnr1boe3kjjm2rljeevnezrpwys7jqc5p78cdjeqp8a2ivhuxnhnbygbevnvx5boit2rdfylal2cr0ppyns.jpg', 'large', 'jpg', '1366x768', '274.7kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv');
INSERT INTO `stock` VALUES (29, 10, '11515822998ag0ymjszilkdii0p59tdxvhsimbsqnwvwsg2e38jkmzjrfthj5tynnpv2hcbvzwu9lmxlcsezpzzoq6ie4epbnrwkf1tgpni4shh.jpg', 'medium', 'jpg', '1280x720', '214.2kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv');
INSERT INTO `stock` VALUES (30, 10, '115158229980t5i2df46f42x8ghjt7phtjam9iojeslawaghhitwh67c9igxzc5avo6y0pnu19sdowujri3tve40caw8h3yenmz7rirvzelyjqr.jpg', 'small', 'jpg', '640x360', '59.9kB', 'JY9rk12lBCYZseHDb3tHd9X5bQUHD7G7kyvtLL2pkk2Baf6n9ASEFKyQoWJlUEFQxUOCib63kPxqDD01GBi3FeNBUafkPkAXYENaeEVBsWahRd69aIeBMlwHHDqZmXhq0c6XlzkcNW1QbPBtCmk8LCkyGrN3oJ5Ed1yeBDKSj2f4NsHEdru7gwersUJGMwuWGcJcQFuv');
INSERT INTO `stock` VALUES (31, 11, '11515823043grolrchkvz3bnmdv5kt5xo5bpu8lzuoor8d33xhxl7jblupexyxgs4ab42msm2nqtla2jp4uytwiqsezdobdnstlko9pxa03ss6f.jpg', 'large', 'jpg', '1366x768', '206.5kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j');
INSERT INTO `stock` VALUES (32, 11, '115158230434jvzg0oyf0hulc2eurxmrv4egorusdjnvjrstbh7uqee7w05eca3vwxjrw63xn6kzmd6gxitejozyblr5yy4egch65thsbj1peq2.jpg', 'medium', 'jpg', '1280x720', '135.3kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j');
INSERT INTO `stock` VALUES (33, 11, '11515823043zk4l7yk5cwrclzmpfyhanhzozfvpsx65tngxp7xrwwk1w09wllydkwutiry9a3vspd74ejryghor2nthgbezwneqmx7ebqfsxgfc.jpg', 'small', 'jpg', '640x360', '39.7kB', 'vPbBX8z0Ssawug6xpUgbNXUldiy5CI7pylXF4MGICbQkisQz59zlTdLFFBSBbwINnsp75JC6t3v1OcvH45byWBdHn0NvhbhkO8F0iDXVLxieF6vSdtfgmrEzxGfAq2eyBs3vhSrgGMnTEYHOCDZwFH4ZledgXGNNPPFg1O5TV3xLaFUGecnW4wSvxLCZPjYgpd6Kos3j');
INSERT INTO `stock` VALUES (34, 12, '11515823091pbcoj7ecdchilucn70n7i8dgw0uefpjjpx9ysosx4wzx2cxmint2uhv3uzdr5nfxjfrxfvpgscuihklpaqkcxvtnudlvlrvjeqe1.jpg', 'large', 'jpg', '1366x768', '534.2kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3');
INSERT INTO `stock` VALUES (35, 12, '11515823091zcgoioubmuvpuy2pq1si7x7bn1feocufcuwlxpxvywuulw9foqmmorg2e8dgct3yekjw4zxhy3ul9iqozosglbdumwdbs7pgcys4.jpg', 'medium', 'jpg', '1280x720', '333.1kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3');
INSERT INTO `stock` VALUES (36, 12, '11515823091ehnqm2rerljnkjw6jqurrh1daxn8u3injue5n2wkqswanfumccxvnglacnfhvcfm09ddcyxqhck32j1jq0sodk9eerhfznrqj28u.jpg', 'small', 'jpg', '640x360', '96.3kB', 'PteBCYFTlQzerdXR2vYPe91sGWbwcQzaOOqcipCoUbXYS5xLkZ04mNFZV6N8fOCbtBcrgfldwQTZtNq982ptCgVVpHZusv4VG1gPoRFLgu0ybs2gBV16uFh3rCBncpBV9GP8Cq0d17D2brXz8ARI6BBC8RelhcaJ0Zx3AwNcX2UYOVnKeC5ko1uUEDK09KQ34k34BEc3');
INSERT INTO `stock` VALUES (37, 13, '11515823149jh0axwqdacbb8bmy9rrtsdabpkuhfc8uxx8xniesq5dmxuxq1m6djcwolch3vsmpojzu124plz32bp0v97cdtxf8c5ncn33glv1p.jpg', 'large', 'jpg', '1366x768', '332.1kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm');
INSERT INTO `stock` VALUES (38, 13, '11515823149i3blfnd9uskanmfjdtwxiusacv1pwvb9us2majufh93naakm2gqa4yxcdlv4ze7dwbjqtkdaezx76pcc8trv7lgybdqdcbmhlgtd.jpg', 'medium', 'jpg', '1280x720', '187.9kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm');
INSERT INTO `stock` VALUES (39, 13, '115158231494ottvmdhhuinos4fqj6n4bffslnjisybvk2qwz6egq32zvtk6tgvorziqqijnao2gamx6odfmtdfzq4ly9t1ascgh49mvzoxon2m.jpg', 'small', 'jpg', '640x360', '56.4kB', '49Ft4jdxQklX2XI6PHQezDHvzSdYMc8UDF94h04R641JFAzN3IexgmjK5ndJjiJjnRb79nKY0B1gnTv4kK5wQtS8XDSdVC6ycolAMvYFCrlTT2TQ8GuV8QsxN2W4UsPNVPKs7U6xprOYKbEGOvcNhM3sVLxTnhLXO4KpCrvoZBoGIuTSCCaokaNPO0BRCYrbJ1pIHkKm');
INSERT INTO `stock` VALUES (40, 14, '11515823198fkayku3cifdtavl59kjhuwdh7nmrtyh21qwlfppp1jncmdgrexpvza7d2mo8nbp6xn3sq8ed23nofkhihgdw0b5wblnxkqc2apdu.jpg', 'large', 'jpg', '1366x768', '171.6kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg');
INSERT INTO `stock` VALUES (41, 14, '11515823198vqkuqzap2vaaxynybckuszz9u61ltmewggwjlypqnnyfbxceuhv0yu3x8zb6jxwgmr62iac41ai45afgqf9qkhzwut5qy2vdjiaz.jpg', 'medium', 'jpg', '1280x720', '107.9kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg');
INSERT INTO `stock` VALUES (42, 14, '115158231986icidrdd1r4jpmurfbaiwdhoijs1ohh3o2dwzhghx8a9zpx3t6ogqogw8rr5mosv44gatxgzdai0nqph6rupctdzcznei4um11un.jpg', 'small', 'jpg', '640x360', '34.2kB', 'FhYF4T9NZwcNszIaYh4FJRMkhyUYuJfl3hSuWwHc2qFVquKvS52cbGUxwDAOd8YEGgrziqPcXoTLyxYwpjXExz3oqxcgmtsXdD8hxsFw7ZPhdzhGbOTwbv7nFVvKjwosffKiDTAb3vZ5WKdcCENe8sgAx3i76kB4jINZRwJUAlNyZF4XEJBxl7oAJNgNQAPsU2SiKvbg');
INSERT INTO `stock` VALUES (43, 15, '11515823238pfyjq1xagl83dlcmwres9byjj3c3tc7ooc8s6bjjhjlaqqe5exqiuqif6ovtghvkkbfhlzuijekiyaa61gl2f10yineee2soiiq0.jpg', 'large', 'jpg', '1366x768', '314.2kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb');
INSERT INTO `stock` VALUES (44, 15, '11515823238gjfnpym4rvkwkypyjgltoqlfqnla7hsintlai5uv1k8kdtkaunjukiomek7ezg5wwvbvqzboxrvzeew33bk8fe73fopfyhjx9xy1.jpg', 'medium', 'jpg', '1280x720', '204kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb');
INSERT INTO `stock` VALUES (45, 15, '115158232385g6402mfbomxrb8ispxyozhpwuhm9ggfbww5mw0ig0h3evshx5ysipeytazff3dha15uf2sbuvhkin2en5pexvlvcyn5mcmyznep.jpg', 'small', 'jpg', '640x360', '64.6kB', '8SXDvbhnuDet9CvLFzmVaY3VTS9GuYpPIw3nT85nwpuallCw9cNaK5pUrTEfrhoMuekYhHT6gH4joZqi7jnHiOqqp5bYmRNCgQbfxtdZT8XGdfkMp0IZSGACanHByzbjqmTufWx5Yfaa90XsAnkBqQXX8g5fEiZrFc3hdswKbU9hXJdYAxE5FiNQiVNojbSkhkzJsazb');
INSERT INTO `stock` VALUES (46, 16, '11515823277t3drgjbz2l0ddkwkycn9gz42gxdtgp2z1nbmwx02dp2uj7g0toxm7x0uetobzjekjc44txcmwfydhhy8s0lshih9hywcujn6ituy.jpg', 'large', 'jpg', '1365x768', '358.8kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ');
INSERT INTO `stock` VALUES (47, 16, '11515823277bjfy6sugvwvdfrbmlqbpnrlovfufdezlpku8m8ga8yzsq1rjwrn486qksij5gfyhf9ps4pusds9nxj0fqgrrmgxy9pwxpkqtdvir.jpg', 'medium', 'jpg', '1280x721', '282.7kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ');
INSERT INTO `stock` VALUES (48, 16, '11515823277bkqgyb7zakp3zt2cghfksfkvggwz1zv9fc8kgrhv3hyj5jnbt8uiyyitdarputciv3k2oojtssrgbgmuravyaiipa0csardzyqql.jpg', 'small', 'jpg', '640x361', '77.7kB', 'aJcUFf5FLPOKawoGAFSjYY40E6juDXAFuIjYXoDFIVRnXFqT4hBtAVCPBV4TK23wdBQB2mGzfl7RdHXsnXMJ3V1SBv6XvGYiZn0AQRd3nIFkdRHsRGG8jC5KnT88pXQBu1ntvezy49NcyPzjz4RHpMiZBEBgZJOnoYRQZ8BH7ym9TJ6281SLfwUELl9jmSEOUqcg7EcQ');
INSERT INTO `stock` VALUES (49, 17, '11515823318bdtiae7ljxiwcmgvbh5s0nwd145yyouahenwepqf8euktmomrm5rzppi4x0fa0rxbgrwuxollt10hytorlpcbsmpf5glgqtizkim.jpg', 'large', 'jpg', '1365x768', '312.8kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH');
INSERT INTO `stock` VALUES (50, 17, '11515823318izhuscnr6w054b7lkqwmyc1bqiweyolrzzun8ebmeewx9uhfspqw9pztife2ke6l63qobet7zhi2fmjiw9xjoy6rxael1o19i4dp.jpg', 'medium', 'jpg', '1280x721', '239.7kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH');
INSERT INTO `stock` VALUES (51, 17, '11515823318w3xzxmrycccnzg5fqgnyimspuq6gpgqg3tegukhlf7w7lhuwhk2uq60yo8eng8jlxvole6x7g8tho8kamntzyke8djhqz3amfzem.jpg', 'small', 'jpg', '640x361', '64.6kB', 'DoUQtMQ7CVnEd1R3CIM26LJ7J182tbUio8QrXCS2zPiJY7Ay3is6BaCztVuaqsksWaEcAS5ZQwGZgjxFTLabVPA3RiV3Ql0JQRQ2sVd8C4hKS3vTAZsRwA32E3fSNVGzRWBDOHPDMH2y7CIhx0UaWUxUtVuAYMN1q6MaEY91IuvQjAPmN6BvXXgHiVeQutgXNDfwpOpH');
INSERT INTO `stock` VALUES (52, 18, '11515823350tlh6knzye4z680tveuj8zhlggcxjshmwcjhuuznkxbbrew6ueklyoczola1ibwme5w4rmyo7qc4orshpsoe421bn1ntgofjgfpik.jpg', 'large', 'jpg', '1366x768', '162.9kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3');
INSERT INTO `stock` VALUES (53, 18, '11515823350k99lek5eaxeixlce1sdikdstk3kuul6o3audvtnmbqj8fqlvgk4tztfnxeocss9hwmiyfsw2zw3ao8zyplo2ynj98j0bccpdqzoi.jpg', 'medium', 'jpg', '1280x720', '103.6kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3');
INSERT INTO `stock` VALUES (54, 18, '1151582335078ps9qhdbevdcdlylmdkrkdnz0g3zse4outtlazhskn62zvegiygd6rpducfdjg2k8edd78qkgnt3stlqcptkvebupe1qpn6ajua.jpg', 'small', 'jpg', '640x360', '31.4kB', 'tZK2ktJcAQXTYhD2f6ldC6S3JNOY8scR7KtoulGp1BzXpd9X5awv7iAErXs0sDpIKWkF1gH4exBqVj8CQIuXwggfAathtYIRetDD6YWqiiAvlyWkX4Yma5Or8qsDMvkkKmbO8ofbVx25vClpjN3smeCrMqxeuLwQLvrCdUWvBPQwS2gS4jjAQNUzzKETSmIsexkMOMf3');
INSERT INTO `stock` VALUES (61, 21, '11515831707ijfsffb7ndgnrjoxdp0cobzvzxsahxmcogilak8sr0aqwsthlowsmpfu6jqprpdsic4zsekpltw2rwdcqwdqp4o5l148vfme2udg.jpg', 'large', 'jpg', '1365x768', '330.3kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R');
INSERT INTO `stock` VALUES (62, 21, '115158317071mfzqyq9xy0snxvdn4ddcwthmifiv1hsu5oi6xz6tc6yfpujba2ubcnemooldhrpysrdomll32uum9hrnmxksxjkkuo1op1vvnyv.jpg', 'medium', 'jpg', '1280x721', '262.7kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R');
INSERT INTO `stock` VALUES (63, 21, '11515831707pkbxbfvi8o6vqeg7xnnq66qrjaomk7m18lpdbuwlxqv19tivtxx17gsmonk1wjvyeov2mzimhjwb6zox7xglxodkenqclfy2fedm.jpg', 'small', 'jpg', '640x361', '77kB', 't2yrsRF1quTH8BmHeVx6sOhpG0wNZDA9O68K10KsbuT8EUZLUQ6K3o9YEc1Wx1YbWhoJNiOvALjllMays8q9a6Nd9aKwjJWlUd6oRYDqKM1F0j0PcbhnsvOvkmwOwmIrv9Eg1Ktuo2YmQIEW1zIhRaOoqxpVaYG11W6XrJ7bbg2Z63ZPfViAWeyDCo1eheC9UNyjOZ5R');
INSERT INTO `stock` VALUES (64, 22, '51599197575wblqv484fuuy2brqf4hwklybrr1lm90ohifskqeyn7kkk673wog4if8zmhqw8j9tidlh0jvww9bpl6gw1lfji5saarpvddwuoztb.jpg', 'large', 'jpg', '220x165', '16.3kB', 'yqoWiKjBYMaeoPpFjbs440rhnhuCyXrdt09CudBaZlm3Zgttg5NMxXg1gdZf7sK22yfY2rXUsy7mktML3VogbdHGdnd5Ycm2Fpp33EdsfKzMaRFqsoHgYRiRkem3kigspM0HwXHaywxOveqCF6ELJ57a6mkzkgtGkDl0COZnDlzIAXt97M7s5CFgkwk3Gmgruqw69nRE');
INSERT INTO `stock` VALUES (65, 22, '51599197575z0zxktrdnzflccm8crrj4ahjpr4lgd8fagw7jzo5luuvu7kuqhakowjoj7pqdeix77xp681vggfdtrffycibgi7vpoxoobca47dc.jpg', 'medium', 'jpg', '900x675', '148.1kB', 'yqoWiKjBYMaeoPpFjbs440rhnhuCyXrdt09CudBaZlm3Zgttg5NMxXg1gdZf7sK22yfY2rXUsy7mktML3VogbdHGdnd5Ycm2Fpp33EdsfKzMaRFqsoHgYRiRkem3kigspM0HwXHaywxOveqCF6ELJ57a6mkzkgtGkDl0COZnDlzIAXt97M7s5CFgkwk3Gmgruqw69nRE');
INSERT INTO `stock` VALUES (66, 22, '51599197575z4lvg6patarodf0uvygybp8nt2cqnxqbyymn1yponidljdxya7sfkosaue7ma6808d2anrfvkwex8iwjevl1ibcgecxvrjzmkcpa.jpg', 'small', 'jpg', '640x480', '84.9kB', 'yqoWiKjBYMaeoPpFjbs440rhnhuCyXrdt09CudBaZlm3Zgttg5NMxXg1gdZf7sK22yfY2rXUsy7mktML3VogbdHGdnd5Ycm2Fpp33EdsfKzMaRFqsoHgYRiRkem3kigspM0HwXHaywxOveqCF6ELJ57a6mkzkgtGkDl0COZnDlzIAXt97M7s5CFgkwk3Gmgruqw69nRE');
INSERT INTO `stock` VALUES (67, 23, '51599199777kyz61ncijjvtpihpv2dvyx0dqrvjmrj3gbbzv4hjk865dtmadlqqqt4kh3hyueax0mvsafuttukkfkdmbovwju7jicuavzjprfx1.jpg', 'large', 'jpg', '220x165', '17.2kB', '98oayBSIfsZpIKVg1hTBCF3IK8BgaOmhX9A5656VHWq9A47SISiCOoaNuptLUmMnL2B1DLsUVUIcSxE9ewN5k99nEDyXEbN81xIvswqWnkpyIKNwD2AcnqlC2NIAHQd5jVGiQT2ECx33el6TBvjUe9HoDA1aAQj3YMKicdlsOfqHktzChiGRrEdSbw9JRTcyXIASy5sV');
INSERT INTO `stock` VALUES (68, 23, '51599199777olpivoe50oecjno5aafssghusyhuqsbrx4xjkscbmw085cfvfluqurw2nasafvuwajjpocg3fsf4fk9t6jdp7b5stfjbs1k5tutw.jpg', 'medium', 'jpg', '900x675', '153kB', '98oayBSIfsZpIKVg1hTBCF3IK8BgaOmhX9A5656VHWq9A47SISiCOoaNuptLUmMnL2B1DLsUVUIcSxE9ewN5k99nEDyXEbN81xIvswqWnkpyIKNwD2AcnqlC2NIAHQd5jVGiQT2ECx33el6TBvjUe9HoDA1aAQj3YMKicdlsOfqHktzChiGRrEdSbw9JRTcyXIASy5sV');
INSERT INTO `stock` VALUES (69, 23, '515991997778gwjvvgilpkfc8oavr0o36kibpmlheflrxa9tsifstpqsxqrz7tttou60ogiqaeayvndm94mwtodmgyiddwpfzjht7cejfdml3b6.jpg', 'small', 'jpg', '640x480', '87.6kB', '98oayBSIfsZpIKVg1hTBCF3IK8BgaOmhX9A5656VHWq9A47SISiCOoaNuptLUmMnL2B1DLsUVUIcSxE9ewN5k99nEDyXEbN81xIvswqWnkpyIKNwD2AcnqlC2NIAHQd5jVGiQT2ECx33el6TBvjUe9HoDA1aAQj3YMKicdlsOfqHktzChiGRrEdSbw9JRTcyXIASy5sV');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bio` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `countries_id` char(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` char(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `avatar` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` enum('pending','active','suspended','delete') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'pending',
  `type_account` enum('1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '1 Buyer, 2 Seller',
  `role` enum('normal','admin') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal',
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `twitter` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `facebook` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `google` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `paypal_account` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activation_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `oauth_uid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oauth_provider` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `token` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `authorized_to_upload` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `username`(`username`, `status`) USING BTREE,
  INDEX `activation_code`(`activation_code`) USING BTREE,
  INDEX `role`(`role`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', '佳音布吉', '我们不应该不惜任何代价地去保持友谊，从而使它受到玷污。如果为了那更伟大的爱，必须牺牲友谊，那也是没有办法的事；不过如果能够保持下去，那么，它就能真的达到完美的境界了。 —— 泰戈尔\r\n', '45', '$2y$10$wjbCfnJZ07JcBEb4aGD58.Urd0yAFfHsAyofPE3w9W61y05MgZBJa', 'admin@example.com', '2016-12-16 07:16:43', 'admin-11515824136rlrmhnhnkj.jpg', 'cover.jpg', 'active', '1', 'admin', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'ilFHKXsxqH4L9GgMLFq4HSXfPB2BMU7EJjlfn7gWBh81ldEa1uLB7agiHcNj', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'https://item.taobao.com/item.htm?spm=0.7095261.0.0.1bfde3c5n8vb5z&id=564099222906', 'miguelvasquezweb@gmail.com', '', NULL, NULL, '', 'yes');
INSERT INTO `users` VALUES (4, 'test520', '', '', '', '$2y$10$176Qt..6ZqHsi7j1K.uKHOS40wyjsmDZniJ5V7zKfv3OLbjfnycqS', '1990672233@qq.com', '2018-01-13 14:21:17', 'default.jpg', 'cover.jpg', 'active', '1', 'normal', '', 'oFsOSlzFj2PHimPyioGKbIQJczJcVQrKZ7pDYvvjk2TtmPkqKhE7wJg87WMP', '', '', '', '', '', NULL, NULL, 'XxnsfxiVXfFzNPtVR7OQNjiPRSPOburp6vtCbHTLY7EZps8M3jcTe0qcXR89vpHp48upC8WNTFW', 'yes');
INSERT INTO `users` VALUES (5, 'xpx888', '', '', '', '$2y$10$1kS6UwfduNGSC8KFBpjytOuy1XoPPoxlLkO54Mp.pxjznY/KcKdua', '30854665@qq.com', '2020-09-04 10:37:54', 'default.jpg', 'cover.jpg', 'active', '1', 'normal', '', 'DbL4pPlkTYL4wn9Smfxmg8TkaO5QQqmP8803H5c0bF0nYLeHtZaRtREQW76Y', '', '', '', '', '', NULL, NULL, 'Pf9FIQ7OCt15Jt5UreUY8nvUnjGFYVYzZVpJYCEOY0ISn7qH2kFpJeZLEp9JDJhGVWAtd2zgrw2', 'yes');

-- ----------------------------
-- Table structure for users_reporteds
-- ----------------------------
DROP TABLE IF EXISTS `users_reporteds`;
CREATE TABLE `users_reporteds`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reason` enum('copyright','privacy_issue','violent_sexual_content','spoofing') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `id_reported` int(0) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user`(`user_id`, `id_reported`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for visits
-- ----------------------------
DROP TABLE IF EXISTS `visits`;
CREATE TABLE `visits`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `images_id` int(0) UNSIGNED NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `ip` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `publicacion_id`(`images_id`) USING BTREE,
  INDEX `usr_id`(`user_id`) USING BTREE,
  INDEX `ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visits
-- ----------------------------
INSERT INTO `visits` VALUES (1, 1, 0, '183.226.120.154', '2018-01-11 11:49:23');
INSERT INTO `visits` VALUES (2, 1, 0, '114.218.116.188', '2018-01-12 10:32:33');
INSERT INTO `visits` VALUES (3, 1, 0, '106.120.161.66', '2018-01-12 10:33:05');
INSERT INTO `visits` VALUES (4, 1, 0, '220.181.132.194', '2018-01-12 10:33:30');
INSERT INTO `visits` VALUES (5, 1, 2, '114.218.116.188', '2018-01-12 10:35:45');
INSERT INTO `visits` VALUES (6, 1, 0, '183.226.121.4', '2018-01-12 20:05:08');
INSERT INTO `visits` VALUES (7, 2, 0, '183.226.121.4', '2018-01-13 11:36:58');
INSERT INTO `visits` VALUES (8, 15, 0, '183.226.121.4', '2018-01-13 14:05:26');
INSERT INTO `visits` VALUES (9, 17, 0, '183.226.121.4', '2018-01-13 14:05:42');
INSERT INTO `visits` VALUES (10, 11, 0, '183.226.121.4', '2018-01-13 14:06:34');
INSERT INTO `visits` VALUES (11, 18, 0, '183.226.121.4', '2018-01-13 14:08:49');
INSERT INTO `visits` VALUES (12, 18, 4, '183.226.121.4', '2018-01-13 14:25:00');
INSERT INTO `visits` VALUES (13, 16, 0, '183.226.121.4', '2018-01-13 14:29:18');
INSERT INTO `visits` VALUES (14, 13, 0, '183.226.121.4', '2018-01-13 17:15:29');
INSERT INTO `visits` VALUES (15, 18, 5, '127.0.0.1', '2020-09-04 10:38:01');
INSERT INTO `visits` VALUES (16, 21, 5, '127.0.0.1', '2020-09-04 10:57:10');
INSERT INTO `visits` VALUES (17, 12, 5, '127.0.0.1', '2020-09-04 10:59:25');
INSERT INTO `visits` VALUES (18, 18, 0, '127.0.0.1', '2020-09-04 11:06:22');
INSERT INTO `visits` VALUES (19, 11, 5, '127.0.0.1', '2020-09-04 13:34:24');

SET FOREIGN_KEY_CHECKS = 1;
