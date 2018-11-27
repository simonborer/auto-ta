/* Ryan Robinson - Assignment 5. Question 1. */
SET SERVEROUTPUT ON;
DECLARE
    invoice_counter   NUMBER;
BEGIN
SELECT COUNT(*)
INTO invoice_counter
FROM invoices
WHERE (invoice_total - payment_total - credit_total >= 5000);
DBMS_OUTPUT.PUT_LINE(invoice_count ||' invoices exceed $5000');
END;

/* Ryan Robinson - Assignment 5. Question 2. */
SET SERVEROUTPUT ON;

DECLARE
    count_balances_due   NUMBER;
    sum_balances_due     NUMBER(9,2);

BEGIN
SELECT COUNT (*), SUM(invoice_total - payment_total - credit_total)
INTO count_balances_due, sum_balances_due
FROM invoices
WHERE (invoice_total - payment_total - credit_total) > 0;
    IF sum_balances_due >= 65000 THEN
        DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || count_balances_due);
        DBMS_OUTPUT.PUT_LINE('Total balance due is $' || sum_balances_due);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000');
    END IF;
END;

/* Ryan Robinson - Assignment 5. Question 3. */
SET SERVEROUTPUT ON;
DECLARE
CURSOR invoices_cursor IS
SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) AS balance_due
FROM vendors v 
JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE (invoice_total - payment_total - credit_total) >= 5000
ORDER BY balance_due DESC;
invoice_row invoices%ROWTYPE;

BEGIN  
FOR invoice_row IN invoices_cursor LOOP   
    DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' ' || 
        invoice_row.invoice_number || ' ' ||
        invoice_row.vendor_name);
END LOOP;
END;

/* Ryan Robinson - Assignment 5. Question 4. */
SET SERVEROUTPUT ON;
DECLARE
CURSOR invoices_cursor IS
SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) AS balance_due
FROM vendors v 
JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE (invoice_total - payment_total - credit_total) >= 5000
ORDER BY vendor_name;

invoice_row invoices%ROWTYPE;

BEGIN
DBMS_OUTPUT.PUT_LINE(''); 
DBMS_OUTPUT.PUT_LINE('$20,000 or More'); 
FOR invoice_row IN invoices_cursor LOOP
    IF invoice_row.balance_due >= 20000 THEN
        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' ' || 
            invoice_row.invoice_number || ' ' ||
            invoice_row.vendor_name);
    END IF;
END LOOP;
  
DBMS_OUTPUT.PUT_LINE(''); 
DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000'); 
FOR invoice_row IN invoices_cursor LOOP
    IF invoice_row.balance_due >= 10000 AND invoice_row.balance_due < 20000 THEN
    DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' ' || 
        invoice_row.invoice_number || ' ' ||
        invoice_row.vendor_name);
    END IF;
END LOOP;
  
DBMS_OUTPUT.PUT_LINE(''); 
DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000'); 
FOR invoice_row IN invoices_cursor LOOP
    IF invoice_row.balance_due >= 5000 AND invoice_row.balance_due < 10000 THEN
    DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' ' || 
        invoice_row.invoice_number || ' ' ||
        invoice_row.vendor_name);
    END IF;
END LOOP;
END;

/* Ryan Robinson Assignment 5 - Question 5. */
SET SERVEROUTPUT ON;
VARIABLE minimum_balance_due NUMBER;
BEGIN
    :minimum_balance_due := &minimum_balance_due;
END;
DECLARE
CURSOR invoices_cursor IS
SELECT vendor_name, invoice_number, invoice_total - payment_total - credit_total AS balance_due
FROM vendors v JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE (invoice_total - payment_total - credit_total) >= :minimum_balance_due
ORDER BY vendor_name;

invoice_row invoices%ROWTYPE;

BEGIN
    dbms_output.put_line(' '); 
    dbms_output.put_line('Invoice amounts greater than or equal to $' || 
    :minimum_balance_due);
    dbms_output.put_line('========================================');
FOR invoice_row IN invoices_cursor LOOP   
    DBMS_OUTPUT.PUT_LINE(
        TO_CHAR(invoice_row.balance_due, '$99,999.99') || ' ' || 
        invoice_row.invoice_number || ' ' ||
        invoice_row.vendor_name);
  END LOOP;
END;