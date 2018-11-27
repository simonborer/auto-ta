/* Assignment 5 - Question 3
   Name: Raymond Giang
   Student Number: n01304390 */

/* 3. Write an anonymous PL/SQL script that creates a cursor consisting of vendor_name, invoice_number, and balance_due for 
each invoice with a balance due that’s greater than or equal to $5,000. The rows in this cursor should be sorted in descending 
sequence by balance due. Then, for each invoice, display the balance due, invoice number, and vendor name so it looks something 
like this:
    $19,351.18    P-0608    Malloy Lithographing Inc */

SET SERVEROUTPUT ON;

DECLARE
    CURSOR vendor_invoice_cursor IS 
        SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) AS balance_due
        FROM vendors v
        JOIN invoices i
            ON v.vendor_id = i.vendor_id
        WHERE (invoice_total - payment_total - credit_total) >= 5000
        ORDER BY balance_due DESC;

BEGIN
    FOR vendor_invoice IN vendor_invoice_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('$' || vendor_invoice.balance_due || CHR(9) || vendor_invoice.invoice_number || 
            CHR(9) || vendor_invoice.vendor_name);
    END LOOP;
END;

