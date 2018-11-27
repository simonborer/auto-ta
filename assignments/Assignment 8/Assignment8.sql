
CREATE OR REPLACE PROCEDURE create_items
(

    item_id_param               NUMBER,
    item_name_param            VARCHAR2,
    price_param                NUMBER,
    cost_of_ingredients_param  NUMBER,
    baking_time_param          NUMBER,
    prep_time_param            NUMBER,
    oven_space_param           NUMBER,
    temp_param                 NUMBER,
    datatype_exception             EXCEPTION

)    

AS

BEGIN
       if  item_id_param !=  employees.item_id%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        
        if  item_name_param !=  employees.item_name%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        
        if  price_param !=  employees.price_param%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        
        if  cost_of_ingredients_param !=  employees.cost_of_ingredients%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        
        
        if  baking_time_param !=  employees.baking_time%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        
        if  prep_time_param !=  employees.prep_time%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        if  oven_space_param !=  employees.oven_space%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
        if  temp_param !=  employees.temp%TYPE THEN
       RAISE datatype_exception;
        END IF; 
        
         
        
   
        INSERT INTO bakery_items
        VALUES(item_id_param,item_name_param,price_param,cost_of_ingredients_param,baking_time_param,prep_time_param,oven_space_param,temp_param);    
    COMMIT;
EXCEPTION

  WHEN datatype_exception THEN
  DBMS_OUTPUT.PUT_LINE('An unknown exception occurs');
  ROLLBACK;
  
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('An unknown exception occurs');
  ROLLBACK;
END;

CALL create_items('T','REINA',23,24,55,4,5,45);



---2-----

SET SERVEROUTPUT ON;

DECLARE 
       d     number(2);
  CURSOR cursor_x IS 
    SELECT item_id,item_name, price, cost_of_ingredients,baking_time,prep_time, oven_space,temp 
    FROM bakery_items; 
    
BEGIN
    select to_char(to_date(sysdate), 'w') into d from dual;
    DBMS_OUTPUT.PUT_LINE(CHR(10)||'Check out our everyday low prices: '||CHR(10));

    
    IF d = 1 THEN
    FOR cursor_raw IN cursor_x
    LOOP
        IF cursor_raw.item_id=2 THEN
           cursor_raw.price := 0.2 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        ELSE IF cursor_raw.item_id=3 THEN
           cursor_raw.price := 0.1 *  cursor_raw.price;
           DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
           
        ELSE IF cursor_raw.item_id=4 THEN
            cursor_raw.price := 0.1 *  cursor_raw.price; 
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
    END LOOP;
    
    END IF;
    
    
     
    IF d = 2 THEN
    FOR cursor_raw IN cursor_x
    LOOP
        IF cursor_raw.item_id=3 THEN
           cursor_raw.price := 0.2 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
         END IF; 
         
        IF cursor_raw.item_id=4 THEN
           cursor_raw.price := 0.1 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF;  
        
        ELSE IF cursor_raw.item_id=5 THEN
            cursor_raw.price := 0.1 *  cursor_raw.price; 
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
    END LOOP;
    
    END IF;

    IF d = 3 THEN
    FOR cursor_raw IN cursor_x
    LOOP
        IF cursor_raw.item_id=4 THEN
           cursor_raw.price := 0.2 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
        
        IF cursor_raw.item_id=5 THEN
           cursor_raw.price := 0.1 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
         END IF; 
         
        IF cursor_raw.item_id=6 THEN
            cursor_raw.price := 0.1 *  cursor_raw.price; 
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
    END LOOP;
    
    END IF;
    
    
    IF d = 4 THEN
    FOR cursor_raw IN cursor_x
    LOOP
        IF cursor_raw.item_id=5 THEN
           cursor_raw.price := 0.2 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
       IF cursor_raw.item_id=6 THEN
           cursor_raw.price := 0.1 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
        
        IF cursor_raw.item_id=7 THEN
            cursor_raw.price := 0.1 *  cursor_raw.price; 
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
    END LOOP;
    
    END IF;
    
    
    
    IF d = 5 THEN
    FOR cursor_raw IN cursor_x
    LOOP
        IF cursor_raw.item_id=6 THEN
           cursor_raw.price := 0.2 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
     
         IF cursor_raw.item_id=8 THEN
           cursor_raw.price := 0.1 *  cursor_raw.price;
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
        
        IF cursor_raw.item_id=7 THEN
            cursor_raw.price := 0.1 *  cursor_raw.price; 
            DBMS_OUTPUT.PUT_LINE(CHR(10)||'The Price of '||cursor_raw.item_name||' is '||cursor_raw.price||CHR(10));
        END IF; 
    END LOOP;
    
    END IF;
    
   

END;

