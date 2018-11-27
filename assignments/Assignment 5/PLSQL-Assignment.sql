--Aakarshit Bajaj
--N01297945
--Section-B
--Assignment-5
set serveroutput on;


--Q1--
Declare
balance integer;
Begin
select count (*) into balance from invoices
where (invoice_total-payment_total-credit_total) >= 5000;
dbms_output.put_line(balance||' invoices exceed $5000');
end;

--Q2--

DECLARE
balance_due integer;
balance_sum float;

BEGIN
select count (*) into balance_due from invoices
where (invoice_total-payment_total-credit_total) <> 0;
dbms_output.put_line('The number of Unpaid Invoices is '||balance_due);
select sum(invoice_total-payment_total-credit_total)into balance_sum from invoices
where (invoice_total-payment_total-credit_total) <> 0;
if(balance_sum > 50000) then
dbms_output.put_line('Total balance due is $ '|| balance_sum);
else
dbms_output.put_line('Total balance due is less than $50,000');
end if;
end;

--Q3--

DECLARE 
cursor cursor_2  is 
select vendor_name,invoice_number,invoice_total-payment_total-credit_total as balance_due
from invoices  invc 
join vendors ven
on invc.vendor_id = ven.vendor_id
where invoice_total-payment_total-credit_total > 5000
order by (invoice_total-payment_total-credit_total) desc; 
BEGIN
for cursor_3 in cursor_2
loop
dbms_output.put_line (cursor_3.balance_due||CHR(10)||cursor_3.invoice_number||CHR(10)||cursor_3.vendor_name||CHR(10));
end loop;
end;

--Q4--

DECLARE 
cursor cursor_2 IS 
select vendor_name, invoice_number, invoice_total-payment_total-credit_total as balance_due
from invoices invc
join vendors ven
on invc.vendor_id = ven.vendor_id
where invoice_total-payment_total-credit_total > 5000
order by invoice_total-payment_total-credit_total desc; 

begin
dbms_output.put_line('Amount due greater than 20000');

for cursor_3 in cursor_2 
(select invoice_number,vendor_name,invoice_total-payment_total-credit_total from  invoices 
where invoice_total-payment_total-credit_total > 20000 
order by (invoice_total-payment_total-credit_total) desc);
loop
dbms_output.put_line(I.invoice_number||' '||I.balance_due||' '||I.vendor_name);
end loop;

dbms_output.put_line('Amount dues between 10000 and 20000');

for cursor_3 in cursor_2 
(select invoice_number,vendor_name,invoice_total-payment_total-credit_total 
from invoices where invoice_total-payment_total-credit_total 
between 10000 and 20000 
order by invoice_total-payment_total-credit_total desc);
loop
dbms_output.put_line(I. invoice_number||' '||I.balance_due||' '||I.vendor_name);
end loop;

dbms_output.put_line('Amount dues between 5000 and 10000');

for cursor_3 in cursor_2 
(select invoice_number,vendor_name,invoice_total-payment_total-credit_total 
from invoices 
where  invoice_total-payment_total-credit_total
between 5000 and 10000 
order by invoice_total-payment_total-credit_total desc);
loop
dbms_output.put_line(I.invoice_number||' '||I.balance_due||' '||I.vendor_name);
end loop;
end;



