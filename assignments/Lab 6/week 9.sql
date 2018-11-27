--Q1--
CREATE OR REPLACE PROCEDURE update_vendor_name /* Give it a name */
(
    /*  our parameters - the options we'll pass in when 
        we call the procedure */
    vendor_name_par     VARCHAR2,
    vendor_id_par      NUMBER
)
AS
/* Define the procedure as PL/SQL code */
BEGIN
    UPDATE vendors
    SET vendor_name = vendor_name_par
    WHERE vendor_id = vendor_id_par;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CALL update_vendor_name('Nickholas Cage' , 1);

--Q2--
CREATE TABLE my_books
(
    book_id         NUMBER(5)         PRIMARY KEY,
    title           VARCHAR2(40)      NOT NULL,
    genre           VARCHAR2(20),      
    rank            NUMBER(20)
)
DROP TABLE my_books;


CREATE TABLE my_movies
(
    movie_id         NUMBER(5)         PRIMARY KEY,
    title           VARCHAR2(40)      NOT NULL,
    genre           VARCHAR2(20),      
    rank            INT
)
DROP TABLE my_movies;


--books--
CREATE OR REPLACE PROCEDURE update_my_books
(
    book_id_par      NUMBER,
    title_par        VARCHAR2,
    genre_par        VARCHAR2,
    rank_par         NUMBER
)
AS
BEGIN
    INSERT INTO my_books
    VALUES(book_id_par, title_par, genre_par, rank_par);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
CALL update_my_books(1, 'Lord of the Rings', 'Fantasy', 1);
CALL update_my_books(2, 'The Witcher', 'Fantasy', 2);
CALL update_my_books(3, 'Sherlock Holmes', 'Detective', 3);

select * from my_books;
--movies--
CREATE OR REPLACE PROCEDURE update_my_movies
(
    movie_id_par      NUMBER,
    title_par        VARCHAR2,
    genre_par        VARCHAR2,
    rank_par         INT
)
AS
BEGIN
    INSERT INTO my_movies
    VALUES(movie_id_par, title_par, genre_par, rank_par);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/


CALL update_my_movies(1, 'Lord of the Rings', 'Fantasy', 1);
CALL update_my_movies(2, 'Snatch', 'Comedy | Crime', 2);
CALL update_my_movies(3, 'Sherlock Holmes', 'Detective', 3);

select * from my_movies;

--Q3--
CREATE OR REPLACE FUNCTION get_movie_name
(
  rank_par my_movies.rank%TYPE 
)
RETURN VARCHAR2
AS
  movie_name_par VARCHAR2(40);
BEGIN 
  SELECT rank
  INTO movie_name_par
  FROM my_movies
  WHERE rank = rank_par;

  RETURN movie_name_par;
END;
/


SELECT  title
FROM my_movies
WHERE RANK = get_movie_name(2)