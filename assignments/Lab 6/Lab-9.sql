--Jay Patel
--Ques.1
--Lab. 9
CREATE OR REPLACE PROCEDURE invoices_ivn
    (
    credit_payment_total NUMBER,
    new_debit_total NUMBER
    )
    AS
    BEGIN
    UPDATE INVOICES
    SET payment_total=credit_payment_total
    WHERE credit_total=new_debit_total;
    COMMIT;
    END;
    /
    CALL invoices_ivn(0,0);
    
    
--Ques.2

create table my_Books
(
Book_id number(10) primary key,
Book_Title varchar2(20),
Book_genre varchar2(20),
Book_rank number(10),
Book_author varchar2(20)
);

create table my_movies
(
Movie_id number(10) primary key,
Movie_title varchar2(20),
Movie_genre varchar2(20),
Movie_rank number(10)
);

--calling a function--
call insert_data(213,'Love-ni-bhavai','love-story',21);
call insert_data(311,'kite','gujarati-festival',31);
call inser_data(432,'Call-of-duty','gaming',65);
call insert_data(555,'Singham','police-power',77);

--Ques.3
create or replace function return_author_name
(
a_name varchar
)
return varchar
as 
Book_title varchar(20);
begin
select Book_title
into title from My_Books
where Book_author = a_name;

return Book_title;
commit;
end;

/
select return_author_name('j.p') 
from dual;
