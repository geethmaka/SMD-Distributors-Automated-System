CREATE DATABASE  IF NOT EXISTS `smd`;
USE `smd`;
--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `Cus_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Hardware_Name` varchar(45) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `NIC` varchar(13) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  PRIMARY KEY (`Cus_ID`)
);

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;

CREATE TABLE `delivery` (
  `Delivery_ID` int NOT NULL AUTO_INCREMENT,
  `Route` varchar(45) DEFAULT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Order_ID` int NOT NULL,
  `Cus_ID` int NOT NULL,
  PRIMARY KEY (`Delivery_ID`),
  KEY `OID_idx` (`Order_ID`,`Cus_ID`),
  CONSTRAINT `OCID` FOREIGN KEY (`Order_ID`, `Cus_ID`) REFERENCES `orders` (`Order_ID`, `Cust_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `Emp_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `Username` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `NIC` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Total_Salary` double DEFAULT NULL,
  `Hours_Worked` int DEFAULT NULL,
  `Emp_Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Emp_ID`),
  KEY `Employee_Type_idx` (`Emp_Type`),
  CONSTRAINT `Employee_Type` FOREIGN KEY (`Emp_Type`) REFERENCES `employeetype` (`Emp_Type`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `employeetype`
--

DROP TABLE IF EXISTS `employeetype`;

CREATE TABLE `employeetype` (
  `Emp_Type` varchar(45) NOT NULL,
  `Basic_Salary` double NOT NULL,
  `Hours` int NOT NULL,
  PRIMARY KEY (`Emp_Type`)
);

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `Feedback_ID` int NOT NULL AUTO_INCREMENT,
  `Cus_ID` int NOT NULL,
  `Date` varchar(11) DEFAULT NULL,
  `Type` varchar(10) NOT NULL,
  `Message` varchar(100) NOT NULL,
  `Rating` varchar(45) NOT NULL,
  `Status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Feedback_ID`,`Cus_ID`),
  KEY `CustomerID_idx` (`Cus_ID`),
  CONSTRAINT `CustomerID` FOREIGN KEY (`Cus_ID`) REFERENCES `customer` (`Cus_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `has`
--

DROP TABLE IF EXISTS `has`;

CREATE TABLE `has` (
  `Vehicle_Num` varchar(20) NOT NULL,
  `Emp_ID` int NOT NULL,
  `Deliver_ID` int NOT NULL,
  `Date` varchar(45) NOT NULL,
  PRIMARY KEY (`Vehicle_Num`,`Emp_ID`,`Deliver_ID`),
  KEY `EPID_idx` (`Emp_ID`),
  KEY `DV_ID_idx` (`Deliver_ID`),
  CONSTRAINT `DV_ID` FOREIGN KEY (`Deliver_ID`) REFERENCES `delivery` (`Delivery_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `EPID` FOREIGN KEY (`Emp_ID`) REFERENCES `employee` (`Emp_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Vehicle_NUMBER` FOREIGN KEY (`Vehicle_Num`) REFERENCES `vehicle` (`Vehicle_Num`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Cust_ID` int NOT NULL,
  `Order_Date` varchar(45) DEFAULT NULL,
  `Order_Status` varchar(45) DEFAULT NULL,
  `Total_Price` double DEFAULT NULL,
  `Paid_Amount` double DEFAULT NULL,
  `Remaining_Amount` double DEFAULT NULL,
  `Qty` int DEFAULT NULL,
  `Product_ID` int DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Cust_ID`),
  KEY `PID_idx` (`Product_ID`),
  KEY `CID_idx` (`Cust_ID`),
  CONSTRAINT `CID` FOREIGN KEY (`Cust_ID`) REFERENCES `customer` (`Cus_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PID` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Prod_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `Pay_ID` int NOT NULL AUTO_INCREMENT,
  `Amount` double DEFAULT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Order_ID` int NOT NULL,
  `Cus_ID` int NOT NULL,
  `Emp_ID` int DEFAULT NULL,
  PRIMARY KEY (`Pay_ID`),
  KEY `EmpID_idx` (`Emp_ID`),
  KEY `OidCid_idx` (`Order_ID`,`Cus_ID`),
  CONSTRAINT `EmpID` FOREIGN KEY (`Emp_ID`) REFERENCES `employee` (`Emp_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OidCid` FOREIGN KEY (`Order_ID`, `Cus_ID`) REFERENCES `orders` (`Order_ID`, `Cust_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `Prod_ID` int NOT NULL AUTO_INCREMENT,
  `Product_Weight` double DEFAULT NULL,
  `Added_Date` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Unit_Price` double DEFAULT NULL,
  PRIMARY KEY (`Prod_ID`)
);

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `Stock_ID` int NOT NULL AUTO_INCREMENT,
  `Item_Name` varchar(45) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Stock_ID`)
);

--
-- Table structure for table `supply`
--

DROP TABLE IF EXISTS `supply`;

CREATE TABLE `supply` (
  `Product_ID` int NOT NULL,
  `Vender_ID` int NOT NULL,
  `Stock_ID` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`,`Vender_ID`),
  KEY `SID_idx` (`Stock_ID`),
  KEY `VID_idx` (`Vender_ID`),
  CONSTRAINT `PrID` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Prod_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SID` FOREIGN KEY (`Stock_ID`) REFERENCES `stock` (`Stock_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `VID` FOREIGN KEY (`Vender_ID`) REFERENCES `vendor` (`Vendor_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;

CREATE TABLE `vehicle` (
  `Vehicle_Num` varchar(20) NOT NULL,
  `Insurence_Exp` varchar(45) DEFAULT NULL,
  `Licence_Exp` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Supported_Weight` double NOT NULL,
  `Status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Vehicle_Num`)
);

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;

CREATE TABLE `vendor` (
  `Vendor_ID` int NOT NULL AUTO_INCREMENT,
  `Vendor_Name` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`Vendor_ID`)
);

-- Insert queries
--
-- Dumping data for table `customer`
--

INSERT INTO `customer` 
VALUES (1,'Dilupa','Gimhan','DGHardware','0767008922','dghan','dg01','981491768V','dg@gmail.com','16,Wattegama,Kandy'),
	(2,'Poorna ','Dimal','KandyHardware','0757891242','pdrana','rana@55','981245674V','rana@gmail.com','12,King Street,Kandy'),
    (3,'Thameera','Perera','GampolaHardware','0722123456','thampe','tham01','981465879V','tham@gmail.com','22/A,Kandy road,Gampola.');

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` 
VALUES (1,'kandy','2021-03-20','on delivery',1,1),
	(2,'matale','2021-03-25','delivered',2,2),
    (3,'kegalle','2021-04-05','delivered',3,3);

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` 
VALUES (1,'Kumara','Jayathilaka','0712211759',NULL,NULL,'5712867321V','kumara@gmail.com','12/1,Galahawatta,Mawanalla',33000,187,'cashCollector'),
	(2,'Jagath','Mahanama','0775642387',NULL,NULL,'651247987V',NULL,'20/5B,newtown,Pilimathalawa',15000,150,'labor'),
    (3,'Saman','Karunarathna','0754336587',NULL,NULL,'612552290V',NULL,'07/5,Milawaththa,Mawanalla.',30000,195,'driver');

--
-- Dumping data for table `employeetype`
--

INSERT INTO `employeetype` 
VALUES ('cashCollector',30000,180),
	('driver',25000,180),
    ('labor',15000,150);

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` 
VALUES (1,1,'2021-05-18','a','Excellent service','5','pending'),
	(2,2,'2021-08-19','q','is it possible to delivery?','3','compelted'),
    (3,3,'2021-04-02','c','poor service','1','pending');

--
-- Dumping data for table `has`
--

INSERT INTO `has` 
VALUES ('40-1150',2,2,'2021-03-25'),
	('NA-0122',2,3,'2021-04-05'),
    ('NC-2025',2,1,'2021-03-20');

--
-- Dumping data for table `order`
--

INSERT INTO `orders` 
VALUES (1,1,'2021-03-12','pending',127000,0,127000,127,1),
	(2,2,'2021-03-15','paid',310000,200000,110000,282,2),
    (3,3,'2021-03-17','delivered',220000,220000,0,250,3);

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` 
VALUES (1,100000,'2021-06-13',1,1,1),
	(2,300000,'2021-06-30',2,2,1),
    (3,50000,'2021-7-12',3,3,1);

--
-- Dumping data for table `product`
--

INSERT INTO `product` 
VALUES (1,25,'2021-05-20','Tokyo1247',970),
	(2,25,'2021-05-25','Sanstha1247',968),
    (3,20,'2021-05-26','Tokyo107',1005);

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` 
VALUES (1,'Tokyo1247',500000,'2021-05-23',600),
	(2,'Tokyo107',380000,'2021-04-10',350),
	(3,'Sanstha1247',650000,'2021-05-10',700);

--
-- Dumping data for table `supply`
--

INSERT INTO `supply` 
VALUES (1,3,1),
	(2,4,2),
    (3,5,3);

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle`
VALUES ('40-1150','2022-03-04','2022-08-10','Dual',4,'Not Available'),
	('NA-0122','2022-06-21','2022-07-21','Heavy',10,'Delivering'),
    ('NC-2025','2022-01-10','2022-03-13','Heavy',10,'Available');

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` 
VALUES (3,'Holcim','Holcim Cement,Puttalam rd, Kurunagala','0377800800'),
	(4,'Sanstha','Sanstha cement(pvt),Oruwala,Colombo','0111461005'),
	(5,'Tokyo','Tokyo cement,Wallampitiya,Colombo.','0112532832');

--
-- Database views 
--

-- PaymentDetails
Create View PaymentDetails As 
Select p.Pay_ID,c.Hardware_Name,o.Order_ID,p.Date,pd.Prod_ID,o.Qty,o.Total_Price,o.Paid_Amount,o.Remaining_Amount
from customer c,orders o,payment p,product pd
where  c.Cus_ID=o.Cust_ID and c.Cus_ID=p.Cus_ID and o.Cust_ID=p.Cus_ID and pd.Prod_ID=o.Product_ID;

-- Customer Aged
Create View CustomerAged AS
Select c.Hardware_Name,c.Phone,o.Order_ID,p.Date,o.Total_Price,o.Paid_Amount,o.Remaining_Amount
from customer c,orders o,payment p
where c.Cus_ID=o.Cust_ID and c.Cus_ID=p.Cus_ID and o.Cust_ID=p.Cus_ID; 

-- NewOrders
Create View NewOrders As
Select o.Order_Date,c.Hardware_Name,o.Qty,o.Total_Price
from customer c,orders o
where c.Cus_ID=o.Cust_ID and Order_Status="pending";


--
-- Database functions & procedures
--



--
-- select queries
--

-- select tables
select * from smd.customer;
select * from smd.delivery;
select * from smd.employee;
select * from smd.employeetype;
select * from smd.feedback;
select * from smd.has;
select * from smd.orders;
select * from smd.payment;
select * from smd.product;
select * from smd.stock;
select * from smd.supply;
select * from smd.vehicle;
select * from smd.vendor;

-- select views
select * from smd.PaymentDetails;
select * from smd.CustomerAged;
select * from smd.NewOrders;