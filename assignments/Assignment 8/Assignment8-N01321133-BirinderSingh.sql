/*1*/
CREATE OR REPLACE PROCEDURE insert_into_bakery
(
    item_id             NUMBER,
    item_name           VARCHAR2,
    price               NUMBER,
    cost_of_ingredients NUMBER,
    baking_time         NUMBER,
    prep_time           NUMBER,
    oven_space          NUMBER,
    temp                NUMBER
)
AS
BEGIN
    INSERT INTO
    bakery_items VALUES(item_id,item_name,price,cost_of_ingredients,baking_time,prep_time,oven_space,temp);   
    COMMIT;
EXCEPTION
    WHEN ROWTYPE_MISMATCH THEN
        DBMS_OUTPUT.PUT_LINE('Check DataType of values entered');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
END;

/*2*/

CREATE OR REPLACE PROCEDURE display_discounted_menu(
    item_name OUT varchar2,
    item_price OUT NUMBER
)
AS
BEGIN
    SELECT bakery_items.item_name,bakery_items.price INTO item_name,item_price
    FROM bakery_discount LEFT JOIN bakery_items
    ON bakery_discount.major_discount = bakery_items.item_id
    WHERE bakery_discounts.week_starting=(select trunc(sysdate,'IW') from dual); /*https://asktom.oracle.com/pls/apex/asktom.search?tag=first-date-of-weekmonday-date */
    
    DBMS_OUTPUT.PUT_LINE('This weeks special:' || item_name || 'is only ' || item_price*.8 || '!');

    SELECT bakery_items.item_name,bakery_items.price INTO item_name,item_price
    FROM bakery_discount LEFT JOIN bakery_items
    ON bakery_discount.minor_discounts = bakery_items.item_id
    WHERE bakery_discounts.week_starting=(select trunc(sysdate,'IW') from dual); /*https://asktom.oracle.com/pls/apex/asktom.search?tag=first-date-of-weekmonday-date */

    DBMS_OUTPUT.PUT_LINE('Take 10% off:' || item_name || ' ' || item_price*.9 || 'and' || item_name || ' ' || item_price*.9);
    DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices:' || chr(10));

    FOR cursor1 IN (SELECT * FROM bakery_items) 
          LOOP
            DBMS_OUTPUT.PUT_LINE(cursor1.item_name || '  ' || cursor1.price || chr(10));
          END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown error occurred');
END;