
create database Bakery;
create table B_Location (
  
  B_unit INT, 
  B_Address VARCHAR,
  Postal_code VARCHAR,
  City VARCHAR
  
);
insert into B_Location values (1,'adrss1', 'L1M1N1','Toronto');
insert into B_Location values (2,'adrss2', 'L2M2N2','Toronto');
insert into B_Location values (3'adrss3', 'L3M3N3'.'Toronto');

create table Employees (
   
  Employee_id INT,
  Employee_fname VARCHAR,
  Employee_lname VARCHAR,
  Employee_type VARCHAR
  
);
insert into Employees values ( 100, 'Ray', 'Johnson', 'Cashier');
insert into Employees values ( 101, 'Rupinder ', 'Singh', 'Cashier');
insert into Employees values (102, 'Arun ', 'Sharma', 'Baker');
insert into Employees values (103, 'Ken ', 'Li', 'Baker');

create table Menu (
   
  item_number INT,
  item_type VARCHAR,
  item_ingredient_cost INT,
  item_labour_cost INT,
  Baking_time VARCHAR,
  Baking_prep_time VARCHAR,
  Baking_Temp VARCHAR,
  Baking_Space VARCHAR
  
  
);
insert into Menu values ( 01, 'Pineapple pastery', 2.05, 2  , '1 hr' , '10 min' , '180 °C',' 2ovens'  );
insert into Menu values ( 02, 'Chocolate pastery',2.50, 2 , '1 hr' , '10 min' , '180 °C',' 2ovens');
insert into Menu values ( 03, 'Straberry pastery',1.90, 2 , '1 hr' , '10 min' , '180 °C',' 2ovens' );
insert into Menu values ( 04, 'Blueberry pastery',3.10, 2 , '1 hr' , '10 min' , '180 °C',' 2ovens' );
insert into Menu values ( 05, 'Vanilla pastery', 1.95, 2 , '1 hr' , '10 min' , '180 °C',' 2ovens');
insert into Menu values ( 06, 'Mango pastery', 3.05, 2 , '1 hr' , '10 min' , '180 °C',' 2ovens' );
insert into Menu values ( 07,'Multigrain Bread', 2.25, 3 , '2 hr' , '15 min' , '230 °C',' 4ovens')
insert into Menu values (08,'Oat Bread', 'Latte', 2.10, 3 , '2 hr' , '15 min' , '230 °C',' 4ovens')
insert into Menu values (09,'Whole wheat Bread', 2.50,3 , '2 hr' , '15 min' , '230 °C',' 4ovens' )
insert into Menu values (10,'Italian Bread', 2.75, 3 , '2 hr' , '15 min' , '230 °C',' 4ovens' )
insert into Menu values (11,'Coffee', 1.10, 1 , '10 min' , ' 2 min' , 'null',' null')
 

create table Employee_schedule (
   
  Employee_id INT,
  B_unit INT,
  weekly_Hours_permit INT,
  Shift_duration INT,
  Shift_date Date
  
  
);
insert into Employee_schedule values ( 100, 1, 25 , 5 , '11-10-18' );
insert into Employee_schedule values ( 101, 2, 30 , 6 , '11-10-18' );
insert into Employee_schedule values ( 102, 2, 35 , 7 , '11-10-18' );
insert into Employee_schedule values ( 103, 3, 40 , 8 , '11-10-18' );
insert into Employee_schedule values ( 100, 2, 25 , 4 , '12-10-18' );
insert into Employee_schedule values ( 101, 1, 30 , 5 , '12-10-18' );
insert into Employee_schedule values ( 102, 1, 35 , 8 , '12-10-18' );
insert into Employee_schedule values ( 103, 3, 40 , 7 , '12-10-18' );
insert into Employee_schedule values ( 102, 2, 35 , 7 , '14-10-18' );
insert into Employee_schedule values ( 103, 2, 40 , 7 , '14-10-18' );


create table B_Transactions (
   
  Transaction_id VARCHAR,
  Transaction_type VARCHAR,
  Transaction_date date
  
  
  
);
insert into B_Transactions values ( 'T1', 'Payment' , '1-10-18' );
insert into B_Transactions values ( 'T2', 'Payment' , '2-10-18' );
insert into B_Transactions values ( 'T3', 'Maintenence work' , '3-10-18' );
insert into B_Transactions values ( 'T4', 'Maintenence work' , '4-10-18' );
insert into B_Transactions values ( 'T5', 'Equipment' , '4-10-18' );
insert into B_Transactions values ( 'T6', 'Ingredients Purchase' , '5-10-18' );
insert into B_Transactions values ( 'T7', 'Payment' , '6-10-18' );
insert into B_Transactions values ( 'T8', 'Payment' , '6-10-18' );
insert into B_Transactions values ( 'T9', 'Ingredient' , '7-10-18' );
insert into B_Transactions values ( 'T10', 'Equipment' , '7-10-18' );








