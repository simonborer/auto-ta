-- Question 2
SET SERVEROUTPUT ON;

DECLARE
major_discount NUMBER(5,2);
major_item_name VARCHAR2(30);
TYPE minor_discount_varray IS VARRAY(2) OF NUMBER(5,2);
TYPE minor_item_name_varray IS VARRAY(2) OF VARCHAR2(30);
minor_discount minor_discount_varray := minor_discount_varray();
minor_item_name minor_item_name_varray := minor_item_name_varray();
item_index INTEGER := 0;

CURSOR discount_items IS 
    SELECT item_description, item_price, discount_id, item_price - item_price * discount_amt AS Discount_Price
    FROM item_discounts
    JOIN menu
    USING(discount_id)
    JOIN product_items
    USING(item_id)
    WHERE menu_week_start = TO_DATE('18-11-19', 'YY-MM-DD')
    ORDER BY discount_id DESC;

BEGIN
    FOR item_discount in discount_items LOOP
        IF(item_discount.discount_id = 3) THEN
            major_item_name := item_discount.item_description;
            major_discount := item_discount.discount_price;
        END IF;
        IF(item_discount.discount_id = 2) THEN
            item_index := item_index + 1;
            minor_item_name.EXTEND;
            minor_discount.EXTEND;
            minor_discount(item_index) := item_discount.discount_price;
            minor_item_name(item_index) := item_discount.item_description;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('This week''s special: ' || major_item_name ||' is only '|| major_discount);
    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || minor_item_name(1) || ' (' || minor_discount(1) ||') and ' || minor_item_name(2) || ' (' || minor_discount(2) || ').');
    DBMS_OUTPUT.PUT_LINE('Check out our everyday low prices: ');
    
    FOR no_discount in discount_items LOOP
        IF(no_discount.discount_id IS NULL) THEN
            DBMS_OUTPUT.PUT_LINE('Nothing Found');
        ELSE
            IF(no_discount.discount_id = 1) THEN
                DBMS_OUTPUT.PUT_LINE(no_discount.item_description || ' - ' || no_discount.item_price);
            END IF;
        END IF;
    END LOOP;
END;


/** reference for using the v array 
https://www.tutorialspoint.com/plsql/plsql_arrays.htm

DECLARE 
   CURSOR c_customers is 
   SELECT  name FROM customers; 
   type c_list is varray (6) of customers.name%type; 
   name_list c_list := c_list(); 
   counter integer :=0; 
BEGIN 
   FOR n IN c_customers LOOP 
      counter := counter + 1; 
      name_list.extend; 
      name_list(counter)  := n.name; 
      dbms_output.put_line('Customer('||counter ||'):'||name_list(counter)); 
   END LOOP; 
END; 
**/

