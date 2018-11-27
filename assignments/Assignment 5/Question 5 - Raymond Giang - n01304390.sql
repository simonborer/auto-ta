/* Assignment 5 - Question 5
   Name: Raymond Giang
   Student Number: n01304390 */

/* 4. Enhance your solution to exercise 3 so it uses a substitution variable to set a bind variable that you use to determine 
what the minimum balance due should be for the invoices that the SELECT statement is going to retrieve. You should also use 
this bind variable to display a heading like this before the list of invoices: You are using the bind variable to set the 
balance due minimum. In this case 2000 is not a hard coded value but is set using a bind variable.

Invoice amounts greater than or equal to $2,000
==================================================

where 2,000 is the value of the bind variable. */

SET SERVEROUTPUT ON;

VARIABLE bound_balance_total NUMBER;

DECLARE
    CURSOR vendor_invoice_cursor IS 
        SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) AS balance_due
        FROM vendors v
        JOIN invoices i
            ON v.vendor_id = i.vendor_id
        WHERE (invoice_total - payment_total - credit_total) >= :bound_balance_total
        ORDER BY balance_due DESC;
   
BEGIN
    :bound_balance_total := '&min_balance_due';
    
    DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || :bound_balance_total);
    DBMS_OUTPUT.PUT_LINE('==================================================================');
    
    FOR vendor_invoice IN vendor_invoice_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(CHR(9) || '$' || vendor_invoice.balance_due || CHR(9) || vendor_invoice.invoice_number || 
            CHR(9) || vendor_invoice.vendor_name);
    END LOOP;
END;
