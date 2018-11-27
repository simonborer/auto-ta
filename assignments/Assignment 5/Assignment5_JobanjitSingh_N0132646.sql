--JOBANJIT SINGH N01302646
--ASSIGNMENT 5 

--1
SET SERVEROUTPUT ON;
DECLARE
    count_Invoices NUMBER;
BEGIN
  SELECT count(invoice_total) into count_Invoices 
  FROM invoices 
  WHERE (invoice_total-payment_total-credit_total)>=5000;
  DBMS_OUTPUT.PUT_LINE(count_Invoices || ' invoices exceeds $5,000');
END;

--2
SET SERVEROUTPUT ON;
DECLARE
    count_Invoices   NUMBER;
    amount_due       NUMBER;
BEGIN
  SELECT count(*) into count_Invoices 
  FROM invoices 
WHERE (invoice_total - payment_total - credit_total)>0;
  SELECT SUM(invoice_total - payment_total - credit_total) INTO amount_due 
  FROM invoices 
  WHERE (invoice_total - payment_total - credit_total) > 0;
 
  IF (amount_due>50000) THEN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Number of unpaid invoices is ' || count_Invoices || CHR(10) || 'Total Balance due is ' || amount_due || CHR(10));
  ELSE
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Total balance due is less than $50,000.'|| CHR(10));
  END IF;
END;

--3
DECLARE 
  CURSOR cursor_1 IS 
    SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) balance_due
    FROM invoices 
    INNER JOIN vendors 
    ON invoices.vendor_id = vendors.vendor_id
    WHERE (invoice_total - payment_total - credit_total)>5000
    ORDER BY (invoice_total - payment_total - credit_total) DESC; 
BEGIN
    FOR cursor_item IN cursor_1
    LOOP
    DBMS_OUTPUT.PUT_LINE(cursor_item.balance_due || CHR(9) || cursor_item.invoice_number || CHR(9) ||  cursor_item.vendor_name ||CHR(10));
    END LOOP;
END;
--4
DECLARE 
  CURSOR cursor_1 IS 
    SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) balance_due
    FROM invoices 
    INNER JOIN vendors 
    ON invoices.vendor_id = vendors.vendor_id
    WHERE (invoice_total - payment_total - credit_total)>5000
    ORDER BY (invoice_total - payment_total - credit_total) DESC; 
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('$20000 or More' || CHR(10));
    FOR cursor_item IN cursor_1
    LOOP
    IF cursor_item.balance_due > 20000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_item.balance_due || CHR(10) || cursor_item.invoice_number || CHR(10) ||  cursor_item.vendor_name ||CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '$10000 to $20000' || CHR(10));
    FOR cursor_item IN cursor_1
    LOOP
    IF cursor_item.balance_due > 10000 AND  cursor_item.balance_due < 20000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_item.balance_due || CHR(9) || cursor_item.invoice_number || CHR(9) ||  cursor_item.vendor_name ||CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '$5000 to $10000' || CHR(10));
    FOR cursor_item IN cursor_1
    LOOP
    IF cursor_item.balance_due > 5000 AND  cursor_item.balance_due < 10000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_item.balance_due || CHR(9) || cursor_item.invoice_number || CHR(9) ||  cursor_item.vendor_name ||CHR(10));
    END IF;
    END LOOP;
END;

--5
DECLARE 
    get_amount NUMBER;
    CURSOR cursor_1 IS 
    SELECT vendor_name, invoice_number, (invoice_total - payment_total - credit_total) balance_due
    FROM invoices INNER JOIN vendors ON invoices.vendor_id=vendors.vendor_id
    WHERE (invoice_total - payment_total - credit_total) > &get_amount
    ORDER BY (invoice_total - payment_total - credit_total) DESC; 
BEGIN
    FOR cursor_item IN cursor_1
    LOOP
    DBMS_OUTPUT.PUT_LINE(cursor_item.balance_due || CHR(10) || cursor_item.invoice_number || CHR(10) ||  cursor_item.vendor_name ||CHR(10));
    END LOOP; 
END;

