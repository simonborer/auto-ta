(kindly check note at the end of this chart)


1.
 create table bakery_main(
   location_name  varchar(10) primary key,
   employee_id    number (10) ref key employee_details(employee_id),
   address        varchar(30)
  
);

2.create table employee_department(
   dapartment_name  varchar(10) primary key,
   employee_id      number(10)  ref key employee_details(employee_id),	
   location_name    varchar (10) ref. key bakery_main(location_name)
  
);

3. create table bakery_items (
    item_name        varcha(20) primary key,
    location_name    varchar (10) ref. key bakery_main(location_name),
    item_number      number(10),
    item_type	     varchar(20),
    made_date	     date,
    best_before      date,
    production_cost  number(10),
    price 	     number (10),
    
);

4. create table other_items (
     item_description  varchar(10) primary key,
     item_price        number (10),
     item_cost	       number (10),
     selling_date      date,
);

5. create table employee_details(
     employee_id      number(10) primary key,
     first_name	      varchar(20),
     last_name	      varchar (20),
     hire_date	      date,
     salary	      number,
     department_name  varchar(10) ref key employee_department (department_name),
     location_name    varchar (10) ref. key bakery_main(location_name)

);

6. create table production_requirment(
    item_id		number(10) primary key,
    item_name		varcha(20) ref key bakery_item (item_name),
    oven_space		number (10)
    ingredients		varchar(20),
    baking_time         number(5),
    oven_temp		number (5),
    prepation_time	number (5)
    
);
7. create table shifts_details(
     shift_id		number(10) primary key,
     employee_id	number (10)   ref key employee_details(employee_id),
     start_time		number (5),
     end_time		number (5),
     location_name 	varchar (10) ref. key bakery_main(location_name)
);

8. create table transcation_details(
     transaction_id	numnber (10) primary key
     item_name		varcha(20) ref key bakery_item (item_name), 
     transaction_date   date,
     location_name      varchar (10) ref. key bakery_main(location_name)
);

9.create table discount_details(
     discount_id	number(10) primary key,
     item_name		varcha(20) ref key bakery_item (item_name),
     week_high_discount number (5),
     week_less_discount number (5),
     employee_discount  number (5)
     location_name	varchar (10) ref. key bakery_main(location_name),
     employee_id        number (10)   ref key employee_details(employee_id),
     
);


{As i had submitted this assignment late, some references are taken from your examples}