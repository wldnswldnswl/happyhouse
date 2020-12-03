DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`(
	`title` varchar(100) DEFAULT NULL,
    `content` varchar(300) DEFAULT NULL,
    `writer` varchar(50) DEFAULT NULL,
    `url` varchar(100) DEFAULT NULL
);

DROP TABLE IF EXISTS `graph`;
CREATE TABLE `graph` (
  `no` int NOT NULL AUTO_INCREMENT,
  `dong` varchar(30) NOT NULL,
  `AptName` varchar(50) NOT NULL,
  `dealAmount` int,
  `dealYear` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
);

INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','아크로힐스논현',158000,'2015'),('논현동','아크로힐스논현',150000,'2016'),('논현동','아크로힐스논현',158000,'2017'),('논현동','아크로힐스논현',159500,'2018'),('논현동','아크로힐스논현',160000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','쌍용',85000,'2015'),('논현동','쌍용',77000,'2016'),('논현동','쌍용',76000,'2017'),('논현동','쌍용',90000,'2018'),('논현동','쌍용',74000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','이산',39000,'2015'),('논현동','이산',35500,'2016'),('논현동','이산',35000,'2017'),('논현동','이산',40000,'2018'),('논현동','이산',43000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','신동아(22)',127000,'2015'),('논현동','신동아(22)',70500,'2016'),('논현동','신동아(22)',70000,'2017'),('논현동','신동아(22)',115000,'2018'),('논현동','신동아(22)',71100,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','세호시티라이프',29000,'2015'),('논현동','세호시티라이프',35300,'2016'),('논현동','세호시티라이프',33500,'2017'),('논현동','세호시티라이프',28000,'2018'),('논현동','세호시티라이프',29000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','골든캐슬',99000,'2015'),('논현동','골든캐슬',100000,'2016'),('논현동','골든캐슬',115000,'2017'),('논현동','골든캐슬',123000,'2018'),('논현동','골든캐슬',140000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','거평프리젠',27000,'2015'),('논현동','거평프리젠',29500,'2016'),('논현동','거평프리젠',35000,'2017'),('논현동','거평프리젠',33000,'2018'),('논현동','거평프리젠',40000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','한진로즈힐',45000,'2015'),('논현동','한진로즈힐',44000,'2016'),('논현동','한진로즈힐',49000,'2017'),('논현동','한진로즈힐',42900,'2018'),('논현동','한진로즈힐',45150,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','논현인텔(9-2)',49226,'2015'),('논현동','논현인텔(9-2)',34400,'2016'),('논현동','논현인텔(9-2)',36322,'2017'),('논현동','논현인텔(9-2)',23803,'2018'),('논현동','논현인텔(9-2)',40000,'2019');
INSERT INTO `graph` (`dong`, `AptName`, `dealAmount`, `dealYear`) VALUES ('논현동','논현동한화꿈에그린',85000,'2015'),('논현동','논현동한화꿈에그린',79500,'2016'),('논현동','논현동한화꿈에그린',95000,'2017'),('논현동','논현동한화꿈에그린',93000,'2018'),('논현동','논현동한화꿈에그린',100000,'2019');

DROP TABLE IF EXISTS `time_table`;
CREATE TABLE `time_table`(
	`id` varchar(16) DEFAULT NULL,
    `checktime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

INSERT INTO `time_table` (`id`) VALUES ('admin');
INSERT INTO `time_table` (`id`) VALUES ('user1');
