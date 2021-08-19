-- Create the database Titled Kiva DW

create database kiva_dw character set UTF8mb4 collate utf8mb4_bin; 

use kiva_dw;

-- country dimension
-- some data are in UTF-8, we have to consider them
create table `dimCountry`(
    `country_id` int unsigned not null PRIMARY key AUTO_INCREMENT,
    `iso_code` varchar(100) not null,
    `country_name` varchar(255) not null,
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
)

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
     FOREIGN KEY (`country_id`) REFERENCES `country`(`country_id`),
     FOREIGN KEY (`region_id`) REFERENCES `country`(`country_id`),
     FOREIGN KEY (`w_region_id`) REFERENCES `country`(`country_id`)
);

-- Loan theme --
create table `dimLoanThemeType`(
    `loan_theme_id` bigint unsigned not null primary key AUTO_INCREMENT,
    `loan_theme_type` varchar(255) not null
);





