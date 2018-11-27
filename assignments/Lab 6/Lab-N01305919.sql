--Parampreet Singh Grewal
--N01305919
--LAB-6

1.  CREATE OR REPLACE PROCEDURE invoices_invcs
	(
	new_payment_total NUMBER,
	new_credit_total NUMBER
	)
	AS 
	BEGIN
	UPDATE INVOICES
	SET payment_total=new_payment_total
	WHERE credit_total=new_credit_total;
	COMMIT;
	END;
	/
	CALL invoices_invcs(2312.2,0);


2.	--Parampreet-N01305919
	CREATE TABLE my_books
	(
	book_id number(7) PRIMARY KEY,
	book_title varchar(25) NOT NULL,
	book_genre varchar(25) NOT NULL,
	book_rank  number(30) NOT NULL
	);



	CREATE TABLE my_movies
	(
	movie_id number(7) PRIMARY KEY,
	movie_title varchar(25) NOT NULL,
	movie_genre varchar(25) NOT NULL,
	movie_rank  number(30) NOT NULL
	);
	CREATE OR REPLACE PROCEDURE insert_data
	(
	book_id NUMBER,
	book_title VARCHAR,
	book_genre  VARCHAR,
	book_rank NUMBER
	)
	AS BEGIN
	INSERT INTO my_books(book_id,book_title,book_genre,book_rank)
	VALUES (book_id,book_title,book_genre,book_rank);
	COMMIT;
	EXCEPTION WHEN OTHERS THEN ROLLBACK;
	END;
	/
	CALL insert_data(331,'2-States','Love story',11);
	CALL insert_data(332,'Road to heaven','Life Experience',24);
	CALL insert_data(333,'Oone thing','comedy',05);


3.	--Parampreet N01305919
	
	
