-- Create tables. Assingnment 7. n01261269 Artem Nahornyi
CREATE TABLE bakery_address (
    address_id          NUMBER(4)    PRIMARY KEY,
    bakery_address      VARCHAR2(40) 
);
CREATE TABLE worker_role(
    role_id       NUMBER(4)         PRIMARY KEY,
    role_name     VARCHAR2(20)
);

CREATE TABLE bakery (
    bakery_id         NUMBER(4)     PRIMARY KEY,
    address_id        NUMBER(4)     REFERENCES bakery_address(address_id),
    bakery_name       VARCHAR2(40),
    backery_phone     VARCHAR2(20)
);

CREATE TABLE bakery_worker (
    worker_id       NUMBER(4)       PRIMARY KEY,
    address_id      NUMBER(4)       REFERENCES bakery_address(address_id),
    role_id         NUMBER(4),
    f_name          VARCHAR2(20),
    l_name          VARCHAR2(20),
    worker_phone    VARCHAR2(20)
);
ALTER TABLE bakery_worker
ADD FOREIGN KEY (role_id)   REFERENCES worker_role(role_id);

CREATE TABLE bakery_timetable(
    timetable_id    NUMBER(4)   PRIMARY KEY,
    worker_id       NUMBER(4)   REFERENCES bakery_worker(worker_id),
    role_id         NUMBER(4)   REFERENCES worker_role(role_id),
    address_id      NUMBER(4)   REFERENCES bakery_address(address_id),
    working_days    VARCHAR2(40),
    working_hours   NUMBER
);

CREATE TABLE bakery_food (
    food_id             NUMBER(4)    PRIMARY KEY,
    food_name           VARCHAR2(20),
    food_price          NUMBER,
    cost_to_cook        NUMBER,
    cooking_time        NUMBER,
    cooking_temp        NUMBER
);

CREATE TABLE bakery_drinks (
    drink_id             NUMBER(4)    PRIMARY KEY,
    drink_name           VARCHAR2(20),
    drink_price          NUMBER,
    cost_to_cook         NUMBER,
    cooking_time         NUMBER
);

CREATE TABLE bakery_menu (
    menu_id             NUMBER(4)    PRIMARY KEY,
    menu_name           VARCHAR2(20),
    food_id             NUMBER(4)    REFERENCES bakery_food(food_id),
    drink_id            NUMBER(4)    REFERENCES bakery_drinks(drink_id)
);

CREATE TABLE bakery_order (
    order_id        NUMBER(4)    PRIMARY KEY,
    menu_id         NUMBER(4)    REFERENCES bakery_menu(menu_id),
    drink_id        NUMBER(4)    REFERENCES bakery_drinks(drink_id),
    food_id         NUMBER(4)    REFERENCES bakery_food(food_id),
    quantity        NUMBER       DEFAULT 1,
    order_time      DATE,
    order_price     NUMBER,
    worker_id       NUMBER(4)
);
ALTER TABLE bakery_order
ADD FOREIGN KEY (worker_id)   REFERENCES bakery_worker(worker_id);
/*
CREATE TABLE bakery_discounts (
    discount_id       NUMBER(4)   PRIMARY KEY,
    week_starting     DATE,
    food_id           NUMBER      REFERENCES bakery_food(food_id),
    discount_percent  NUMBER
);
*/

/*
-- TO DROP ALL TABLES
drop table bakery_address;
drop table bakery;
drop table bakery_timetable;
drop table bakery_food;
drop table bakery_drinks;
drop table bakery_menu;
drop table bakery_order;
drop table bakery_discounts;

drop table bakery_worker;
drop table worker_role;
*/

-- ======================================================================
-- ======================================================================
--Question 1. Assignment 8. n01261269 Artem Nahornyi
CREATE OR REPLACE PROCEDURE add_food_procedure
(
    food_id_param              NUMBER,
    food_name_param            VARCHAR2,
    food_price_param           NUMBER,
    cost_to_cook_param         NUMBER,
    cooking_time_param         NUMBER,
    cooking_temp_param         NUMBER
)
AS
BEGIN
    INSERT INTO bakery_food
    VALUES (food_id_param, food_name_param, food_price_param, cost_to_cook_param, cooking_time_param, cooking_temp_param);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/
--DROP PROCEDURE add_food_procedure;
CALL add_food_procedure(1, 'Burger', 3, 4, 5, 6);
CALL add_food_procedure(2, 'Hotdog', 8, 5, 5, 200);
CALL add_food_procedure(3, 'Pizza', 10, 5, 5, 200);
CALL add_food_procedure(4, 'Black Burger', 10, 5, 5, 200);
CALL add_food_procedure(5, 'Pasta', 10, 5, 5, 200);

--SELECT * FROM bakery_food;

-- ======================================================================
-- ======================================================================
--Question 2. Assignment 8. n01261269 Artem Nahornyi
SET SERVEROUTPUT ON;
DECLARE
    --==========Food item==================================
    food_name_param      VARCHAR2(20);
    food_name_param_2    VARCHAR2(20);
    food_name_param_3    VARCHAR2(20);
    food_name_param_4    VARCHAR2(20);
    food_name_param_5    VARCHAR2(20);
    
    --==================Food item price====================
    food_price_param     NUMBER;
    food_price_param_2   NUMBER;
    food_price_param_3   NUMBER;
    food_price_param_4   NUMBER;
    food_price_param_5   NUMBER;
    
    --===============Curant day; Sysdate===================
    curant_day_param     DATE;
    
    --==============Price - Discount=======================
    final_price_param    NUMBER; --After discount
    
    --==================Discount block=====================
    discount_1           NUMBER    DEFAULT 10; -- discount 10%
    discount_2           NUMBER    DEFAULT 20; -- discount 20%
    discount_3           NUMBER    DEFAULT 30; -- discount 30%
    discount_4           NUMBER    DEFAULT 40; -- discount 40%
    

BEGIN
    --Took form https://it.toolbox.com/question/function-to-get-day-only-from-date-field-031609
    SELECT extract(day from SYSDATE)
    INTO curant_day_param
    FROM dual;
    -- Took from https://www.techonthenet.com/oracle/functions/case.php
    CASE
      WHEN curant_day_param BETWEEN 1 AND 6  
      THEN      SELECT food_name
                INTO food_name_param
                FROM bakery_food
                WHERE food_id = 1;
                
                SELECT food_price
                INTO food_price_param
                FROM bakery_food
                WHERE food_id = 1;
                final_price_param := TRUNC(food_price_param -(food_price_param * (discount_1 / 100)));
                dbms_output.put_line('Take 10% off ' || food_name_param || '. Final price:  ' || final_price_param );
                
        WHEN curant_day_param BETWEEN 7 AND 13  
        THEN    SELECT food_name
                INTO food_name_param_1
                FROM bakery_food
                WHERE food_id = 2;
                
                SELECT food_price
                INTO food_price_param_2
                FROM bakery_food
                WHERE food_id = 2;
                final_price_param := TRUNC(food_price_param_2 -(food_price_param_2 * (discount_2 / 100))); 
                dbms_output.put_line('Take 20% off ' || food_name_param_2 || ' ' || final_price_param_2 );
                
        WHEN curant_day_param BETWEEN 14 AND 20  
        THEN    SELECT food_name
                INTO food_name_param_3
                FROM bakery_food
                WHERE food_id = 3;
                
                SELECT food_price
                INTO food_price_param_3
                FROM bakery_food
                WHERE food_id = 3;
                final_price_param := TRUNC(food_price_param_3 -(food_price_param_3 * (discount_3 / 100))); 
                dbms_output.put_line('Take 30% off ' || food_name_param_3 || ' ' || final_price_param_3 );
                
        WHEN curant_day_param BETWEEN 21 AND 26  
        THEN    SELECT food_name
                INTO food_name_param_4
                FROM bakery_food
                WHERE food_id = 4;
                
                SELECT food_price
                INTO food_price_param_4
                FROM bakery_food
                WHERE food_id = 4;
                final_price_param := TRUNC(food_price_param_4 -(food_price_param_4 * (discount_4 / 100))); 
                dbms_output.put_line('Take 40% off ' || food_name_param_4 || ' ' || final_price_param_4 );
        
        WHEN curant_day_param BETWEEN 27 AND 31  
        THEN    SELECT food_name
                INTO food_name_param_5
                FROM bakery_food
                WHERE food_id = 5;
                
                SELECT food_price
                INTO food_price_param_5
                FROM bakery_food
                WHERE food_id = 5;
                final_price_param := TRUNC(food_price_param_5 -(food_price_param_5 * (discount_1 / 100))); 
                dbms_output.put_line('Take 10% off ' || food_name_param_5 || ' ' || final_price_param_5 );

      ELSE dbms_output.put_line('No discount for today!');
    END CASE;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/