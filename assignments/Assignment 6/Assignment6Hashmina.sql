SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE insert_glaccount 
(
    /*  our parameters - the options we'll pass in when 
        we call the procedure */
    account_number_new   NUMBER ,
    account_description_new VARCHAR2     
)
AS
/* Define the procedure as PL/SQL code */
BEGIN
    UPDATE general_ledger_accounts
    SET account_number = account_number_new
    WHERE account_description = account_description_new;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CALL insert_glaccount(541, 'Space Advertising');



BEGIN

insert_glaccount(account_number_new ,
    account_description_new);
        
EXCEPTION
    /*IF( account_number = account_number_new && 
    accout_description=account_desprption_new)
    THEN
    DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occured');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('An unknown exception occured'); */
    
    
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occured');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
    
    /*END IF;*/
    
END;
/


CREATE OR REPLACE FUNCTION test_glaccount_description 
(
    /*  our parameters - the options we'll pass in when 
        we call the procedure */
    account_description_test general_ledger_accounts.account_description%TYPE 
         
)
RETURN NUMBER
AS
  account_des_test NUMBER;
BEGIN 
  SELECT account_description
  INTO account_des_test
  FROM general_ledger_accounts
  WHERE account_description = account_des_test;
  
IF( account_description = account_des_test) THEN
        RETURN 1;
ELSE  
        RETURN 0;
 END IF; 
END;
/


BEGIN

test_glaccount_description(account_description_test);
        
EXCEPTION
    IF( account_description = account_escription_test )
    THEN
    DBMS_OUTPUT.PUT_LINE('Account description already in use');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('Account description is available'); 
    
    
    END IF;
    
END;
/




