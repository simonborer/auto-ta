-- Q1

SELECT * FROM invoices WHERE invoice_id = 1

-- Q2

SELECT vendor_id
FROM invoices WHERE vendor_id >= 50 AND <= 100
ORDER BY invoice_total
