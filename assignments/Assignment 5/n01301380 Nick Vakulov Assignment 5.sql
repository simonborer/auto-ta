--Q1--
SET SERVEROUTPUT ON;
DECLARE
n number;
BEGIN
n:= 0;
FOR i IN (SELECT vendor_id FROM invoices WHERE invoice_total- payment_total - credit_total > 5000) LOOP
    n:=n+1; 
END LOOP;
DBMS_OUTPUT.PUT_LINE(n || ' invoices exceed $5,000.');
END;
--Q2--
SET SERVEROUTPUT ON;
DECLARE
total_balance_due NUMBER;
count_invoices NUMBER;
BEGIN
    SELECT SUM(invoice_total-payment_total-credit_total), COUNT(vendor_id)
    INTO total_balance_due, count_invoices
    FROM invoices
    WHERE invoice_total-payment_total-credit_total>0;
    IF total_balance_due > 50000 THEN
        DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || count_invoices);
        DBMS_OUTPUT.PUT_LINE('Total balance due is ' || total_balance_due);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000');
    END IF;
END;
--Q3--
DECLARE 
c1 varchar2(50);
c2 varchar2(50);
c3 number;
CURSOR cur IS
SELECT  (invoice_total-payment_total-credit_total) AS balance_due,  invoice_number, vendor_name  FROM Vendors
JOIN invoices
USING (vendor_id)
WHERE invoice_total-payment_total-credit_total>5000
ORDER BY balance_due DESC;
Begin
OPEN cur;
FOR i IN (SELECT invoice_id FROM invoices WHERE invoice_total- payment_total - credit_total > 5000) LOOP
fetch cur into c3, c2, c1;
    DBMS_OUTPUT.PUT_LINE(c3 || ' ' || c2 || ' ' || c1);
end loop;
CLOSE cur;
end;