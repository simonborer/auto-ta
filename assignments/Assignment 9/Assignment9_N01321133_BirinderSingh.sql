/*1*/
CREATE VIEW employee_schedule AS
SELECT CONCAT(bakery_employees.first_name, ' ', bakery_employees.last_name) AS "name",
bakery_shifts.start_time AS "starts",
bakery_shifts.end_time AS "ends",
bakery_locations.address AS "address"
FROM 
bakery_shifts 
LEFT JOIN bakery_employees ON bakery_shifts.employee_id=bakery_employees.employee_id
LEFT JOIN bakery_locations ON bakery_shifts.location_id = bakery_locations.location_id

 
 /*2*/
CREATE TRIGGER valid_shifts
  BEFORE INSERT ON bakery_shifts
  FOR EACH ROW
BEGIN
  DECLARE shift_interval INT;
  DECLARE total_shift_hours INT;
  
  SELECT TIME_TO_SEC(TIMEDIFF(end_time-start_time))/3600  
  INTO shift_interval
  FROM bakery_shifts;
  
  SELECT sum(TIME_TO_SEC(TIMEDIFF(end_time-start_time))/3600) 
  INTO total_shift_hours
  FROM bakery_shits
  WHERE start_time=DATE_ADD(day, INTERVAL (7 - DAYOFWEEK(day)) DAY)  /*https://dba.stackexchange.com/questions/30733/getting-the-first-day-of-week*/

   IF shift_interval < 4 OR shift_interval > 8  THEN
    SIGNAL SQLSTATE 'HY000'
      SET MESSAGE_TEXT = 'Shift should be within 4-8 hours';
  END IF;	
  
  IF total_shift_hours > 44 THEN
    SIGNAL SQLSTATE 'HY000'
      SET MESSAGE_TEXT = 'Weekly Shift should be less than 44 hours';
  END IF;	
  
END 