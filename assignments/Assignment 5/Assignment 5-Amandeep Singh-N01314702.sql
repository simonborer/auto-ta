/*  Assignment 5- Amandeep singh N01314702 */

/* Q1. Write an anonymous PL/SQL script that declares and sets a variable that’s equal to 
the count of all rows in the Invoices table that have a balance due that’s greater than or equal to $5,000.
Then, the script should display a message that looks like this: */


set serveroutput on;

DECLARE
    invoice_count number;
-- Variables get assigned inside the block
BEGIN
    Select count(*) into invoice_count from invoices where invoice_total-payment_total-credit_total >= 5000;
    DBMS_OUTPUT.PUT_LINE(invoice_count || ' invoices exceed $5,000.');
END;


/* Q2. Write an anonymous PL/SQL script that uses variables to get (1) the count of all of the invoices in the Invoices table 
that have a balance due and (2) the sum of the balances due for all of those invoices. If that total balance due is greater 
than or equal to $50,000, the script should display a message like this: Uses an IF/THEN/ELSE after you determine the number
of invoices that have a balance due. */

SET SERVEROUTPUT ON;
DECLARE
    invoice_count       NUMBER;
    total_balance_due   NUMBER;
BEGIN
  SELECT count(*) into invoice_count FROM invoices WHERE invoice_total-payment_total-credit_total>0;
  SELECT  sum(invoice_total-payment_total-credit_total) into total_balance_due FROM invoices WHERE invoice_total-payment_total-credit_total>0;
 
  IF (total_balance_due>50000) THEN
     DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || invoice_count || '.' || CHR(10) || 'Total Balance due is $' || total_balance_due || '.' || CHR(10));
  ELSE
     DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Total balance due is less than $50,000'|| CHR(10));
  END IF;
END;

/* Q3. Write an anonymous PL/SQL script that creates a cursor consisting of vendor_name, invoice_number, and balance_due 
for each invoice with a balance due that’s greater than or equal to $5,000. The rows in this cursor should be sorted in 
descending sequence by balance due. Then, for each invoice, display the balance due, invoice number, and vendor name   */

SET SERVEROUTPUT ON;
DECLARE 
  CURSOR cursor_value IS 
    SELECT ven.vendor_name, inv.invoice_number, inv.invoice_total-inv.payment_total-inv.credit_total balance_due
    FROM invoices inv
    JOIN vendors ven
        ON inv.vendor_id=ven.vendor_id
    WHERE inv.invoice_total-inv.payment_total-inv.credit_total > 5000
    ORDER BY inv.invoice_total-inv.payment_total-inv.credit_total DESC; 
BEGIN
    FOR cur IN cursor_value    LOOP
        DBMS_OUTPUT.PUT_LINE('$' || cur.balance_due || CHR(9) || cur.invoice_number || CHR(9) ||  cur.vendor_name ||CHR(9));
    END LOOP;
END;

/* Q4. Enhance your solution to exercise 3 so it shows the invoice data in three groups based on the balance due amounts with 
these headings: You will use the CURSOR three different times to loop through using the different criteria as defined below 
with the headings.
                    $20,000 or More
                    $10,000 to $20,000
                    $5,000 to $10,000*/

SET SERVEROUTPUT ON;
DECLARE 
  CURSOR cursor_value IS 
    SELECT ven.vendor_name, inv.invoice_number, inv.invoice_total-inv.payment_total-inv.credit_total balance_due
    FROM invoices inv
    JOIN vendors ven
        ON inv.vendor_id=ven.vendor_id
    WHERE inv.invoice_total-inv.payment_total-inv.credit_total > 5000
    ORDER BY inv.invoice_total-inv.payment_total-inv.credit_total DESC; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('$20,000 or More' || CHR(10));
    FOR cur IN cursor_value    LOOP
        IF cur.balance_due > 20000 THEN
            DBMS_OUTPUT.PUT_LINE('$' || cur.balance_due || CHR(9) || cur.invoice_number || CHR(9) ||  cur.vendor_name ||CHR(9));
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '$10,000 to $20,000' || CHR(10));
    FOR cur IN cursor_value    LOOP
        IF cur.balance_due > 10000 AND  cur.balance_due < 20000 THEN
            DBMS_OUTPUT.PUT_LINE('$' || cur.balance_due || CHR(9) || cur.invoice_number || CHR(9) ||  cur.vendor_name ||CHR(9));
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '$5,000 to $10,000' || CHR(10));
    FOR cur IN cursor_value    LOOP
        IF cur.balance_due > 5000 AND  cur.balance_due < 10000 THEN
            DBMS_OUTPUT.PUT_LINE('$' || cur.balance_due || CHR(9) || cur.invoice_number || CHR(9) ||  cur.vendor_name ||CHR(9));
        END IF;
    END LOOP;
END;


/* Q5. Enhance your solution to exercise 3 so it uses a substitution variable to set a bind variable that you use to determine 
what the minimum balance due should be for the invoices that the SELECT statement is going to retrieve. You should also use this
bind variable to display a heading like this before the list of invoices: You are using the bind variable to set the balance due
minimum. In this case 2000 is not a hard coded value but is set using a bind variable.
Invoice amounts greater than or equal to $2,000
==================================================
where 2,000 is the value of the bind variable. */

SET SERVEROUTPUT ON;

DECLARE 
    bind_value NUMBER;
    CURSOR cursor_value IS 
    SELECT ven.vendor_name, inv.invoice_number, inv.invoice_total-inv.payment_total-inv.credit_total balance_due
    FROM invoices inv
    JOIN vendors ven
        ON inv.vendor_id=ven.vendor_id
    WHERE inv.invoice_total-inv.payment_total-inv.credit_total > &bind_value
    ORDER BY inv.invoice_total-inv.payment_total-inv.credit_total DESC; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || :bind_value);
    FOR cur IN cursor_value   LOOP
         DBMS_OUTPUT.PUT_LINE(cur.balance_due || CHR(9) || cur.invoice_number || CHR(9) ||  cur.vendor_name ||CHR(10));
    END LOOP; 
END;































