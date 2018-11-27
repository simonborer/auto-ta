restaurant 
primary key: restaurant ID NUMBER (5)
foreign key: customer ID NUMBER (5)
restaurant name varchar2 (15) NOT NULL 
restaurant address varchar(20) NOT NULL

customer
primary key: customer ID
foreign key: reservation ID
name  NUMBER (5)
phone number varchar2(10)

reservation
primary key: reservation ID
foreign key: customer ID 
date (date) NOT NULL
size NUMBER(2) DEFAULT 5 
-----------------------------------------------------------------

1.A)
CREATE TABLE restaurant(
restaurant_id NUMBER(5) PRIMARY KEY,
customer_id NUMBER(5),
restaurant_name VARCHAR2(15) NOT NULL,
restaurant_address VARCHAR(15) NOT NULL
)

CREATE TABLE customer(
customer_id NUMBER(5) PRIMARY KEY,
reservation_id NUMBER(5),
name VARCHAR2(20),
phone_number CHAR(10) UNIQUE
)

CREATE TABLE reservation(
reservation_id NUMBER(5) PRIMARY KEY,
customer_id NUMBER(5),
reservation_date DATE,
reservation_size NUMBER(2) DEFAULT 1
)

1.B) 
CREATE TABLE restaurant(
restaurant_id NUMBER(5) CONSTRAINT restaurant_restaurant_id_pk PRIMARY KEY,
customer_id NUMBER(5) CONSTRAINT restaurant_customer_fk REFERENCES customer(customer_id),
restaurant_name VARCHAR2(15) NOT NULL,
restaurant_address VARCHAR(15) NOT NULL
)

CREATE TABLE customer(
customer_id NUMBER(5) CONSTRAINT customer_customer_id_pk PRIMARY KEY,
reservation_number NUMBER(5) CONSTRAINT customer_reservation_fk REFERENCES reservation(reservation_id),
name VARCHAR2(20),
phone_number CHAR(10) UNIQUE
)

CREATE TABLE reservation(
reservation_id NUMBER(5) CONSTRAINT reservation_reservation_id_pk PRIMARY KEY,
customer_number NUMBER(5) CONSTRAINT reservation_customer_fk REFERENCES customer(customer_id),
reservation_date DATE,
reservation_size NUMBER(2) DEFAULT 1
)

--------------------------------------------
2.
INSERT INTO customer VALUES(1, 1, 'Beverly', 9051231234)
INSERT INTO customer VALUES(2, 2, 'Victor', 9051231235)
INSERT INTO customer VALUES(3, 3, 'Vivian', 9051231236)

INSERT INTO restaurant VALUES(1, 1, 'Coasters', '110 Hill Street')
INSERT INTO restaurant VALUES(2, 1, 'Shack', '123 Rainbow St')
INSERT INTO restaurant VALUES(3, 2, 'Birds', '10 Toronto St')

INSERT INTO reservation VALUES(1, 1, to_date('19-OCT-10', 'dd-mon-yy'), 5)

INSERT INTO reservation VALUES(2, 2, to_date('11-OCT-10', 'dd-mon-yy'), 15)
INSERT INTO reservation VALUES(3, 3, to_date('18-OCT-10', 'dd-mon-yy'), 2)

3.
SELECT *
FROM restaurant r
    FULL JOIN customer c
    ON r.customer_id = c.customer_id
    FULL JOIN reservation res
    ON c.customer_id = res.customer_number

4.
ALTER TABLE restaurant ADD phone CHAR(10)

5.
ALTER TABLE customer RENAME TO guests
