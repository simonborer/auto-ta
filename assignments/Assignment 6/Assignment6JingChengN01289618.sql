//Jing Cheng
//n01289618
//Question 1
CREATE OR REPLACE PROCEDURE insert_glaccount
(
  account_number_param IN NUMBER,
  account_description_param IN VARCHAR2
)
AS
BEGIN
  INSERT INTO general_ledger_accounts(account_number, account_description)
  VALUES(account_number_param, account_description_param);
  
  COMMIT;
  EXCEPTION
  WHEN OTHERS THEN 
  ROLLBACK;
END;

CALL insert_glaccount(633, 'Jings hotdog fees');

SELECT * FROM general_ledger_accounts
ORDER BY account_number DESC

//Question 2
SET SERVEROUTPUT ON;

BEGIN 
  insert_glaccount
  (
  account_number_param => 633,
  account_description_param => 'Jings hotdog fees'
  );
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;
/

SELECT * FROM general_ledger_accounts
ORDER BY account_number DESC

//Question 3
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
  account_description_check VARCHAR2
)
RETURN NUMBER
AS 
  account_description_duplicate NUMBER;
BEGIN
  SELECT 1
  INTO account_description_duplicate
  FROM general_ledger_accounts
  WHERE account_description = account_description_check;
  RETURN account_description_duplicate;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;
/

//Question 4
BEGIN
  IF test_glaccounts_description('Jings hotdog fees') = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Account description is already in use');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Account description is available');
  END IF;
END;
/