create user ikuyonn identified by pro;

grant connect, dba, resource to ikuyonn;

create table message (
seq number primary key,
message varchar2(2000),
id varchar2(100),
roomnum varchar2(100),
date2 date
);
create sequence message_seq start with 1 increment by 1;

create table usertable(
userName varchar2(100),
password varchar2(100)
);

create table email(
userid varchar2(100),
address varchar2(200),
id varchar2(100),
password varchar2(100),
host varchar2(200),
smtp varchar2(200)
);

create table inbox(
userid varchar2(100),
address varchar2(200),
msgNum varchar2(100),
title varchar2(300),
content clob,
sentdate varchar2(200),
sentaddress varchar2(200)
);