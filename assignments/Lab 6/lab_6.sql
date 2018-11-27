--lab(week 8)--
--binita patel--

--1--

CREATE OR REPLACE PROCEDURE create_v
(
      create_vendor_id NUMBER,
      create_vendor_name VARCHAR2
)
AS

BEGIN
    UPDATE vendors 
    SET vendor_id=create_vendor_id
    WHERE vendor_name=create_vendor_name;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;


CALL create_v(4, 'Jobtrak');


--2--

--table:my_book--

CREATE TABLE my_books
(
book_id NUMBER(6) PRIMARY KEY,
title VARCHAR2(30) NOT NULL,
genre VARCHAR(15),
rank NUMBER(5) 
)


--procedures for my_book--
CREATE OR REPLACE PROCEDURE create_my_books
(
      create_book_id NUMBER,
      create_title VARCHAR2,
      create_genre VARCHAR,
      create_rank NUMBER    
)
AS

BEGIN
        INSERT INTO my_books
        VALUES(create_book_id,create_title,create_genre,create_rank);    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;

CALL create_my_books(1,'Wings Of Fire',biography,1);
CALL create_my_books(2,'Pooh','Animation',3);
CALL create_my_books(3,'Beloved','Fiction',2);


--table my_movies--
CREATE TABLE my_movies
(
movies_id NUMBER(6) PRIMARY KEY,
title VARCHAR2(30) NOT NULL,
genre VARCHAR(15),
rank NUMBER(5)
)


--procedures for my_movies--

CREATE OR REPLACE PROCEDURE create_my_movies
(
      create_movie_id NUMBER,
      create_title VARCHAR2,
      create_genre VARCHAR,
      create_rank NUMBER    
)
AS

BEGIN
        INSERT INTO my_movies
        VALUES(create_movie_id,create_title,create_genre,create_rank);    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;


CALL create_my_movies(1,'3-idiots','Comedy',1);
CALL create_my_movies(2,'Humpty Sharma','Drama',3);
CALL create_my_movies(3,'Love Story 2050','Romace',2);


--3--
CREATE OR REPLACE FUNCTION get_title_books
(
  get_rank NUMBER
  
)
RETURN VARCHAR
AS
  var_title VARCHAR2(15);
BEGIN 
  SELECT title
  INTO var_title
  FROM my_books
  WHERE rank=get_rank;

  RETURN var_title;
END;

SELECT get_title_books(2)
FROM dual

