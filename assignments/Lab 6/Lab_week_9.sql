--Question 1
--Create a stored procedure or function for anything from the previous weeks,
--the syntax of which you find difficult to remember.
CREATE OR REPLACE PROCEDURE update_vendors_city
(
    vendor_city_param       VARCHAR2,
    vendor_state_param      VARCHAR2,
    vendor_id_param         NUMBER
)
AS
BEGIN
    UPDATE vendors
    SET vendor_city = vendor_city_param, vendor_state = vendor_state_param
    WHERE vendor_id = vendor_id_param;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CALL update_vendors_city('Kharkiv', 'KH', 1);

SELECT vendor_id, vendor_city, vendor_state
FROM vendors
WHERE vendor_id = 1;

--Question 2
/*Create 2 tables, one called my_books, one called my_movies. In each, create a primary key, a column called 'title',
a column called 'genre', and a column called 'rank'. Then create a stored procedure that can insert a row into either of
those tables, with the values passed as parameters. Insert at least 3 each of your favourite books and movies into the 
tables using your procedure.*/
-----------------------------------------------------------------
CREATE TABLE my_books
(
    book_id         INT               PRIMARY KEY,
    title           VARCHAR2(50)      UNIQUE,
    rank            NUMBER(4)         NOT NULL,
    genre           VARCHAR2(20)      NOT NULL
)
INSERT INTO my_books
VALUES(1, 'The Rock', 1, 'Commedy');

SELECT * FROM my_books
-----------------------------------------------------------------
CREATE TABLE my_movies
(
    movie_id        INT               PRIMARY KEY,
    title           VARCHAR2(50)      UNIQUE,
    rank            NUMBER(4)         NOT NULL,
    genre           VARCHAR2(20)      NOT NULL
) 
INSERT INTO my_movies
VALUES(1, 'Super Mile', 5, 'Ski-fi');

SELECT * FROM my_movies
-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE update_my_books
(
    book_id_param          NUMBER,
    title_param             VARCHAR2,
    rank_param              NUMBER,
    genre_param             VARCHAR2
)
AS
BEGIN
    INSERT INTO my_books
    VALUES(book_id_param, title_param, rank_param, genre_param);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
CALL update_my_books(2, 'Red and White', 2, 'Romance');
CALL update_my_books(3, 'Elisons life in NY', 3, 'Drama');
CALL update_my_books(4, 'Rich dad', 4, 'Busines');

SELECT * FROM my_books;
-----------------------------------------------------------------
--DROP TABLE my_movies;
CREATE OR REPLACE PROCEDURE update_my_movies
(
    movie_id_param          NUMBER,
    title_param             VARCHAR2,
    rank_param              NUMBER,
    genre_param             VARCHAR2
)
AS
BEGIN
    INSERT INTO my_movies
    VALUES(movie_id_param, title_param, rank_param, genre_param);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
CALL update_my_movies(2, 'Rocky', 2, 'Sport');
CALL update_my_movies(3, 'Rocky 2', 3, 'Sport');
CALL update_my_movies(4, 'Rocky 3', 4, 'Sport');

SELECT * FROM my_movies;


--Question 3
--Create a stored function that can return the title based on your ranking.
CREATE OR REPLACE FUNCTION get_my_movies
(
  rank_param my_movies.rank%TYPE 
)
RETURN NUMBER
AS
  name_movie NUMBER;
BEGIN 
  SELECT rank
  INTO name_movie
  FROM my_movies
  WHERE rank = rank_param;

  RETURN name_movie;
END;
/

SELECT title
FROM my_movies
WHERE rank = get_my_movies(1);






