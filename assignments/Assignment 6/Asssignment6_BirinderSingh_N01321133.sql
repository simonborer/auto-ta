/*1*/
create or replace PROCEDURE insert_glaccount
(
    act_number                IN      INTEGER,
    act_description           IN      VARCHAR2
)
AS
BEGIN
    INSERT into general_ledger_accounts (account_number,account_description) 
    VALUES (act_number,act_description);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
END;


/*2*/
SET SERVEROUTPUT ON;
BEGIN
    insert_glaccount(act_number=>999,act_description=>'Something Special');
EXCEPTION
    WHEN dup_val_on_index THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred');
    ROLLBACK;
END;


/*3*/
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
  act_description general_ledger_accounts.account_description%TYPE 
)
RETURN NUMBER
AS
  resultvar NUMBER DEFAULT 0;
BEGIN 
    SELECT count(*)
    into resultvar
    FROM general_ledger_accounts
    WHERE account_description = act_description;
    return resultvar;  
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Description Found'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Some other error');  
END;

/*4*/
SET SERVEROUTPUT ON;
DECLARE
    resultvar NUMBER;
BEGIN 
    SELECT test_glaccounts_description('SXYSl') 
    INTO resultvar
    FROM DUAL;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account description is available.'); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Account description is already in use.');  
END;

