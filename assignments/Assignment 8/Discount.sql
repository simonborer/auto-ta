SET SERVEROUTPUT ON;
DECLARE
    dis_mj INT;
    dis_mn INT;
    tdate VARCHAR(5);
    
    food_name_1  VARCHAR2(255);
    food_name_2  VARCHAR2(255);
    food_name_3  VARCHAR2(255);
    
    food_cost_1 NUMBER;
    food_cost_2 NUMBER;
    food_cost_3 NUMBER;
    
    dis_cost_1 NUMBER;
    dis_cost_2 NUMBER;
    dis_cost_3 NUMBER;

BEGIN
    dis_mj:= 20;
    dis_mn:=10;
    
----    SELECT dbms_random.value(1, 20) num INTO dis_mj FROM dual; -- random discount
----    SELECT dbms_random.value(1, 5) num INTO food_r FROM dual; --random food
--    SELECT food_name INTO food_name_1 FROM foods  WHERE food_id = food_r;
--    SELECT food_cost INTO fc FROM foods  WHERE food_id = food_r;
--    SELECT sysdate INTO tdate FROM dual;
--    dis_cost_1:=ROUND(fc -(fc*(dis_mj/100)), 2);
--    dis_cost_2:=ROUND(fc -(fc*(dis_mn/100)), 2);
--    dis_cost_3:=ROUND(fc -(fc*(dis_mn/100)), 2);
--    DBMS_OUTPUT.PUT_LINE('This week special: ' || food_name_1 || ' is only ' || dis_cost_1 || '$');
--    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || food_name_2 || ' ' || dis_cost_2 || '$' || ' and ' || food_name_3 || ' ' || dis_cost_3 || '$');

--Simon, I did it using randomizer, but I'm not sure that it's allow. Can u tell me can I use this way or not?
    
select TO_CHAR(SYSDATE, 'dd') into tdate from dual;
IF tdate >= 1 and tdate <=7 THEN
    SELECT food_name INTO food_name_1 FROM foods  WHERE food_id = 1;
    SELECT food_cost INTO food_cost_1 FROM foods  WHERE food_id = 1;
    SELECT food_name INTO food_name_2 FROM foods  WHERE food_id = 2;
    SELECT food_cost INTO food_cost_2 FROM foods  WHERE food_id = 2;
    SELECT food_name INTO food_name_3 FROM foods  WHERE food_id = 3;
    SELECT food_cost INTO food_cost_3 FROM foods  WHERE food_id = 3;
    dis_cost_1:=ROUND(food_cost_1 -(food_cost_1*(dis_mj/100)), 2);
    dis_cost_2:=ROUND(food_cost_2 -(food_cost_2*(dis_mn/100)), 2);
    dis_cost_3:=ROUND(food_cost_3 -(food_cost_3*(dis_mn/100)), 2);
    DBMS_OUTPUT.PUT_LINE('This week special: ' || food_name_1 || ' is only ' || dis_cost_1 || '$');
    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || food_name_2 || ' ' || dis_cost_2 || '$' || ' and ' || food_name_3 || ' ' || dis_cost_3 || '$');
ELSIF tdate >= 8 and tdate <=14 THEN
    SELECT food_name INTO food_name_1 FROM foods  WHERE food_id = 4;
    SELECT food_cost INTO food_cost_1 FROM foods  WHERE food_id = 4;
    SELECT food_name INTO food_name_2 FROM foods  WHERE food_id = 5;
    SELECT food_cost INTO food_cost_2 FROM foods  WHERE food_id = 5;
    SELECT food_name INTO food_name_3 FROM foods  WHERE food_id = 6;
    SELECT food_cost INTO food_cost_3 FROM foods  WHERE food_id = 6;
    dis_cost_1:=ROUND(food_cost_1 -(food_cost_1*(dis_mj/100)), 2);
    dis_cost_2:=ROUND(food_cost_2 -(food_cost_2*(dis_mn/100)), 2);
    dis_cost_3:=ROUND(food_cost_3 -(food_cost_3*(dis_mn/100)), 2);
    DBMS_OUTPUT.PUT_LINE('This week special: ' || food_name_1 || ' is only ' || dis_cost_1 || '$');
    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || food_name_2 || ' ' || dis_cost_2 || '$' || ' and ' || food_name_3 || ' ' || dis_cost_3 || '$');
ELSIF tdate >= 15 and tdate <=21 THEN
    SELECT food_name INTO food_name_1 FROM foods  WHERE food_id = 7;
    SELECT food_cost INTO food_cost_1 FROM foods  WHERE food_id = 7;
    SELECT food_name INTO food_name_2 FROM foods  WHERE food_id = 8;
    SELECT food_cost INTO food_cost_2 FROM foods  WHERE food_id = 8;
    SELECT food_name INTO food_name_3 FROM foods  WHERE food_id = 9;
    SELECT food_cost INTO food_cost_3 FROM foods  WHERE food_id = 9;
    dis_cost_1:=ROUND(food_cost_1 -(food_cost_1*(dis_mj/100)), 2);
    dis_cost_2:=ROUND(food_cost_2 -(food_cost_2*(dis_mn/100)), 2);
    dis_cost_3:=ROUND(food_cost_3 -(food_cost_3*(dis_mn/100)), 2);
    DBMS_OUTPUT.PUT_LINE('This week special: ' || food_name_1 || ' is only ' || dis_cost_1 || '$');
    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || food_name_2 || ' ' || dis_cost_2 || '$' || ' and ' || food_name_3 || ' ' || dis_cost_3 || '$');
ELSE 
    SELECT food_name INTO food_name_1 FROM foods  WHERE food_id = 10;
    SELECT food_cost INTO food_cost_1 FROM foods  WHERE food_id = 10;
    SELECT food_name INTO food_name_2 FROM foods  WHERE food_id = 11;
    SELECT food_cost INTO food_cost_2 FROM foods  WHERE food_id = 11;
    SELECT food_name INTO food_name_3 FROM foods  WHERE food_id = 12;
    SELECT food_cost INTO food_cost_3 FROM foods  WHERE food_id = 12;
    dis_cost_1:=ROUND(food_cost_1 -(food_cost_1*(dis_mj/100)), 2);
    dis_cost_2:=ROUND(food_cost_2 -(food_cost_2*(dis_mn/100)), 2);
    dis_cost_3:=ROUND(food_cost_3 -(food_cost_3*(dis_mn/100)), 2);
    DBMS_OUTPUT.PUT_LINE('This week special: ' || food_name_1 || ' is only ' || dis_cost_1 || '$');
    DBMS_OUTPUT.PUT_LINE('Take 10% off ' || food_name_2 || ' ' || dis_cost_2 || '$' || ' and ' || food_name_3 || ' ' || dis_cost_3 || '$');
END IF;
END;