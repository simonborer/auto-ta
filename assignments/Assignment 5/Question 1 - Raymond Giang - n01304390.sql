/* Assignment 5 - Question 1
   Name: Raymond Giang
   Student Number: n01304390 */

/* 1. Write an anonymous PL/SQL script that declares and sets a variable that’s equal to the count of 
all rows in the Invoices table that have a balance due that’s greater than or equal to $5,000. Then, the 
script should display a message that looks like this:
    3 invoices exceed $5,000. */

SET SERVEROUTPUT ON;

DECLARE
    num_high_balance_invoices NUMBER;
    
BEGIN
    SELECT COUNT(*)
    INTO num_high_balance_invoices
    FROM invoices
    WHERE (invoice_total - payment_total - credit_total) >= 5000;
    
    DBMS_OUTPUT.PUT_LINE(num_high_balance_invoices ||
    ' invoices exceed $5,000.');
END;

