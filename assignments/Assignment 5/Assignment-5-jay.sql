--Assignment-5
--Jay Patel
--Ques.1

SET SERVEROUTPUT ON;
DECLARE
    noOfInvoices   NUMBER;
BEGIN
  SELECT count(*) into noOfInvoices FROM invoices WHERE invoice_total-payment_total-credit_total>=5000;
  DBMS_OUTPUT.PUT_LINE(noOfInvoices || ' invoices exceeds $5,000'  || CHR(10));
END;

--Ques.2

SET SERVEROUTPUT ON;
DECLARE
    noOfInvoices   NUMBER;
    totalDue       NUMBER;
BEGIN
  SELECT count(*) into noOfInvoices 
  FROM invoices inv
  WHERE invoice_total-payment_total-credit_total>0;
  SELECT  sum(invoice_total-payment_total-credit_total) into totalDue 
  FROM invoices inv
  WHERE invoice_total-payment_total-credit_total>0;
 
  IF (totalDue>50000) THEN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Number of unpaid invoices is' || noOfInvoices || CHR(10) || 'Total Balance due is ' || totalDue || CHR(10));
  ELSE
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Total balance due is less than $50,000'|| CHR(10));
  END IF;
END;

--Ques.3

DECLARE 
  CURSOR cursor_name IS 
    SELECT vendor_name, invoice_number, invoice_total-payment_total-credit_total balance_due
    FROM invoices inv
    INNER JOIN vendors ven
    ON inv.vendor_id=ven.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY invoice_total-payment_total-credit_total DESC; 
BEGIN
    FOR cursor_r IN cursor_name
    LOOP
    DBMS_OUTPUT.PUT_LINE(cursor_r.balance_due || CHR(9) || cursor_r.invoice_number || CHR(9) ||  cursor_r.vendor_name ||CHR(10));
    END LOOP;
END;

--Ques.4

--Ques.5
