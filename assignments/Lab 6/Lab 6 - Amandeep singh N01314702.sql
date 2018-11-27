/*Lab 6 - Amandeep singh N01314702 */
/* Q 1. Stored procedure  */

CREATE or replace PROCEDURE update_invoices_payment_total /* Give it a name */
(
    /*  our parameters - the options we'll pass in when 
        we call the procedure */
    invoice_id_param     invoices.invoice_id%TYPE,
    payment_total_param      NUMBER
)
AS
/* Define the procedure as PL/SQL code */
BEGIN
    UPDATE invoices
    SET payment_total = payment_total_param
    WHERE invoice_id = invoice_id_param;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

/*
drop procedure update_invoices_payment_total;
select * from invoices where invoice_id=1;
*/

CALL update_invoices_payment_total(1, 400);

BEGIN
  update_invoices_payment_total(1, 400);
END;



/* Q 1. function  */

CREATE or replace FUNCTION get_vendor_name
(
  /* reference the data type of the appropriate column */
  vendor_id_param vendors.vendor_id%TYPE 
)
RETURN VARCHAR2
AS
  vendor_name_var vendors.vendor_name%TYPE;
BEGIN 
  SELECT vendor_name
  INTO vendor_name_var
  FROM vendors 
  where vendor_id = vendor_id_param;

  RETURN vendor_name_var;
END;


/* drop function get_vendor_name;  */


SELECT *
FROM vendors
WHERE vendor_name = get_vendor_name(1);



/* Q.2  */

/*drop procedure book_insert;
drop table my_Books;
*/

create table my_Books
(
Book_id number(10) primary key,
Book_title varchar2(20),
Book_genre varchar2(20),
Book_rank number(10)
);


create or replace procedure book_insert
(
book_id number,
book_title varchar2,
book_genre varchar2,
book_rank number
)
as
begin

insert into my_Books(Book_id,Book_title,Book_genre,Book_rank)
values (book_id,book_title,book_genre,book_rank);
commit;
exception
when others then
    DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
end;

/* SELECT * FROM my_Books;*/

BEGIN
  book_insert(1,'The 3 Mistakes','Fiction',1);
  book_insert(2,'Half Girlfriend','Romance novel',2);
  book_insert(3,'Night at CallCentre','Fiction',3);
END;




/*drop procedure movies_insert;
drop table my_movies;
*/

create table my_movies
(
Movie_id number(10) primary key,
Movie_title varchar2(20),
Movie_genre varchar2(20),
Movie_rank number(10)
);



create or replace procedure movies_insert
(
movie_id number,
movie_title varchar2,
movie_genre varchar2,
movie_rank number
)
as
begin

insert into my_movies(Movie_id,Movie_title,Movie_genre,Movie_rank)
values (movie_id,movie_title,movie_genre,movie_rank);
commit;
exception
when others then
    DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
end;

/* SELECT * FROM my_movies;*/

BEGIN
  movies_insert(1,'3 Idiots','Comedy',1);
  movies_insert(2,'Baahubali','Action',2);
  movies_insert(3,'Ki and Ka','Romance ',3);
END;



/*Q.3 */

/* drop function get_book_title;  */


CREATE or replace FUNCTION get_book_title
(
  /* reference the data type of the appropriate column */
  book_rank_param my_Books.Book_rank%TYPE 
)
RETURN VARCHAR2
AS
  book_title_var my_books.book_title%TYPE;
BEGIN 
  SELECT book_title
  INTO book_title_var
  FROM my_Books 
  where Book_rank = book_rank_param;
    
  RETURN book_title_var;
  
  EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('A value error occurred');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');

END;



SELECT *
FROM my_Books
WHERE book_title = get_book_title(2);



/* drop function get_movies_title;  */

CREATE or replace FUNCTION get_movies_title
(
  /* reference the data type of the appropriate column */
  movies_rank_param my_movies.Movie_rank%TYPE 
)
RETURN VARCHAR2
AS
  movies_title_var my_movies.movie_title%TYPE;
BEGIN 
  SELECT movie_title
  INTO movies_title_var
  FROM my_movies 
  where Movie_rank = movies_rank_param;
    
  RETURN movies_title_var;
  
  EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('A value error occurred');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');

END;


SELECT *
FROM my_movies
WHERE movie_title = get_movies_title(1);