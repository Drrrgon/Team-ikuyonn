CREATE user ikuyonn identified by pro;

grant connect, dba, resource to ikuyonn;

DROP TABLE message purge;
DROP TABLE usertable purge;
DROP TABLE email purge;
DROP TABLE inbox purge;
DROP TABLE nameCard purge;
DROP TABLE project purge;
DROP TABLE event purge;
DROP sequence message_seq;

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
);

CREATE TABLE email(
    emailAddress varchar2(100) PRIMARY KEY
    , emailId varchar2(60) NOT NULL
    , emailPassword varchar2(100) NOT NULL
    , host varchar2(200) NOT NULL
    , smtp varchar2(200) NOT NULL
    , userID varchar2(40)
);
ALTER TABLE email ADD CONSTRAINT fk_email_userID FOREIGN KEY (userID) REFERENCES usertable(userID);

CREATE TABLE inbox(
    msgNum varchar2(20)
    , emailAddress varchar2(100)
    , title varchar2(300) NOT NULL
    , content clob NOT NULL
    , sentdate varchar2(40) NOT NULL
    , sentaddress varchar2(200) NOT NULL
);
ALTER TABLE inbox ADD CONSTRAINT fk_inbox_emailAddress FOREIGN KEY (emailAddress) REFERENCES email(emailAddress);

CREATE TABLE project (
    projectSeq number PRIMARY KEY
    , projectName varchar2(200)
    ,due varchar2(100) default '------'
    ,memberNum number
);

CREATE TABLE events (
    eventSeq number PRIMARY KEY
    , userID varchar2(40)
    , summary varchar2(100) NOT NULL
    , description varchar2(500) NOT NULL
    , startDate date NOT NULL
    , startTime varchar2(50) NOT NULL
    , endDate date NOT NULL
    , endTime varchar2(50) NOT NULL
);

ALTER TABLE events ADD CONSTRAINT fk_events_userID FOREIGN KEY (userID) REFERENCES usertable(userID);

CREATE TABLE joinProject (
    userID varchar2(40)
    , projectSeq number
);
CREATE SEQUENCE project_seq START WITH 1 INCREMENT BY 1;

ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_userID FOREIGN KEY (userID) REFERENCES usertable(userID);
ALTER TABLE joinProject ADD CONSTRAINT fk_joinProject_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq);

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
);
ALTER TABLE nameCard ADD CONSTRAINT check_nameCard_ncCheck CHECK (ncCheck BETWEEN 0 AND 1);
ALTER TABLE nameCard ADD CONSTRAINT fk_nameCard_userID FOREIGN KEY (userID) REFERENCES usertable(userID);

CREATE TABLE projectEvent(
    projectSeq number
    , eventSeq number
);

ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq);
ALTER TABLE projectEvent ADD CONSTRAINT fk_projectEvent_eventSeq FOREIGN KEY (eventSeq) REFERENCES events(eventSeq);
create sequence eventseq;
alter table events drop column startTime;
alter table events drop column endTime;

CREATE TABLE cloudFile(
    fileName varchar2(100) PRIMARY KEY
    ,filePath varchar2(300) NOT NULL
    ,fileType varchar2(40) NOT NULL
    ,projectSeq number 
);
ALTER TABLE cloudFile add CONSTRAINT fk_file_projectSeq FOREIGN KEY (projectSeq) REFERENCES project(projectSeq);