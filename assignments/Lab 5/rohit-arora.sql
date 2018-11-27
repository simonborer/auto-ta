"Q1"CREATE TABLE subject1 (    subjectID NUMBER(7)    CONSTRAINT subject1_subjectID_pk PRIMARY KEY,         student numeric(7) ,         subjectname varchar(255)     CONSTRAINT subject1_subjectname_ck CHECK (SUBSTR(subjectname, 1, 1) BETWEEN 'A' AND 'M'),        subjectcode char(10) Default '000k'        )


CREATE TABLE teacher1(teacherid NUMBER(7)CONSTRAINT teacher1_teacherid_pk PRIMARY KEY,

subject NUMERIC(7),
FirstName varchar(255)  Default 'rohit'CONSTRAINT teacher1_FirstName_nn not null,
subjectteach char(30)CONSTRAINT teacher1_subjectteach_ck CHECK (SUBSTR(subjectteach, 1, 1) BETWEEN 'A' AND 'M')
)


CREATE TABLE student1 (studentid NUMBER(7)CONSTRAINT student1_studentid_pk PRIMARY KEY,
class_study numeric(7), studentname varchar(255) Default 'raj',
subject char(10) CONSTRAINT student1_subject_ck CHECK (SUBSTR(subject, 1, 1) BETWEEN 'A' AND 'M')

)


Alter table subject1 modify student CONSTRAINT subject_student_fk REFERENCES student(studentid)


Alter table teacher1 modify subject CONSTRAINT teacher1_student_fk REFERENCES subject1(subjectID)


Alter table student1 modify teacher CONSTRAINT student1_student_fk REFERENCES teacher1(teacherid)
"Q2"INSERT INTO subject1 (SUBJECTID,STUDENT,SUBJECTNAME,SUBJECTCODE) values (1,2,'D','23sd')INSERT INTO subject1 (SUBJECTID,STUDENT,SUBJECTNAME,SUBJECTCODE) values (2,3,'F','ugdiud6')INSERT INTO subject1 (SUBJECTID,STUDENT,SUBJECTNAME,SUBJECTCODE) values (3,4,'D','54sd')
INSERT INTO TEACHER1 (teacherid,subject,FIRSTNAME,SUBJECTTEACH) values (1,2,'F','DSB')INSERT INTO TEACHER1 (teacherid,subject,FIRSTNAME,SUBJECTTEACH) values (2,2,'G','HKSB')INSERT INTO TEACHER1 (teacherid,subject,FIRSTNAME,SUBJECTTEACH) values (3,4,'J','DS98B')
INSERT INTO TEACHER1 (STUDENTID,CLASS_STUDY,STUDENTNAME,SUBJECT) values (1,2,'ROHIT','DATA')INSERT INTO TEACHER1 (STUDENTID,CLASS_STUDY,STUDENTNAME,SUBJECT) values (2,3,'AA','ASP')INSERT INTO TEACHER1 (STUDENTID,CLASS_STUDY,STUDENTNAME,SUBJECT) values (3,3,'ROHIT','DATA')

"Q3"SELECT * FROM subject1FULL JOIN teacher1ON  teacher1.subject = subject1.subjectIDFULL JOIN student1ON student1.teacher = teacher1.teacherid
"q4"
Alter table  student1add  student1_phnumber number(10) 


"Q5"
Alter table  teacher1 rename  table teacher3;