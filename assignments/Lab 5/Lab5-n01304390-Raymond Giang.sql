/*  Lab 5
    Name: Raymond Giang
    Student Number: n01304390 */
    
/* 1. Create 3 tables. Each should have a primary key, and a foreign key that references one of your other tables' primary 
key. Each should have 4 columns. Use 4 different data types. Use at least 2 kinds of constraint besides primary and foreign 
keys. Use at least 1 default value. */

CREATE TABLE pet_owners (
    owner_id        NUMBER(5)
        CONSTRAINT pet_owners_owner_id_pk PRIMARY KEY,
    owner_name      VARCHAR2(30)
        CONSTRAINT pet_owners_owner_name_nn NOT NULL,
    favourite_pet   NUMBER(5),
    phone_number    VARCHAR2(12)
        CONSTRAINT pet_owners_phone_number_ck CHECK 
            (phone_number LIKE '___-___-____')
);

CREATE TABLE pets (
    pet_id        NUMBER(5)
        CONSTRAINT pets_pet_id_pk PRIMARY KEY,
    owner_id      NUMBER(5)
        CONSTRAINT pets_owner_id_fk REFERENCES pet_owners(owner_id),
    species       VARCHAR2(15)
        CONSTRAINT pets_species_nn NOT NULL,
    aquire_date   DATE
        DEFAULT   SYSDATE
);

ALTER TABLE pet_owners
ADD CONSTRAINT pet_owners_favourite_pet_fk 
    FOREIGN KEY (favourite_pet)
    REFERENCES pets (pet_id);

CREATE TABLE pet_accessories (
    accessory_id    NUMBER(5)
        CONSTRAINT pet_accessories_accessory_id_pk PRIMARY KEY,
    pet_id          NUMBER(5)
        CONSTRAINT pet_accessories_pet_id_fk REFERENCES pets(pet_id),
    accessory_type  CHAR(4)
        CONSTRAINT pet_accessories_accessory_type NOT NULL,
    accessory_name  VARCHAR2(20)
);

/* 2. Insert at least 3 rows of data into each table. */

INSERT INTO pet_owners (owner_id, owner_name, phone_number)
VALUES (10001, 'John Smith', '905-123-1234');
INSERT INTO pet_owners (owner_id, owner_name, phone_number)
VALUES (10002, 'Lisa Edwards', '647-321-1234');
INSERT INTO pet_owners (owner_id, owner_name, phone_number)
VALUES (10003, 'Bob Johnson', '416-123-4321');

INSERT INTO pets (pet_id, owner_id, species, aquire_date)
VALUES (20001, 10003, 'Dog', '15-JAN-01');
INSERT INTO pets (pet_id, owner_id, species)
VALUES (20002, 10002, 'Cat');
INSERT INTO pets (pet_id, owner_id, species, aquire_date)
VALUES (20003, 10002, 'Goldfish', '17-NOV-15');

UPDATE pet_owners
SET favourite_pet = 20001
WHERE owner_id = 10003;
UPDATE pet_owners
SET favourite_pet = 20002
WHERE owner_id = 10002;

INSERT INTO pet_accessories (accessory_id, pet_id, accessory_type, accessory_name)
VALUES (30001, 20001, 'CLTH', 'Hat');
INSERT INTO pet_accessories (accessory_id, pet_id, accessory_type, accessory_name)
VALUES (30002, 20001, 'TOYS', 'Chew Toy');
INSERT INTO pet_accessories (accessory_id, pet_id, accessory_type, accessory_name)
VALUES (30003, 20002, 'TOYS', 'Ball of Yarn');

/* 3. Write a statement that does a FULL JOIN on all three tables. */
SELECT * 
FROM pet_owners po
    FULL JOIN pets p
        ON po.owner_id = p.owner_id
    FULL JOIN pet_accessories pa
        ON p.pet_id = pa.pet_id;

/* 4. Add a column to one of your tables. */
ALTER TABLE pets
ADD pet_name VARCHAR2(20);

/* 5. Rename one of your tables. */
ALTER TABLE pet_accessories
RENAME TO pet_items;

/* ASIDE */

SELECT * FROM pet_owners;
SELECT * FROM pets;
SELECT * FROM pet_accessories;
SELECT * FROM pet_items;

ALTER TABLE pet_owners
DROP CONSTRAINT pet_owners_favourite_pet_fk;

DROP TABLE pet_items;
DROP TABLE pet_accessories;
DROP TABLE pets;
DROP TABLE pet_owners;
