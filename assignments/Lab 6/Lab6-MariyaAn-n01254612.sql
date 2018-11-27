1)
--Lab 9, Question 1

CREATE OR REPLACE FUNCTION get_balance (
invoice_id_param NUMBER
)
RETURN NUMBER
AS
balance_due_var NUMBER;
BEGIN
SELECT invoice_total-payment_total-credit_total 
AS balance_due
INTO balance_due_var
FROM invoices
WHERE invoice_id=invoice_id_param;

RETURN balance_due_var;
END;
/


2)
--Lab 9, Question 2a
CREATE TABLE my_books
(
book_id  NUMBER(6) CONSTRAINT my_books_book_id_pk PRIMARY KEY,
book_title   VARCHAR2(100) CONSTRAINT my_books_book_title_nn NOT NULL,
book_genre VARCHAR2(100) CONSTRAINT my_books_book_genre_nn NOT NULL,
book_rank  NUMBER(3)
)

CREATE TABLE my_movies
(
movie_id  NUMBER(6) CONSTRAINT my_movies_movie_id_pk PRIMARY KEY,
movie_title   VARCHAR2(100) CONSTRAINT my_movies_movie_title_nn NOT NULL,
movie_genre VARCHAR2(100) CONSTRAINT my_movies_movie_genre_nn NOT NULL,
movie_rank  NUMBER(3)
)

--Lab 9, Question 2b
CREATE SEQUENCE books_sequence
CREATE SEQUENCE movies_sequence

CREATE OR REPLACE PROCEDURE insert_books_values
(
book_id_param IN my_books.book_id%TYPE, 
book_title_param IN my_books.book_title%TYPE,
book_genre_param IN my_books.book_genre%TYPE, 
book_rank_param IN my_books.book_rank%TYPE DEFAULT books_sequence.NEXTVAL
)
AS
BEGIN
INSERT INTO my_books
VALUES (book_id_param, book_title_param, book_genre_param, book_rank_param);
COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE insert_moviess_values
(
movie_id_param IN my_movies.movie_id%TYPE, 
movie_title_param IN my_movies.movie_title%TYPE,
movie_genre_param IN my_movies.movie_genre%TYPE, 
movie_rank_param IN my_movies.movie_rank%TYPE DEFAULT movies_sequence.NEXTVAL
)
AS 
BEGIN
INSERT INTO my_movies
VALUES (movie_id_param, movie_title_param, movie_genre_param, movie_rank_param);
COMMIT;
END;
/

--Lab 2, question 2c
CALL insert_books_values ('To Kill A Mockingbird', 'Fiction', 3);
CALL insert_books_values ('The Sun Also Rises', 'Fiction', 2);
CALL insert_books_values ('Under the Skin ', 'Science Fiction', 1);
CALL insert_movies_values ('Black Mirror', 'Sci-fi', 1);
CALL insert_movies_values ('The Departed', 'Crime', 2);
CALL insert_movies_values ('The Great Gatsby', 'Drama', 3);

3)
Lab 2, Question 3
CREATE OR  REPLACE FUNCTION get_rank_books (
book_rank_param NUMBER
)
RETURN VARCHAR2(100)
AS
book_title_var VARCHAR2(100)
BEGIN
SELECT 
book_title
INTO book_title_var
FROM my_books
WHERE book_rank=book_rank_param;

RETURN book_title_var;
END;
/
CREATE OR  REPLACE FUNCTION get_rank_movies (
movie_rank_param NUMBER
)
RETURN VARCHAR2(100)
AS
movie_title_var VARCHAR2(100)
BEGIN
SELECT 
movie_title
INTO movie_title_var
FROM my_movies
WHERE movie_rank=movie_rank_param;

RETURN movie_title_var;
END;
/