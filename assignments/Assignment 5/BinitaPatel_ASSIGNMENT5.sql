--ASSIGNMENT5--
--BINITA PATEL--


--1--
SET SERVEROUTPUT ON;
DECLARE
    Invoice NUMBER;
BEGIN
  SELECT COUNT(*) INTO Invoice 
  FROM INVOICES 
  WHERE invoice_total-payment_total-credit_total>=5000;
  DBMS_OUTPUT.PUT_LINE(Invoice || ' invoices exceeds $5,000'  || CHR(10));
END;


--2--
SET SERVEROUTPUT ON;
DECLARE
    Invoice NUMBER;
    Due NUMBER;
BEGIN
 SELECT COUNT(*) INTO Invoice 
 FROM Invoices 
 WHERE invoice_total-payment_total-credit_total>0;
  
  SELECT SUM( invoice_total-payment_total-credit_total) INTO Due
  FROM Invoices
  WHERE invoice_total-payment_total-credit_total>0;
  
  IF(Due>50000)THEN
  DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is:'|| Invoice || CHR(10) ||'Total balance due is:'|| Due  || CHR(10));
  ELSE
  DBMS_OUTPUT.PUT_LINE('Total Balance Due is less than $50,000'|| Invoice || CHR(10) ||'Total balance due is:'|| Due  || CHR(10));
  END IF;
END;

--3--
DECLARE
CURSOR c_name IS
    SELECT vendor_name,invoice_number,invoice_total-payment_total-credit_total Due
    FROM invoices
    INNER JOIN vendors
    ON invoices.vendor_id=vendors.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY invoice_total-payment_total-credit_total DESC;
BEGIN
    FOR c_rows IN c_name
    LOOP
     DBMS_OUTPUT.PUT_LINE(c_rows.Due|| CHR(10) ||c_rows.invoice_number|| CHR(10) || c_rows.vendor_name  || CHR(10));
    END LOOP;
END;    
    
--4--
DECLARE
CURSOR c_name IS
SELECT vendor_name,invoice_number,invoice_total-payment_total-credit_total Due
    FROM invoices
    INNER JOIN vendors
    ON invoices.vendor_id=vendors.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY invoice_total-payment_total-credit_total DESC;
BEGIN
   DBMS_OUTPUT.PUT_LINE('$20000 or more' || CHR(10));
    FOR c_rows IN c_name
    LOOP
    IF c_rows.Due>20000 THEN
    DBMS_OUTPUT.PUT_LINE(c_rows.Due|| CHR(10) ||c_rows.invoice_number|| CHR(10) || c_rows.vendor_name  || CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('$10000 to $20000' || CHR(10));
    FOR c_rows IN c_name
    LOOP
    IF c_rows.Due>10000 AND c_rows.Due<20000 THEN
    DBMS_OUTPUT.PUT_LINE(c_rows.Due|| CHR(10) ||c_rows.invoice_number|| CHR(10) || c_rows.vendor_name  || CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('$5000 to $10000' || CHR(10));
    FOR c_rows IN c_name
    LOOP
    IF c_rows.Due>10000 AND c_rows.Due<20000 THEN
    DBMS_OUTPUT.PUT_LINE(c_rows.Due|| CHR(10) ||c_rows.invoice_number|| CHR(10) || c_rows.vendor_name  || CHR(10));
    END IF;
    END LOOP;
END;    


--5--
DECLARE
CURSOR c_name IS
SELECT vendor_name,invoice_number,invoice_total-payment_total-credit_total Due
    FROM invoices
    INNER JOIN vendors
    ON invoices.vendor_id=vendors.vendor_id
    WHERE invoice_total-payment_total-credit_total>&Input
    ORDER BY invoice_total-payment_total-credit_total DESC;
BEGIN
FOR c_rows IN c_name
    LOOP
    IF c_rows.Due>10000 AND c_rows.Due<20000 THEN
    DBMS_OUTPUT.PUT_LINE(c_rows.Due|| CHR(10) ||c_rows.invoice_number|| CHR(10) || c_rows.vendor_name  || CHR(10));
    END IF;
    END LOOP;
END;
