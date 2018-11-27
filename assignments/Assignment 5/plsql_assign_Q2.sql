SET SERVEROUTPUT ON;
DECLARE

CURSOR unpaid_balance IS
SELECT COUNT(invoice_total - payment_total) AS Unpaid, SUM(invoice_total - payment_total) AS Total_Balance
FROM invoices
WHERE invoice_total - payment_total > 0;

BEGIN
FOR unpaid IN unpaid_balance LOOP
IF (unpaid.Unpaid IS NOT NULL AND unpaid.Total_Balance IS NOT NULL) THEN
    DBMS_OUTPUT.PUT_LINE( 'Number of unpaid invoices is ' ||  unpaid.Unpaid);
    DBMS_OUTPUT.PUT_LINE( 'Total balance due is ' ||  unpaid.Total_Balance);
  IF (unpaid.Total_Balance < 50000) THEN
    DBMS_OUTPUT.PUT_LINE( 'Total balance due is less than $50,000' );
  END IF;
END IF;
END LOOP;
END;
/