/*Nick Vakulov n01301380*/
/*Q1*/  
CREATE TABLE directors
(
    director_name VARCHAR(22) PRIMARY KEY,
    date_of_birth DATE,
    director_country VARCHAR(20),
    director_id NUMBER(5)
)

CREATE TABLE movies
(
    movie_id NUMBER(5),
    movie_name    VARCHAR(50) PRIMARY KEY,
    director_name VARCHAR(22) REFERENCES directors(director_name),
    movie_country  VARCHAR(15) DEFAULT 'USA',
    movie_time CHARACTER(8)
    
)

CREATE TABLE actors
(
    actor_ID NUMBER(5),
    actor_name VARCHAR(50),
    movie_name VARCHAR(50) REFERENCES movies(movie_name),
    actor_country VARCHAR(20)    
)
DROP TABLE movies

DROP TABLE directors

DROP TABLE actors


INSERT INTO directors
VALUES('Christopher Nolan', '30-JUL-70', 'UK', '1');
INSERT INTO directors
VALUES('The Wachowskis', '21-JUN-65', 'USA', '2');
INSERT INTO directors
VALUES('Peter Jackson', '31-OCT-61', 'New Zeland', '3');
INSERT INTO directors
VALUES('Irvin Kershner','29-APR-23','USA','4');

INSERT INTO movies
VALUES(1, 'Lord of the Rings: The Fellowship of the Ring', 'Peter Jackson', 'New Zeland', '02:35:16');
INSERT INTO movies
VALUES(2, 'The Matrix', 'The Wachowskis', DEFAULT, '02:16:14');
INSERT INTO movies
VALUES(3, 'Inception', 'Christopher Nolan', DEFAULT, '02:02:12');
INSERT INTO movies
VALUES(4, 'Star Wars:The Empire stikes back', 'Irvin Kershner', DEFAULT, '01:58:45');


INSERT INTO actors
VALUES(1, 'Keanu Reeves', 'The Matrix', 'Lebanon');
INSERT INTO actors
VALUES(2, 'Leonardo DiCaprio', 'Inception', 'USA');
INSERT INTO actors
VALUES(3,'Mark Hamill','Star Wars:The Empire stikes back', 'USA');
INSERT INTO actors
VALUES(4,'Viggo Mortensen', 'Lord of the Rings: The Fellowship of the Ring', 'USA');

/*Q2*/    
INSERT INTO movies(movie_name)
VALUES('Goes for sixty seconds')

INSERT INTO movies(movie_name)
VALUES('Spider Man')

INSERT INTO movies(movie_name)
VALUES('Now you see me')

INSERT INTO directors(director_name)
VALUES('Steven Spielberg')

INSERT INTO directors(director_name)
VALUES('Stanley Kubrick')

INSERT INTO directors(director_name)
VALUES('Martin Scorsese')

INSERT INTO actors(actor_name)
VALUES('Orlando Bloom')

INSERT INTO actors(actor_name)
VALUES('Johnny Depp')

INSERT INTO actors(actor_name)
VALUES('Matt Damon')


/*Q3*/  
SELECT * 
FROM movies m
FULL OUTER JOIN directors d
ON m.director_name = d.director_name
    FULL OUTER JOIN actors a
    ON a.movie_name = m.movie_name
    
    
/*Q4*/      
ALTER TABLE actors
ADD hair_color varchar(50)

/*Q5*/  
ALTER TABLE actors
RENAME TO actress
