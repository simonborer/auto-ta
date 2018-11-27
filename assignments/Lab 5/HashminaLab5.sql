CREATE TABLE Students (

    studentNumber int,    
    subject varchar(255),
    Programme varchar(255),
    SLastName varchar(255),
    SFirstName varchar(255),
    SAddress varchar(255),
    SCountry varchar(255)
);

SELECT * FROM students

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(100, 'Singh', 'Hashmina', 'Brampton', 'India', 'Database', 'Web_development' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(101, 'Kaur', 'Rupinder', 'Brampton', 'India', 'Database', 'Web_development' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(102, 'Kaur', 'Amarpreet', 'Etobicoke', 'India', 'Digital Design', 'Web_development' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(200, 'Kaur', 'Gurpreet', 'Etobicoke', 'India', 'Digital Design', 'UX_design' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(201, 'Cooper', 'Becca', 'Etobicoke', 'Canada', 'Digital Design', 'UX_design' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(300, 'Kaur', 'Lovepreet', 'Etobicoke', 'India', 'Project Management', 'Global_Business_Manangement' )

INSERT INTO Students(studentNumber, SLastName, SFirstName,SAddress, SCountry, subject, Programme)
VALUES(301, 'Jackson', 'Ron', 'Missisauga', 'India', 'Project Management', 'Global_Business_Manangement' )


CREATE TABLE Teachers (
    TeaherID int,
    TLastName varchar(255),
    TFirstName varchar(255),
    TAddress varchar(255),
    Subject varchar(255),
    Programme varchar(255)
);



INSERT INTO Teachers (TeaherID, TLastName, TFirstName, TAddress ,Subject , Programme )
VALUES(001, ' Borer', 'Simon' ,'Missisauga', 'Database' , 'Web_Development')

INSERT INTO Teachers (TeaherID, TLastName, TFirstName, TAddress ,Subject , Programme )
VALUES(003, 'Kommala', 'Joanna' ,'Missisauga', 'Digital Design' , 'Web_Development')

INSERT INTO Teachers (TeaherID, TLastName, TFirstName, TAddress ,Subject , Programme )
VALUES(002, 'Smith', 'George' ,'Missisauga', 'Digit' , 'UX_Design')

INSERT INTO Teachers (TeaherID, TLastName, TFirstName, TAddress , Subject , Programme )
VALUES(004, 'Monnette', 'Bernie' ,'Missisauga', 'Project Management' , 'Global_Business_Mangement')


SELECT * FROM Teachers

CREATE TABLE Humber(
    TeaherID int,
    Programme varchar(255),
    StudentNumber int,
    Loaction varchar(255)
);



INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(001, 'Web_Development', 100, 'Etobicoke')

INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(003, 'Web_development', 101, 'Etobicoke')

INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(002, 'UX_Design', 200, 'Etobicoke')

INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(002, 'UX_Design', 201, 'Etobicoke')

INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(004, 'Global_business Management', 300, 'Lakeshore')

INSERT INTO Humber (TeaherID, Programme, StudentNumber , Loaction)
VALUES(004, 'Global_business Management', 301, 'Lakeshore')

SELECT * FROM Humber

SELECT * FROM Students
FULL OUTER JOIN Humber ON Students.StudentNumber = Humber.StudentNumber
FULL OUTER JOIN  Teachers ON Humber.TeacherId= Teachers.TeacherId


ALTER TABLE Teachers
  ADD  Tcountry VARCHAR(255) ;
  
ALTER TABLE Humber RENAME TO Humber_College;



