/*
* Lab 5 Artem Nahornyi. n01261269
*/
--QUESTION 1-2

--DROP TABLE new_car;
CREATE TABLE new_car
(
  car_id      NUMBER(6)     PRIMARY KEY,
  car_name    VARCHAR2(15)  NOT NULL,
  car_color   VARCHAR2(15)  DEFAULT 'White',
  car_price   NUMERIC(6, 2) UNIQUE,
  car_number  CHAR(4)       DEFAULT 0000
)
INSERT INTO new_car
VALUES(1, 'BMW', 'Green', 410, DEFAULT);
INSERT INTO new_car
VALUES(2, 'Mersedes', 'Black', 550, 1111);
INSERT INTO new_car
VALUES(3, 'Audi', 'Red', 470, DEFAULT);
INSERT INTO new_car
VALUES(4, 'Infinity', DEFAULT, 230, DEFAULT);

SELECT *
FROM new_car
-- ==================================================================
-- ==================================================================
--DROP TABLE car_driver;
CREATE TABLE car_driver
(
  driver_id     NUMBER(6)     PRIMARY KEY,
  last_name     VARCHAR2(15)  NOT NULL,
  first_name    VARCHAR2(15)  NOT NULL,
  store_used    NUMBER(6)     REFERENCES car_store(car_store_id)
)
INSERT INTO car_driver
VALUES(10, 'Bill', 'Block', 1);
INSERT INTO car_driver
VALUES(20, 'Mike', 'Kane', 2);
INSERT INTO car_driver
VALUES(30, 'Miaf', 'Kaag', 3);

SELECT *
FROM car_driver

-- ==================================================================
-- ==================================================================
--DROP TABLE car_store;
CREATE TABLE car_store
(
  car_store_id  NUMBER(6)     PRIMARY KEY,
  car_sold      NUMBER(6)     REFERENCES new_car(car_id),
  country       VARCHAR2(15)  DEFAULT 'USA',
  director      VARCHAR2(15)
)
INSERT INTO car_store
VALUES(1, 2, DEFAULT, 'Artem Nahornyi');
INSERT INTO car_store
VALUES(2, 1, DEFAULT, 'Artem Nahornyi');
INSERT INTO car_store
VALUES(3, 3, DEFAULT, 'Artem Nahornyi');

SELECT *
FROM car_store
-- ==================================================================
-- ==================================================================

--QUESTION 3
SELECT *
FROM new_car a
FULL OUTER JOIN car_store b
USING(car_id)
FULL OUTER JOIN car_driver c
USING(car_store_id)

--QUESTION 4
INSERT INTO car_store (car_store_id) 
VALUES ('999')

--QUESTION 5
ALTER TABLE car_store RENAME TO new_car_store
