--Jetalbahen Tandel
--Assignment 7
--1

CREATE TABLE bakeries
(
   bakery_id       NUMBER(10)    PRIMARY KEY,
   bakery_address  VARCHAR2(25)  NOT NULL,
   employee_id      NUMBER(5)
                    CONSTRAINT   bakeries_employee_id_fk REFERENCES  employees(employee_id),
                    UNIQUE(employee_id)
);


--Jetalbahen Tandel
--Assignment 7
--2

CREATE TABLE employees
(
  employee_id        NUMBER(5)       PRIMARY KEY,
  bakery_id          NUMBER(10)
                     CONSTRAINT employees_bakery_id_fk REFERENCES bakeries(bakery_id),
  employee_name      VARCHAR2(20)    NOT NULL,
  employee_role      VARCHAR2(15)
                     CONSTRAINT employees_employee_role_ck CHECK(employee_role IN('cashier','baker')),
  weekly_hours       NUMBER(5)
                     CONSTRAINT  employees_weekly_hours_ck  CHECK(weekly_hours BETWEEN 25 AND 45),
  daily_shift        NUMBER(5)
                     CONSTRAINT  employees_daily_shift_ck   CHECK(daily_shift>=4 AND daily_shift<=8),
  work_location      VARCHAR2(15)
);

--Jetalbahen Tandel
--Assignment 7
--3

CREATE  TABLE  menus
(
  menu_id      NUMBER(7)     PRIMARY KEY,
  item_type    VARCHAR(20)    NOT NULL,
  item_name    VARCHAR2(20)   NOT NULL,
  item_price   NUMBER(8)     
); 



--Jetalbahen Tandel
--Assignment 7
-- 4
CREATE TABLE   item_cost
(
 menu_id      NUMBER(5) 
              CONSTRAINT item_cost_menu_id_fk REFERENCES menus(menu_id),
 baking_time   NUMBER(5),
 prepare_time   NUMBER(5),
 ingredient     VARCHAR2(10),
 ingredients_cost NUMBER(10),
 baking_temp      NUMBER(5)
);



--Jetalbahen Tandel
--Assignment 7
-- 5
CREATE  TABLE  pastries
(
 pastry_id     NUMBER(8)     PRIMARY KEY,
 pastry_flavour  VARCHAR2(15)  NOT NULL,
 pastry_price     NUMBER(10)   NOT NULL
);

--Jetalbahen Tandel
--Assignment 7
-- 6
CREATE TABLE  breads
(
  id               NUMBER(5)     PRIMARY KEY,
  bread_flavour    VARCHAR2(15)   NOT NULL,
  bread_price      NUMBER(10)     NOT NULL
);

