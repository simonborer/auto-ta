--Khushboo Umrigar--
--Section B--
--Assignment5--
--QuestionNo(1)--
SET SERVEROUTPUT ON;
DECLARE
    num_Of_Invoices   NUMBER;
BEGIN
  SELECT count(*) into num_Of_Invoices FROM invoices WHERE invoice_total-payment_total-credit_total>=5000;
  DBMS_OUTPUT.PUT_LINE(num_Of_Invoices || ' invoices exceeds $5,000'  || CHR(10));
END;
--Khushboo Umrigar--
--Section B--
--Assignment5--
--QuestionNo(2)--
SET SERVEROUTPUT ON;
DECLARE
    num_Of_Invoices   NUMBER;
    Due_Total NUMBER;
BEGIN
  SELECT count(*) into num_Of_Invoices FROM invoices WHERE invoice_total-payment_total-credit_total>0;
  SELECT  sum(invoice_total-payment_total-credit_total) into Due_Total FROM invoices WHERE invoice_total-payment_total-credit_total>0;
 
  IF (Due_Total>50000) THEN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Number of unpaid invoices is' || num_Of_Invoices || CHR(10) || 'Total Balance due is ' || Due_Total || CHR(10));
  ELSE
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Total balance due is less than $50,000'|| CHR(10));
  END IF;
END;

--Khushboo Umrigar--
--Section B--
--Assignment5--
--QuestionNo(3)--
DECLARE 
  CURSOR cursor_name IS 
    SELECT vendor_name, invoice_number, invoice_total-payment_total-credit_total balance_due
    FROM invoices INNER JOIN vendors ON invoices.vendor_id=vendors.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY invoice_total-payment_total-credit_total DESC; 
BEGIN
    FOR cursor_r IN cursor_name
    LOOP
    DBMS_OUTPUT.PUT_LINE(cursor_r.balance_due || CHR(9) || cursor_r.invoice_number || CHR(9) ||  cursor_r.vendor_name ||CHR(10));
    END LOOP;
END;
