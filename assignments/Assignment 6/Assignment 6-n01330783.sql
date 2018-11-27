--Jetalbahen Tandel
--Assignment 6
--Que 1

CREATE OR REPLACE PROCEDURE insert_glaccount
(
  acc_number_new      NUMBER,
  acc_description_new  VARCHAR2
)
AS 
BEGIN
  INSERT INTO general_ledger_accounts
  VALUES (acc_number_new,acc_description_new);
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

END;


CALL insert_glaccount(500,'cable services');

--Jetalbahen Tandel
--Assignment 6
--Que 2

SET SERVEROUTPUT ON;
BEGIN
  insert_glaccount(500,'cable services');
  COMMIT;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
   WHEN OTHERS THEN
        DBMS_OUTPUT.PUT('An unknown exception occurerd. ');
END;
/


--Jetalbahen Tandel
--Assignment 6
--Que 3
--reference from stackoverflow

CREATE OR REPLACE FUNCTION test_glaccounts_description
(
  acc_description VARCHAR2
)
RETURN NUMBER AS
 acc_number general_ledger_accounts.account_number%TYPE;
BEGIN
  SELECT account_number INTO acc_number
  FROM general_ledger_accounts
  WHERE account_description=acc_description;
  IF SQL%ROWCOUNT =1 THEN
   RETURN 1;
  END IF;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;


--Jetalbahen Tandel
--Assignment 6
--Que 4

SET SERVEROUT ON

BEGIN
 IF test_glaccounts_description('Internet')=1 THEN
  DBMS_OUTPUT.PUT_LINE('Account description is already in use');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Account description is available');
END IF;
END;
