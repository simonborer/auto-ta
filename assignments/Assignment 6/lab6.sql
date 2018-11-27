--1--

CREATE OR REPLACE PROCEDURE update_vendors_VENDOR_STATE
(
    vendor_id_param     VARCHAR2,
    vendor_state_param      VARCHAR2
)
AS
BEGIN
    UPDATE vendors
    SET VENDOR_STATE = vendor_state_param
    WHERE VENDOR_ID = vendor_id_param;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

--2---

create table my_books
(
book_id number primary key,
title varchar2(255),
genre varchar2(255),
rank number
)

create table my_movies
(
movie_id number primary key,
title varchar2(255),
genre varchar2(255),
rank number
)

CREATE OR REPLACE PROCEDURE insert_my_tables
(
    id_param number,
title_param varchar2,
genre_param varchar2,
rank_param number
)
AS
BEGIN
    INSERT INTO my_movies
    VALUES(id_param,title_param,genre_param,rank_param); 

    INSERT INTO my_books
    VALUES(id_param,title_param,genre_param,rank_param); 
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;


SET SERVEROUTPUT ON;

BEGIN
insert_my_tables(1,'the one thing','suspense','23');
insert_my_tables(2,'the lawer','jokes','10');
insert_my_tables(3,'Half Girlfriend','romantic','12');

END;

--3----

CREATE OR REPLACE FUNCTION select_my_books_titles
(
id_param number
)
RETURN number
AS
  my_books_rank number;
BEGIN
    SELECT rank into my_books_rank FROM my_BOOKS
    WHERE book_id=id_param; 
    
    Return my_books_rank;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

 select title from my_BOOKS
 where rank= select_my_books_titles(1)

