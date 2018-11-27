--ASSIGNMENT-6--
--BINITA PATEL--
--N01283919--

--1--
CREATE OR REPLACE PROCEDURE insert_glaccount
(
  i_number NUMBER,
  i_desc VARCHAR2
)

AS 

BEGIN 
    INSERT into general_ledger_accounts
    VALUES(i_number,i_desc);
    COMMIT;
END;
/

CALL insert_glaccount(1000,'new1');


--2--

SET SERVEROUTPUT ON
BEGIN
    insert_glaccount(1000,'new1');
    insert_glaccount(1001,'new2');
    COMMIT;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occured');
    ROLLBACK;
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('An unknown exception occurs');
  ROLLBACK;
END;


--3--
CREATE OR REPLACE FUNCTION test_glaacoounts_description(i_desc VARCHAR2)
RETURN NUMBER IS
    v_number
    general_ledger_accounts.account_number%TYPE;
BEGIN
    SELECT account_number INTO v_number
    FROM general_ledger_accounts
    WHERE account_description=i_desc;
    IF SQL%ROWCOUNT=1 THEN
        RETURN 1;
    END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
       RETURN 0;
END;

--4--
SET SERVEROUTPUT ON
BEGIN
IF test_glaccounts_description('new1')=1 THEN
    DBMS_OUTPUT.PUT_LINE('Account description is already in use');
ELSE
 DBMS_OUTPUT.PUT_LINE('Account description is available');
END IF;

IF test_glaccounts_description('ABC')=1 THEN
    DBMS_OUTPUT.PUT_LINE('Account description is already in use');
ELSE
 DBMS_OUTPUT.PUT_LINE('Account description is available');
END IF;
END;

