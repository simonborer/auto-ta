-- Question 1
CREATE OR REPLACE FUNCTION getBalanceDue
(
  /* get the invoice id as reference */
  invoice_id_param NUMBER 
)
RETURN NUMBER
AS
  balance_due_var NUMBER(9,2);
BEGIN 
  SELECT invoice_total - (payment_total + credit_total)
  INTO balance_due_var
  FROM invoices
  WHERE invoice_id = invoice_id_param;

  RETURN balance_due_var;
END;
/

SELECT invoice_id, getBalanceDue(invoice_id) AS Balance
FROM invoices;

-- Question 2
CREATE TABLE my_books(
    book_id NUMBER PRIMARY KEY,
    book_title VARCHAR2(50),
    book_genre VARCHAR2(30),
    book_rank NUMBER
);

CREATE TABLE my_movies(
    movie_id NUMBER PRIMARY KEY,
    movie_title VARCHAR2(50),
    movie_genre VARCHAR2(30),
    movie_rank NUMBER
);

CREATE OR REPLACE PROCEDURE insertTableBooks
(
    tableNameID      NUMBER,
    tableNameTitle VARCHAR2,
    tableNameGenre VARCHAR2,
    tableNameRank NUMBER
)
AS
BEGIN
    INSERT INTO my_books
    VALUES (tableNameID, tableNameTitle, tableNameGenre, tableNameRank);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE insertTableMovies
(
    tableNameID      NUMBER,
    tableNameTitle VARCHAR2,
    tableNameGenre VARCHAR2,
    tableNameRank NUMBER
)
AS
BEGIN
    INSERT INTO my_movies
    VALUES (tableNameID, tableNameTitle, tableNameGenre, tableNameRank);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CREATE SEQUENCE myBookSEQ;
CREATE SEQUENCE myMovieSEQ;

ALTER TABLE my_books
ADD UNIQUE (book_rank);

ALTER TABLE my_movies
ADD UNIQUE (movie_rank);

BEGIN
insertTableBooks(myBookSEQ.NEXTVAL, 'Tell Tale Heart', 'Horror', 1);
insertTableBooks(myBookSEQ.NEXTVAL, 'The Pit and the Pendulum', 'Horror', 2);
insertTableBooks(myBookSEQ.NEXTVAL, 'Murders in the Rue Morgue', 'Horror', 3);

insertTableMovies(myMovieSEQ.NEXTVAL, 'Shawshank Redemption', 'Drama', 1);
insertTableMovies(myMovieSEQ.NEXTVAL, 'The Hateful Eight', 'Adventure', 2);
insertTableMovies(myMovieSEQ.NEXTVAL, 'Pineapple Express', 'Comedy', 3);
END;


-- Question 3
CREATE OR REPLACE FUNCTION getBook
(
  rank_id_param NUMBER 
)
RETURN VARCHAR2
AS
  table_title_var VARCHAR2(20);
BEGIN 
  SELECT book_title
  INTO table_title_var
  FROM my_books
  WHERE book_rank = rank_id_param;

  RETURN table_title_var;
END;
/

SELECT *
FROM my_books
WHERE book_title = getBook(1);

CREATE OR REPLACE FUNCTION getMovies
(
  rank_id_param NUMBER 
)
RETURN VARCHAR2
AS
  table_title_var VARCHAR2(20);
BEGIN 
  SELECT movie_title
  INTO table_title_var
  FROM my_movies
  WHERE movie_rank = rank_id_param;

  RETURN table_title_var;
END;
/

SELECT *
FROM my_movies
WHERE movie_title = getMovies(1);