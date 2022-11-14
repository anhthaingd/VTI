DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

-- Tao bang
CREATE TABLE `Department` (
    DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(20) NOT NULL UNIQUE KEY
);

CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);
-- ENUM dùng để chọn với số ít các dữ liệu
DROP TABLE IF EXISTS account;
CREATE TABLE `Account` (
    AccountID TINYINT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE KEY,
    Username VARCHAR(50) NOT NULL UNIQUE KEY,
    Fullname VARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW()
);

CREATE TABLE `Group` (
    GroupID TINYINT AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(20) NOT NULL UNIQUE KEY,
    CreatorID TINYINT NOT NULL,
    CreateDate DATETIME DEFAULT NOW()
);

CREATE TABLE `GroupAccount` (
    GroupID TINYINT NOT NULL,
    AccountID TINYINT NOT NULL,
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE `TypeQuestion` (
    TypeID TINYINT AUTO_INCREMENT PRIMARY KEY,
    TypeName ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

CREATE TABLE `CategoryQuestion` (
    CategoryID TINYINT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(20) NOT NULL UNIQUE KEY
);

CREATE TABLE `Question` (
    QuestionID TINYINT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    CategoryID TINYINT NOT NULL,
    TypeID TINYINT NOT NULL,
    CreatorID TINYINT NOT NULL,
    CreateDate DATETIME DEFAULT NOW()
);
CREATE TABLE `Answer` (
    AnswerID TINYINT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    QuestionID TINYINT NOT NULL,
    isCorrect BOOLEAN 
);

CREATE TABLE `Exam` (
    ExamID TINYINT AUTO_INCREMENT PRIMARY KEY,
    `Code` VARCHAR(10) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID TINYINT NOT NULL,
    Duration TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT NOT NULL,
    CreateDate DATETIME DEFAULT NOW()
);

CREATE TABLE `ExamQuestion` (
    ExamID TINYINT NOT NULL,
    QuestionID TINYINT NOT NULL
);

-- Them khoa phu
ALTER TABLE `account` ADD FOREIGN KEY (PositionID) REFERENCES `position`(PositionID) ON DELETE CASCADE;
ALTER TABLE `account` ADD FOREIGN KEY (DepartmentID) REFERENCES `department`(DepartmentID)  ON DELETE CASCADE;
ALTER TABLE `groupaccount` ADD FOREIGN KEY (AccountID) REFERENCES `account`(AccountID) ON DELETE CASCADE;
ALTER TABLE `Question` ADD FOREIGN KEY (CategoryID) REFERENCES `categoryquestion`(CategoryID)  ON DELETE CASCADE;
ALTER TABLE `Question` ADD FOREIGN KEY (TypeID) REFERENCES `typequestion`(TypeID)  ON DELETE CASCADE;
ALTER TABLE `Answer` ADD FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID )  ON DELETE CASCADE;
ALTER TABLE `Exam` ADD FOREIGN KEY (CategoryID) REFERENCES `categoryquestion` (CategoryID)  ON DELETE CASCADE;
ALTER TABLE `ExamQuestion` ADD FOREIGN KEY(ExamID) REFERENCES `Exam`(ExamID)  ON DELETE CASCADE;
ALTER TABLE `ExamQuestion` ADD FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID)  ON DELETE CASCADE;
ALTER TABLE `group` ADD FOREIGN KEY(CreatorID) REFERENCES `account`(AccountID) ON DELETE CASCADE;
ALTER TABLE `question` ADD FOREIGN KEY(CreatorID) REFERENCES `account`(AccountID) ON DELETE CASCADE;
ALTER TABLE `exam` ADD FOREIGN KEY(CreatorID) REFERENCES `account`(AccountID) ON DELETE CASCADE;
