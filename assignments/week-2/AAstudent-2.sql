-- Q1

SELECT invoice_id FROM invoices
WHERE invoice_id = 2

-- Q2

SELECT vendor_id
FROM invoices WHERE vendor_id >= 50 AND <= 100
ORDER BY invoice_total

-- Q3

SELECT * FROM invoices 
JOIN invoice_line_items 
ON invoices.invoice_id = invoice_line_items.invoice_id
WHERE invoice_id = 2