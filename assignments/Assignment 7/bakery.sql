--BINITA PATEL--

--bakery table-
CREATE TABLE bakery
(
bakery_id NUMBER(6) PRIMARY KEY,
bakery_location VARCHAR2(15) NOT NULL
)


--employee table--
CREATE TABLE bakery_employee
(
employee_id NUMBER(6) PRIMARY KEY,
emp_first_name VARCHAR2(15),
emp_last_name VARCHAR2(15),
emp_age NUMBER(6),
emp_address VARCHAR2(15),
emp_city VARCHAR2(15),
emp_state VARCHAR2(15)
 )
 
 --employee schedule--
 CREATE TABLE bakery_employee_schedule
(
employee_id NUMBER(6) 
         CONSTRAINT bakery_employee_schedule_employee_id_fk REFERENCES bakery_employee(employee_id),
total_hours  NUMBER(6)         
)
 
 
 --menu--
 CREATE TABLE bakery_menu
(
menu_id NUMBER(6) PRIMARY KEY,
menu_item VARCHAR2(15) NOT NULL
)

--items--
 CREATE TABLE bakery_items
(
item_id NUMBER(6) PRIMARY KEY,
menu_id NUMBER(6) 
        CONSTRAINT bakery_items_menu_id_fk REFERENCES bakery_menu(menu_id),
item_price VARCHAR2(15) NOT NULL,
prep_time NUMBER(6),
number_of_serving NUMBER(6), 
calories_per_serving NUMBER(6),
ingredients VARCHAR2(15) NOT NULL
)

--discount--
 CREATE TABLE bakery_discount
(
discount_id  NUMBER(6) PRIMARY KEY,
item_id NUMBER(6) 
        CONSTRAINT discount_item_id_fk REFERENCES bakery_items(item_id)
)


--customer--
CREATE TABLE bakery_customers
(
customer_id NUMBER(6) PRIMARY KEY,
customer_name VARCHAR2(15) NOT NULL,
phone_number  NUMBER(6),
cust_address VARCHAR2(15),
cust_city VARCHAR2(15),
cust_state VARCHAR2(15)
)



