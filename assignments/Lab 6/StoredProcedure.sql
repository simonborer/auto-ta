--Q1--
CREATE OR REPLACE PROCEDURE update_invoices
(
INVOICES_ID_ONE NUMBER,
INVOICES_NUMBER_ONE VARCHAR2
)
AS
BEGIN

UPDATE invoices 
SET invoice_id = INVOICES_ID_ONE
WHERE invoice_number = INVOICES_NUMBER_ONE;

commit;
EXCEPTION
         WHEN OTHERS THEN
                  ROLLBACK;
END;
/
-- CALLING A PROCEDURE --
CALL update_invoices(1, 'QP58872');

--Q2--
create table  my_books(
book_id number(10) primary key,
title varchar2(50),
genre varchar2(50),
book_rank number
);

create table  my_movies(
movie_number number(10) primary key,
movie_title varchar2(50),
movie_genre varchar2(50),
movie_rank number
);

CREATE OR REPLACE PROCEDURE data_insertion
(
book_id   number,
title    varchar2,
genre    varchar2,
book_rank  number 
)
AS 
BEGIN 
     

     INSERT INTO my_books(book_id,title,genre,book_rank) 
     VALUES (book_id,title,genre,book_rank);
commit;
EXCEPTION
         WHEN OTHERS THEN
                  ROLLBACK;
END;
--calling stored procedure--
CALL data_insertion(1,'3-idiots','comedy',4);
CALL data_insertion(2,'conjuring','horror',5);
CALL data_insertion(3,'dyana','horror',3);
--select * from my_books--


--Q3--

CREATE OR REPLACE FUNCTION book_data
(

 title varchar2
)
RETURN varchar2
AS
  item_title NUMBER;
BEGIN 
  SELECT book_rank
  into item_title
  FROM my_books;


  RETURN item_title;
END;
/
----calling a function----
SELECT title
FROM my_books
WHERE title = book_data(4);



