
------ Question 1 -------
CREATE OR REPLACE PROCEDURE update_vendors_vendor_zip_code
(
    vendor_number_param NUMBER,
    updated_zip_code VARCHAR2
)
AS
BEGIN 
    UPDATE vendors 
    SET vendor_zip_code = updated_zip_code
    WHERE vendor_id = vendor_number_param;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;        

CALL update_vendors_vendor_zip_code(1,55555);

------ Question 2 -------

CREATE TABLE my_books (
    book_id NUMBER  PRIMARY KEY,
    title   VARCHAR2(20),
    genre   VARCHAR2(10),
    ranked   NUMBER 
)

CREATE TABLE my_movies (
    movie_id NUMBER  PRIMARY KEY,
    title   VARCHAR2(20),
    genre   VARCHAR2(10),
    ranked  NUMBER 
)
drop table my_movies;



CREATE OR REPLACE PROCEDURE updated_my_book_values
(
    unique_key my_books.book_id%TYPE,
    title_show my_books.title%TYPE,
    genre_show my_books.genre%TYPE,
    ranked_show my_books.ranked%TYPE
)
AS
BEGIN 
    INSERT INTO my_books(
        book_id,
        title,
        genre,
        ranked
    )
    VALUES
    (
        unique_key,
        title_show,
        genre_show,
        ranked_show
    );

END;

CALL updated_my_book_values(1,'GOT','Fantasy',1);
CALL updated_my_book_values(2,'LORDS','Fantasy',2);
CALL updated_my_book_values(3,'300','ACTION',3);

--
CREATE OR REPLACE PROCEDURE updated_my_movies_values
(
    unique_key my_movies.movie_id%TYPE,
    title_show my_movies.title%TYPE,
    genre_show my_movies.genre%TYPE,
    ranked_show my_movies.ranked%TYPE
)
AS
BEGIN 
    INSERT INTO my_movies(
        movie_id,
        title,
        genre,
        ranked
    )
    VALUES
    (
        unique_key,
        title_show,
        genre_show,
        ranked_show
    );

END;

CALL updated_my_movies_values(1,'4 letters','Drama',2);
CALL updated_my_movies_values(2,'Thor','Sci-Fi',1);
CALL updated_my_movies_values(3,'Love Note','Romance',3);


------ QUESTION 3 ------
CREATE OR REPLACE FUNCTION title_based_on_rank
(
    title_ranking my_books.title%TYPE,
    ranked_is my_books.ranked%TYPE
)
RETURN VARCHAR2
AS
    ranking_title VARCHAR2;
BEGIN
    SELECT title
    INTO ranking_title
    FROM my_books
    WHERE ranked = title_ranking;
    
    RETURN ranking_title;
END;   

SELECT title
FROM my_books
WHERE ranked = title_based_on_rank('1st');
