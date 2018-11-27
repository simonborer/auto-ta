SET SERVEROUTPUT ON;
DECLARE

CURSOR vendor_info IS
SELECT vendor_name, invoice_number, invoice_total - payment_total AS Balance
FROM invoices x
JOIN vendors y
ON x.vendor_id = y.vendor_id
WHERE invoice_total - payment_total >= 5000
ORDER BY Balance DESC;

BEGIN
FOR vendor IN vendor_info LOOP
    IF (vendor.Balance IS NOT NULL) THEN
        DBMS_OUTPUT.PUT_LINE('$' || vendor.Balance ||'   '||vendor.invoice_number ||'   '||  vendor.vendor_name);
    END IF;
END LOOP;
END;
/