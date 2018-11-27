-- NAME: Rabih Aoun
-- ASSIGNMENT 5
-- STUDENT ID : N01329942
-------------------------
-- Question 1 --
SET SERVEROUTPUT ON;
DECLARE
    balance NUMBER;
    
BEGIN
    SELECT COUNT(*) into balance FROM INVOICES WHERE invoice_total >=5000;

        DBMS_OUTPUT.PUT_LINE(balance || ' invoices exceed $5,000');
  
END;

-- Question 2 --

DECLARE
    balance_due NUMBER;
    total_balance NUMBER;
BEGIN
    SELECT COUNT(*) into balance_due FROM INVOICES WHERE invoice_total > 0;
    SELECT SUM(invoice_total) into total_balance FROM INVOICES;
    IF(total_balance >= 50000) THEN
        DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || balance_due);
        DBMS_OUTPUT.PUT_LINE('Total balance due is ' || TO_CHAR(total_balance,'$999,999.99'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total balance due is less then $50,000.');
    END IF;    

END;

-- Question 3 --

DECLARE
    cursor invoices_cursor is select 
                            (invoice_total + payment_total + credit_total) as balance_due,
                            invoice_number, vendor_name
                            from vendors v join invoices i 
                            on v.vendor_id = i.vendor_id
                            where (invoice_total + payment_total + credit_total) >= 5000
                            order by balance_due desc;
                                                   
BEGIN
 FOR invoice_row IN invoices_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due,'$99,999.99') || ' ' || 
    invoice_row.invoice_number ||' ' || invoice_row.vendor_name);
 END LOOP;   
   
END;

-- Question 4 --
DECLARE
    cursor invoices_cursor1 is select 
                            invoice_total + payment_total + credit_total as balance_due,
                            invoice_number, vendor_name
                            from vendors v join invoices i 
                            on v.vendor_id = i.vendor_id
                            where invoice_total + payment_total + credit_total > 20000
                            order by balance_due desc;                       
    cursor invoices_cursor2 is select 
                            invoice_total + payment_total + credit_total as balance_due,
                            invoice_number, vendor_name
                            from vendors v join invoices i 
                            on v.vendor_id = i.vendor_id
                            where (invoice_total + payment_total + credit_total) BETWEEN 10000 AND 20000
                            order by balance_due desc;
    cursor invoices_cursor3 is select 
                            invoice_total + payment_total + credit_total as balance_due,
                            invoice_number, vendor_name
                            from vendors v join invoices i 
                            on v.vendor_id = i.vendor_id
                            where (invoice_total + payment_total + credit_total) BETWEEN 5000 AND 10000
                            order by balance_due desc;                            
BEGIN
 DBMS_OUTPUT.PUT_LINE('$20,000 or More');
 FOR invoice_row IN invoices_cursor1 LOOP
    
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due,'$99,999.99') || ' ' || 
    invoice_row.invoice_number ||' ' || invoice_row.vendor_name);
 END LOOP;   
 DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000');
 FOR invoice_row IN invoices_cursor2 LOOP

    DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due,'$99,999.99') || ' ' || 
    invoice_row.invoice_number ||' ' || invoice_row.vendor_name);
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000');
 FOR invoice_row IN invoices_cursor3 LOOP
    
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(invoice_row.balance_due,'$99,999.99') || ' ' || 
    invoice_row.invoice_number ||' ' || invoice_row.vendor_name);
 END LOOP;
END;

-- Question 5 --



