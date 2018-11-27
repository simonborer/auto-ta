//Question 1 
create view employee_schedule as
select concat(be.first_name, ' ', be.last_name) as Name, bs.start_time, bs.end_time, bl.address
from bakery_employees be 
join bakery_locations bl
on be.default_loc = bl.location_id
join bakery_shifts bs
on bs.employee_id = be.employee_id
order by start_time

select *
from employee_schedule


//Question 2 
DELIMITER $$
create trigger shift_constraint
before INSERT on bakery_shifts
for each row
begin
	declare shift_start_time DATETIME;
	declare shift_end_time DATETIME;

select start_time 
into shift_start_time
from bakery_shifts 
group by shift_id
having MAX(shift_id);

select end_time
into shift_end_time
from bakery_shifts
group by shift_id
having MAX(shift_id);

if (SELECT(TIMESTAMPDIFF(hour, shift_start_time, shift_end_time) > 8) or (SELECT(TIMESTAMPDIFF(hour, shift_start_time, shift_end_time) < 4))) then
signal sqlstate 'HY000'
set MESSAGE_TEXT = "Shift must be greater than 4 hours and less than 8 hours duration.";
end if;

end
$$

select * from bakery_shifts
call insert_bakery_shifts(4, 1, 1, '2018-11-23 09:00:00', '2018-11-23 22:00:00');
DELETE from bakery_shifts where shift_id = 4;
call insert_bakery_shifts(5, 1, 1, '2018-11-24 09:00:00', '2018-11-24 22:00:00');
call insert_bakery_shifts(6, 1, 1, '2018-11-25 09:00:00', '2018-11-25 22:00:00');
call insert_bakery_shifts(7, 1, 1, '2018-11-26 09:00:00', '2018-11-26 22:00:00');
