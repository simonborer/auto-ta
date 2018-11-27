/* Assignment 6
   Name: Raymond Giang
   Student Number: n01304390 */
   
/* 1. Create a stored procedure named insert_glaccount that lets a user add a new row to the general_ledger_accounts table. 
This procedure should have two parameters, one for each of the two columns in this table. Then, code a CALL statement that 
tests the procedure. (Note that this table doesn’t allow duplicate account descriptions.) */

CREATE OR REPLACE PROCEDURE insert_glaccount
(
    account_num_to_insert     general_ledger_accounts.account_number%TYPE,
    account_desc_to_insert    general_ledger_accounts.account_description%TYPE
)
AS
BEGIN
    INSERT INTO general_ledger_accounts(account_number, account_description)
    VALUES(account_num_to_insert, account_desc_to_insert);
    
    COMMIT;
END;
/

CALL insert_glaccount(1000, 'Test Account');

/* 2. Code a script that calls the procedure that you created in exercise 1 and passes the parameters by name. This procedure 
should provide exception handling that displays this message if the INSERT statement fails because the account number or 
account description is already in the table (a DUP_VAL_ON_INDEX error): A DUP_VAL_ON_INDEX error occurred. It should provide 
this message if any other type of error occurs: An unknown exception occurred. */

SET SERVEROUTPUT ON;

BEGIN 
    insert_glaccount(
        account_num_to_insert => 1000, 
        account_desc_to_insert => 'Test Account'
    );
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred');
END;
/

/* 3. Code a function named test_glaccounts_description that accepts one parameter that tests whether an account description 
is already in the General_Ledger_Accounts table. This function should return a value of 1 if the account description is in 
the table or zero if it isn’t. (Note: If a SELECT statement doesn’t return any data, it throws a NO_DATA_FOUND exception 
that your function can handle.) */

CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    account_description_param   general_ledger_accounts.account_description%TYPE
)
RETURN NUMBER
AS
    return_val NUMBER;
BEGIN 
    SELECT 1
    INTO return_val
    FROM general_ledger_accounts 
    WHERE account_description = account_description_param;
    RETURN return_val;
   
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    return_val := 0;
    RETURN return_val;
END;
/

/* 4. Code a script that calls the function that you created in exercise 3. This script should display this message if the 
account description is in the table: Account description is already in use. It should provide this message if any other type 
of error occurs: Account description is available. */

SET SERVEROUTPUT ON;

DECLARE
    search_result   NUMBER;
BEGIN 
    SELECT test_glaccounts_description('&account_description')
    INTO search_result
    FROM dual;
    
    IF search_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Account description is already in use.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account description is available.');
    END IF;
END;
/
