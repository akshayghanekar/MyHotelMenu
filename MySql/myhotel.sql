-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 14, 2019 at 12:45 PM
-- Server version: 5.5.61-38.13-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `akshayby_myhotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `apikey`
--

CREATE TABLE `apikey` (
  `id` int(11) NOT NULL,
  `HashKey` varchar(100) NOT NULL,
  `ClientName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apikey`
--

INSERT INTO `apikey` (`id`, `HashKey`, `ClientName`) VALUES
(1, '9738bbd44fc469aa3f61922a5576c31e', 'MyHotel');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `itemName` varchar(100) NOT NULL,
  `itemDescription` varchar(100) NOT NULL,
  `itemPrice` float NOT NULL,
  `itemType` varchar(20) NOT NULL,
  `itemActive` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `itemName`, `itemDescription`, `itemPrice`, `itemType`, `itemActive`) VALUES
(1, 'Item 1', 'THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s', 10.5, 'v', 1),
(2, 'Item 2', 'THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s', 25.3, 'n', 1),
(3, 'Item 3', 'THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s', 100, 'v', 1),
(4, 'Item 4', 'Delicious', 125.2, 'n', 1),
(5, 'Item 5', 'Delicious', 0, 'v', 1),
(6, 'Item 6', 'Delicious', 0, 'n', 1),
(7, 'Item 7', 'Delicious', 0, 'v', 1),
(8, 'Item 8', 'Delicious', 0, 'n', 1),
(9, 'Item 9', 'Delicious', 0, 'v', 1),
(10, 'Item 10', 'Delicious', 0, 'n', 1),
(11, 'Item 11', 'Delicious', 0, 'v', 1),
(12, 'Item 12', 'Delicious', 0, 'n', 1),
(13, 'Item 13', 'Delicious', 0, 'v', 1),
(14, 'Item 14', 'Delicious', 0, 'n', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `clientId` varchar(10) NOT NULL,
  `orderItems` varchar(20000) NOT NULL,
  `date` varchar(50) NOT NULL,
  `isDelivered` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `clientId`, `orderItems`, `date`, `isDelivered`) VALUES
(50, '25', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"61.10\",\"clientId\":\"25\"}', '2018-09-24 21:02:22', 0),
(46, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"371.60\",\"clientId\":\"25\"}', '2018-09-23 23:42:04', 0),
(47, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"42.00\",\"clientId\":\"25\"}', '2018-09-23 23:42:38', 0),
(48, '27', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":49,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"1250.20\",\"clientId\":\"27\"}', '2018-09-24 00:01:39', 0),
(49, '29', '{\"Items\":\"[{\\\"id\\\":\\\"12\\\",\\\"itemName\\\":\\\"Item 13\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":0},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"200.00\",\"clientId\":\"29\"}', '2018-09-24 10:12:00', 0),
(45, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"46.30\",\"clientId\":\"25\"}', '2018-09-23 23:20:49', 0),
(44, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"632.60\",\"clientId\":\"25\"}', '2018-09-23 23:09:32', 0),
(51, '30', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"25.30\",\"clientId\":\"30\"}', '2018-09-24 21:39:11', 0),
(52, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"443.10\",\"clientId\":\"25\"}', '2018-09-24 21:44:47', 0),
(53, '25', '{\"Items\":\"[{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"626.20\",\"clientId\":\"25\"}', '2018-09-24 21:45:37', 0),
(54, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"435.80\",\"clientId\":\"25\"}', '2018-09-25 00:22:46', 0),
(55, '31', '{\"Items\":\"[{\\\"id\\\":\\\"12\\\",\\\"itemName\\\":\\\"Item 13\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":0},{\\\"id\\\":\\\"11\\\",\\\"itemName\\\":\\\"Item 12\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":0}]\",\"finalAmount\":\"0.00\",\"clientId\":\"31\"}', '2018-09-25 05:41:17', 0),
(56, '31', '{\"Items\":\"[{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"200.00\",\"clientId\":\"31\"}', '2018-09-25 05:49:07', 0),
(57, '31', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"35.80\",\"clientId\":\"31\"}', '2018-09-25 12:53:11', 0),
(58, '25', '{\"Items\":\"[{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"125.20\",\"clientId\":\"25\"}', '2018-09-25 19:11:51', 0),
(59, '25', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"475.80\",\"clientId\":\"25\"}', '2018-09-28 00:28:47', 0),
(60, '31', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"10.50\",\"clientId\":\"31\"}', '2018-09-28 13:19:30', 0),
(61, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"235.80\",\"clientId\":\"25\"}', '2018-09-29 19:59:58', 0),
(62, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"261.10\",\"clientId\":\"25\"}', '2018-09-29 22:48:58', 0),
(63, '25', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"71.60\",\"clientId\":\"25\"}', '2018-09-30 00:20:28', 0),
(64, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":5,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":5,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"1079.80\",\"clientId\":\"25\"}', '2018-09-30 00:37:56', 0),
(65, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"10.50\",\"clientId\":\"25\"}', '2018-10-02 15:31:06', 0),
(66, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"10.50\",\"clientId\":\"25\"}', '2018-10-04 20:48:35', 0),
(67, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"35.80\",\"clientId\":\"25\"}', '2018-10-16 23:07:27', 0),
(68, '25', '{\"Items\":\"[{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"225.20\",\"clientId\":\"25\"}', '2018-10-25 22:56:34', 0),
(69, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":9,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"94.50\",\"clientId\":\"25\"}', '2018-10-26 13:14:54', 0),
(70, '25', '{\"Items\":\"[{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"447.40\",\"clientId\":\"25\"}', '2018-10-27 00:23:26', 0),
(71, '25', '{\"Items\":\"[{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"261.10\",\"clientId\":\"25\"}', '2018-10-30 00:06:52', 0),
(72, '25', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"71.60\",\"clientId\":\"25\"}', '2018-11-07 18:51:02', 0),
(73, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"46.30\",\"clientId\":\"25\"}', '2018-11-17 00:08:31', 0),
(74, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"46.30\",\"clientId\":\"25\"}', '2019-02-20 22:25:11', 0),
(75, '25', '{\"Items\":\"[{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"125.20\",\"clientId\":\"25\"}', '2019-02-20 22:25:58', 0),
(76, '25', '{\"Items\":\"[{\\\"id\\\":\\\"6\\\",\\\"itemName\\\":\\\"Item 7\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":5,\\\"itemPrice\\\":0},{\\\"id\\\":\\\"5\\\",\\\"itemName\\\":\\\"Item 6\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":5,\\\"itemPrice\\\":0},{\\\"id\\\":\\\"7\\\",\\\"itemName\\\":\\\"Item 8\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":0},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":9,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":6,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":20,\\\"itemPrice\\\":100}]\",\"finalAmount\":\"2246.30\",\"clientId\":\"25\"}', '2019-02-20 22:27:01', 0),
(77, '25', '{\"Items\":\"[{\\\"id\\\":\\\"2\\\",\\\"itemName\\\":\\\"Item 3\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":100},{\\\"id\\\":\\\"3\\\",\\\"itemName\\\":\\\"Item 4\\\",\\\"itemDescription\\\":\\\"Delicious\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":125.2}]\",\"finalAmount\":\"450.40\",\"clientId\":\"25\"}', '2019-03-23 11:27:20', 0),
(78, '25', '{\"Items\":\"[{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":2,\\\"itemPrice\\\":25.3},{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":1,\\\"itemPrice\\\":10.5}]\",\"finalAmount\":\"61.10\",\"clientId\":\"25\"}', '2019-04-10 18:10:12', 0),
(79, '25', '{\"Items\":\"[{\\\"id\\\":\\\"0\\\",\\\"itemName\\\":\\\"Item 1\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"v\\\",\\\"itemQty\\\":4,\\\"itemPrice\\\":10.5},{\\\"id\\\":\\\"1\\\",\\\"itemName\\\":\\\"Item 2\\\",\\\"itemDescription\\\":\\\"THE ORIGINAL. Still freshly prepared in every restaurant, the Colonel\'s Original Recipe chicken is s\\\",\\\"itemType\\\":\\\"n\\\",\\\"itemQty\\\":3,\\\"itemPrice\\\":25.3}]\",\"finalAmount\":\"117.90\",\"clientId\":\"25\"}', '2019-04-12 12:12:33', 0);

-- --------------------------------------------------------

--
-- Table structure for table `userRegistrations`
--

CREATE TABLE `userRegistrations` (
  `id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Mobile` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Address` varchar(2000) NOT NULL,
  `isVerified` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userRegistrations`
--

INSERT INTO `userRegistrations` (`id`, `Name`, `Gender`, `Email`, `Mobile`, `Password`, `Address`, `isVerified`) VALUES
(25, 'Akshay Ghanekar', 'Male', 'aki.ghanekar@gmail.com', '9987003342', '25f9e794323b453885f5181f1b624d0b', '{\"buildName\":\"My Apartment\",\"flatNo\":\"A\\/204\",\"s1Address\":\"Datta mandir rd, Somwar bazar\",\"s2Address\":\"malad west. and Landmark\",\"zipCode\":\"400064\"}', 1),
(31, 'Chandan Jha', 'Male', 'jhac36@gmail.vom', '9223344672', 'cce2b3771c27df8ddfe72bc284246be5', '{\"flatNo\":\"Sahar\",\"buildName\":\"Vileparle\",\"s1Address\":\"F\",\"s2Address\":\"G\",\"zipCode\":\"400099\"}', 1),
(30, 'Sagar', 'Male', 'sgrsanas8@gmail.com', '8419994545', '488a14440b40a3edeeffdae32a97e92e', '{\"flatNo\":\"Xcvvg\",\"buildName\":\"Tgvv\",\"s1Address\":\"Dcvv\",\"s2Address\":\"Fgv\",\"zipCode\":\"400068 \"}', 1),
(29, 'Ajay', 'Male', 'ajay@gmail.com', '9920550230', '81dc9bdb52d04dc20036dbd8313ed055', '{\"buildName\":\"Serenity\",\"flatNo\":\"A-123\",\"s1Address\":\"Poonam garden\",\"s2Address\":\"Mira road\",\"zipCode\":\"401107\"}', 1),
(32, 'Aaa', 'Male', 'aki.ghanekar@gmail.com', '8976551650', '1bbd886460827015e5d605ed44252251', '{\"flatNo\":\"1111\",\"buildName\":\"1111\",\"s1Address\":\"1111\",\"s2Address\":\"1111\",\"zipCode\":\"400064\"}', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apikey`
--
ALTER TABLE `apikey`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userRegistrations`
--
ALTER TABLE `userRegistrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apikey`
--
ALTER TABLE `apikey`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `userRegistrations`
--
ALTER TABLE `userRegistrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
