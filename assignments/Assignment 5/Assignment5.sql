----assignment-5 rohit arora----
---1--
SET SERVEROUTPUT ON;


DECLARE
foo number; 
   
BEGIN
foo:=0;
FOR i IN
(SELECT  *  from INVOICES where INVOICE_TOTAL- PAYMENT_TOTAL-CREDIT_TOTAL >=5000)
LOOP 

foo:=foo+1;
END LOOP;
DBMS_OUTPUT.PUT_LINE(foo || ' invoices exceed $5,000.');
END;



---2---
SET SERVEROUTPUT ON;

DECLARE
    foo number; 
    x number;
   
BEGIN
foo:=0;
FOR i IN
(SELECT  *  from INVOICES where INVOICE_TOTAL- PAYMENT_TOTAL-CREDIT_TOTAL >=5000)
LOOP 

foo:=foo+1;
END LOOP;

select sum(INVOICE_TOTAL- PAYMENT_TOTAL-CREDIT_TOTAL) into x from INVOICES ;

IF(x>50000)THEN
 DBMS_OUTPUT.PUT_LINE( 'Number of unpaid invoices is ' || foo || CHR(10) || 'Total Balance due is ' || x || CHR(10));
  ELSE
  DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000'|| CHR(10));
  END IF;
END;


----3----


SET SERVEROUTPUT ON;

DECLARE 

  CURSOR cursor_x IS 
    SELECT vendor_name, invoice_number, invoice_total-payment_total-credit_total AS "balance due"
    FROM invoices i
    JOIN vendors v
    ON i.vendor_id=v.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY "balance due" DESC; 
BEGIN
    FOR cursor_raw IN cursor_x
    LOOP
    DBMS_OUTPUT.PUT_LINE('$'||cursor_raw."balance due" || ' ' || cursor_raw.invoice_number ||' ' ||
    cursor_raw.vendor_name ||CHR(10));
    END LOOP;
END;

--4--


SET SERVEROUTPUT ON;


DECLARE 
  CURSOR cursor_x IS 
    SELECT vendor_name, invoice_number, invoice_total-payment_total-credit_total as "balance due"
    FROM invoices i
    JOIN vendors v
    ON i.vendor_id=v.vendor_id
    WHERE invoice_total-payment_total-credit_total>5000
    ORDER BY "balance due" DESC; 
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('$20000 or More' || CHR(10));
    FOR cursor_raw IN cursor_x
    LOOP
    IF cursor_raw."balance due" > 20000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_raw."balance due" || ' ' || cursor_raw.invoice_number || ' ' ||  cursor_raw.vendor_name ||CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '$10000 to $20000' || CHR(10));
    FOR cursor_raw IN cursor_x
    LOOP
    IF cursor_raw."balance due" > 10000 AND  cursor_r."balance due" < 20000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_raw."balance due" ||' ' || cursor_raw.invoice_number || ' ' ||  cursor_raw.vendor_name ||CHR(10));
    END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('$5000 to $10000' || CHR(10));
    FOR cursor_raw IN cursor_x
    LOOP
    IF cursor_raw."balance due" > 5000 AND  cursor_raw."balance due" < 10000 THEN
        DBMS_OUTPUT.PUT_LINE(cursor_raw."balance due"||' ' || cursor_raw.invoice_number || ' ' ||  cursor_raw.vendor_name ||CHR(10));
    END IF;
    END LOOP;
    
END;



--5--


SET SERVEROUTPUT ON;

VARIABLE x NUMBER;

DECLARE 
    
    CURSOR cursor_x IS 
    SELECT vendor_name, invoice_number, invoice_total-payment_total-credit_total as "balance due"
    FROM invoices i
    JOIN vendors v
    ON i.vendor_id=v.vendor_id
    WHERE invoice_total-payment_total-credit_total>:x
    ORDER BY "balance due" DESC;
  
    
BEGIN
    :x :=&x;
    DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || :x || CHR(10));
    FOR cursor_raw IN cursor_x
    LOOP
    DBMS_OUTPUT.PUT_LINE(cursor_raw."balance due" || '  ' || cursor_raw.invoice_number || '  ' ||  cursor_raw.vendor_name ||CHR(10));
    END LOOP; 
END;










