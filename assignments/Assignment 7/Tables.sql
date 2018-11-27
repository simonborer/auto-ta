CREATE TABLE locations(
    location_id        NUMBER(5)   PRIMARY KEY,
    location_address   VARCHAR2(255)
)

CREATE TABLE stuff(
    stuff_id        NUMBER(10)   PRIMARY KEY,
    first_name      VARCHAR2(20),
    last_name       VARCHAR2(20),
    stuff_phone     VARCHAR(20),
    location_id     NUMBER(5)   REFERENCES locations(location_id)
)

CREATE TABLE timesheet(
    timesheet_id    NUMBER(5)    PRIMARY KEY,
    shift_start     NUMBER,
    shift_end       NUMBER,
    shift_time      VARCHAR2(10),
    stuff_id        NUMBER(10)  REFERENCES stuff(stuff_id)
)

CREATE TABLE foods(
    food_id         NUMBER(5)   PRIMARY KEY,
    food_name       VARCHAR2(20),
    food_cost       NUMBER     
)

CREATE TABLE drinks(
    drink_id         NUMBER(5)   PRIMARY KEY,
    drink_name       VARCHAR2(20),
    drink_cost       NUMBER     
)

CREATE TABLE combos(
    combo_id        NUMBER(5)   PRIMARY KEY,
    combo_name      VARCHAR2(20),
    food_id         NUMBER(5)   REFERENCES foods(food_id),
    drink_id        NUMBER(5)   REFERENCES drinks(drink_id),
    combo_price     NUMBER
)

CREATE TABLE bakery_orders(
    order_id        NUMBER(5)   PRIMARY KEY,
    combo_id        NUMBER(5)   REFERENCES combos(combo_id),
    food_id         NUMBER(5)   REFERENCES foods(food_id),
    drink_id        NUMBER(5)   REFERENCES drinks(drink_id),
    stuff_id        NUMBER(10)  REFERENCES stuff(stuff_id),
    discount        NUMBER(10)
)
DROP TABLE locations
DROP TABLE stuff
DROP TABLE timesheet
DROP TABLE foods
DROP TABLE drinks
DROP TABLE combos
DROP TABLE bakery_orders

CREATE OR REPLACE PROCEDURE add_items_food
(
    add_food_id     foods.food_id%TYPE,
    add_food_name   foods.food_name%TYPE,
    add_food_cost   foods.food_cost%TYPE
)
IS
CURSOR c1 IS
   SELECT COUNT(food_id)
   FROM foods
   WHERE food_id = add_food_id;
i number;
BEGIN
OPEN c1;
    FETCH c1 INTO i;
    IF (i > 0 ) THEN
        RAISE VALUE_ERROR;
    END IF;
    INSERT INTO foods
    VALUES (add_food_id, add_food_name, add_food_cost);
    COMMIT;
    EXCEPTION 
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('A DUP_VAL_ON_INDEX error occurred.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;
/

CALL add_items_food(1, 'bread1', 1);
CALL add_items_food(2, 'bread2', 2);
CALL add_items_food(3, 'bread3', 3);
CALL add_items_food(4, 'bread4', 4);
CALL add_items_food(5, 'bread5', 5);
CALL add_items_food(6, 'bread6', 6);
CALL add_items_food(7, 'bread7', 7);
CALL add_items_food(8, 'bread8', 8);
CALL add_items_food(9, 'bread9', 9);
CALL add_items_food(10, 'bread10', 10);
CALL add_items_food(11, 'bread11', 11);
CALL add_items_food(12, 'bread12', 12);
CALL add_items_food(13, 'bread13', 13);

select * from foods