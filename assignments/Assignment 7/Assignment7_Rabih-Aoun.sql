CREATE TABLE STORE_LOCATIONS(
    location_code        NUMBER(3)   PRIMARY KEY,
    postal_code          VARCHAR2(6),
    address              VARCHAR2(30),
    location_name        VARCHAR2(40)
);

CREATE TABLE STORE_EMPLOYEES(
    employee_id     NUMBER(5)   PRIMARY KEY,
    first_name      VARCHAR2(20),
    last_name       VARCHAR2(20),
    location_code   NUMBER(3)   REFERENCES STORE_LOCATIONS(location_code),
    work_type       VARCHAR2(15),
    hiredate        DATE
);

CREATE TABLE STORE_SHIFTS(
    shift_id        NUMBER(4)   PRIMARY KEY,
    employee_id     NUMBER (5)  REFERENCES STORE_EMPLOYEES(employee_id),
    start_shift     DATE,
    end_shift       DATE
);

CREATE TABLE STORE_PRODUCTS(
    product_id      NUMBER(6)   PRIMARY KEY,
    product_type    VARCHAR2(15),
    product_name    VARCHAR(30),
    product_cost    NUMBER(3,2) 
);

CREATE TABLE STORE_PRODUCTS_PREP(
    prep_id         NUMBER(8)   PRIMARY KEY,
    product_id      NUMBER(6) REFERENCES STORE_PRODUCTS(product_id),
    prep_cost       NUMBER(4,2),
    bake_time       NUMBER(2),
    prep_time       NUMBER(2),
    bake_temp       NUMBER(3),
    prep_space      NUMBER(2)
);

CREATE TABLE STORE_TRANSACTIONS(
    bill_id         NUMBER(8)   PRIMARY KEY,
    product_id      NUMBER (6)  REFERENCES STORE_PRODUCTS(product_id),
    quantity        NUMBER(4)   DEFAULT 1  
);

CREATE TABLE STORE_DISCOUNT(
    discount_id     NUMBER(3)   PRIMARY KEY,
    start_in        DATE,
    product_id      NUMBER(6)   REFERENCES STORE_PRODUCTS(product_id),
    minor_discount  NUMBER(2)
);





