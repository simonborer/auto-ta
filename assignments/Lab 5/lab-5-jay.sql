--Ques.1
CREATE TABLE students1
(
  student_id  NUMBER(6)     PRIMARY KEY,
  first_name   VARCHAR2(15)  NOT NULL,
  Country   VARCHAR2(15),
  Contact    NUMBER (10)
);

create table subjects1
 (
  Subject_id number(10) primary key,
  student number(6) references students1(student_id)
  )

create table assignments1
(
Assignment_id number(6) PRIMARY key,
assignment number(10) references subjects1(subject_id)
)

--Ques.2
insert into students1( student_id,first_name,country,contact)
values(00,'Jay','Canada',3245);

insert into students1( student_id,first_name,country,contact)
values(01,'Amandeep','Canada',32145);

insert into students1( student_id,first_name,country,contact)
values(02,'Khush','Canada',31235);

insert into subjects1( subject_id,student)
values(5101,00);


insert into subjects1( subject_id,student)
values(5102,01);


insert into subjects1( subject_id,student)
values(5103,02);

insert into assignments1(Assignment_id,assignment)
values(1,5101);


insert into assignments1(Assignment_id,assignment)
values(3,5102);


insert into assignments1(Assignment_id,assignment)
values(2,5103);

--Ques.3
select * from students1
join subjects1
on students1.student_id=Subjects1.student
join assignments1
on subjects1.subject_id=assignments1.assignment


--Ques.4

alter table students1
add students1_background varchar(15)


--Ques.5

alter table assignments1
rename to  Assign1
