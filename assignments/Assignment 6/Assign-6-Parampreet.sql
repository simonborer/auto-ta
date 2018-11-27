--Assignment 6
--Parampreet Singh Grewal N01305919

--1 Parampreet N01305919
CREATE OR REPLACE PROCEDURE  insert_glaccount(
latest_account_number NUMBER,
latest_account_description VARCHAR
)
AS BEGIN
INSERT INTO general_ledger_accounts 
VALUES(latest_account_number,latest_account_description);
COMMIT;
END;
/
CALL insert_glaccount(1996,'PARAM ACCOUNT');


--2 Parampreet N01305919
SET SERVEROUTPUT ON
BEGIN
insert_glaccount(1996, 'PARAM ACCOUNT'); --i insert this in que 1
COMMIT;
EXCEPTION
WHEN dup_val_on_index 
THEN dbms_output.put_line( 'A DUP_VAL_ON_INDEX error occurred.' );
ROLLBACK;
WHEN OTHERS 
THEN dbms_output.put_line( 'An unknown exception occurred.' );
ROLLBACK;
END;
/


--3 Parampreet N01305919
CREATE OR REPLACE FUNCTION test_glaccounts_description(
latest_account_description VARCHAR
)
RETURN NUMBER IS
test_condition general_ledger_accounts.account_number%TYPE;
BEGIN
SELECT account_number 
INTO test_condition 
FROM general_ledger_accounts 
WHERE account_description = latest_account_description;
IF SQL%ROWCOUNT = 1  --refered from https://sqlpatterns.wordpress.com/2017/06/03/using-sqlrowcount-with-dynamic-plsql/
THEN
RETURN  1;
END IF;   
EXCEPTION  
WHEN NO_DATA_FOUND 
THEN
RETURN  0;
END;
/


--4 Parampreet N01305919
SET  SERVEROUTPUT  ON
BEGIN
IF  test_glaccounts_description ('Accounts Receivable')= 1 --account recievable is a value from table
THEN
dbms_output.put_line( 'Account description is already in use' );
ELSE
dbms_output.put_line( 'Account description is available' );  
END IF;  
END;
