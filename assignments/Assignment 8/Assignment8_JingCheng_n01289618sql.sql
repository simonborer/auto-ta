//Assignment 8 Jing Cheng n01289618
//Question 1
CREATE OR REPLACE PROCEDURE add_menu_items
(
  item_id_param NUMBER,
  item_name_param VARCHAR2,
  price_param NUMBER,
  cost_of_ingredients_param NUMBER,
  baking_time_param NUMBER,
  prep_time_param NUMBER,
  oven_space_param NUMBER,
  temp_param NUMBER  
)

AS
BEGIN
  INSERT INTO bakery_items(item_id, item_name, price, cost_of_ingrdients, baking_time, prep_time, oven_space, temp)
  VALUES(item_id_param, item_name_param, price_param, cost_of_ingredients_param, baking_time_param, prep_time_param, oven_space_param, temp_param);
  COMMIT;
EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('A value error occurred');
  WHEN OTHERS THEN
    ROLLBACK;
END;

//Question 2
CREATE TABLE bakery_discounts (
    discount_id     NUMBER  PRIMARY KEY,
    week_starting   DATE,
    major_discount  NUMBER REFERENCES menu_items(menu_item_id),
    minor_discounts NUMBER REFERENCES menu_items(menu_item_id)
);

INSERT INTO bakery_discounts(discount_id, week_starting, major_discount, minor_discounts)
VALUES(1, 01-11-2018, 1, 2)

INSERT INTO bakery_discounts(discount_id, week_starting, major_discount, minor_discounts)
VALUES(2, 08-11-2018, 2, 1)

INSERT INTO menu_items(menu_item_id, menu_item_name, menu_item_price, menu_item_ingredient_cost, menu_item_baking_time, 
menu_item_prep_time, menu_item_baking_temp, menu_item_req_space, menu_item_desc)
VALUES(1, 'Rye Bread', 5, 2, 3, 1, 250, 1, 'Loaf')

INSERT INTO menu_items(menu_item_id, menu_item_name, menu_item_price, menu_item_ingredient_cost, menu_item_baking_time, 
menu_item_prep_time, menu_item_baking_temp, menu_item_req_space, menu_item_desc)
VALUES(2, 'White Bread', 5, 2, 3, 1, 250, 1, 'Loaf')

SELECT * FROM menu_items

INSERT INTO bakery_discount(discount_id, week_starting, major_discount, minor_discounts)
VALUES(1, TO_DATE('2018/11/18', 'YYYY/MM/DD'), 1, 2)

SELECT * FROM bakery_discount

CREATE OR REPLACE PROCEDURE output_bakery_discounts
(
  major_discounted_item VARCHAR2,
  major_discounted_item_price NUMBER,
  minor_discounted_item VARCHAR2,
  minor_discounted_item_price NUMBER
)
AS
BEGIN
  SELECT menu_item_name
  INTO major_discounted_item
  FROM menu_items mi
  INNER JOIN bakery_discount bd
  ON bd.major_discount = mi.menu_item_id
  WHERE bd.week_starting = TO_DATE('2018/11/18', 'YYYY/MM/DD');
  
  SELECT menu_item_price
  INTO major_discounted_item_price
  FROM menu_items mi
  INNER JOIN bakery_discount bd
  ON bd.major_discount = mi.menu_item_id
  WHERE bd.major_discount = mi.menu_item_id;
  
  SELECT menu_item_name
  INTO minor_discounted_item
  FROM menu_items mi
  INNER JOIN bakery_discount bd
  ON bd.minor_discount = mi.menu_item_id
  WHERE bd.week_starting = TO_DATE('2018/11/18', 'YYYY/MM/DD');
  
  SELECT menu_item_price
  INTO minor_discounted_item_price
  FROM menu_items mi
  INNER JOIN bakery_discount bd
  ON bd.minor_discount = mi.menu_item_id
  WHERE bd.minor_discount = mi.menu_item_id;
  
  dbms_output.put_line('This weeks special: '|| major_discounted_item || ' is only' || (major_discounted_item_price*.8));
  dbms_output.put_line('Take 10% off ' || minor_discounted_item || (minor_discounted_item_price * .9);
  dbms_output.put_line('Check out our everyday low prices');
  COMMIT;
END;
/
