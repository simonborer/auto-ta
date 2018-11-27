//Jing Cheng
//Student #: n01289618

//Question 1: Create a stored procedure or function for anything from the previous weeks, the syntax of which you find difficult to remember.
CREATE OR REPLACE PROCEDURE update_character_level
(
  character_id_number IN VARCHAR2,
  character_level IN VARCHAR2,
  character_hitpoints IN VARCHAR2,
  character_armour_class IN VARCHAR2,
  character_strength IN VARCHAR2,
  character_dexterity IN VARCHAR2,
  character_constitution IN VARCHAR2,
  character_intelligence IN VARCHAR2,
  character_wisdom IN VARCHAR2,
  character_charisma IN VARCHAR2
)
AS
BEGIN
  UPDATE characters_copy
  SET char_level = character_level,
  hitpoints = character_hitpoints,
  armour_class = character_armour_class,
  strength = character_strength,
  dexterity = character_dexterity,
  constitution = character_constitution,
  intelligence = character_intelligence,
  wisdom = character_wisdom,
  charisma = character_charisma
  WHERE character_id = character_id_number;
  
  COMMIT;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;

CALL update_character_level('0048c5', 4, 30, 18, 15, 18, 15, 18, 20, 11);

//Question 2
CREATE TABLE my_books
(
  book_id NUMBER(6) PRIMARY KEY,
  book_title VARCHAR2(20),
  book_genre VARCHAR2(20),
  book_rank NUMBER(3)

)
CREATE TABLE my_movies
(
  movie_id NUMBER(6) PRIMARY KEY,
  movie_title VARCHAR2(20),
  movie_genre VARCHAR2(20),
  movie_rank NUMBER(3)
)

CREATE OR REPLACE PROCEDURE update_books_movies
(
book_id_number IN NUMBER,
book_title_info IN VARCHAR2,
book_genre_info IN VARCHAR2,
book_rank_number IN NUMBER,
movie_id_number IN NUMBER,
movie_title_info IN VARCHAR2,
movie_genre_info IN VARCHAR2,
movie_rank_number IN NUMBER
)
AS
BEGIN
  INSERT INTO my_books(book_id, book_title, book_genre, book_rank)
  VALUES(book_id_number, book_title_info, book_genre_info, book_rank_number);
  
  INSERT INTO my_movies(movie_id, movie_title, movie_genre, movie_rank)
  VALUES(movie_id_number, movie_title_info, movie_genre_info, movie_rank_number);

  COMMIT;
EXCEPTION 
  WHEN OTHERS THEN
  ROLLBACK;
END;

CALL update_books_movies(1, 'A Clockwork Orange', 'Drama/Mystery', 8, 1, 'Zootopia', 'Animated', 5);
CALL update_books_movies(2, 'Ulysses', 'Novel', 3, 2, 'Fast and the Furious', 'Action/Adventure', 2);
CALL update_books_movies(3, 'Moby Dick', 'Novel', 2, 3, 'Transformers', 'Action', 3); 

select * FROM my_books
select * FROM my_movies

//Question 3: Create a stored function that can return the title based on your ranking.
CREATE OR REPLACE FUNCTION get_book_title
(
  book_ranking_param  my_books.book_rank%TYPE
)
RETURN VARCHAR2
AS
  book_title_var VARCHAR2(20);
BEGIN
  SELECT book_title
  INTO book_title_var
  FROM my_books
  WHERE book_rank = book_ranking_param;
  
  RETURN book_title_var;
END;
/

SELECT book_title
FROM my_books
WHERE book_title = get_book_title(2)

CREATE OR REPLACE FUNCTION get_movie_title
(
movie_ranking_param my_movies.movie_rank%TYPE
)
RETURN VARCHAR2
AS
  movie_title_var VARCHAR2(20);
BEGIN
  SELECT movie_title
  INTO movie_title_var
  FROM my_movies
  WHERE movie_rank = movie_ranking_param;
  
  RETURN movie_title_var;
END;
/

SELECT movie_title
FROM my_movies
WHERE movie_title = get_movie_title(5)