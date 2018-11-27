Assignment 6- Jobanjit Singh
n01302646
--Que 1
CREATE OR REPLACE PROCEDURE insert_glaccount  
(
    Account_Number_param number,
    account_desc_param varchar2
)
AS

BEGIN
   Insert into general_ledger_accounts 
   Values(Account_Number_param,account_desc_param);
COMMIT;
END;
/

CALL insert_glaccount(511,'My demo Ledger entry');

--Que2
SET SERVEROUTPUT ON;
BEGIN 
    insert_glaccount(511,'My demo Ledger entry');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
END;
/

--Que 3
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
  account_desc_param VARCHAR2
)
RETURN NUMBER
AS 
  count_do_Entry_exists NUMBER;
BEGIN 
  SELECT count(account_description)
  INTO count_do_Entry_exists
  FROM General_Ledger_Accounts
  WHERE account_description = account_desc_param;
 
  RETURN count_do_Entry_exists;
END;
/

Select  test_glaccounts_description('Utilities1') from dual

-- No need to check for exception because count on (account_description) returns 0 if their is no entry for given (account_description).
-- Also (account_description) doesn't allow duplicate entry so no need to check for multiple entries. 
--So count will alwys return either 0 or 1 satisfying the question description

Que 4

SET SERVEROUTPUT ON;
BEGIN 
    IF(test_glaccounts_description('Utilities') = 1)
    THEN
        DBMS_OUTPUT.PUT_LINE('Account description is already in use');
    END IF;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Account description is available.');
END;
/
