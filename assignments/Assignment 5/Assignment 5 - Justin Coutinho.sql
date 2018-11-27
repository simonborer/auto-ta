/*Question 1*/
SET SERVEROUTPUT ON;

DECLARE
total_in NUMBER;

BEGIN
SELECT COUNT(invoice_total - payment_total - credit_total) AS "Balance Due"
INTO total_in
FROM invoices
WHERE ((invoice_total - payment_total - credit_total) > 5000);
DBMS_OUTPUT.PUT_LINE(total_in || ' invoices exceed $5,000.' || CHR(60));
END;

/*Question 2*/
SET SERVEROUTPUT ON;

DECLARE

balance_due NUMBER;
invoices_count invoices.invoice_id%TYPE;

BEGIN
SELECT COUNT(invoice_id), SUM(invoice_total - payment_total - credit_total) 
INTO invoices_count, balance_due
FROM invoices
WHERE ((invoice_total - payment_total - credit_total) > 0);

IF balance_due > 50000 THEN
DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices: ' || invoices_count || ' Balance due is: ' || balance_due);
ELSE
DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000');
END IF;
END;
/*Question 3*/
SET SERVEROUTPUT ON;

DECLARE
CURSOR c_vendor IS
SELECT v.vendor_name,i.invoice_number,(i.invoice_total - i.payment_total - i.credit_total) AS balance_due
FROM invoices i
JOIN vendors v
ON i.vendor_id = v.vendor_id
WHERE (i.invoice_total - i.payment_total - i.credit_total) >= 5000 
ORDER BY (i.invoice_total - i.payment_total - i.credit_total) DESC;

BEGIN
FOR i IN c_vendor LOOP
DBMS_OUTPUT.PUT_LINE(i.balance_due ||' '||i.invoice_number||' '||i.vendor_name);
END LOOP;
END;
/*Question 4*/
SET SERVEROUTPUT ON;

DECLARE
CURSOR c_vendor IS
SELECT v.vendor_name,i.invoice_number,(i.invoice_total - i.payment_total - i.credit_total) AS balance_due
FROM invoices i
JOIN vendors v
ON i.vendor_id = v.vendor_id
WHERE (i.invoice_total - i.payment_total - i.credit_total) >= 5000 
ORDER BY (i.invoice_total - i.payment_total - i.credit_total) DESC;

BEGIN
FOR i IN c_vendor LOOP
IF (i.balance_due >= 20000) THEN
DBMS_OUTPUT.PUT_LINE('$20,000 or More ' || i.balance_due);
ELSIF (i.balance_due >= 10000) THEN
DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000 ' || i.balance_due);
ELSIF (i.balance_due >= 5000) THEN
DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000 ' || i.balance_due);  
END IF;
END LOOP;
END;
/*Question 5*/
SET SERVEROUTPUT ON;

VARIABLE input_balance NUMBER;

BEGIN
    :input_balance := &balance_in;
END;
/
DECLARE
CURSOR c_vendor IS
SELECT v.vendor_name,i.invoice_number,(i.invoice_total - i.payment_total - i.credit_total) AS balance_due
FROM invoices i
JOIN vendors v
ON i.vendor_id = v.vendor_id
WHERE (i.invoice_total - i.payment_total - i.credit_total) = :input_balance;

BEGIN
OPEN c_vendor;
IF (:input_balance >= 20000) THEN
DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $20,000');
ELSIF (:input_balance >= 10000) THEN
DBMS_OUTPUT.PUT_LINE('Invoice amounts between $10,000 and $20,000 ');
ELSIF (:input_balance >= 5000) THEN
DBMS_OUTPUT.PUT_LINE('Invoice amounts between $5,000 and $10,000 '); 
ELSIF (:input_balance < 5000) THEN
DBMS_OUTPUT.PUT_LINE('Invoice amounts less than $5,000');
END IF;
CLOSE c_vendor;
END;
/