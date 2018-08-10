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