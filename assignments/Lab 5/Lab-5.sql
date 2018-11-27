--Q1
CREATE TABLE my_class
(
class_id NUMBER(5) CONSTRAINT class_id_pk PRIMARY KEY,
name VARCHAR2(50),
description VARCHAR2(300),
subject_name VARCHAR(50)
)
 --Q2
INSERT INTO my_class(class_id,name,description,subject_name)
VALUES(1,'Project Managment','About Project','Sub-1');
INSERT INTO my_class(class_id,name,description,subject_name)
VALUES(2,'PHP','About PHP','Sub-2');
INSERT INTO my_class(class_id,name,description,subject_name)
VALUES(3,'ASP.NET','About ASP.NET','Sub-3');



CREATE TABLE my_group
(
group_id NUMBER(5) CONSTRAINT group_id_pk PRIMARY KEY,
name VARCHAR2(50),
description VARCHAR2(300),
member_of_group NUMBER(10)
)

--Q2
INSERT INTO my_group(group_id,name,description,member_of_group)
VALUES(11,'Group-1','For ASP.NET Project-1', 5);

INSERT INTO my_group(group_id,name,description,member_of_group)
VALUES(22,'Group-2','For ASP.NET Project-2', 6);

INSERT INTO my_group(group_id,name,description,member_of_group)
VALUES(33,'Group-3','For ASP.NET Project-3', 5);



CREATE TABLE class_meeting
(
class_part  NUMBER(5) CONSTRAINT class_meeting_class_fk REFERENCES my_class(class_id),
group_part NUMBER(5) CONSTRAINT class_meeting_group_fk REFERENCES my_group(group_id),
class_meeting_id NUMBER(5) CONSTRAINT class_meeting_id_pk PRIMARY KEY,
meeting_date DATE
)

INSERT INTO class_meeting(class_part,group_part,class_meeting_id,meeting_date)
VALUES(1,11,111,TO_DATE('01-JAN-18','DD-MON-RR'));
INSERT INTO class_meeting(class_part,group_part,class_meeting_id,meeting_date)
VALUES(2,22,222,TO_DATE('02-JAN-18','DD-MON-RR'));
INSERT INTO class_meeting(class_part,group_part,class_meeting_id,meeting_date)
VALUES(3,33,333,TO_DATE('03-JAN-18','DD-MON-RR'));


--Q-3   (i made a mistake to create table in my_group and my_class like there is nothing common between my_class and my_group table. So, here my JOIN is:)
SELECT class_id,subject_name,group_id,member_of_group
FROM class_meeting m
FULL JOIN my_class c
ON m.class_part = c.class_id
FULL JOIN my_group g
ON m.group_part = g.group_id


--4

ALTER TABLE class_meeting
ADD meeting_name varchar(30);

--Q5

ALTER TABLE my_class
RENAME TO class;

