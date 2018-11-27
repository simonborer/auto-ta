CREATE TABLE Bakery_Employees
(
 employee_id NUMBER(2) PRIMARY KEY,
 employee_fname VARCHAR2(15),
 employee_lname VARCHAR2(20),
 employee_job VARCHAR2(10),
 hours_weekly NUMBER (2),
 shifts_weekly NUMBER (2)
)

CREATE TABLE Bakery_Menu
(
 product VARCHAR2(20) PRIMARY KEY,
 price NUMBER(2),
 discount NUMBER(2)
)

CREATE TABLE Bakery_Locations
(
 location_id NUMBER(3) PRIMARY KEY,
 bakery_address VARCHAR2(20),
 weekly_revenue NUMBER(6),
 employee_number NUMBER (2)
)

CREATE TABLE Schedule
(
 shift_id NUMBER(3) PRIMARY KEY,
 employee_id NUMBER(2) REFERENCES Bakery_Employees(employee_id),
 job_type VARCHAR2(10),
 shift_start NUMBER(4),
 shift_length NUMBER(1),
 location_id NUMBER(3) REFERENCES Bakery_Locations(location_id),
 shift_date VARCHAR2(10)
)

CREATE TABLE Baked_Goods
(
 item_id NUMBER(3) PRIMARY KEY,
 product VARCHAR2(20) REFERENCES Bakery_Menu(product),
 prep_time NUMBER(2),
 price NUMBER(2),
 ingredients_cost NUMBER(4),
 quantity NUMBER(3)
)
CREATE TABLE Bakery_Drinks
(
 drink_id NUMBER(3) PRIMARY KEY,
 drink VARCHAR2(10) REFERENCES Bakery_Menu(product),
 price NUMBER(1),
 ingredients_cost NUMBER(4),
 quantity NUMBER(3)
)
CREATE TABLE Bakery_Invoices
(
 invoices_id NUMBER(3) PRIMARY KEY,
 location_id NUMBER(3) REFERENCES Bakery_Locations(location_id),
 invoice_total NUMBER(4),
 invoice_date VARCHAR2(10)
)