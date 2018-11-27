/*
Assignment 6 - Amandeep singh - N01314702

Q1. Create a stored procedure named insert_glaccount that lets a user add a new row to the general_ledger_accounts table. 
This procedure should have two parameters, one for each of the two columns in this table. 
Then, code a CALL statement that tests the procedure. (Note that this table doesn’t allow duplicate account descriptions */

/* select * from general_ledger_accounts order by account_number desc; */

create or replace PROCEDURE insert_glaccount
(
    acnt_number_param	NUMBER,
    acnt_description_param	VARCHAR2
)
AS
BEGIN
    INSERT into general_ledger_accounts (account_number,account_description) 
    VALUES (acnt_number_param,acnt_description_param);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
END;


call insert_glaccount(680,"Humber Tax");

/*Q2. Code a script that calls the procedure that you created in exercise 1 and passes the parameters by name. 
This procedure should provide exception handling that displays this message if the INSERT statement fails 
because the account number or account description is already in the table (a DUP_VAL_ON_INDEX error): 
A DUP_VAL_ON_INDEX error occurred.It should provide this message if any other type of error occurs: 
An unknown exception occurred.*/


SET SERVEROUTPUT ON;
BEGIN
    insert_glaccount(act_number=>681,act_description=>'Tax Humber');
EXCEPTION
    WHEN dup_val_on_index THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred');
    ROLLBACK;
END;


/*Q3. Code a function named test_glaccounts_description that accepts one parameter that tests whether 
an account description is already in the General_Ledger_Accounts table. This function should return a 
value of 1 if the account description is in the table or zero if it isn’t. (Note: If a SELECT statement 
doesn’t return any data, it throws a NO_DATA_FOUND exception that your function can handle.)*/


CREATE OR REPLACE FUNCTION test_glaccounts_description
(
  accnt_description_param	 general_ledger_accounts.account_description%TYPE 
)
RETURN NUMBER
AS
  accnt_description_exist NUMBER DEFAULT 0;
BEGIN 
    SELECT 1
    into accnt_description_exist
    FROM general_ledger_accounts
    WHERE account_description = accnt_description_param;
    return accnt_description_exist;  
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Data Found'); 
        accnt_description_exist :=0;
        return accnt_description_exist;  
END;

/*Q4. Code a script that calls the function that you created in exercise 3. 
This script should display this message if the account description is in the table: 
Account description is already in use. It should provide this message if any other 
type of error occurs: Account description is available.
*/

SET SERVEROUTPUT ON;
DECLARE
    accnt_description_exist NUMBER;
BEGIN 
    SELECT test_glaccounts_description('Accodddunting') 
    INTO accnt_description_exist
    FROM DUAL;
    if accnt_description_exist =1 then
        DBMS_OUTPUT.PUT_LINE('Account description is already in use.'); 
    end if;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Account description is available.');  
END;
