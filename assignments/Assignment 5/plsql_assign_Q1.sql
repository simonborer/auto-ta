SET SERVEROUTPUT ON;
DECLARE
counter NUMBER;
CURSOR balance_due IS
SELECT invoice_total - payment_total as Balance_Total
FROM invoices
WHERE invoice_total - payment_total > 5000;

BEGIN

counter := 0;
FOR bal_count IN balance_due LOOP
  IF (bal_count.Balance_Total IS NOT NULL ) THEN
    counter := counter + 1;
  END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE( counter || ' invoices exceed $5,000' );
END;
/


