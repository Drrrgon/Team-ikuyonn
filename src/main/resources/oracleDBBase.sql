CREATE user ikuyonn identified by pro;

grant connect, dba, resource to ikuyonn;

DROP TABLE JOINPROJECT PURGE;
DROP TABLE message purge;
DROP TABLE usertable purge;
DROP TABLE email purge;
DROP TABLE inbox purge;
DROP TABLE nameCard purge;
DROP TABLE project purge;
DROP TABLE event purge;
drop table projectEvent purge;
drop table events purge;
drop table cloudFile purge;

DROP sequence message_seq;
DROP sequence project_seq;
DROP sequence eventseq;
DROP Sequence fileSeq ;
CREATE TABLE message (
    messageSeq number PRIMARY KEY
    , userID varchar2(40)
    , userName varchar2(100)
    , message varchar2(2000)
    , messageDate date 
    , projectName varchar2(100)
);



CREATE sequence message_seq start with 1 increment by 1;


CREATE TABLE usertable(
    userID varchar2(40) PRIMARY KEY
    , userPW varchar2(80) NOT NULL
    , userName varchar2(40) NOT NULL
    , userBirth date
    , userPhone varchar2(24) NOT NULL
    , originalFileName varchar2(300)
);
insert into usertable values('qwer', 'qwer', '신용하',sysdate, '1', null);
insert into usertable values('asdf', 'asdf', '이민석',sysdate, '1', null);
insert into usertable values('zxcv', 'zxcv', '강수빈',sysdate, '1', null);
insert into usertable values('1234', '1234', '이상운',sysdate, '1', null);

CREATE TABLE email(
    emailAddress varchar2(100) PRIMARY KEY
    , emailId varchar2(60) NOT NULL
    , emailPassword varchar2(100) NOT NULL
    , host varchar2(200) NOT NULL
    , smtp varchar2(200) NOT NULL
    , userID varchar2(40)
);
ALTER TABLE email ADD CONSTRAINT fk_email_userID FOREIGN KEY (userID) REFERENCES usertable(userID)on delete cascade;

insert into email values('ikuyong01@gmail.com','ikuyong01@gmail.com','dlzndyd01','imap.gmail.com','smtp.gmail.com','asdf');
insert into email values('ikuyong02@gmail.com','ikuyong02@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','zxcv');
insert into email values('ikuyong03@gmail.com','ikuyong03@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','qwer');
insert into email values('ikuyong04@gmail.com','ikuyong04@gmail.com','aaa','imap.gmail.com','smtp.gmail.com','1234');

CREATE TABLE inbox(
    msgNum varchar2(20)
    , emailAddress varchar2(100)
    , title varchar2(300) NOT NULL
    , content clob NOT NULL
    , sentdate varchar2(40) NOT NULL
    , sentaddress varchar2(200) NOT NULL
);
ALTER TABLE inbox ADD CONSTRAINT fk_inbox_emailAddress FOREIGN KEY (emailAddress) REFERENCES email(emailAddress)on delete cascade;

CREATE TABLE project (
    -- project master e-mail
    projectSeq number PRIMARY KEY
    , projectName varchar2(200)
    ,due varchar2(100) default '------'
    ,memberNum number
);
CREATE SEQUENCE project_seq START WITH 1 INCREMENT BY 1;
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'Team Ikuyonn', NULL, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'Team DDONG', NULL, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'Team 12', NULL, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'Team 34', NULL, NULL);

CREATE TABLE events (
    eventSeq number PRIMARY KEY
    , userID varchar2(40)
    , summary varchar2(100) NOT NULL
    , description varchar2(500) NOT NULL
    , startDate date NOT NULL
    , endDate date NOT NULL
    , projectseq number
);
create sequence eventseq;

ALTER TABLE events ADD CONSTRAINT fk_events_userID FOREIGN KEY (userID) REFERENCES usertable(userID)on delete cascade;
ALTER TABLE events ADD CONSTRAINT fk_events_projectseq FOREIGN KEY (projectseq) REFERENCES project(projectseq)on delete cascade;

CREATE TABLE joinProject (
    userID varchar2(40)
    , projectSeq number
);

insert into joinproject values('qwer',1);
insert into joinproject values('asdf',1);
insert into joinproject values('zxcv',1);
insert into joinproject values('1234',1);



ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_userID FOREIGN KEY (userID) REFERENCES usertable(userID)on delete cascade;
ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq)on delete cascade;

CREATE TABLE nameCard (
    ncSeq varchar2(20) PRIMARY KEY
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
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_ncCheck CHECK (ncCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_emailCheck CHECK (emailCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT fk_nameCard_userID FOREIGN KEY (userID) REFERENCES usertable(userID)on delete cascade;

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