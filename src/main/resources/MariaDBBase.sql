use mysql

create database ikuyonn;
 use ikuyonn

 create user 'ikyMaster'@'localhost' identified by 'xyz';

 grant all privileges on ikyonn.* to ikyMaster@localhost;

 flush privileges;


DROP TABLE joinProject ;
DROP TABLE message ;
DROP TABLE userTable ;
DROP TABLE email ;
DROP TABLE inbox ;
DROP TABLE nameCard ;
DROP TABLE project ;
DROP TABLE event ;
drop table projectEvent ;
drop table events ;
drop table cloudFile ;


CREATE TABLE `ikuyonn`.`message` ( `messageSeq` INT NOT NULL AUTO_INCREMENT , `userID` VARCHAR(40) NOT NULL , `userName` VARCHAR(100) NOT NULL , `message` VARCHAR(2000) NOT NULL , `messageDate` DATETIME NOT NULL , `projectName` VARCHAR(100) NOT NULL , PRIMARY KEY (`messageSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci COMMENT = 'message table';

CREATE TABLE `ikuyonn`.`userTable` ( `userID` VARCHAR(40) NOT NULL , `userPW` VARCHAR(80) NOT NULL , `userName` VARCHAR(40) NOT NULL , `userBirth` DATE NULL , `userPhone` VARCHAR(24) NOT NULL , `originalFileName` VARCHAR(300) NULL , PRIMARY KEY (`userID`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

insert into userTable values('qwer', 'qwer', '신용하',now(), '1', null);
insert into userTable values('asdf', 'asdf', '이민석',now(), '1', null);
insert into userTable values('zxcv', 'zxcv', '강수빈',now(), '1', null);
insert into userTable values('1234', '1234', '이상운',now(), '1', null);


CREATE TABLE `ikuyonn`.`email` ( `emailAddress` VARCHAR(100) NOT NULL , `emailId` VARCHAR(60) NOT NULL , `emailPassword` VARCHAR(100) NOT NULL , `host` VARCHAR(200) NOT NULL , `smtp` VARCHAR(200) NOT NULL , `userID` VARCHAR(40) NOT NULL , PRIMARY KEY (`emailAddress`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE email ADD CONSTRAINT fk_email_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;

insert into email values('ikuyong01@gmail.com','ikuyong01@gmail.com','dlzndyd01','imap.gmail.com','smtp.gmail.com','asdf');
insert into email values('ikuyong02@gmail.com','ikuyong02@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','zxcv');
insert into email values('ikuyong03@gmail.com','ikuyong03@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','qwer');
insert into email values('ikuyong04@gmail.com','ikuyong04@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','1234');

CREATE TABLE `ikuyonn`.`inbox` ( `msgNum` VARCHAR(20) NULL , `emailAddress` VARCHAR(100) NULL , `title` BLOB NOT NULL , `content` LONGBLOB NOT NULL , `sentdate` VARCHAR(40) NOT NULL , `sentaddress` VARCHAR(200) NOT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE inbox ADD CONSTRAINT fk_inbox_emailAddress FOREIGN KEY (emailAddress) REFERENCES email(emailAddress)on delete cascade;

CREATE TABLE `ikuyonn`.`project` ( `projectSeq` INT NOT NULL AUTO_INCREMENT , `projectMaster` VARCHAR(40) NOT NULL , `projectName` VARCHAR(200) NULL , `due` VARCHAR(100) NULL DEFAULT '------' , `memberNum` INT NULL , `color` VARCHAR(20) NULL , PRIMARY KEY (`projectSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE project ADD CONSTRAINT fk_project_projectMaster FOREIGN KEY (projectMaster) REFERENCES userTable(userID)on delete cascade;
INSERT INTO project VALUES(null, 'qwer', 'Team Ikuyonn', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team DDONG', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team 12', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team 34', now(), NULL,'66ccff');

CREATE TABLE `ikuyonn`.`events` ( `eventSeq` INT NOT NULL AUTO_INCREMENT , `userID` VARCHAR(40) NULL , `summary` VARCHAR(100) NOT NULL , `description` VARCHAR(500) NOT NULL , `startDate` DATETIME NOT NULL , `endDate` DATETIME NOT NULL , `projectseq` INT NULL , `color` VARCHAR(20) NULL , PRIMARY KEY (`eventSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE events ADD CONSTRAINT fk_events_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;
ALTER TABLE events ADD CONSTRAINT fk_events_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;

CREATE TABLE `ikuyonn`.`joinProject` ( `userID` VARCHAR(40) NOT NULL , `projectSeq` INT NOT NULL, `status` INT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

insert into joinProject values('qwer',1,1);
insert into joinProject values('asdf',1,1);
insert into joinProject values('zxcv',1,1);
insert into joinProject values('1234',1,1);


ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;
ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;

CREATE TABLE `ikuyonn`.`nameCard` ( `ncSeq` INT NOT NULL AUTO_INCREMENT , `userID` VARCHAR(40) NOT NULL , `ncCheck` VARCHAR(10) NOT NULL , `ncName` VARCHAR(40) NULL , `ncEmail` VARCHAR(100) NOT NULL , `hUserID` VARCHAR(40) NULL , `ncMobile` VARCHAR(60) NULL , `ncPhone` VARCHAR(60) NULL , `ncFax` VARCHAR(60) NULL , `ncCompany` VARCHAR(60) NULL , `ncDepartment` VARCHAR(60) NULL , `ncTitle` VARCHAR(40) NULL , `ncWebsite` VARCHAR(100) NULL , `ncAddress` VARCHAR(100) NULL , `ncGroup` VARCHAR(40) NOT NULL DEFAULT '기본' , `nameCardUrl` VARCHAR(100) NULL , `emailCheck` VARCHAR(10) NOT NULL DEFAULT '0' , PRIMARY KEY (`ncSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_ncCheck CHECK (ncCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_emailCheck CHECK (emailCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT fk_nameCard_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;

--비회원
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','김개똥','aaa1@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem1.jpg','0');
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','김말똥','aaa2@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem2.jpg','0');
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','김소똥','aaa3@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem3.jpg','0');
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','김쥐똥','aaa4@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem4.jpg','0');
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','김뱀똥','aaa5@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem5.jpg','0');
--회원
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','신용하','ikuyong03@gmail.com','010-0000-0000','02-0000-0000','02-0000-0000','a company','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem2.jpg','1');
INSERT INTO nameCard(ncSeq,userID,ncCheck,ncName,ncEmail,ncMobile,ncPhone,ncFax,ncCompany,ncDepartment,ncTitle,ncWebsite,ncAddress,nameCardUrl,emailCheck) VALUES(null,'asdf','1','이상운','ikuyong04@gmail.com','010-0000-0000','02-0000-0000','02-0000-0000','a company','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem3.jpg','1');             
CREATE TABLE `ikuyonn`.`projectEvent` ( `projectSeq` INT NOT NULL , `eventSeq` INT NOT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;
ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_eventSeq FOREIGN KEY (eventSeq) REFERENCES events(eventSeq)on delete cascade;


CREATE TABLE `ikuyonn`.`cloudFile` ( `fileSeq` INT NOT NULL AUTO_INCREMENT , `fileName` VARCHAR(100) NOT NULL , `filePath` VARCHAR(300) NOT NULL DEFAULT 'c:\\\\\\\\filerepo\\\\\\\\' , `saveFileName` VARCHAR(300) NOT NULL , `fileType` VARCHAR(40) NOT NULL , `projectSeq` INT NOT NULL , PRIMARY KEY (`fileSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE cloudFile add CONSTRAINT fk_file_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;
