SET SERVEROUTPUT ON;
DECLARE

CURSOR vendor_bracket IS
SELECT vendor_name, invoice_number, invoice_total - payment_total AS Balance
FROM invoices x
JOIN vendors y
ON x.vendor_id = y.vendor_id;

BEGIN
DBMS_OUTPUT.PUT_LINE('$5,000 to $10,000');
FOR vendor IN vendor_bracket LOOP
    IF(vendor.Balance >= 5000 AND vendor.Balance <= 10000) THEN
        DBMS_OUTPUT.PUT_LINE('$' || vendor.Balance ||'   '||vendor.invoice_number ||'   '||  vendor.vendor_name);
    END IF;
END LOOP;

DBMS_OUTPUT.PUT_LINE('$10,000 to $20,000');
FOR vendor IN vendor_bracket LOOP
    IF(vendor.Balance >= 10000 AND vendor.Balance <= 20000) THEN
        DBMS_OUTPUT.PUT_LINE('$' || vendor.Balance ||'   '||vendor.invoice_number ||'   '||  vendor.vendor_name);
    END IF;
END LOOP;

DBMS_OUTPUT.PUT_LINE('$20,000 or More');
FOR vendor IN vendor_bracket LOOP
    IF(vendor.Balance > 20000) THEN
        DBMS_OUTPUT.PUT_LINE('$' || vendor.Balance ||'   '||vendor.invoice_number ||'   '||  vendor.vendor_name);
    END IF;
END LOOP;
END;
/