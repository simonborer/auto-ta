--Assignment-7--
--Section-B--
--N01297945--       
--Bakery Database Architecture-- 
--Waheguru ji Mehar Kariyo--

--   Table creation Bakery --

create table Bakery (
    
    Bakery_Unit_No            number primary key,
    Bakery_Zone               varchar(50)
      
                    )
                    
--   Table creation Employee --

create table Employee (

     Bakery_Id_No             number constraint Employee_Bakery_Id_No_FK references Bakery(Bakery_Unit_No), 
     Emp_Id                   number Primary key,
     Bakery_Employee_Type     varchar(20),
     Emp_FName                varchar(50),
     Emp_LName                varchar(50),
     Emp_Address              varchar(50),
     Emp_Mobile_No            number(10),
     Emp_Gender               char,
     Emp_Identity             varchar(50)
                                            
                      )
                      
--   Table creation  Employee_Timings  --
 
create table  Employee_Timings
                     
                     (
     Timings_Id               number       Primary key,
     Bakery_id                number       constraint   Employee_Timings_Bakery_id_FK references Bakery(Bakery_Unit_No),
     Emp_no                   number       constraint   Employee_Timings_Emp_No_FK REFERENCES Employee(Emp_Id),
     Weekly_Hours             number(2)    constraint   Employee_Timings_Hours_Week_CK Check(Weekly_Hours between 25 and 45),                    
     Shift_Timings            number(1)    constraint   Employee_Timings_Shift_Timings_CK Check(Shift_Timings>=4 and Shift_Timings<= 8)
     
                     )
                    
-- Table creation Bakery_Product (Main product table)--

create table Bakery_Product
                    
                    (
                    
      Bakery_Product_Id       number        Primary Key,
      bakery_number           number        references Bakery(Bakery_Unit_No),   
      Bakery_Product_Name     Varchar(2),
      Bakery_Product_Price    number
                    
                    )

-- Table Creation Bakery_product_Pastery  (Pastery)--

create table Bakery_product_Pastery
                    
                    (
                    
       Bakery_Product_Pastery_Id     number       Primary Key,
       Bakery_Product_Pastery_Type   varchar(20)  references Bakery_Product(Bakery_Product_Id),
       Bakery_Product_Pastery_price  number  
                    
                    )
                    
-- Table Creation Bakery_product_1  (Bread)--

create table Bakery_product_Bread
                    
                    (
                    
       Bakery_Product_Bread_Id     number       Primary Key,
       Bakery_Product_Bread_Type   varchar(20)  References Bakery_Product(Bakery_Product_Id),
       Bakery_Product_Bread_price  number  
                    
                    )
                    
-- Table Creation Bakery_product_Coffee  (Coffee)--

create table Bakery_product_Coffee
                    
                    (
                    
       Bakery_Product_Coffee_Id     number       Primary Key,
       Bakery_Product_Coffee_Type   varchar(20)  references Bakery_Product(Bakery_Product_Id),
       Bakery_Product_Coffee_price  number 
                    
                    )
                    
                    