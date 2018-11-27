-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2018 at 05:25 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bakery`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(4) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_designation` varchar(8) NOT NULL,
  `emp_rateperhour` float(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `emp_name`, `emp_designation`, `emp_rateperhour`) VALUES
(1, 'Birinder Singh', 'Cashier', 22.00);

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `item_id` int(4) NOT NULL,
  `rawitem_id` int(6) NOT NULL,
  `quantity` float(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`item_id`, `rawitem_id`, `quantity`) VALUES
(1, 1, 0.40);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `location_id` int(4) NOT NULL,
  `item_id` int(4) NOT NULL,
  `quantity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`location_id`, `item_id`, `quantity`) VALUES
(1, 1, 50);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `location_id` int(3) NOT NULL,
  `invoice_time` int(10) NOT NULL,
  `employee_id` int(4) NOT NULL,
  `amount` float(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `location_id`, `invoice_time`, `employee_id`, `amount`) VALUES
(1, 1, 1546544330, 1, 540.55);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(4) NOT NULL,
  `shop_name` varchar(50) NOT NULL,
  `shop_contact_person` varchar(50) NOT NULL,
  `shop_address` varchar(100) NOT NULL,
  `shop_phone` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `shop_name`, `shop_contact_person`, `shop_address`, `shop_phone`) VALUES
(1, 'Adam\'s Bakery', 'Adam', '#123, West Toronto', '6475554444');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

CREATE TABLE `menu_item` (
  `id` int(4) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_type` int(3) NOT NULL,
  `item_cookingtime` int(3) NOT NULL,
  `item_cookingtemp` int(3) NOT NULL,
  `item_cookingspace` int(3) NOT NULL,
  `item_cost` float(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`id`, `item_name`, `item_type`, `item_cookingtime`, `item_cookingtemp`, `item_cookingspace`, `item_cost`) VALUES
(1, 'Brown Bread', 2, 40, 120, 35, 3.00);

-- --------------------------------------------------------

--
-- Table structure for table `menu_itemtype`
--

CREATE TABLE `menu_itemtype` (
  `id` int(3) NOT NULL,
  `itemtype_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_itemtype`
--

INSERT INTO `menu_itemtype` (`id`, `itemtype_name`) VALUES
(1, 'Pasteries,'),
(2, 'Bread'),
(3, 'Coffee');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `invoice_id` int(6) NOT NULL,
  `menu_item_id` int(4) NOT NULL,
  `quantity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`invoice_id`, `menu_item_id`, `quantity`) VALUES
(1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `raw_item`
--

CREATE TABLE `raw_item` (
  `id` int(6) NOT NULL,
  `rawitem_name` varchar(50) NOT NULL,
  `rawitem_unitcost` float(5,2) NOT NULL,
  `units` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `raw_item`
--

INSERT INTO `raw_item` (`id`, `rawitem_name`, `rawitem_unitcost`, `units`) VALUES
(1, 'Eggs', 0.50, 'Nos'),
(2, 'Cream', 3.00, 'Kgs');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `shift_id` int(6) NOT NULL,
  `employee_id` int(4) NOT NULL,
  `location_id` int(4) NOT NULL,
  `starttime` int(10) NOT NULL,
  `endtime` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`shift_id`, `employee_id`, `location_id`, `starttime`, `endtime`) VALUES
(1, 1, 2, 1546745400, 1546763400);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`item_id`,`rawitem_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`location_id`,`item_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_itemtype`
--
ALTER TABLE `menu_itemtype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `raw_item`
--
ALTER TABLE `raw_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`shift_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_itemtype`
--
ALTER TABLE `menu_itemtype`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `raw_item`
--
ALTER TABLE `raw_item`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `shift_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
