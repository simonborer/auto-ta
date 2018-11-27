--Question 1
SET SERVEROUTPUT ON;

DECLARE
    sum_balance_due    NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO sum_balance_due
    FROM INVOICES 
    WHERE invoice_total - payment_total - credit_total >= 5000;
    DBMS_OUTPUT.PUT_LINE(sum_balance_due || ' invoices exceed $5,000');
END;
/
--Question 2
SET SERVEROUTPUT ON;

DECLARE
    sum_balance_due    NUMBER;
    count_sum_balance_due   NUMBER;
BEGIN
    SELECT COUNT(*), SUM(invoice_total - payment_total - credit_total)
    INTO sum_balance_due, count_sum_balance_due
    FROM INVOICES 
    WHERE invoice_total - payment_total - credit_total > 0;
    
    DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || sum_balance_due);
    --DBMS_OUTPUT.PUT_LINE(count_sum_balance_due);
    
   IF count_sum_balance_due >= 50000 THEN
    DBMS_OUTPUT.PUT_LINE('Total balance due is $' || count_sum_balance_due);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000.');
    END IF;
END;
/

--Question 3
SET SERVEROUTPUT ON;

DECLARE
    CURSOR my_cursor IS 
        SELECT vendor_name, invoice_number, invoice_total - payment_total - credit_total AS balance_due
        FROM invoices
        JOIN vendors
        USING(vendor_id)
        WHERE invoice_total - payment_total - credit_total >= 5000
        ORDER BY balance_due DESC;
BEGIN
    FOR cursor_for
    IN my_cursor
    LOOP
       DBMS_OUTPUT.put_line (cursor_for.balance_due ||'       '|| cursor_for.invoice_number ||'       '|| cursor_for.vendor_name);
    END LOOP;
END;
/


