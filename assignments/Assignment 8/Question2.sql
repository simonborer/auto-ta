-- I had a lot of trouble with the dates here and bascially ran out of time so I couldn't get this to run properly.
-- Hopefully you can at least follow my logic. I know that I should use a cursor to cycle through my menu and print out the prices
-- of the other items, but I wasn't sure/didn't have time to test out how I would filter out the discounted items.

SET SERVEROUTPUT ON;
DECLARE
item_name_var_1   VARCHAR2(30);
item_price_var_1  NUMBER(4,2);
item_name_var_2   VARCHAR2(30);
item_price_var_2  NUMBER(4,2);
item_name_var_3   VARCHAR2(30);
item_price_var_3  NUMBER(4,2);
major_discount_var  NUMBER;
minor_discount_var  NUMBER;
minor_discount_var_2  NUMBER;



BEGIN

SELECT major_discount_week, item_name, item_price
INTO major_discount_var, item_name_var_1, item_price_var_1
FROM bakery_items
WHERE major_discount_var = TO_NUMBER(TO_CHAR(sysdate,'iw'));
DBMS_OUTPUT.PUT_LINE("This week's special item is " + item_name_var_1 + "at a discounted price of " (item_price_var_2*1.2) );

SELECT minor_discount_week_1, item_name, item_price
INTO minor_discount_var, item_name_var_2, item_price_var_2
FROM bakery_items
WHERE minor_discount_var = TO_NUMBER(TO_CHAR(sysdate,'iw'));
DBMS_OUTPUT.PUT_LINE("This week's minor discount 1 is " + item_name_var_2 + "at a discounted price of " (item_price_var_2*1.1));

SELECT minor_discount_week_2, item_name, item_price
INTO minor_discount_var_2, item_name_var_3, item_price_var_3
FROM bakery_items
WHERE minor_discount_var_2 = TO_NUMBER(TO_CHAR(sysdate,'iw'));
DBMS_OUTPUT.PUT_LINE("This week's minor discount 2 is " + item_name_var_3 + "at a discounted price of " (item_price_var_3*1.1));
END;
/