--Khushboo Umrigar--
--Section B--
--Assignment- (6)--
--QuestionNo(1)--
CREATE OR REPLACE PROCEDURE insert_glaccount
(
AC_number_param NUMBER,
AC_description_param VARCHAR2   
)
AS 
BEGIN
INSERT INTO general_ledger_accounts
values(AC_number_param,AC_description_param);
COMMIT;
END;
/
CALL insert_glaccount(2,'values');

--Khushboo Umrigar--
--Section B--
--Assignment- (6)--
--QuestionNo(2)--
SET SERVEROUTPUT ON
BEGIN
  insert_glaccount(2, 'values');
  insert_glaccount(3, 'values2'); 
  insert_glaccount(4, 'values3');
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

--Khushboo Umrigar--
--Section B--
--Assignment- (6)--
--QuestionNo(3)--
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
RECENT_account_description VARCHAR
)
RETURN NUMBER IS
condition_to_be_check general_ledger_accounts.account_number%TYPE;
BEGIN
SELECT account_number 
INTO condition_to_be_check 
FROM general_ledger_accounts 
WHERE account_description = RECENT_account_description;
IF SQL%ROWCOUNT = 1  
THEN
RETURN  1;
END IF;   
EXCEPTION  
WHEN NO_DATA_FOUND 
THEN
RETURN  0;
END;
/
--Khushboo Umrigar--
--Section B--
--Assignment- (6)--
--QuestionNo(4)--
SET SERVEROUT ON
BEGIN
IF test_glaccounts_description ('IN TABLE')= 1 
THEN
dbms_output.put_line ('account description is already in use');
ELSE
dbms_output.put_line ('account description is available');  
END IF;
IF  test_glaccounts_description ('IN TABLE')= 0 
THEN
dbms_output.put_line ('account description is already in use');
ELSE
dbms_output.put_line ('account description is available');  
END IF;   
END;
/