--Nick Vakulov n01301380--
--Q1 and Q2--
CREATE OR REPLACE PROCEDURE insert_glaccount
(
    insert_account_number        general_ledger_accounts.account_number%TYPE,
    insert_account_description   general_ledger_accounts.account_description%TYPE
)
IS 
CURSOR c1 IS
   SELECT COUNT(account_number)
   FROM general_ledger_accounts
   WHERE account_number = insert_account_number;
i number;
BEGIN
    OPEN c1;
    FETCH c1 INTO i;
    IF (i > 0 ) THEN
    RAISE VALUE_ERROR;
    END IF;
    INSERT INTO general_ledger_accounts
    VALUES(insert_account_number, insert_account_description);
COMMIT;
END;
--Calling our procedure--
SET SERVEROUTPUT ON;
BEGIN
insert_glaccount(1000, 'TEST'); 
EXCEPTION 
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;

DELETE FROM general_ledger_accounts
WHERE account_number = 1000;

select * from general_ledger_accounts
order by account_number

--Q3 and Q4--
CREATE OR REPLACE FUNCTION test_glaccounts_description(insert_account_description VARCHAR2 )
RETURN VARCHAR2
AS
  numb VARCHAR2(50);
BEGIN 
numb:=0;
  SELECT COUNT(account_description)
  INTO numb
  FROM general_ledger_accounts
  WHERE account_description = insert_account_description;
  IF numb > 0 THEN
    numb:=1;
--I don't know why, but if i type 'RAISE VALUE_ERROR' it says that function-- 
--returns without value, but I printed numb and it has value. Can you explain me this case?--
    DBMS_OUTPUT.PUT_LINE(numb);
    RAISE VALUE_ERROR;
    ELSE
    DBMS_OUTPUT.PUT_LINE(numb);
     END IF;
  RETURN numb; 
  
  EXCEPTION 
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;


SELECT  COUNT(account_description)
FROM general_ledger_accounts
WHERE account_description = test_glaccounts_description('State Corporation Income Taxes')
