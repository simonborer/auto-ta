create or replace PROCEDURE add_bakery_item
(
    item_id_p NUMBER,
    item_name_p VARCHAR2,
    sale_price_p    NUMBER,
    prep_minutes_p NUMBER,
    bake_minutes_p  NUMBER,
    oven_racks_p    NUMBER,
    items_per_batch_p   NUMBER,
    major_p     DATE,
    minor_1_p   DATE,
    minor_2_p   DATE
)
AS
BEGIN
INSERT INTO bakery_items(item_id, item_name, sale_price, prep_minutes, bake_minutes, oven_racks_needed, items_per_batch, major_discount_week, minor_discount_week_1, minor_discount_week_2)
VALUES (item_id_p, item_name_p, sale_price_p, prep_minutes_p, bake_minutes_p, oven_racks_p, items_per_batch_p, major_p, minor_1_p, minor_2_p);
EXCEPTION
WHEN VALUE_ERROR THEN
DBMS_OUTPUT.PUT_LINE('A Value error has occured, please try again');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('An unknown error has occured.');
END;

CALL add_bakery_item (003,'Chocolate Chip Cookie', 1.25, 15, 25, 2, 36, '2018-11-19', '2018-11-26', '2018-12-03');