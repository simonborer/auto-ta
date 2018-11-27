-- Question 1
CREATE TABLE music_artist(
    artist_id NUMBER(6) 
        CONSTRAINT music_artist_artist_id_pk PRIMARY KEY,
    last_name VARCHAR2(20) 
        NOT NULL,
    first_name VARCHAR2(20) 
        NOT NULL,
    genre_id NUMBER(6) 
);

CREATE TABLE artist_albums(
    album_id NUMBER(6) 
        CONSTRAINT artist_albums_album_id_pk PRIMARY KEY,
    artist_id NUMBER(6), 
    album_name VARCHAR2(30),
    release_date 
        DATE DEFAULT SYSDATE
);

CREATE TABLE album_genres(
    genre_id NUMBER(6) 
        CONSTRAINT album_genres_genre_id_pk PRIMARY KEY,
    artist_id NUMBER(6) ,
    album_id NUMBER(6) ,
    genre CHAR(15)
);

ALTER TABLE music_artist
ADD CONSTRAINT music_artist_genre_fk
FOREIGN KEY(genre_id)
REFERENCES album_genres(genre_id);

--disable the constraint first
ALTER TABLE music_artist
DISABLE CONSTRAINT music_artist_genre_fk;
--enable after placing data
ALTER TABLE music_artist
ENABLE CONSTRAINT music_artist_genre_fk;

ALTER TABLE artist_albums
ADD CONSTRAINT artist_albums_artist_id_fk
FOREIGN KEY(artist_id)
REFERENCES music_artist(artist_id);

ALTER TABLE album_genres
ADD CONSTRAINT album_genres_artist_id_fk
FOREIGN KEY(artist_id)
REFERENCES music_artist(artist_id);

ALTER TABLE album_genres
ADD CONSTRAINT album_genres_album_id_fk
FOREIGN KEY(album_id)
REFERENCES artist_albums(album_id);


-- Question 2
INSERT INTO music_artist
VALUES(1, 'Davis', 'Miles', 3);
INSERT INTO music_artist
VALUES(2, 'Jackson', 'Michael', 1);
INSERT INTO music_artist
VALUES(3, 'Green', 'Anthony', 2);

INSERT INTO artist_albums
VALUES(1, 1, 'Kind of Blue', '1952-04-22');
INSERT INTO artist_albums
VALUES(2, 2, 'Bad', '1987-08-31');
INSERT INTO artist_albums
VALUES(3, 3, 'Avalon', '2008-08-05');

INSERT INTO album_genres
VALUES(3, 1, 1, 'JAZZ');
INSERT INTO album_genres
VALUES(1, 2, 2, 'POP');
INSERT INTO album_genres
VALUES(2, 3, 3, 'ROCK');


-- Question 3
SELECT x.artist_id, album_name, genre
FROM artist_albums x
FULL JOIN album_genres y
ON x.album_id = y.album_id;

-- Question 4
ALTER TABLE music_artist
ADD status VARCHAR2(15) DEFAULT 'inactive';

-- Question 5
ALTER TABLE artist_albums
RENAME TO discography;