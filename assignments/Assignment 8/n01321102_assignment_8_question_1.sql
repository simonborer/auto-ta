-- Question 1
CREATE OR REPLACE PROCEDURE insert_product_item (
    item_id_param NUMBER,
    item_desc_param VARCHAR2,
    item_type_param VARCHAR2,
    item_price_param product_items.item_price%TYPE,
    prod_ing_param VARCHAR2,
    prod_cost_param product_items.production_cost%TYPE,
    prod_time_param product_items.production_time%TYPE,
    prod_qty_param NUMBER,
    oven_space_param NUMBER,
    num_batch_param NUMBER,
    prod_temp_param product_items.production_temp%TYPE
)
AS
BEGIN
    INSERT INTO product_items VALUES (
        item_id_param, 
        item_desc_param, 
        item_type_param, 
        item_price_param, 
        prod_ing_param, 
        prod_cost_param, 
        prod_time_param,
        prod_qty_param, 
        oven_space_param, 
        num_batch_param, 
        prod_temp_param
    );

COMMIT;
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An Undefined Error has occurred');
END;