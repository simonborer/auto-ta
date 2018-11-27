/*1*/
CREATE OR REPLACE PROCEDURE update_invoices_payment_total
(
    invoice_number_param         IN      VARCHAR2,
    payment_total_param          IN      NUMBER,
    update_count                OUT      INTEGER
)
AS
BEGIN
    UPDATE invoices
    SET payment_total = payment_total+payment_total_param
    WHERE invoice_number = invoice_number_param;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        SELECT 0 INTO update_count FROM dual;
        ROLLBACK;
END;



/*2*/
CREATE TABLE MY_MOVIES(
TITLE VARCHAR2(50),
GENRE VARCHAR2(20),
RANK INTEGER,
PRIMARY KEY(TITLE)
);

CREATE TABLE MY_BOOKS(
TITLE VARCHAR2(50),
GENRE VARCHAR2(20),
RANK INTEGER,
PRIMARY KEY(TITLE)
);

CREATE OR REPLACE PROCEDURE INSERT_INTO_MY_BOOKS
(
    title_param         IN      VARCHAR2,
    genre_param         IN      VARCHAR2,
    rank                IN      INTEGER,
    title_out           OUT     VARCHAR2
)
AS
BEGIN
    INSERT INTO MY_BOOKS (TITLE,GENRE,RANK)
    VALUES(title_param,genre_param,rank);
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
    SELECT 0 INTO title_out FROM dual;
        ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE INSERT_INTO_MY_MOVIES
(
    title_param         IN      VARCHAR2,
    genre_param         IN      VARCHAR2,
    rank                IN      INTEGER,
    title_out           OUT     VARCHAR2
)
AS
BEGIN
    INSERT INTO MY_BOOKS (TITLE,GENRE,RANK)
    VALUES(title_param,genre_param,rank);
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
    SELECT 0 INTO title_out FROM dual;
        ROLLBACK;
END;


/*3*/
CREATE OR REPLACE FUNCTION get_book_title
(
  entered_rank MY_BOOKS.RANK%TYPE 
)
RETURN VARCHAR2
AS
  book_title VARCHAR2;
BEGIN 
  SELECT TITLE
  INTO book_title
  FROM MY_BOOKS
  WHERE rank = entered_rank;

  RETURN book_title;
END;