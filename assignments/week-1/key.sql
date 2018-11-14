-- Q1

SELECT * FROM invoices WHERE invoice_id = 1

-- Q2

SELECT vendor_id
FROM invoices WHERE vendor_id BETWEEN 50 AND 100
ORDER BY invoice_total DESC

-- Q3

SELECT * FROM invoices 
JOIN invoice_line_items USING (invoice_id)
WHERE invoice_id = 2