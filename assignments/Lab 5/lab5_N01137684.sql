-- Lab 5
-- EKTA PATEL N01137684
-- Q1
-- Create 3 tables. Each should have a primary key, and a foreign key that references one of your other tables' primary key. Each should have 4 columns.
-- Use 4 different data types. Use at least 2 kinds of constraint besides primary and foreign keys. Use at least 1 default value.

CREATE TABLE books
(
    book_Id NUMBER(7)
        CONSTRAINT book_id_pk PRIMARY KEY,
    book_title VARCHAR2(20),
    author VARCHAR2(20)
        DEFAULT 'Robert Villium',
    price NUMBER(8,2)
)


CREATE TABLE library_member
(
    member_id Number(7)
        CONSTRAINT member_id_pk Primary Key,
    name VARCHAR2(20),
    address VARCHAR2(20),
    dob DATE
)



CREATE TABLE loan_info
(
    loan_info_id NUMBER(7)
        CONSTRAINT loan_info_id_pk Primary Key,
    member NUMBER(7) 
        CONSTRAINT member_fk REFERENCES library_member(member_id),
    book NUMBER(7) 
        CONSTRAINT book_fk REFERENCES books(book_id),
    borrow_date DATE,
    returned CHAR(5)
)

--Q2
--Insert at least 3 rows of data into each table.

INSERT INTO books (book_Id,book_title,author,price)
    VALUES(111,'The Secret','Mark robert',25.50);
INSERT INTO books (book_Id,book_title,author,price)
    VALUES(112,'Women rights','Richard',25.50);
INSERT INTO books (book_Id,book_title,author,price)
    VALUES(113,'2 States',DEFAULT,25.50); 

SELECT * FROM books;

-- DROP table books;



INSERT INTO library_member(member_id,name,address,dob)
    VALUES(121,'Ekta','Mississauga',TO_DATE('26-APR-14','DD-MON-RR'));
INSERT INTO library_member(member_id,name,address,dob)
    VALUES(122,'Neerav','Brampton',TO_DATE('15-APR-14','DD-MON-RR'));
INSERT INTO library_member(member_id,name,address,dob)
    VALUES(123,'Patel','Etobicoke',TO_DATE('06-MAY-14','DD-MON-RR'));

SELECT * FROM library_member;


INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned)
    VALUES(131,121,111,TO_DATE('14-JAN-20','DD-MON-RR'),'YES');
INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned)
    VALUES(132,121,112,TO_DATE('14-AUG-20','DD-MON-RR'),'NO');
INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned)
    VALUES(133,123,113,TO_DATE('23-SEP-21','DD-MON-RR'),'YES');    
    
SELECT * FROM loan_info;


--Q3
--Write a statement that does a FULL JOIN on all three tables.
SELECT book_title, borrow_date,returned,name,address
FROM loan_info l
FULL JOIN books b
ON l.book = b.book_id
FULL JOIN library_member lm
ON l.member = lm.member_id


--Q4
--Add a column to one of your tables.
ALTER TABLE loan_info
ADD due_date DATE;

INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned,due_date)
    VALUES(131,121,111,TO_DATE('14-JAN-20','DD-MON-RR'),'YES',TO_DATE('24-JAN-20','DD-MON-RR'));
INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned,due_date)
    VALUES(132,121,112,TO_DATE('14-AUG-20','DD-MON-RR'),'NO',TO_DATE('24-AUG-20','DD-MON-RR'));
INSERT INTO loan_info(loan_info_id,member,book,borrow_date,returned,due_date)
    VALUES(133,123,113,TO_DATE('23-SEP-21','DD-MON-RR'),'YES',TO_DATE('03-OCT-21','DD-MON-RR'));


UPDATE loan_info SET due_date = TO_DATE('24-JAN-20','DD-MON-RR') WHERE loan_info_id=131;
UPDATE loan_info SET due_date = TO_DATE('24-AUG-20','DD-MON-RR') WHERE loan_info_id=132;
UPDATE loan_info SET due_date = TO_DATE('03-OCT-21','DD-MON-RR') WHERE loan_info_id=133;

SELECT * FROM loan_info;
--TRUNCATE TABLE loan_info;

--Q5
--Rename one of your tables.
ALTER TABLE books
RENAME TO library_books;



