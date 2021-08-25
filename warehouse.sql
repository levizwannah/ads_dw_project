-- Create the database Titled Kiva DW

create database kiva_dw character set UTF8mb4 collate utf8mb4_bin; 

use kiva_dw;

-- country dimension
-- some data are in UTF-8, we have to consider them
create table `dimCountry`(
    `country_id` int unsigned not null PRIMARY key AUTO_INCREMENT,
    `iso_code` varchar(100) not null,
    `country_name` varchar(255) not null
);

-- Region dimension --
create table `dimRegion`(
    `region_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `region_name` varchar(300) not null
);

-- World region dimension --
create TABLE `dimWorldRegion`(
    `w_region_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `w_region_name` varchar(300) not null
);

-- Location dimension
create table `dimLocation`(
    `location_id` bigint unsigned not null primary key AUTO_INCREMENT,
    `country_id` int unsigned not null,
    `region_id` bigint unsigned not null,
    `w_region_id` BIGINT unsigned not null,
    `lat` float ,
    `long` float ,
    `location_name` varchar(1000) not null,
    `mpi` float not null,
     FOREIGN KEY (`country_id`) REFERENCES `dimCountry`(`country_id`)ON DELETE CASCADE,
     FOREIGN KEY (`region_id`) REFERENCES `dimRegion`(`region_id`)ON DELETE CASCADE,
     FOREIGN KEY (`w_region_id`) REFERENCES `dimWorldRegion`(`w_region_id`) ON DELETE CASCADE
);

-- Loan theme type --
create table `dimLoanThemeType`(
    `theme_type_id` bigint unsigned not null primary key AUTO_INCREMENT,
    `loan_theme_type` varchar(255) not null
);

-- Partner dimenstion --
create table `dimPartner`(
    `t_partner_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `partner_id` int unsigned,
    `partner_name` varchar(300),
    `theme_type_id` BIGINT UNSIGNED NOT NULL,
    
     FOREIGN KEY (`theme_type_id`) REFERENCES `dimLoanThemeType`(`theme_type_id`)ON DELETE CASCADE 
);

-- loan theme grant fact --
create table `factLoanThemeGrant`(
    `loan_theme_grant_id` bigint unsigned not null primary key AUTO_INCREMENT,
    `location_id` bigint unsigned not null,
    `t_partner_id` bigint unsigned not null,
    `loan_theme_number` int,
    `loan_theme_amount` float not null,
    FOREIGN KEY (`location_id`) REFERENCES `dimLocation`(`location_id`)ON DELETE CASCADE,
    FOREIGN KEY (`t_partner_id`) REFERENCES `dimPartner`(`t_partner_id`) ON DELETE CASCADE
);

-- time dimenstion table --
create table `dimTime`(
    `time_id` BIGINT UNSIGNED not null PRIMARY KEY AUTO_INCREMENT,
    `date_string` datetime,
    `year` int unsigned not null,
    `month` int unsigned not null,
    `month_string` varchar(12) not null,
    `day` int unsigned not null,
    `day_string` varchar(12) 
);

-- sector dimenstion --

create table `dimSector`(
    `sector_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `sector_name` varchar(500) not null
);

-- Loan dimension --

create table `dimLoan`(
    `loan_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `activity` varchar(1500),
    `sector_id` BIGINT UNSIGNED NOT NULL,
    `currency` varchar(15) NOT NULL,
    `borrower_gender` varchar(15),
    FOREIGN KEY (`sector_id`) REFERENCES `dimSector`(`sector_id`) ON DELETE CASCADE
);

-- fact loan grants

create table `factLoanGrant`(
    `loan_grant_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `loan_id` BIGINT UNSIGNED NOT NULL,
    `location_id` BIGINT UNSIGNED NOT NULL,
    `partner_id` BIGINT UNSIGNED NOT NULL,
    `funded_time_id` BIGINT UNSIGNED NOT NULL,
    `posted_time_id` BIGINT UNSIGNED NOT NULL,
    `disbursed_time_id` BIGINT UNSIGNED NOT NULL,
    `loan_amount`  INT UNSIGNED NOT NULL,
    `funded_amount` INT UNSIGNED NOT NULL,
    `lender_count` INT UNSIGNED NOT NULL,
    `term_in_months` INT UNSIGNED NOT NULL,
    FOREIGN KEY(`loan_id`) REFERENCES `dimLoan`(`loan_id`)ON DELETE CASCADE,
    FOREIGN KEY(`location_id`) REFERENCES `dimLocation`(`location_id`)ON DELETE CASCADE,
    FOREIGN KEY(`partner_id`) REFERENCES `dimPartner`(`t_partner_id`)ON DELETE CASCADE,
    FOREIGN KEY(`funded_time_id`) REFERENCES `dimTime`(`time_id`) ON DELETE CASCADE
    FOREIGN KEY(`posted_time_id`) REFERENCES `dimTime`(`time_id`) ON DELETE CASCADE
    FOREIGN KEY(`disbursed_time_id`) REFERENCES `dimTime`(`time_id`) ON DELETE CASCADE
);


