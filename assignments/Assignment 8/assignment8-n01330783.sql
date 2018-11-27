--Jetalbahen Tandel
--Assignment 8
--1


CREATE OR REPLACE PROCEDURE update_menus 
(  
  add_menuid      NUMBER,
  add_itemtype    VARCHAR2,
  add_itemname   VARCHAR2,
  add_itemprice   NUMBER
  
) 
AS 
BEGIN 
   INSERT INTO menus
   VALUES (add_menuid,add_itemtype,add_itemname,add_itemprice);
   COMMIT; 
   
 EXCEPTION 
   WHEN OTHERS THEN 
    ROLLBACK; 
END; 
/

CALL update_menus(1,'bread','egglessbread',2);

--Jetalbahen Tandel
--Assignment 8
--2
SET SERVEROUTPUT ON;

DECLARE
     week_day         VARCHAR2(20);
     weekly_discount_item  VARCHAR2(15);
     item_discount_price   NUMBER(4,3);
     weekly_minor_discount_item  VARCHAR2(15);
     minor_item_discount_price   NUMBER(2,2);
     
     weekly_secminor_discount_item  VARCHAR2(20);
    secminor_item_discount_price NUMBER(2,3);
    
BEGIN
   SELECT  menu_id ,item_name,item_price  FROM   menus ORDER BY RAND();
   weekly_discount_item := item_name;
   
   SELECT  menu_id ,item_name,item_price  FROM   menus ORDER BY RAND();
   weekly_minor_discount_item := item_name;
    
   SELECT  menu_id ,item_name,item_price  FROM   menus ORDER BY RAND();
   weekly_secminor_discount_item := item_name;
   
   
SELECT RAND(menu_id)
INTO  weekly_discount_item
FROM  menus;

SELECT RAND(menu_id)
INTO  weekly_minor_discount_item
FROM  menus;

SELECT RAND(menu_id)
INTO  weekly_secminor_discount_item
FROM  menus;

item_discount_price := item_price*0.8;
minor_item_discount_price := item_price*0.9;
secminor_item_discount_price := item_price*0.9;

IF EXTRACT(DAY FROM SYSDATE)>=1 AND EXTRACT (DAY FROM SYSDATE)<=7 THEN
  DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discount_item ||'is only' ||item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Take 10% off' || weekly_minor_discount_item || minor_item_discount_price ||
                        'and' || weekly_secminor_discount_item ||secminor_item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices:');
                        
ELSIF EXTRACT(DAY FROM SYSDATE)>=8 AND EXTRACT (DAY FROM SYSDATE)<=14 THEN
  DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discount_item ||'is only' ||item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Take 10% off' || weekly_minor_discount_item || minor_item_discount_price ||
                        'and' || weekly_secminor_discount_item ||secminor_item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices:');
                        
ELSIF EXTRACT(DAY FROM SYSDATE)>=15 AND EXTRACT (DAY FROM SYSDATE)<=21 THEN
  DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discount_item ||'is only' ||item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Take 10% off' || weekly_minor_discount_item || minor_item_discount_price ||
                        'and' || weekly_secminor_discount_item ||secminor_item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices:');
ELSE
   DBMS_OUTPUT.PUT_LINE('This week special:' || weekly_discount_item ||'is only' ||item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Take 10% off' || weekly_minor_discount_item || minor_item_discount_price ||
                        'and' || weekly_secminor_discount_item ||secminor_item_discount_price);
  DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices:');
  
  
  END IF;
END;
/
