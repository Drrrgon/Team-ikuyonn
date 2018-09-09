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
    
    projectSeq number PRIMARY KEY,
    projectMaster varchar2(40)
    , projectName varchar2(200)
    , due varchar2(100) default '------'
    , memberNum number
);
CREATE SEQUENCE project_seq START WITH 1 INCREMENT BY 1;
ALTER TABLE project ADD CONSTRAINT fk_project_projectMaster FOREIGN KEY (projectMaster) REFERENCES userTable(userID)on delete cascade;
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'qwer', 'Team Ikuyonn', sysdate, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'qwer', 'Team DDONG', sysdate, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'qwer', 'Team 12', sysdate, NULL);
INSERT INTO PROJECT VALUES(project_seq.nextVal, 'qwer', 'Team 34', sysdate, NULL);

CREATE TABLE events (
    eventSeq number PRIMARY KEY
    , userID varchar2(40)
    , summary varchar2(100) NOT NULL
    , description varchar2(500) NOT NULL
    , startDate date NOT NULL
    , endDate date NOT NULL
);
create sequence eventseq;

ALTER TABLE events ADD CONSTRAINT fk_events_userID FOREIGN KEY (userID) REFERENCES usertable(userID)on delete cascade;

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
    , ncEmail varchar2(100) UNIQUE NOT NULL
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