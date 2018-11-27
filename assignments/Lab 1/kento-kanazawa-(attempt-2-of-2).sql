1. The query will select invoice number, invoice date, and the invoice total from invoices database, for the invoices that are $2000 and larger, and for dates bewteen April 1 2008 and May 31 2008.The invoices will be listed in ascending order of invoice date, and invoice total. 

  

2. The query will select vender id, invoice date and invoice total from the invoices database, for the invoices that are $2000 and larger, for dates between April 1 2008, and May 31 2008. The invoices will be listed in ascending order of invoice date, and invoice total. 

  

3. The query will select the vendor name, vendor address, vendor city, and vendor state from the vendors database, for vendors that are located in Michigan, Arizona, and Texas, in descending alphabetical order. 

  

4. The query will select the invoice number, invoice total, payment total, and Balance Owing (which is a value calculated from invoice total minus the payment total), from the invoices database, where the total invoice subtracted by the total payment does not equal 0, and is larger or equal to $500. The list will be ordered by the number of invoice. 

  

5. 

SELECT vendor_name AS "Vendor", vendor_state AS "State", vendor_city AS "City"
 FROM vendors
 ORDER BY vendor_city ASC 

  

6. 

SELECT invoice_id, invoice_number, invoice_total - payment_total AS "balance"
 FROM invoices
 WHERE invoice_date BETWEEN '08-APR-1' AND '08-APR-30' 

  

7. 

SELECT vendor_id, vendor_name, vendor_contact_first_name || ' ' || vendor_contact_last_name AS "Vendor Contact Name", vendor_phone
 FROM vendors
 ORDER BY vendor_contact_last_name