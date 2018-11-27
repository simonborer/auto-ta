/*Assignment 8 Ryan Robinson Question 1.*/
CREATE OR REPLACE PROCEDURE insert_menu_items
(
    menu_item_id_param     IN  NUMBER,
    menu_item_price_param  IN  NUMBER,
    menu_item_name_param   IN  VARCHAR2,
    discount_param         IN  NUMBER
)
AS
BEGIN
    INSERT INTO menu_items(menu_item_id, menu_item_price, menu_item_name, discount)
    VALUES(menu_item_id_param, menu_item_price_param, menu_item_name_param, discount_param);
    COMMIT;
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The wrong data type has been entered.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error has occured.');
END;
/*Assignment 8 Ryan Robinson Question 2.*/
CONNECT ap/ap

SET SERVEROUTPUT ON;

DECLARE
    discounted_price     NUMERIC(4,2);
    discount_rate        NUMERIC(3,2);
    discounted_item      VARCHAR2(20);
BEGIN 
    SELECT ROUND((menu_item_price * discount),2), discount, menu_item_name
    INTO discounted_price, discount_rate, discounted_item
    FROM menu_items
    WHERE discount > 0;
    
    DBMS_OUTPUT.PUT_LINE('');
END;
/