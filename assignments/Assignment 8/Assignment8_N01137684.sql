-- Ekta Patel(N01137684)
-- Assignment 7 

CREATE TABLE bakery_location(
    bakery_id NUMBER(15) PRIMARY KEY,
    bakery_address VARCHAR(25) NOT NULL
);


CREATE TABLE employee(
    employee_id  NUMBER(6) PRIMARY KEY,
    bakery_id NUMBER(15) 
              CONSTRAINT emp_bakery_id REFERENCES bakery_location(bakery_id),
    employee_name VARCHAR(25) NOT NULL,
    employee_role VARCHAR(15)
                  CONSTRAINT employee_role_chk CHECK(employee_role IN('cashier','baker'))
);

CREATE TABLE bakery_shifts(
    employee_id NUMBER(6) REFERENCES employee(employee_id),
    location_id NUMBER REFERENCES bakery_location(bakery_id),
    weekly_hours NUMBER(4)
                 CONSTRAINT emp_weekly_hrs CHECK(weekly_hours BETWEEN 25 AND 44),
    daily_shift NUMBER(4)
                 CONSTRAINT emp_daily_shift CHECK(daily_shift>=4 AND daily_shift<=8)
);

CREATE TABLE bakery_menu(
    item_id NUMBER(15),
    item_name VARCHAR(20) NOT NULL,
    item_type VARCHAR(20),
    bake_time NUMBER(4),
    bake_temp VARCHAR(10),
    req_oven_space VARCHAR(15),
    item_total_cost NUMBER(10)
);

CREATE OR REPLACE PROCEDURE insert_into_bekery_menu
(
    item_id_param NUMBER,
    item_name_param VARCHAR,
    item_type_param VARCHAR,
    bake_time_param NUMBER,
    bake_temp_param VARCHAR,
    req_oven_space_param VARCHAR,
    item_total_cost_param NUMBER
)
AS
BEGIN
    INSERT INTO bakery_menu
    VALUES (item_id_param, item_name_param, item_type_param,bake_time_param, bake_temp_param, req_oven_space_param, item_total_cost_param);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;
/

CALL insert_into_bekery_menu(1,'French vanila', 'coffee', 15, '45degree', '1' , 3);
CALL insert_into_bekery_menu(1,'Muffin', 'Bread', 15, '55degree', '2' , 2);






CREATE TABLE item_cost_detail(
    item_cost_id NUMBER(15) PRIMARY KEY,
    item_id NUMBER(15) 
              CONSTRAINT item_id_fk REFERENCES bakery_menu(item_id),
    bakers_prep_time NUMBER(4),
    bake_time NUMBER(4),
    bake_temp VARCHAR(10),
    req_oven_space VARCHAR(15),
    item_total_cost NUMBER(10)
);


CREATE TABLE weekly_offer(
    weekly_offer_id NUMBER(10) PRIMARY KEY,
    reducedby_20_item_id NUMBER(15) 
              CONSTRAINT item_id_fk REFERENCES bakery_menu(item_id),
    reducedby_10_item_id NUMBER(15) 
              CONSTRAINT item_id_fk REFERENCES bakery_menu(item_id)
);

CREATE TABLE bakery_transaction(
    transaction_id NUMBER(15),
    item_id REFERENCES bakery_menu(item_id),
    quantity NUMBER(4) DEFAULT 1
);


SET SERVEROUTPUT ON;

-- Declaring variables
DECLARE
    week_day   VARCHAR2(25);
    weekly_discounted_item VARCHAR2(25);
    item_discounted_price NUMBER(4,2);
    
    weekly_101discounted_item VARCHAR2(25);
    item_101discounted_price NUMBER(4,2);
    
    weekly_102discounted_item VARCHAR2(25);
    item_102discounted_price NUMBER(4,2);

-- Code block
BEGIN
  SELECT item_id, item_name,item_price FROM bakery_menu ORDER BY RAND(); 
  weekly_discounted_item := item_name;
  
  SELECT item_id, item_name,item_price FROM bakery_menu ORDER BY RAND(); 
  weekly_101discounted_item := item_name;
  
  SELECT item_id, item_name,item_price FROM bakery_menu ORDER BY RAND(); 
  weekly_102discounted_item := item_name;


  SELECT RAND(item_id)
  INTO weekly_discounted_item
  FROM bakery_menu;
  
  SELECT RAND(item_id)
  INTO item_101discounted_price
  FROM bakery_menu;
  
  SELECT RAND(item_id)
  INTO item_102discounted_price
  FROM bakery_menu;
  
  item_discounted_price := item_price * 0.8;
  
 
    IF EXTRACT(DAY FROM SYSDATE) >=1 AND EXTRACT(DAY FROM SYSDATE) <=7  THEN
      DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discounted_item || ' is only ' || item_discounted_price);
    ELSIF EXTRACT(DAY FROM SYSDATE) >=8 AND EXTRACT(DAY FROM SYSDATE) <=14  THEN
      DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discounted_item || ' is only ' || item_discounted_price);
    ELSIF EXTRACT(DAY FROM SYSDATE) >=15 AND EXTRACT(DAY FROM SYSDATE) <=21  THEN
      DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discounted_item || ' is only ' || item_discounted_price);
    ELSE
    DBMS_OUTPUT.PUT_LINE();
    END IF;

END;
/


















