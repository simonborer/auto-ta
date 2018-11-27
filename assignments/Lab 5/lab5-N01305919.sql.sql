--LAB 5
--Parampreet Singh Grewal
--N01305919


			


		--table 1
Q1......		CREATE TABLE college_gym
				(
 					member_id  NUMBER(7)     PRIMARY KEY,
  					member_first_name   VARCHAR2(20)  NOT NULL,
  					member_last_name  VARCHAR2(20)    NOT NULL,
  					age         NUMBER(3)
				)

		--table 2
			CREATE TABLE student_info
				(
  					student_id   NUMBER(7)     PRIMARY KEY,
 					member_no    NUMBER(15)    REFERENCES college_gym(member_id),
 					course_year  NUMBER(1)    NOT NULL,
 					course_name  VARCHAR2(25)
				)

		--table 3
			CREATE TABLE member_info
				(
  					member_id         NUMBER(7)     PRIMARY KEY,
 					membership_type   VARCHAR2(20)  DEFAULT 'silver',
  					extra_activities  VARCHAR2(25)  , 
  					mob_no            NUMBER(1)
				)





Q2......	--insert 4 rows into 1st table college_gym
			INSERT INTO college_gym
			VALUES(091, 'Param', 'Grewal', 22);
			INSERT INTO college_gym
			VALUES(092, 'Aman', 'Singh',  23);
			INSERT INTO college_gym
			VALUES(093, 'Aakshar', 'Bajaj', 22);
			INSERT INTO college_gym
			VALUES(094, 'Jay', 'patel', 21);

		
		--insert 4 rows into 2st table student_info
			INSERT INTO student_info
			VALUES(055, 094, 2, 'web');
			INSERT INTO student_info
			VALUES(056, 093, 1, 'networking');
			INSERT INTO student_info
			VALUES(057, 092, 3, 'app development');
			INSERT INTO student_info
			VALUES(058, 091, 4, 'java');

		
		--insert 4 rows into 3st table member_info
			INSERT INTO member_info
			VALUES(093, 'gold', 'swimming', 4);
			INSERT INTO member_info
			VALUES(091, 'platinum', 'arobics', 2);
			INSERT INTO member_info
			VALUES(094, DEFAULT, 'yoga', 4);
			INSERT INTO member_info
			VALUES(092, 'basic', 'dance', 2);





Q3....		--In this query i join all three tales that i created.
			SELECT *
			FROM college_gym clgm JOIN student_info stdif
			ON clgm.member_id=stdif.member_no
			JOIN member_info memif ON clgm.member_id=memif.member_id



Q4....		--IN this i add a coulumn name member_hobbies in table member_info
			ALTER TABLE member_info
			ADD member_hobbies VARCHAR2(20)


Q5....		--In this i changed the table name from college_gym to gym_info.
			ALTER TABLE student_info
			RENAME TO gym_info
	

