Lab 5

1.
CREATE TABLE students
(
  student_id  NUMBER(6)     PRIMARY KEY,
  last_name   VARCHAR2(15)  NOT NULL,
  first_name  VARCHAR2(15),
  gpa         NUMBER(3, 2)
)

CREATE TABLE work_placements
(
  placement_id  NUMBER(6)     PRIMARY KEY,
  student       NUMBER(6)     REFERENCES students(student_id),
  country       VARCHAR2(20)  DEFAULT 'Canada',
  company_name  VARCHAR2(15)  UNIQUE,
)

CREATE TABLE workplace
(
company_id         NUMBER(3) PRIMARY KEY,
placement_number   NUMBER(3) REFERENCES work_placements(placement_id),
start_date         DATE DEFAULT '01-APR-18' NOT NULL,
accessible	   BOOLEAN

2.
INSERT INTO work_placements
VALUES(121, 'Voorhees', 'Jason', 3.43);
INSERT INTO new_students
VALUES(122, 'Myers', 'Michael', 1.9);
INSERT INTO new_students
VALUES(123, 'Kreuger', 'Freddy', 3.8);
INSERT INTO new_students
VALUES(124, 'Chuck', 'Chucky', 3.4);

INSERT INTO work_placements1
VALUES(001, 121,'Canada', 'Jump branding and design');
INSERT INTO work_placements
VALUES(002, 122, 'Canada', 'Canopy Web Development');
INSERT INTO work_placements
VALUES(003, 123, 'Canada', 'Wealth Simple');
INSERT INTO work_placements
VALUES(004, 124, 'Canada', 'Wave Digital)

INSERT INTO workplace
VALUES(100, 001,'01-APR-18', TRUE);
INSERT INTO work_placements
VALUES(140, 002, '04-APR-18', TRUE);
INSERT INTO work_placements
VALUES(170, 003, '01-APR-18', TRUE);
INSERT INTO work_placements
VALUES(130, 004, '07-APR-18', FALSE)

3.
SELECT student_id, country, accessible
FROM students s 
FULL JOIN work_placements wp
ON s.student_id = wp.student
JOIN workplace w
ON wp.placement_id = w.placement_number

4.
ALTER workplace
ADD distance number

5.
ALTER workplace RENAME TO company







