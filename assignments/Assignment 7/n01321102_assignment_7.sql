/**
 * CREATE TABLES
**/
CREATE TABLE employee (
    employee_id NUMBER PRIMARY KEY,
    employee_first_name VARCHAR2(30) NOT NULL,
    employee_last_name VARCHAR2(30) NOT NULL,
    employee_type_id NUMBER
);

CREATE TABLE employee_type (
    employee_type_id NUMBER PRIMARY KEY,
    employee_description VARCHAR2(30) NOT NULL
);

CREATE TABLE bakery (
    bakery_id NUMBER PRIMARY KEY,
    bakery_name VARCHAR(30),
    location_id NUMBER
);

CREATE TABLE bakery_location (
    location_id NUMBER PRIMARY KEY,
    location_name VARCHAR2(30)
);

CREATE TABLE bakery_employee (
    bakery_employee_id NUMBER PRIMARY KEY,
    bakery_id NUMBER,
    employee_id NUMBER
);

CREATE TABLE product_items (
    item_id NUMBER PRIMARY KEY,
    item_description VARCHAR2(30),
    item_type VARCHAR2(10),
    production_id NUMBER
);

CREATE TABLE menu (
    menu_id NUMBER PRIMARY KEY,
    menu_item_price NUMBER(9,2) NOT NULL,
    menu_item_discount NUMBER(5,2),
    item_id NUMBER
);

CREATE TABLE production (
    production_id NUMBER PRIMARY KEY,
    production_description VARCHAR2(50),
    production_cost NUMBER(9,2) NOT NULL,
    production_time NUMBER(2) NOT NULL,
    production_qty NUMBER(5) NOT NULL,
    num_of_batches NUMBER(5) DEFAULT 1,
    production_date DATE DEFAULT SYSDATE,
    item_id NUMBER
);

CREATE TABLE bakery_transactions (
    transaction_id NUMBER PRIMARY KEY,
    bakery_id NUMBER,
    item_id NUMBER,
    item_description VARCHAR2(30),
    item_qty NUMBER(5),
    item_discount NUMBER(5,2),
    transaction_total NUMBER(9,2),
    transaction_date DATE DEFAULT SYSDATE
);

/** END **/

/**
* ADD FOREIGN KEY Constraints
**/

ALTER TABLE employee
ADD CONSTRAINT employee_type_id_fk
FOREIGN KEY (employee_type_id) REFERENCES employee_type(employee_type_id);

ALTER TABLE bakery
ADD CONSTRAINT bakery_location_id_fk
FOREIGN KEY (location_id) REFERENCES bakery_location(location_id);

ALTER TABLE bakery_employee
ADD CONSTRAINT be_bakery_id_fk
FOREIGN KEY (bakery_id) REFERENCES bakery(bakery_id);

ALTER TABLE bakery_employee
ADD CONSTRAINT be_employee_id_fk
FOREIGN KEY (employee_id) REFERENCES employee(employee_id);

ALTER TABLE menu
ADD CONSTRAINT menu_item_id_fk
FOREIGN KEY (item_id) REFERENCES product_items(item_id);

ALTER TABLE product_items
ADD CONSTRAINT product_production_id_fk
FOREIGN KEY (production_id) REFERENCES production(production_id);

ALTER TABLE production
ADD CONSTRAINT production_item_id_fk
FOREIGN KEY (item_id) REFERENCES product_items(item_id);

ALTER TABLE bakery_transactions
ADD CONSTRAINT trans_bakery_id_fk
FOREIGN KEY (bakery_id) REFERENCES bakery(bakery_id);

ALTER TABLE bakery_transactions
ADD CONSTRAINT trans_item_id_fk
FOREIGN KEY (item_id) REFERENCES product_items(item_id);

/** END **/