/* Ryan Robinson - Assignement 6 - Question 1 */
CREATE OR REPLACE PROCEDURE insert_glaccount
(
    account_number_param         NUMBER,
    account_description_param    VARCHAR2
)
AS
BEGIN
    INSERT INTO general_ledger_accounts
    VALUES (account_number_param, account_description_param);
    COMMIT;
END;
/
CALL insert_glaaccount(404,'The Pizza Store');

/* Ryan Robinson - Assignement 6 - Question 2 */
SET SERVEROUT ON;
BEGIN
    insert_glaccount
    (
    account_description_param => 'The Pizza Plaza',
    account_number_param => 405
    );
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('This value is already in the table, no duplicates.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error has occurred.');
END;
/

/* Ryan Robinson - Assignement 6 - Question 3 */
CREATE OR REPLACE FUNCTION test_glaccounts_description
(
    account_description_param     VARCHAR2
)
RETURN NUMBER
AS
    description_duplicate      NUMBER;
BEGIN
    SELECT 1
    INTO description_duplicate
    FROM general_ledger_accounts
    WHERE account_description = account_description_param;
    RETURN description_duplicate;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

/* Ryan Robinson - Assignement 6 - Question 4 */
SET SERVEROUTPUT ON;

BEGIN
    IF test_glaccounts_description('Pizza Time') = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Account description is already in use.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account description is available.');
    END IF;
END;
/
        