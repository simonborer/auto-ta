/* Question 1
Create a stored procedure named insert_glaccount that lets a user add a new row to the general_ledger_accounts table. 
This procedure should have two parameters, one for each of the two columns in this table. Then, code a CALL statement that tests the procedure. 
(Note that this table doesn’t allow duplicate account descriptions.)*/

CREATE OR REPLACE PROCEDURE insert_glaccount
(
    accNumParam NUMBER,
    accDescParam VARCHAR2
)
AS
BEGIN
    INSERT INTO general_ledger_accounts(account_number, account_description)
    VALUES(accNumParam, accDescParam);
    COMMIT;
END;


/* Question 2
Code a script that calls the procedure that you created in exercise 1 and passes the parameters by name. This procedure should provide exception 
handling that displays this message if the INSERT statement fails because the account number or account description is already in the 
table (a DUP_VAL_ON_INDEX error): A DUP_VAL_ON_INDEX error occurred.It should provide this message if any other type of error occurs: An unknown exception occurred.*/
SET SERVEROUTPUT ON;
BEGIN
  insert_glaccount(221, 'Speedwagon Foundation');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('ERROR: DUPLICATE ENTRY NOT ALLOWED!');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('AN UNKNOWN EXCEPTION OCCURRED');
END;
/

/* Question 3
Code a function named test_glaccounts_description that accepts one parameter that tests whether an account description is already in the General_Ledger_Accounts table. 
This function should return a value of 1 if the account description is in the table or zero if it isn’t. (Note: If a SELECT statement doesn’t return any data, it throws a 
NO_DATA_FOUND exception that your function can handle.)*/

create or replace FUNCTION test_glaccounts_description
(
    accDescParam VARCHAR2
)
RETURN NUMBER
AS
    account_desc_var NUMBER;
BEGIN
    SELECT account_number
    INTO account_desc_var
    FROM general_ledger_accounts
    WHERE account_description = accDescParam;
    
    IF account_desc_var IS NOT NULL THEN
        account_desc_var := 1;
    ELSE
        account_desc_var := 0;
    END IF;
    
    RETURN account_desc_var;   

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
        RETURN account_desc_var;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UNKNOWN ERROR HAS OCCURRED');
        RETURN account_desc_var;
END;
/

/* Question 4
Code a script that calls the function that you created in exercise 3. This script should display this message if the account description is in the table: Account description is already in use. 
It should provide this message if any other type of error occurs: Account description is available.*/
/*
    reference for the code
    https://www.techonthenet.com/oracle/questions/exec_function.php
    http://www.dba-oracle.com/t_calling_oracle_function.htm
**/
SET SERVEROUTPUT ON;
DECLARE
is_available NUMBER;
BEGIN
    is_available := test_glaccounts_description('Speedwagon Foundation');
    IF is_available = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Account Description is already in use.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account Description is available');
    END IF;
END;
/
