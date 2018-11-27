-- Ekta Patel(N01137684)
-- Assignment 7 

CREATE TABLE bakeries(
    bakery_id NUMBER(15) PRIMARY KEY,
    bakery_address VARCHAR(25) NOT NULL
);


CREATE TABLE employee(
    employee_id  NUMBER(6) PRIMARY KEY,
    bakery_id NUMBER(15) 
              CONSTRAINT emp_bakery_id REFERENCES bakeries(bakery_id),
    employee_name VARCHAR(25) NOT NULL,
    employee_role VARCHAR(15)
                  CONSTRAINT employee_role_chk CHECK(employee_role IN('cashier','baker')),
    weekly_hours NUMBER(4)
                 CONSTRAINT emp_weekly_hrs CHECK(weekly_hours BETWEEN 25 AND 44),
    daily_shift NUMBER(4)
                 CONSTRAINT emp_daily_shift CHECK(daily_shift>=4 AND daily_shift<=8)
);

CREATE TABLE bakery_menu(
    item_id NUMBER(15),
    item_name VARCHAR(20) NOT NULL,
    item_type VARCHAR(20)
);


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
    weekly_offer_id NUMBER(10),
    reducedby_20_item_id NUMBER(15) 
              CONSTRAINT item_id_fk REFERENCES bakery_menu(item_id),
    reducedby_10_item_id NUMBER(15) 
              CONSTRAINT item_id_fk REFERENCES bakery_menu(item_id)
);


