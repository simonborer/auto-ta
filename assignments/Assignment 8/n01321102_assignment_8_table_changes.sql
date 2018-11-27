ALTER TABLE menu
ADD menu_week DATE;

ALTER TABLE menu
RENAME COLUMN menu_week TO menu_week_start;

ALTER TABLE menu
ADD menu_week_end DATE;

CREATE TABLE item_discounts (
    discount_id NUMBER PRIMARY KEY,
    discount_description VARCHAR2(20) NOT NULL,
    discount_amt NUMBER(3,2)
);

ALTER TABLE menu
RENAME COLUMN menu_item_discount TO discount_id;

ALTER TABLE menu
ADD CONSTRAINT menu_discount_id_fk
FOREIGN KEY (discount_id) REFERENCES item_discounts(discount_id);

CREATE TABLE employee_shift (
    shift_id NUMBER PRIMARY KEY,
    employee_id NUMBER,
    bakery_id NUMBER,
    shift_start_day DATE,
    shift_end_day DATE,
    shift_start_time DATE,
    shift_end_time DATE
);

ALTER TABLE production
ADD production_temp NUMBER(5,2);

ALTER TABLE bakery
MODIFY bakery_name VARCHAR2(100);

ALTER TABLE employee_shift
ADD CONSTRAINT employee_shift_emp_id_fk
FOREIGN KEY (employee_id) REFERENCES employee(employee_id);

ALTER TABLE bakery_transactions
DROP (item_description, item_discount, transaction_total);

ALTER TABLE bakery
DROP CONSTRAINT bakery_location_id_fk;

ALTER TABLE bakery
ADD bakery_address VARCHAR2(100);

ALTER TABLE menu
DROP COLUMN menu_item_price;

ALTER TABLE product_items
DROP CONSTRAINT product_production_id_fk;

ALTER TABLE product_items
DROP COLUMN production_id;

ALTER TABLE product_items
ADD (
    production_description VARCHAR2(100),
    production_cost NUMBER(9,2) NOT NULL,
    production_time NUMBER(2) NOT NULL,
    production_qty NUMBER(5) NOT NULL,
    oven_space NUMBER(2),
    num_of_batches NUMBER(5) DEFAULT 1
);

ALTER TABLE product_items
ADD production_temp NUMBER(5,2);

ALTER TABLE production
DROP CONSTRAINT production_item_id_fk;

ALTER TABLE production
DROP COLUMN item_id;

ALTER TABLE product_items
RENAME COLUMN production_description TO production_ingredients;

ALTER TABLE bakery
DROP COLUMN location_id;

DROP TABLE bakery_location;

DROP TABLE production;

/*** Insert data on tables ***/
-- EMPLOYEE_TYPE
INSERT INTO employee_type VALUES (
  1, 'BAKER'  
);

INSERT INTO employee_type VALUES (
  2, 'CASHIER'
);

-- EMPLOYEE
INSERT INTO employee VALUES (
  1, 'Clayton', 'Bigsby', 1  
);

INSERT INTO employee VALUES (
  2, 'Rick', 'James', 1  
);

INSERT INTO employee VALUES (
  3, 'Tyrone', 'Biggums', 1  
);

INSERT INTO employee VALUES (
  4, 'Tron', 'Carter', 2  
);

INSERT INTO employee VALUES (
  5, 'Chuck', 'Taylor', 2  
);

INSERT INTO employee VALUES (
  6, 'Leonard', 'Washington', 2  
);

-- BAKERY
INSERT INTO bakery VALUES (
  1, 'Delectable Doughbreads Done Dirt Cheap BW', '123 Bloor West'  
);

INSERT INTO bakery VALUES (
  2, 'Delectable Doughbreads Done Dirt Cheap Dufferin', '456 Dufferin Street'  
);

INSERT INTO bakery VALUES (
  3, 'Delectable Doughbreads Done Dirt Cheap Parkdale', '789 Parkdale'  
);

-- BAKERY_EMPLOYEE
INSERT INTO bakery_employee VALUES (
  1, 1, 1
);

INSERT INTO bakery_employee VALUES (
  2, 1, 4
);

INSERT INTO bakery_employee VALUES (
  3, 2, 2
);

INSERT INTO bakery_employee VALUES (
  4, 2, 5
);

INSERT INTO bakery_employee VALUES (
  5, 3, 3
);

INSERT INTO bakery_employee VALUES (
  6, 3, 6
);

-- BAKERY_SHIFTS
INSERT INTO employee_shift VALUES (
  1, 1, 1, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('07:00','HH24:SS'), TO_DATE('16:00','HH24:SS')
);

INSERT INTO employee_shift VALUES (
  2, 4, 1, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('07:00','HH24:SS'), TO_DATE('16:00','HH24:SS')
);

INSERT INTO employee_shift VALUES (
  3, 2, 2, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('10:00','HH24:SS'), TO_DATE('18:00','HH24:SS')
);

INSERT INTO employee_shift VALUES (
  4, 5, 2, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('10:00','HH24:SS'), TO_DATE('18:00','HH24:SS')
);

INSERT INTO employee_shift VALUES (
  5, 3, 3, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('09:00','HH24:SS'), TO_DATE('17:00','HH24:SS')
);

INSERT INTO employee_shift VALUES (
  6, 6, 3, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY'), TO_DATE('09:00','HH24:SS'), TO_DATE('17:00','HH24:SS')
);


-- PRODUCT ITEMS
INSERT INTO product_items VALUES (
  1, 'Whole Wheat Bagel', 'Bread', 1.99, 'Flour, Eggs, Salt, Sugar, Shortening, Baking Soda', 50, 3, 40, 1, 4, 200
);

INSERT INTO product_items VALUES (
  2, 'Plain Croissant', 'Pastry', 2.10, 'Flour, Eggs, Salt, Sugar, Butter, Baking Soda', 70, 3, 40, 1, 4, 250
);

INSERT INTO product_items VALUES (
  3, 'Chocolate Muffin', 'Bread', 3.00, 'Flour, Eggs, Salt, Milk, Sugar, Butter, Chocolate, Baking Soda', 90, 1.5, 36, 1, 3, 350
);

INSERT INTO product_items VALUES (
  4, 'Chocolate Chip Cookie', 'Pastry', 1.99 ,'Flour, Eggs, Salt, Milk, Sugar, Chocolate Chips, Butter, Baking Soda', 60, 1.5, 36, 1, 3, 400
);

INSERT INTO product_items VALUES (
  5, 'Peanut Butter Cookie', 'Pastry', 1.99 ,'Flour, Eggs, Salt, Milk, Sugar, Peanuts, Peanut Butter, Shortening, Baking Soda', 60, 1.5, 36, 1, 3, 400
);

INSERT INTO product_items VALUES (
  6, 'Chocolate Fudge Brownies', 'Cake', 2.30 ,'Flour, Eggs, Salt, Milk, Sugar, Chocolate, Nuts, Butter, Baking Soda', 75, 1.45, 36, 1, 3, 450
);

INSERT INTO product_items VALUES (
  7, 'Oatmeal Raisin Cookie', 'Pastry', 1.99 ,'Flour, Eggs, Salt, Milk, Sugar, Raisin, Oatmeal, Butter, Baking Soda', 60, 1.5, 36, 1, 3, 400
);

INSERT INTO product_items VALUES (
  8, 'Red Velvet Cookie', 'Pastry', 1.99 ,'Flour, Eggs, Salt, Milk, Sugar, Butter, Cream Cheese, Baking Soda', 60, 1.5, 36, 1, 3, 400
);

-- ITEM DISCOUNTS
INSERT INTO item_discounts VALUES (
  1, 'No Discount', 0.00
);

INSERT INTO item_discounts VALUES (
  2, '10% Discount', 0.10
);

INSERT INTO item_discounts VALUES (
  3, '20% Discount', 0.20
);

-- MENU
INSERT INTO menu VALUES (
  1, 1, 1, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  2, 1, 2, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);  

INSERT INTO menu VALUES (
  3, 1, 3, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  4, 1, 4, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  5, 1, 5, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  6, 1, 6, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  7, 1, 7, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);

INSERT INTO menu VALUES (
  8, 1, 8, TO_DATE('11-19-2018', 'MM-DD-YYYY'), TO_DATE('11-23-2018', 'MM-DD-YYYY')
);


-- TRANSACTIONS
INSERT INTO bakery_transactions VALUES (
  1,1,1,3,TO_DATE('11-18-2018', 'MM-DD-YYYY')
);

INSERT INTO bakery_transactions VALUES (
  2,2,6,1,TO_DATE('11-19-2018', 'MM-DD-YYYY')
);

INSERT INTO bakery_transactions VALUES (
  3,3,4,2,TO_DATE('11-20-2018', 'MM-DD-YYYY')
);


UPDATE menu
SET discount_id = 2
WHERE menu_id = 1;

UPDATE menu
SET discount_id = 2
WHERE menu_id = 4;

UPDATE menu
SET discount_id = 3
WHERE menu_id = 5;

UPDATE menu
SET discount_id = 2,
    menu_week_start = TO_DATE('11-26-2018', 'MM-DD-YYYY'),
    menu_week_end = TO_DATE('11-30-2018', 'MM-DD-YYYY')
WHERE menu_id BETWEEN 2 AND 3;

UPDATE menu
SET discount_id = 3,
    menu_week_start = TO_DATE('11-26-2018', 'MM-DD-YYYY'),
    menu_week_end = TO_DATE('11-30-2018', 'MM-DD-YYYY')
WHERE menu_id = 6;

SELECT * FROM menu
WHERE discount_id = 2
AND menu_week_start = TO_DATE('18-11-19', 'YY-MM-DD');

SELECT menu_id, item_description, item_price, discount_id, item_price * discount_amt AS "Discount Amount", item_price - item_price * discount_amt AS "Discount Price"
FROM item_discounts itd
JOIN menu m
USING(discount_id)
JOIN product_items pit
USING(item_id)
WHERE discount_id > 1
AND menu_week_start = TO_DATE('18-11-19', 'YY-MM-DD')
ORDER BY discount_id DESC;

SELECT * FROM menu;
