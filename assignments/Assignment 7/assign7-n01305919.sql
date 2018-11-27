--PARAMPREET SINGH GREWAL
--N01305919
--Assignment 7


---------1------------
CREATE TABLE  my_bakery 
(
bakery_number   NUMBER(7)    PRIMARY KEY,
Address         VARCHAR(25),
supervisor_id   NUMBER(7),
bakery_products VARCHAR(20)
)


------------2-------------
CREATE TABLE employeer_info
(
employeer_id    NUMBER(7)   PRIMARY KEY,
bakery_id       NUMBER(7)   REFERENCES my_bakery(bakery_number),     
employeer_name  VARCHAR(15),
employer_age    NUMBER(3)
)


-------------3-------------
CREATE TABLE bakery_time_table
(
time_slot         NUMBER(5)   PRIMARY KEY,
bakery_no         NUMBER(7)   REFERENCES bakery_time_table(bakery_number),  
employeer_number  NUMBER(7)   REFERENCES bakery_time_table(enployeer_id),  
hours_per_week    NUMBER(2)   CONSTRAINT ck_hours CHECK(hours_per_week BETWEEN 25 AND 45), 
hours_per_shift   NUMBER(2)   CONSTRAINT ck_shifthours  CHECK(hours_per_shift BETWEEN 4 AND 8)
)


-------------4--------------
CREATE TABLE bakery_all_items
(
item_id      NUMBER(7)     PRIMARY KEY,
item_name    VARCHAR(11),       
item_price   NUMBER(3),
bakery_location  VARCHAR(25) REFERENCES my_bakery(bakery_number)
)


------------5-----------
CREATE TABLE item_pastry
(
pstry_id      NUMBER(7)    PRIMARY KEY,
pstry_type    NUMBER(11)   REFERENCES bakery_all_items(item_id),     
pstry_price   NUMBER(3),
pstry_expiry_date  NUMBER(6)
)


------------6-----------
CREATE TABLE item_bread
(
bread_id      NUMBER(7)    PRIMARY KEY,
bread_type    NUMBER(11)   REFERENCES bakery_all_items(item_id),     
bread_price   NUMBER(3),
bread_expiry_date  NUMBER(6)
)


-------------7-----------
CREATE TABLE item_coffee
(
coffee_id      NUMBER(7)    PRIMARY KEY,
coffee_type    NUMBER(11)   REFERENCES bakery_all_items(item_id),     
coffee_price   NUMBER(3),
coffee_expiry_date  NUMBER(6)
)





























