
1.
CREATE OR REPLACE PROCEDURE update_item_price_new
(
    /* declare in/out here */
    item_id_param               IN      VARCHAR2,
    unit_price_param            IN      NUMBER,
    update_count                OUT     INTEGER
    )   
AS
BEGIN
    UPDATE ITEMS
    SET item_id = item_id_param
    WHERE unit_price = unit_price_param;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        SELECT 0 INTO update_count FROM dual;
        ROLLBACK;
END;






2.

CREATE TABLE MY_MOVIES
(
 
  MOVIE_ID  VARCHAR(20),
  TITLE     VARCHAR(30),
  GENRE     VARCHAR (10),
  RANK_ID   INTEGER,
PRIMARY KEY (TITLE)

)

 CREATE TABLE MY_BOOKS
 
(
  BOOK_ID  VARCHAR(20),
  TITLE     VARCHAR(30),
  GENRE     VARCHAR (10),
  RANK_ID   INTEGER,
 PRIMARY KEY (TITLE)
    )   

3.
	CREATE OR REPLACE FUNCTION get_book_title
(
Entered_rank MY_BOOKS.RANK%TYPE
)
RETURN VARCHAR2
AS
 Book_title VARCHAR2;
BEGIN
SELECT TITLE
INTO book_title
FROM MY_BOOKS
WHERE rank=entered_rank;

RETURN book_title;
END;

