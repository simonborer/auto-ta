-------------------------------
-- ASSIGNMENT 6              --
-- NAME:           Rabih Aoun--
-- STUDENT NUMBER: N01329942 --
-------------------------------
-- Question 1 --

CREATE OR REPLACE PROCEDURE insert_glaccount
(
    account_number_param        general_ledger_accounts.account_number%TYPE,
    account_description_param   general_ledger_accounts.account_description%TYPE
    
)
AS
BEGIN
    INSERT INTO general_ledger_accounts(
        account_number,
        account_description
    )
    VALUES(
        account_number_param,
        account_description_param
    );
    COMMIT;


END;
/
CALL insert_glaccount(222,'Book Calculation');

-- Question 2 --
CREATE OR REPLACE PROCEDURE insert_glaccount
(
    account_number_param        general_ledger_accounts.account_number%TYPE,
    account_description_param   general_ledger_accounts.account_description%TYPE
    
)
AS
BEGIN
    INSERT INTO general_ledger_accounts(
        account_number,
        account_description
    )
    VALUES(
        account_number_param,
        account_description_param
    );
    exception
     when dup_val_on_index then
        dbms_output.put_line('oops:'||sqlerrm);
        rollback;
END;
/
CALL insert_glaccount(222,'Book Calculation');

-- Question 3 --

CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    account_description_param general_ledger_accounts.account_description%TYPE
)
return NUMBER
AS var_status NUMBER
BEGIN
    SELECT 1 into var_status
        from general_ledger_accounts
        WHERE account_description = account_description_param;
    return var_status;
EXCEPTION
    WHEN no_data_found THEN
    var_status := 0;
    return var_status;
END;    
/







