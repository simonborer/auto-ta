Lab 5-n01302646-JOBANJIT SINGH 

Q1
--TABLE 1
CREATE TABLE products (
   product_id       NUMBER(7) PRIMARY KEY,
   productCode         VARCHAR(15)  REFERENCES "order"(orderProductCode), 
   productVendor      VARCHAR(50) DEFAULT 'CANADIAN BELLS',   
   buyPrice            NUMBER(8,2)    CONSTRAINT buy_price CHECK (buyPrice>0)
   )
   
--TABLE 2
   CREATE TABLE "order" 
   (
   order_id     NUMBER(8)  REFERENCES my_order_details(order_id),
   orderDate       DATE          NOT NULL,
   orderProductCode     VARCHAR(15), 
   status          VARCHAR(15)   DEFAULT 'ORDER RECIEVED', 
   PRIMARY KEY(order_id) 
) 


--TABLE 3
CREATE TABLE my_order_details
(
 order_id NUMBER(8) PRIMARY KEY,
 productCode VARCHAR(15) REFERENCES products(productCode),
 expectdDeliveryDate DATE,
 quantity   NUMBER(3) NOT NULL
 )


--ADDED CONSTRAINTS


ALTER TABLE "order"
ADD  UNIQUE(orderProductCode)

 ALTER TABLE my_order_details
ADD  UNIQUE(productCode)

 ALTER TABLE products
ADD  UNIQUE(productCode)

ADD CONSTRAINT FK_ProductCode
FOREIGN KEY (productCode) REFERENCES products(productCode);

--Q2

 INSERT INTO my_order_details
 VALUES(201,'A',TO_DATE('2018-10-05', 'YYYY-MM-DD'),1)
 
  INSERT INTO my_order_details
 VALUES(202,'B',TO_DATE('2018-09-05', 'YYYY-MM-DD'),3)
 
  INSERT INTO my_order_details
 VALUES(203,'C',TO_DATE('2018-12-05', 'YYYY-MM-DD'),1)


INSERT INTO products
 VALUES(101,'A',DEFAULT,20);
 
 INSERT INTO products
 VALUES(102,'B','NAFTA',10);
 
 INSERT INTO products
 VALUES(103,'C','GIVE AND GO',38)



 INSERT INTO "order"
 VALUES(201,TO_DATE('2018-10-05', 'YYYY-MM-DD'),'A',DEFAULT);
 
  INSERT INTO my_order_details
 VALUES(202,TO_DATE('2018-09-05', 'YYYY-MM-DD'),'B','READY');
 
  INSERT INTO my_order_details
 VALUES(203,TO_DATE('2018-12-05', 'YYYY-MM-DD'),'C','SHIPPED')

--Q3

SELECT * from products p
FULL JOIN "order" o
ON p.productcode = o.orderProductCode
FULL JOIN my_order_details m
ON p.productCode = m.productCode

--Q4
ALTER TABLE products
ADD product_desc varchar(30); 

--Q5
ALTER TABLE products
RENAME TO myProducts