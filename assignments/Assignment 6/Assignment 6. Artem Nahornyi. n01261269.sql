/*  1. Create a stored procedure named insert_glaccount that lets a user add a new row to the general_ledger_accounts table. 
This procedure should have two parameters, one for each of the two columns in this table. Then, code a CALL statement that 
tests the procedure. (Note that this table doesn’t allow duplicate account descriptions.)*/
CREATE OR REPLACE PROCEDURE insert_glaccount(
	account_number_param        NUMBER,
	account_description_param   VARCHAR2
)
AS
BEGIN
	INSERT INTO general_ledger_accounts
	VALUES (account_number_param, account_description_param);
	COMMIT;
END;
/
CALL insert_glaccount(633, 'Sales Tax 2');
--======================================================
SELECT *
FROM general_ledger_accounts
ORDER BY account_number
--======================================================

/*  2. Code a script that calls the procedure that you created in exercise 1 and passes the parameters by name. 
This procedure should provide exception handling that displays this message if the INSERT statement fails because
the account number or account description is already in the table (a DUP_VAL_ON_INDEX error): A DUP_VAL_ON_INDEX
error occurred.It should provide this message if any other type of error occurs: An unknown exception occurred.*/
SET SERVEROUTPUT ON
BEGIN
   insert_glaccount(account_number_param => 632, account_description_param => 'Sales Tax 3');
   insert_glaccount(account_number_param => 100, account_description_param => 'Sales Tax');
  COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
    ROLLBACK;
END;
/
/*  3. Code a function named test_glaccounts_description that accepts one parameter that tests whether an account
description is already in the General_Ledger_Accounts table. This function should return a value of 1 if the account
description is in the table or zero if it isn’t. (Note: If a SELECT statement doesn’t return any data, it throws a
NO_DATA_FOUND exception that your function can handle.)*/
CREATE OR REPLACE FUNCTION test_glaccounts_description(param1  VARCHAR2)
RETURN NUMBER
AS
  var_number NUMBER;
  var_rows NUMBER;
BEGIN
  SELECT account_number 
  INTO var_number 
  FROM general_ledger_accounts 
  WHERE account_description = param1;
  
  var_rows := SQL%ROWCOUNT;
  
  IF var_rows = 1 THEN
    var_number := 1;
    RETURN var_number;
  END IF;   
EXCEPTION  
  WHEN NO_DATA_FOUND THEN
    var_number := 0;
    RETURN var_number;
END;
/
--=========================================================================

/*4. Code a script that calls the function that you created in exercise 3.
This script should display this message if the account description is in the table: Account description
is already in use. It should provide this message if any other type of error occurs: Account description is available. */
SET SERVEROUTPUT ON
BEGIN
  IF test_glaccounts_description('Accounting') = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Available!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Already in use!');  
  END IF;  
  
  IF test_glaccounts_description('GTA Pro') = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Available!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Already in use!');  
  END IF;  
 END; 
 /
--=========================================================================
SELECT * FROM GENERAL_LEDGER_ACCOUNTS
