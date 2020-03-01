create database `djangoblog` default character set utf8 collate utf8_general_ci;

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON djangoblog.* TO 'djangoblog'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

use djangoblog;
SET NAMES utf8mb4;
