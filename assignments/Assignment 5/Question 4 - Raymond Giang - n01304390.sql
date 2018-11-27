/* Assignment 5 - Question 4
   Name: Raymond Giang
   Student Number: n01304390 */

/* 4. Enhance your solution to exercise 3 so it shows the invoice data in three groups based on the balance due amounts with 
these headings: You will use the CURSOR three different times to loop through using the different criteria as defined below 
with the headings.

    $20,000 or More
    $10,000 to $20,000
    $5,000 to $10,000

Each group should have a heading followed by the data for the invoices that fall into that group. Also, the groups should be 
separated by one blank line. */

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
    DBMS_OUTPUT.PUT_LINE('$20,000 or More');
    DBMS_OUTPUT.PUT_LINE('================================');
    FOR vendor_invoice IN vendor_invoice_cursor LOOP
        IF vendor_invoice.balance_due >= 20000 THEN
            DBMS_OUTPUT.PUT_LINE(CHR(9) || '$' || vendor_invoice.balance_due || CHR(9) || vendor_invoice.invoice_number || 
                CHR(9) || vendor_invoice.vendor_name);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CHR(13));
    
    DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000');
    DBMS_OUTPUT.PUT_LINE('================================');
    FOR vendor_invoice IN vendor_invoice_cursor LOOP
        IF vendor_invoice.balance_due >= 10000 AND vendor_invoice.balance_due < 20000 THEN
            DBMS_OUTPUT.PUT_LINE(CHR(9) || '$' || vendor_invoice.balance_due || CHR(9) || vendor_invoice.invoice_number || 
                CHR(9) || vendor_invoice.vendor_name);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CHR(13));
    
    DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000');
    DBMS_OUTPUT.PUT_LINE('================================');
    FOR vendor_invoice IN vendor_invoice_cursor LOOP
        IF vendor_invoice.balance_due >= 5000 AND vendor_invoice.balance_due < 10000 THEN
            DBMS_OUTPUT.PUT_LINE(CHR(9) || '$' || vendor_invoice.balance_due || CHR(9) || vendor_invoice.invoice_number || 
                CHR(9) || vendor_invoice.vendor_name);
        END IF;
    END LOOP;
END;
