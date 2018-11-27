1.

create table student1
(
student_id number(6)  primary key,
f_name varchar2 (15),
l_name  varchar2 (15) not null,
library_id varchar (6),
last_payment_reciept_id number (8)
);

create table librarydetails
(
library_id number(6) primary key,
numberofbooks number (8),
issuedbooks number (8),
nameofbooks varchar (15) 
);

create table paymentissues
(
last_payment_reciept_id number(8) primary key,
student_id number(15) REFERENCES student1(student_id),
classes varchar2 (15) not null,
campus varchar2(20) default 'north campus'
);

2
insert into student1(student_id,f_name,l_name,library_id,last_payment_reciept_id)
values(32,'lovepreet','kaur',3253,0033);

insert into student1
values (43,'lovi','aulakh',3252,0011);

insert into student1
values (44,'asd','fgh',3453,0099);

3
select * 
from student1  stu join librarydetails lib
on stu.library_id = lib.library_id
join paymentissues pis
on 
stu.student_id = pis.student_id

4

alter table student1
add studentaddress varchar2(15)

5
alter table student1
rename to learners

