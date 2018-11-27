--Jay Patel
--1
create or replace procedure insert_glaccount
(     
personal_account_number number,
personal_account_description varchar2
)
as
 begin
insert into
general_ledger_accounts 
values ( personal_account_number,personal_account_description );
commit; 
end;
/

call insert_glaccount (1000,'new account');


--2
set serveroutput on
begin
insert_glaccount(1000, 'new account'); 
insert_glaccount(1001, 'new account2');
commit;
exception when dup_val_on_index 
then dbms_output.put_line ('a dup_val_on_index error occurred');
rollback;
when
others
then dbms_output.put_line ('an unknown exception occurred');
rollback;
end;


--3
create or replace function test_glaccounts_description
(
personal_account_description varchar2
)
return number 
is
gereral syntax
general_ledger_accounts.account_number%TYPE;
begin
select account_number 
into general syntax
from general_ledger_accounts 
where 
account_description = personal_account_description;
if SQL%ROWCOUNT=1  
then
return 1;
end if;   
exception  
when no_data_found
then
return  0;
end;


--4
set serveroutput on
begin
if  test_glaccounts_description ('new account')= 1 
then
dbms_output.put_line ('account description is already in use');
else
dbms_output.put_line ('account description is available');  
end if;

if  test_glaccounts_description ('new user account')= 0 
then
dbms_output.put_line ('account description is already in use');
else
dbms_output.put_line ('account description is available');  
end if;   
end;