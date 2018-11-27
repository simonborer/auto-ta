SET SERVEROUTPUT ON;
VARIABLE bind_var NUMBER;
DECLARE
substitute_var    invoices.payment_total%TYPE;

CURSOR vendor_info IS
SELECT vendor_name, invoice_number, invoice_total - payment_total AS Balance
FROM invoices x
JOIN vendors y
ON x.vendor_id = y.vendor_id
ORDER BY Balance DESC;

BEGIN
:bind_var := &substitute_var;
DBMS_OUTPUT.PUT_LINE('Invoice amounts greater than or equal to $' || :bind_var );
DBMS_OUTPUT.PUT_LINE('==================================================');
FOR vendor IN vendor_info LOOP
    IF (vendor.Balance >= :bind_var) THEN
        DBMS_OUTPUT.PUT_LINE('$' || vendor.Balance ||'   '||vendor.invoice_number ||'   '||  vendor.vendor_name);
    END IF;
END LOOP;
END;
/