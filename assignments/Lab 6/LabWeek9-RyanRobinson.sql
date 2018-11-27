/* Lab Week 9 - Ryan Robinson - Q1. */
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION total_balance_function
(
invoice_total_param invoices.invoice_total%TYPE,
payment_total_param invoices.payment_total%TYPE,
credit_total_param invoices.credit_total%TYPE
)
RETURN NUMBER
AS 
total_balance_due NUMBER;
BEGIN
    SELECT invoice_total - payment_total - credit_total
    INTO total_balance_due
    FROM invoices;
    RETURN total_balance_due;
END;

/* Lab Week 9 - Ryan Robinson - Q2. */
CREATE TABLE my_books
(
  title                    VARCHAR2(50)   PRIMARY KEY,
  genre                VARCHAR2(50)   NOT NULL,
  book_rank         NUMERIC        UNIQUE
)
CREATE TABLE my_movies
(
  movie_title          VARCHAR2(50)   PRIMARY KEY,
  movie_genre      VARCHAR2(50)   NOT NULL,
  movie_rank         NUMERIC        UNIQUE
)

CREATE OR REPLACE PROCEDURE insert_book






