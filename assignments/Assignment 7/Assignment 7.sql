CREATE TABLE employee
(emp_id INT PRIMARY KEY, emp_name VARCHAR2(30) NOT NULL,
	emp_role CHAR(1),
    CONSTRAINT CHK_Role CHECK (emp_role='C' OR emp_role='B')
);	

CREATE TABLE menu
(item_id INT PRIMARY KEY, item_name VARCHAR2(30) NOT NULL,
	sell_price NUMBER(3,2),
);

CREATE TABLE ingredients(ing_id INT PRIMARY KEY, ing_name VARCHAR2(30) NOT NULL,
	used_in_item_id NUMBER(3),
CONSTRAINT FOREIGNKEY_fk  FOREIGN KEY(used_in_item_id) REFERANCES menu(item_id)

);

CREATE TABLE production(
item_id INT PRIMARY KEY, item_type varchar2(10),baking_temperature NUMBER(3,2), baking_time NUMBER(2,2),
ovenspace VARCHAR2(10),cost_price NUMBER(3,2)
);