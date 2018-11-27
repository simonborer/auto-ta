--Waheguru ji Mehar Kariyo--
--Assignment-6--
--Aakarshit Bajaj--
--Section-B---
--N01297945--

--Q1--
create or replace procedure insert_glaccount
(
BajajAccountNumber   number,
BajajAccountDescription varchar2
)
as
Begin
insert into general_ledger_accounts
values (BajajAccountNumber,BajajAccountDescription);
commit;
end;
/
call insert_glaccount(01297945,'credit card')
--select * from general_ledger_accounts

--Q2--

create or replace procedure insert_glaccount
(
BajajAccountNumber   number,
BajajAccountDescription varchar2
)
as
Begin
insert into general_ledger_accounts
values (BajajAccountNumber,BajajAccountDescription);
exception
when DUP_VAL_ON_INDEX then
raise_application_error(-20001,'You are trying to enter a duplicate entry');
when others then
raise_application_error(-20002,'An unknown excepion error occured');
commit;
end;
/
call insert_glaccount(123456,'AxisCard');

--Q3--
create or replace function test_glaccounts_description
(
AccountDescription varchar2
)
return number is condition_checker
general_ledger_accounts.account_number%type;

Begin

select account_number into condition_checker
from general_ledger_accounts
where account_description = AccountDescription;

if  sql%rowcount = 1 then
        return 1;
end if;
exception when no_data_found  then
        return 0;
end;
/
--Q4--
--Calling a function in Q3--
set serveroutput on;
Begin
--select * from general_ledger_accounts
-- calling this function for 'Account description is already in use'
if test_glaccounts_description('Accounting') = 1 then
     dbms_output.put_line('Account description is already in use');
else
     dbms_output.put_line('Account Description is available');
end if;
end;
/
Begin
--select * from general_ledger_accounts
--calling this function for 'Account description is available'
if test_glaccounts_description('ScotiaCard') = 1 then
     dbms_output.put_line('Account description is already in use');
else
     dbms_output.put_line('Account Description is available');
end if;
end;
/