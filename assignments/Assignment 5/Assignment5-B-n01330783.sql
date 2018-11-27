--Jetalbahen tandel
--Assignment 5
--que 1

SET SERVEROUTPUT ON;

DECLARE
    balance_due   NUMBER(3);
    
BEGIN   
SELECT count(invoice_total-payment_total-credit_total)
INTO balance_due
FROM invoices
WHERE invoice_total-payment_total-credit_total >=5000;

DBMS_OUTPUT.PUT_LINE(balance_due || 'invoices exceed $5,000 ');

END ;


--Jetalbahen tandel
--Assignment 5
--que 2

SET SERVEROUTPUT ON;

DECLARE
    balance_due   NUMBER(3);
    sum_balance_due NUMBER(10);
    
BEGIN   
SELECT COUNT(invoice_total-payment_total-credit_total)
INTO balance_due
FROM invoices
WHERE (invoice_total-payment_total-credit_total) >0;

DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is  ' ||balance_due || CHR(10) );

SELECT SUM(invoice_total-payment_total-credit_total)
INTO sum_balance_due
FROM invoices
WHERE (invoice_total-payment_total-credit_total) >0;

IF (sum_balance_due >50000) THEN
DBMS_OUTPUT.PUT_LINE('Total balance due is '||sum_balance_due || CHR(10));

ELSE
DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000 ' || CHR(10));

END IF ;

END;




--Jetalbahen tandel
--Assignment 5
--que 3

SET SERVEROUTPUT ON;

DECLARE
 CURSOR vendor_invoice_cur IS
 SELECT vendor_name,invoice_number,
        invoice_total-payment_total-credit_total AS "balance_due"
 FROM invoices i
 JOIN vendors v
 ON i.vendor_id=v.vendor_id
 WHERE (invoice_total-payment_total-credit_total)>=5000 
 ORDER BY (invoice_total-payment_total-credit_total)DESC ; 
 
BEGIN
FOR invoice_row IN vendor_invoice_cur LOOP

   DBMS_OUTPUT.PUT_LINE(invoice_row."balance_due"  || ' ' || invoice_row.invoice_number || '    ' || invoice_row.vendor_name);
   END LOOP;
END;



--Jetalbahen tandel
--Assignment 5
--que 4

SET SERVEROUTPUT ON;

DECLARE
 CURSOR vendor_invoice_cur IS
 SELECT vendor_name,invoice_number,
        invoice_total-payment_total-credit_total AS "balance_due"
 FROM invoices i
 JOIN vendors v
 ON i.vendor_id=v.vendor_id
 WHERE (invoice_total-payment_total-credit_total)>=5000 
 ORDER BY (invoice_total-payment_total-credit_total)DESC ; 
 
BEGIN
  DBMS_OUTPUT.PUT_LINE('$20,000  or  more ');
  FOR invoice_row IN vendor_invoice_cur LOOP
  IF (invoice_row."balance_due" >=20000) THEN
     DBMS_OUTPUT.PUT_LINE(invoice_row."balance_due" || '  ' ||invoice_row.invoice_number  || '  ' || invoice_row.vendor_name);
     END IF;
     END LOOP;
     
     DBMS_OUTPUT.PUT_LINE('$10,000  to  $20,000 ');
  FOR invoice_row IN vendor_invoice_cur LOOP
  IF (invoice_row."balance_due" >=10000 and invoice_row."balance_due"<20000) THEN
     DBMS_OUTPUT.PUT_LINE(invoice_row."balance_due" || '  ' ||invoice_row.invoice_number  || '  ' || invoice_row.vendor_name);
     END IF;
     END LOOP;
     
     DBMS_OUTPUT.PUT_LINE('$5000  to  $10000 ');
  FOR invoice_row IN vendor_invoice_cur LOOP
  IF (invoice_row."balance_due" >=5000 and invoice_row."balance_due"<10000) THEN
     DBMS_OUTPUT.PUT_LINE(invoice_row."balance_due" || '  ' ||invoice_row.invoice_number  || '  ' || invoice_row.vendor_name);
     END IF;
     END LOOP;
END;


--Jetalbahen tandel
--Assignment 5
--que 5

SET SERVEROUTPUT ON;

VARIABLE bound_variable VARCHAR2(25);

DECLARE
   sub_variable  VARCHAR2(25);
   
BEGIN
   sub_variable := '&sub_variable';
   
   :bound_variable := sub_variable;
END;
  
DECLARE
 CURSOR vendor_invoice_cur IS
 SELECT vendor_name,invoice_number,
        invoice_total-payment_total-credit_total AS "balance_due"
 FROM invoices i
 JOIN vendors v
 ON i.vendor_id=v.vendor_id
 WHERE (invoice_total-payment_total-credit_total)> :bound_variable 
 ORDER BY (invoice_total-payment_total-credit_total)DESC ; 
 
 sub_variable VARCHAR2(25);
 
BEGIN

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'NEW BLOCK' ||CHR(10));
    DBMS_OUTPUT.PUT_LINE('Invoices amount greater than or equal to $'|| :bound_variable);
    DBMS_OUTPUT.PUT_LINE('===============================================');
FOR invoice_row IN vendor_invoice_cur 
   LOOP
    DBMS_OUTPUT.PUT_LINE(invoice_row."balance_due"  || ' ' || invoice_row.invoice_number || '    ' || invoice_row.vendor_name);
   END LOOP;
END;

