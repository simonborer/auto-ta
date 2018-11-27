CREATE OR REPLACE PROCEDURE insert_glaccount
(
account_number_in  NUMBER,
account_description_in VARCHAR2
)
AS
BEGIN
    UPDATE general_ledger_accounts
    SET account_description = account_description_in
    WHERE account_number = account_number_in;

COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
END;
/*CALL STATEMENT*/
CALL insert_glaccount('777', 'just a test');
/*2*/
BEGIN
insert_glaccount ('888', 'TESTING');
END;
/*3*/
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    account_description_compare VARCHAR2
)
RETURN NUMBER
AS
account_test    NUMBER;
BEGIN

    SELECT 1 
    INTO account_test
    FROM general_ledger_accounts
    WHERE account_description = account_description_compare;
    RETURN account_test;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 0;
COMMIT;
END;
/*4*/
BEGIN
IF test_glaccounts_description('Accounting') = 1 THEN
DBMS_OUTPUT.PUT_LINE('Account description is already in use');
ELSE
DBMS_OUTPUT.PUT_LINE('Account description is available');
END IF;
END;
/*Note: I am not confident that I did all of these correctly
and would like to go over them in class*/
