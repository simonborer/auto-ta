--lab 6
--que 1

CREATE OR REPLACE PROCEDURE   vendor_id_vendor_city
(
     
    
    update_vendor_city     VARCHAR2,
    update_vendor_id      NUMBER
)
AS

BEGIN
    UPDATE vendors
    SET vendor_city=update_vendor_city
    WHERE vendor_id=update_vendor_id;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

CALL vendor_id_vendor_city('Chicago', 55);


--que 2

CREATE TABLE my_books
   (
    book_id  NUMBER(10) PRIMARY KEY,
    title    VARCHAR2(15) ,
    genre    VARCHAR2(15),
    Rank     NUMBER(4)
   )

CREATE TABLE my_movies
   (
    movie_id  NUMBER(10) PRIMARY KEY,
    title    VARCHAR2(15) ,
    genre    VARCHAR2(15),
    Rank     NUMBER(4)
   ) 
   
   CREATE OR REPLACE PROCEDURE  insert_my_book
( 
     seq_id         NUMBER,
    update_title    VARCHAR,
    update_genre    VARCHAR,
    update_Rank     NUMBER
)
AS

BEGIN
    INSERT INTO my_books
    VALUES (seq_id,update_title,update_genre,update_Rank);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

CALL insert_my_book(1,'shewalk','novel',2);

CALL insert_my_book(2,'halfgirlfreind','lovestory',1);

CALL insert_my_book(3,'geeta','spiritual',3);




CREATE OR REPLACE PROCEDURE  insert_movie
( 
     seq_id         NUMBER,
    update_title    VARCHAR,
    update_genre    VARCHAR,
    update_Rank     NUMBER
)
AS

BEGIN
    INSERT INTO my_movies
    VALUES (seq_id,update_title,update_genre,update_Rank);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

CALL insert_movie(1,'raazi','lovestory',1);

CALL insert_movie(2,'newton','action',3);

CALL insert_movie(3,'zero','comedy',2);


--que 3
--1(books)

CREATE OR REPLACE FUNCTION get_book_movie
(
  
  mk_rank NUMBER
)
RETURN VARCHAR
AS
  title_mb VARCHAR2(15);
BEGIN 
  SELECT title
  INTO title_mb
  FROM my_books
  WHERE rank=mk_rank;

  RETURN title_mb;
END;


SELECT get_book_movie(2)
FROM dual

--que 3
--movies

CREATE OR REPLACE FUNCTION get_movie
(
  
  mk_rank NUMBER
)
RETURN VARCHAR
AS
  title_mb VARCHAR2(15);
BEGIN 
  SELECT title
  INTO title_mb
  FROM my_movies
  WHERE rank=mk_rank;

  RETURN title_mb;
END;


SELECT get_movie(1)
FROM dual