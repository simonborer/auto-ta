//Jing Cheng n01289618 Assignment 5 Database Design and Development
//1.
SET SERVEROUTPUT ON;
DECLARE
  invoices_exceeding  NUMBER;
  
BEGIN
  SELECT count(*)
  into invoices_exceeding
  FROM invoices
  WHERE (invoice_total - payment_total - credit_total) >= 5000;
    DBMS_OUTPUT.PUT_LINE(invoices_exceeding || ' invoices exceeding $5,000.');
END;

//2.
DECLARE 
  invoices_balancedue NUMBER;
  sum_balancedue NUMBER;

BEGIN
  SELECT count(*)
  into invoices_balancedue
  FROM invoices
  WHERE (invoice_total - payment_total - credit_total) > 0;
  
  SELECT sum(invoice_total - payment_total - credit_total)
  into sum_balancedue
  FROM invoices
  WHERE (invoice_total - payment_total - credit_total) > 0;
  
  IF (sum_balancedue >= 50000) THEN
    DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || invoices_balancedue);
    DBMS_OUTPUT.PUT_LINE('Total balance due is ' || sum_balancedue);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000');
  END IF;
END;

//3.
DECLARE
CURSOR balance_due_cursor IS
  SELECT v.vendor_name, i.invoice_number, (i.invoice_total - i.payment_total - i.credit_total) AS balance_due
  FROM invoices i 
  JOIN vendors v
  ON i.vendor_id = v.vendor_id
  WHERE (i.invoice_total - i.payment_total - i.credit_total) >= 5000
  ORDER BY (i.invoice_total - i.payment_total - i.credit_total) DESC;

BEGIN
FOR i IN balance_due_cursor LOOP
  DBMS_OUTPUT.PUT_LINE(i.balance_due || '   ' || i.invoice_number || '   ' || i.vendor_name);
END LOOP;
END;

//4.
DECLARE
CURSOR balance_due_cursor IS
  SELECT v.vendor_name, i.invoice_number, (i.invoice_total - i.payment_total - i.credit_total) AS balance_due
  FROM invoices i 
  JOIN vendors v
  ON i.vendor_id = v.vendor_id
  WHERE (i.invoice_total - i.payment_total - i.credit_total) >= 5000
  ORDER BY (i.invoice_total - i.payment_total - i.credit_total) DESC;

BEGIN
FOR i IN balance_due_cursor LOOP
IF i.balance_due > 20000 THEN
  DBMS_OUTPUT.PUT_LINE('$' || i.balance_due || '   ' || i.invoice_number || '   ' || i.vendor_name);
END IF;
END LOOP;
END;

//5.
SET SERVEROUTPUT ON;
VARIABLE minimum_balance_due NUMBER;
BEGIN
  :minimum_balance_due := &minimum_balance_due;
END;
/
DECLARE
CURSOR balance_due_cursor IS
  SELECT v.vendor_name, i.invoice_number, (i.invoice_total - i.payment_total - i.credit_total) AS balance_due
  FROM invoices i 
  JOIN vendors v
  ON i.vendor_id = v.vendor_id
  WHERE (i.invoice_total - i.payment_total - i.credit_total) >= :minimum_balance_due
  ORDER BY (i.invoice_total - i.payment_total - i.credit_total) DESC;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || :minimum_balance_due);
  DBMS_OUTPUT.PUT_LINE('==================================================');
FOR i IN balance_due_cursor LOOP
  DBMS_OUTPUT.PUT_LINE('$' || i.balance_due || '   ' || i.invoice_number || '   ' || i.vendor_name);
END LOOP;
END;

