1
CREATE OR REPLACE FUNCTION credit_total
(
  /* reference the data type of the appropriate column */
  invoiceNum varchar
)
RETURN NUMBER
AS
  credit_total NUMBER;
BEGIN 
  SELECT credit_total
  INTO credit_total
  FROM invoices
  WHERE invoice_number = invoiceNum;

  RETURN credit_total;
END;
/

select credit_total('P-0259') from dual;

2
CREATE TABLE myBooks
(
book_id number Primary key,
title varchar2(10),
book_author varchar2(10)
);
3
CREATE OR REPLACE FUNCTION return_author_name
(
a_name  varchar
)
return varchar
AS
title varchar(20);
begin 
select book_title 
into title from my_Books
where book_author = a_name;

return title;
commit;
END;
/
select return_author_name('E.S') from dual;

CREATE TABLE mymovies
(
movie_id number(10)Primary key,
movie_title varchar2(10),
moive_writer varchar2(10)
);
CREATE OR REPLACE PROCEDURE Insert_data_myBooks
(
item_id NUMBER,
item_title varchar2,
item_author varchar2
)
AS
begin 
insert into my_Books
values(item_id,item_title,item_author);
commit;
END;
/
CALL insert_data_myBooks(1,'quantumphysics','rutherford');
CALL insert_data_myBooks(2,'nuclearphysics','stalie');
CALL insert_data_myBooks(3,'numericalmethod','E.S');
 
CREATE TABLE my_movies
(
movie_id number(10)Primary key,
movie_title varchar2(20),
moive_writer varchar2(20)
);

CREATE OR REPLACE PROCEDURE Insert_data_mymovies
(
item_id NUMBER,
item_title varchar2,
item_author varchar2
)
AS
begin 
insert into my_movies
values(item_id,item_title,item_author);
commit;
END;
/
CALL insert_data_mymovies(1,'titanic','Esacle');
CALL insert_data_mymovies(2,'gorzilla','Esa');
 CALL insert_data_mymovies(3,'3idioits','verma'); 









