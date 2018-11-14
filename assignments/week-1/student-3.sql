

-- q2

select vendor_id
from invoices where vendor_id >= 50 and <= 100
order by invoice_total

-- q3

select * from invoices 
join invoice_line_items 
on invoices.invoice_id = invoice_line_items.invoice_id
WHERE invoice_id = 2