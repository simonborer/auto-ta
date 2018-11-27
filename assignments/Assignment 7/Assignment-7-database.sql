--Jay Patel--
--n013059254--
-- 1 --

CREATE TABLE bakery
(
bakery_info       varchar(15) 
    CONSTRAINT bakery_bakery_info_pk PRIMARY KEY,
store_location varchar(30)
);
 
-- 2 --


CREATE TABLE employee_shift_info(
employee_shift_info_id   varchar(10) PRIMARY KEY,
employee_idendity      varchar(10) 
CONSTRAINT employee_shift_info_employee_idendity_fk REFERENCES table_employee(employee_id),
employee_shift_hour   number(2) 
shift_hour   number(2),
bakery_loc        varchar(30) 
CONSTRAINT tbltimetable_bakery_loc_fk REFERENCES tblbakery(bakery_info),
employee_location_alloted   varchar(30)
);

--3--
CREATE TABLE employee
(
employee_id    number (10) PRIMARY KEY,
shift_id       varchar(20) 
CONSTRAINT table_employee_shift_id _fk 
REFERENCES 
employee_shift_info(employee_shift_info_id ),
employee_name        varchar(15),
employee_address     varchar(30),
employee_contact_info      number(10),
employee_document       varchar(10),
employee_type       	varchar(2) 
);

--4--

CREATE TABLE menu
(
menu_info       number(6) PRIMARY KEY,
item_product    varchar(10),
item_id   varchar(10),
item_price   number(6) 
);

--5--
create table Bread
(
bread_id number(10) primary key,
bread_type varchar(20),
bread_price number(5)
);

--6--
create table Pastries
(
pasteries_id number(10) primary key,
pastery_type varchar(20),
pastery_price number(5)
);

--7--
create table Coffee
(
coffee_id number(10) primary key,
coffee_type varchar(20),
coffee_price number(5)
);