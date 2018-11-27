CREATE TABLE bakery_details (
    bakery_id    NUMBER(10)    PRIMARY KEY,
    location        VARCHAR2(255)
);


CREATE TABLE employees (
    emp_id     NUMBER(10)   PRIMARY KEY,
    fname      VARCHAR(255),
    lname       VARCHAR(255),
    etype   VARCHAR(255)
    CONSTRAINT CHK_type CHECK (etype='cashier' OR etype='baker'),
    shifthours      NUMBER(4)
    CONSTRAINT CHK_hrs CHECK (shifthours>=4 OR shifthours<=8),

);

default_loc     NUMBER(4)   REFERENCES bakery_locations(location_id),





CREATE TABLE pasteries (
    pastry_id             NUMBER(6)    PRIMARY KEY,
    item_name           VARCHAR(20),
    item_price            NUMBER(10,2),
    ingredients          NUMBER(10),
    bakinghrs         NUMBER(10),
    bakers_required          NUMBER(4),
    
);

CREATE TABLE breads (
    bread_id             NUMBER(6)    PRIMARY KEY,
    item_name           VARCHAR(20),
    item_price              NUMBER(4,2),
    ingredients     NUMBER(4,2),
    bakinghrs         NUMBER(2),
    bakers_required          NUMBER(2),
    
);

CREATE TABLE additionals (
    additional_id             NUMBER(6)    PRIMARY KEY,
    item_name           VARCHAR(20),
    item_price              NUMBER(4,2),
    ingredients     NUMBER(4,2),
    bakinghrs         NUMBER(2),
    bakers_required          NUMBER(2),
    
);

CREATE TABLE items (
    item_id         NUMBER(6)    PRIMARY KEY,
    pastry_id             NUMBER(6) REFERENCES pasteries( pastry_id ),
    bread_id             NUMBER(6) REFERENCES breads(bread_id),
    additional_id             NUMBER(6)   REFERENCES additionals(additional_id),  
    
);

CREATE TABLE bakery (
     emp_id     NUMBER(10)  REFERENCES employees( emp_id ), 
     bakery_id    NUMBER(10) REFERENCES bakery_details( bakery_id ), 
    item_id         NUMBER(6)   REFERENCES items( item_id  )

    
);


CREATE TABLE transactions (
    transaction_id NUMBER(6)    PRIMARY KEY,
    number_purchased       NUMBER(10)  , 
    item_id         NUMBER(6)   REFERENCES items( item_id  ),
    item_discount NUMBER(6)
    
);





