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
     FOREIGN KEY (`country_id`) REFERENCES `dimCountry`(`country_id`),
     FOREIGN KEY (`region_id`) REFERENCES `dimRegion`(`region_id`),
     FOREIGN KEY (`w_region_id`) REFERENCES `dimWorldRegion`(`w_region_id`)
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
    
     FOREIGN KEY (`theme_type_id`) REFERENCES `dimLoanThemeType`(`theme_type_id`) 
)

-- loan theme grant
create table `dimLoanThemeGrant`(
    `loan_theme_grant_id` bigint unsigned not null primary key AUTO_INCREMENT,
    `location_id` bigint unsigned not null,
    `t_partner_id` bigint unsigned not null,
    `loan_theme_number` int,
    `loan_theme_amount` float not null,
    FOREIGN KEY (`location_id`) REFERENCES `dimLocation`(`location_id`),
    FOREIGN KEY (`t_patner_id`) REFERENCES `dimPartner`(`t_partner_id`),
);

--





