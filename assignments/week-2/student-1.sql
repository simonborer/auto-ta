-- Q1

SELECT * FROM invoice
WHERE invoice_id = 2

-- Q3

SELECT * FROM invoices 
JOIN invoice_line_items 
ON invoices.invoice_id = invoice_line_items.invoice_id
WHERE invoice_id = 2