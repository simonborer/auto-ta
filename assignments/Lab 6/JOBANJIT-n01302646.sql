JOBANJIT SINGH
n01302646
lab 6: 01/11/2018

Que 1:
CREATE OR REPLACE FUNCTION get_Invoice_Balance_Due
(
  invoice_number_param VARCHAR2
)
RETURN NUMBER
AS 
  balance_Due NUMBER;
BEGIN 
  SELECT (invoice_total - payment_total - credit_total) 
  INTO balance_Due
  FROM invoices
  WHERE invoice_number = invoice_number_param;

  RETURN balance_Due;
END;
/

--Call to function
Select  get_Invoice_Balance_Due('P-0608') from dual

Que 2
CREATE TABLE my_Books
(
Book_id number(10) PRIMARY KEY,
Book_Title varchar2(20),
Book_genre varchar2(20),
Book_rank number(10)
);

CREATE TABLE my_Movies
(Movie_id number(10) PRIMARY KEY,
Movie_Title varchar2(20),
Movie_genre varchar2(20),
movie_rank number(10)
);



 CREATE OR REPLACE PROCEDURE Insert_data_mybooks 
(
    item_id number ,
    item_Title varchar2,
    item_genre varchar2,
    item_rank number
)
AS

BEGIN
   Insert into my_books 
   Values(item_id,item_Title,item_genre,item_rank);
COMMIT;
END;
/


 CREATE OR REPLACE PROCEDURE Insert_data_mymovies  
(
    item_id number ,
    item_Title varchar2,
    item_genre varchar2,
    item_rank number
)
AS

BEGIN
   Insert into my_movies 
   Values(item_id,item_Title,item_genre,item_rank);
COMMIT;
END;
/

CALL Insert_data_mybooks(1,'Avengers','Drama',1);
CALL Insert_data_mybooks(2,'20 Days','Drama',2);
CALL Insert_data_mybooks(3,'Killing floor','Comedy',3);

CALL Insert_data_myMovies(1,'LA LA Land','Drama',3);
CALL Insert_data_myMovies(2,'MI 5','Fight',2);
CALL Insert_data_myMovies(3,'Protocol','Drama',1);



Que 3
CREATE OR REPLACE FUNCTION return_title
(
  item_rank number
)
RETURN VARCHAR2
AS 
  item_title VARCHAR2(20);
BEGIN 
  SELECT Book_title
  INTO item_title
  FROM my_books
  WHERE book_rank = item_rank;

  RETURN item_title;
END;
/
 
--Call to function
Select  return_title(1) from dual