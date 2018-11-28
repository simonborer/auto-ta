CREATE TABLE sledge (
op_name VARCHAR(11) UNIQUE,
country VARCHAR(11) NOT NULL,
gender CHAR(1) PRIMARY KEY,  
armor_rating NUMBER(2),
kd NUMERIC(3, 9) 
)
CREATE TABLE blackbeard (
op_name VARCHAR(11) UNIQUE,
country VARCHAR(11) PRIMARY KEY,
gender CHAR(1) REFERENCE sledge(gender),  
armor_rating NUMBER(2),
kd NUMERIC(3, 9) 
)
CREATE TABLE castle (
op_name VARCHAR(11) UNIQUE,
country VARCHAR(11) REFERENCES blackbeard(country),
gender CHAR(1) NOT NULL,  
armor_rating NUMBER(2) PRIMARY KEY,
kd NUMERIC(3, 9) 
)

INSERT INTO sledge
VALUES ('Sledge', 'US', 'm', 2, 0)

INSERT INTO Blackbeard
VALUES ('Blackbeard', 'US', 'm', 2, 0)

INSERT INTO castle
VALUES ('Castle', 'US', 'm', 2, 0)

SELECT *
FROM sledge s
FULL JOIN blackbeard b
ON s.gender = b.gender
FULL JOIN castle c 
ON b.gender = c.gender

ALTER TABLE sledge
ADD ability VARCHAR(19)

SELECT * FROM sledge

ALTER TABLE castle
RENAME TO castle_sucks