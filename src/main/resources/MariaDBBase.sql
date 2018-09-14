CREATE user ikuyonn identified by pro;

grant connect, dba, resource to ikuyonn;

DROP TABLE joinProject PURGE;
DROP TABLE message purge;
DROP TABLE userTable purge;
DROP TABLE email purge;
DROP TABLE inbox purge;
DROP TABLE nameCard purge;
DROP TABLE project purge;
DROP TABLE event purge;
drop table projectEvent purge;
drop table events purge;
drop table cloudFile purge;


CREATE TABLE `ikuyonn`.`message` ( `messageSeq` INT NOT NULL AUTO_INCREMENT , `userID` VARCHAR(40) NOT NULL , `userName` VARCHAR(100) NOT NULL , `message` VARCHAR(2000) NOT NULL , `messageDate` DATETIME NOT NULL , `projectName` INT(100) NOT NULL , PRIMARY KEY (`messageSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci COMMENT = 'message table';

CREATE TABLE `ikuyonn`.`userTable` ( `userID` VARCHAR(40) NOT NULL , `userPW` VARCHAR(80) NOT NULL , `userName` VARCHAR(40) NOT NULL , `userBirth` DATE NULL , `userPhone` VARCHAR(24) NOT NULL , `originalFileName` VARCHAR(300) NULL , PRIMARY KEY (`userID`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

insert into userTable values('qwer', 'qwer', '신용하',now(), '1', null);
insert into userTable values('asdf', 'asdf', '이민석',now(), '1', null);
insert into userTable values('zxcv', 'zxcv', '강수빈',now(), '1', null);
insert into userTable values('1234', '1234', '이상운',now(), '1', null);

CREATE TABLE email(
    emailAddress varchar2(100) PRIMARY KEY
    , emailId varchar2(60) NOT NULL
    , emailPassword varchar2(100) NOT NULL
    , host varchar2(200) NOT NULL
    , smtp varchar2(200) NOT NULL
    , userID varchar2(40)
);
ALTER TABLE email ADD CONSTRAINT fk_email_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;

insert into email values('ikuyong01@gmail.com','ikuyong01@gmail.com','dlzndyd01','imap.gmail.com','smtp.gmail.com','asdf');
insert into email values('ikuyong02@gmail.com','ikuyong02@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','zxcv');
insert into email values('ikuyong03@gmail.com','ikuyong03@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','qwer');
insert into email values('ikuyong04@gmail.com','ikuyong04@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','1234');

CREATE TABLE `ikuyonn`.`inbox` ( `msgNum` VARCHAR(20) NULL , `emailAddress` VARCHAR(100) NULL , `title` VARCHAR(300) NOT NULL , `content` TEXT NOT NULL , `sentdate` VARCHAR(40) NOT NULL , `sentaddress` VARCHAR(20) NOT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE inbox ADD CONSTRAINT fk_inbox_emailAddress FOREIGN KEY (emailAddress) REFERENCES email(emailAddress)on delete cascade;

CREATE TABLE `ikuyonn`.`project` ( `projectSeq` INT NOT NULL AUTO_INCREMENT , `projectMaster` VARCHAR(40) NOT NULL , `projectName` VARCHAR(200) NULL , `due` VARCHAR(100) NULL DEFAULT '------' , `memberNum` INT NULL , `color` VARCHAR(20) NULL , PRIMARY KEY (`projectSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE project ADD CONSTRAINT fk_project_projectMaster FOREIGN KEY (projectMaster) REFERENCES userTable(userID)on delete cascade;
INSERT INTO project VALUES(null, 'qwer', 'Team Ikuyonn', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team DDONG', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team 12', now(), NULL,'66ccff');
INSERT INTO project VALUES(null, 'qwer', 'Team 34', now(), NULL,'66ccff');

CREATE TABLE `ikuyonn`.`events` ( `eventSeq` INT NOT NULL AUTO_INCREMENT , `userID` VARCHAR(40) NOT NULL , `summary` VARCHAR(100) NOT NULL , `description` VARCHAR(500) NOT NULL , `startDate` DATETIME NOT NULL , `endDate` DATETIME NOT NULL , `projectseq` INT NOT NULL , `color` VARCHAR(20) NOT NULL , PRIMARY KEY (`eventSeq`)) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

ALTER TABLE events ADD CONSTRAINT fk_events_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;
ALTER TABLE events ADD CONSTRAINT fk_events_projectseq FOREIGN KEY (projectseq) REFERENCES project(projectseq)on delete cascade;

CREATE TABLE `ikuyonn`.`joinProject` ( `userID` VARCHAR(40) NOT NULL , `projectSeq` INT NOT NULL ) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci;

insert into joinProject values('qwer',1);
insert into joinProject values('asdf',1);
insert into joinProject values('zxcv',1);
insert into joinProject values('1234',1);


ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;
ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;

CREATE TABLE nameCard (
    ncSeq number PRIMARY KEY
    , userID varchar2(40)
    , ncCheck varchar2(10)
    , ncName varchar2(40)
    , ncEmail varchar2(100) NOT NULL
    , ncMobile varchar2(60)
    , ncPhone varchar2(60)
    , ncFax varchar2(60)
    , ncCompany varchar2(60)
    , ncDepartment varchar2(60)
    , ncTitle varchar2(40)
    , ncWebsite varchar2(100)
    , ncAddress varchar2(100)
    , ncGroup varchar2(40) DEFAULT '기본' 
    , nameCardUrl varchar2(100)
    , emailCheck varchar2(10) DEFAULT 0
);
CREATE sequence ncSeq;
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_ncCheck CHECK (ncCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_emailCheck CHECK (emailCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT fk_nameCard_userID FOREIGN KEY (userID) REFERENCES userTable(userID)on delete cascade;

--비회원
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','김개똥','aaa1@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem1.jpg','0');
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','김말똥','aaa2@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem2.jpg','0');
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','김소똥','aaa3@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem3.jpg','0');
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','김쥐똥','aaa4@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem4.jpg','0');
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','김뱀똥','aaa5@naver.com','010-0000-0000','02-0000-0000','02-0000-0000','a회사','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem5.jpg','0');
--회원
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','신용하','ikuyong03@gmail.com','010-0000-0000','02-0000-0000','02-0000-0000','a company','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem2.jpg','1');
--INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
--		VALUES(NCSEQ.NEXTVAL,'asdf','1','강수빈','ikuyong02@gmail.com','010-0000-0000','02-0000-0000','02-0000-0000','a company','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem3.jpg','0');
INSERT INTO NAMECARD(NCSEQ,USERID,NCCHECK,NCNAME,NCEMAIL,NCMOBILE,NCPHONE,NCFAX,NCCOMPANY,NCDEPARTMENT,NCTITLE,NCWEBSITE,NCADDRESS,NAMECARDURL,EMAILCHECK)
		VALUES(NCSEQ.NEXTVAL,'asdf','1','이상운','ikuyong04@gmail.com','010-0000-0000','02-0000-0000','02-0000-0000','a company','회계팀','대리','www.aaa.com','서울시 00구 00로','./resources/images/nameCard/namecard_sem3.jpg','1');             
        
        
CREATE TABLE projectEvent(
    projectSeq number
    , eventSeq number
);

ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;
ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_eventSeq FOREIGN KEY (eventSeq) REFERENCES events(eventSeq)on delete cascade;
Create Sequence fileSeq ;
CREATE TABLE cloudFile(
    fileSeq number PRIMARY KEY
    ,fileName varchar2(100) NOT NULL
    ,filePath varchar2(300) default 'c:\\\\filerepo\\\\'
    ,saveFileName varchar2(300) NOT NULL
    ,fileType varchar2(40) NOT NULL
    ,projectSeq number
);
ALTER TABLE cloudFile add CONSTRAINT fk_file_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;

commit;