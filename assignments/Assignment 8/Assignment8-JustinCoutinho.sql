/*Question 1*/
CREATE OR REPLACE PROCEDURE add_menu
(
item_id_in  NUMBER,
product_in VARCHAR2
)
AS
BEGIN
    UPDATE bakery_menu
    SET item_id = item_id_in
    WHERE product = product_in;

COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
END;

/*Question 2*/
CREATE OR REPLACE PROCEDURE products_and_prices
(
    product_in VARCHAR,
    price_in NUMBER
)
AS 
low_prices VARCHAR2;
BEGIN
    SELECT product, price
    INTO low_prices
    FROM bakery_menu
    WHERE product = product_in;
    
    RETURN low_prices;
END;

/*Anonymous SQL Block*/
SET SERVEROUTPUT ON 
DECLARE
discount_price INTEGER := 2;
product_name VARCHAR2(20) := 'Muffins';
product_10_1 VARCHAR2(20) := 'Pastel de nata $1';
product_10_2 VARCHAR2(20) := 'Sweet bread loafs $8';
products_and_prices VARCHAR2(20);
BEGIN
DBMS_OUTPUT.PUT_LINE('Weekly special: ' ||product_name|| ' are only $' ||discount_price);
DBMS_OUTPUT.PUT_LINE('Take 10% off ' ||product_10_1|| ' and ' ||product_10_2);
DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices ' || products_and_prices);
END;

    