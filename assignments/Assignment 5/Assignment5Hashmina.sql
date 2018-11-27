SET SERVEROUTPUT ON;
DECLARE 
   vcount  NUMBER; 
BEGIN 
SELECT count(Invoice_id) 
INTO vcount 
FROM invoices
WHERE (Invoice_total -  (payment_total + credit_total))  >= 5000; 
   
dbms_output.put_line(vcount || 'Invoives exceed $5000'|| CHR(10)); 
  
END; 
/ 

DECLARE 
   vcount  NUMBER;
   vsum  NUMBER;
BEGIN


SELECT count(Invoice_id), sum(Invoice_total) 
INTO vcount, vsum 
FROM invoices;
IF((Invoice_total -  (payment_total + credit_total))  >= 50000) THEN
dbms_output.put_line( 'Number of unpaid invoices is'|| vcount || CHR(10));
dbms_output.put_line( 'Total Balance due is'|| vsum || CHR(10));
ELSE 
dbms_output.put_line( 'Total Balance due is less than $50,000'|| CHR(10));
END IF;
END; 
/ 

DECLARE

balance_count  NUMBER;
-- Declare a cursor
CURSOR b_cursor IS 
    SELECT Invoice_number, vendor_name,  (Invoice_total -  (payment_total + credit_total)) AS balance_due
    FROM invoices;

BEGIN
OPEN b_cursor;
LOOP
FETCH b_cursor INTO balance_count;
IF((Invoice_total -  (payment_total + credit_total)) > = 5000) THEN
dbms_output.put_line( balance_count);
ORDER BY balance_due desc;
END IF;
END LOOP;
CLOSE b_cursor;
END;
/

DECLARE

icount  NUMBER;
-- Declare a cursor
CURSOR i_cursor IS 
     SELECT Invoice_number, vendor_name,  (Invoice_total -  (payment_total + credit_total)) AS balance_due
    FROM invoices;

BEGIN
OPEN i_cursor;
LOOP
FETCH i_cursor INTO icount;
IF((Invoice_total -  (payment_total + credit_total)) > = 20000) THEN
dbms_output.put_line( '$20,000 or More'||  CHR(10));

ELSE IF ( 10000 < (Invoice_total -  (payment_total + credit_total)) < 20000) THEN
dbms_output.put_line( '$10,000 to $20,000'|| CHR(10));

ELSE 
dbms_output.put_line( '$50,00 to $10,000'|| CHR(10));
END IF;
END LOOP;
CLOSE i_cursor;
END;
/

DECLARE

VARIABLE ivar  VARCHAR2(20);

BEGIN    
SELECT Invoice_id
FROM invoices;

:ivar := 'bind variables';
  
IF((Invoice_total -  (payment_total + credit_total)) >= 20000) THEN
DBMS_OUTPUT.PUT_LINE('Invoice amount is greater than or equal to $2000' || :ivar' || CHR(10)) ;

END IF;
END;


