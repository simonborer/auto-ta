/* Assignment 5 - Question 2
   Name: Raymond Giang
   Student Number: n01304390 */

/* 2. Write an anonymous PL/SQL script that uses variables to get (1) the count of all of the invoices in the Invoices table 
that have a balance due and (2) the sum of the balances due for all of those invoices. If that total balance due is greater 
than or equal to $50,000, the script should display a message like this: Uses an IF/THEN/ELSE after you determine the number 
of invoices that have a balance due.

    Number of unpaid invoices is 40.
    Total balance due is $66,796.24.

    Otherwise, the script should display this message:
    Total balance due is less than $50,000. */

SET SERVEROUTPUT ON;

DECLARE
    num_with_balances NUMBER;
    total_balance NUMBER;

BEGIN
    SELECT COUNT(*), SUM(invoice_total - payment_total - credit_total)
    INTO num_with_balances, total_balance
    FROM invoices
    WHERE (invoice_total - payment_total - credit_total) > 0;
    
    IF total_balance  >= 50000 THEN
	    DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || num_with_balances || '.');
        DBMS_OUTPUT.PUT_LINE('Total balance due is $' || total_balance || '.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000.');
    END IF;
END;

