

						
#AIM:Create a database with required constraint and use views,stored procedures,triggersand cursors on those data.

#DATABASE NAME : HOSPITAL

#NUMBER OF TABLES:11

#CREATION OF EACH TABLES WITH  CONSTRAINTS

1MariaDB [hospital]> CREATE TABLE department( block_no VARCHAR(5) NOT NULL, department varchar(20) NOT NULL, PRIMARY KEY(block_no,department));
2 MariaDB [hospital]> CREATE TABLE leave_table(employee_id varchar(10) NOT NULL,no_of_days INT,from_date DATE,FOREIGN KEY (employee_id) REFERENCES employee_details(employee_id));
3 MariaDB [hospital]> CREATE TABLE finance(employee_id VARCHAR(5) NOT NULL,salary_per_month INT,advance INT CHECK(advance<50000),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
4 MariaDB [hospital]> CREATE TABLE patient_info( patient_id VARCHAR(10) NOT NULL,name VARCHAR(20),phone_no INT,address VARCHAR(40),dob DATE,last_checkup DATE ,PRIMARY KEY(patient_id));
5 MariaDB [hospital]> CREATE TABLE employee_details( employee_id VARCHAR(10) NOT NULL, employee_name VARCHAR(30),department varchar(20) NOT NULL,destination varchar(20),dob date,address VARCHAR(20),phone_no int ,PRIMARY KEY(employee_id) FOREIGN KEY (department) REFERENCES department(department));
6 MariaDB [hospital]> CREATE TABLE ortho_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
7 MariaDB [hospital]> CREATE TABLE cardio_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
8 MariaDB [hospital]> CREATE TABLE dermo_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
9 MariaDB [hospital]> CREATE TABLE optho_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
10 MariaDB [hospital]> CREATE TABLE gyno_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));
11 MariaDB [hospital]> CREATE TABLE diab_table(employee_id VARCHAR(5) NOT NULL,consultation_time_from decimal(4,2),consultation_time_to decimal(4,2),level VARCHAR(20),FOREIGN KEY (employee_id) REFERENCES employee_details (employee_id));

#VIEWS

MariaDB [hospital]> CREATE VIEW salary_less_than_or_equal_to_10000 AS SELECT salary_per_month  FROM finance WHERE salary_per_month <= 10000;
Query OK, 0 rows affected (0.01 sec)

MariaDB [hospital]> SELECT * FROM salary_less_than_or_equal_to_10000;
+------------------+
| salary_per_month |
+------------------+
|             5000 |
|            10000 |
|            10000 |
+------------------+
3 rows in set (0.00 sec)


#TRIGGER

MariaDB [hospital]> CREATE TRIGGER display_current_available_salary BEFORE INSERT ON finance FOR EACH ROW SET @sum=@sum+NEW.salary_per_month;
Query OK, 0 rows affected (0.05 sec)
MariaDB [hospital]> SET @sum=10;
Query OK, 0 rows affected (0.00 sec)
MariaDB [hospital]> CREATE TRIGGER display_current_available_salary BEFORE INSERT ON finance FOR EACH ROW SET @sum=@sum+NEW.salary_per_month;
Query OK, 0 rows affected (0.05 sec)
MariaDB [hospital]> SET @sum=10;
Query OK, 0 rows affected (0.00 sec)


#PROCEDURE WITH CURSOR

MariaDB [hospital]> DELIMITER $$
MariaDB [hospital]> CREATE PROCEDURE build_name_listnew (INOUT name_list varchar(4000))
    -> BEGIN 
    ->  DECLARE v_finished INTEGER DEFAULT 0;
    ->  DECLARE v_name varchar(100) DEFAULT "";
    ->  DEClARE name_cursor CURSOR FOR 
    ->  SELECT employee_name FROM employee_details;
    ->  DECLARE CONTINUE HANDLER 
    ->  FOR NOT FOUND SET v_finished = 1;
    ->  OPEN name_cursor;
    ->  get_name: LOOP
    ->  FETCH name_cursor INTO v_name;
    ->  IF v_finished = 1 THEN 
    ->  LEAVE get_name;
    ->  END IF;
    ->  SET name_list = CONCAT(v_name,";",name_list);
    ->  END LOOP get_name;
    ->  CLOSE name_cursor;
    ->  END$$
Query OK, 0 rows affected (0.00 sec)

MariaDB [hospital]>  DELIMITER ;
MariaDB [hospital]> SET @name_list="";
Query OK, 0 rows affected (0.00 sec)

MariaDB [hospital]> CALL build_name_listnew(@name_list);
Query OK, 0 rows affected, 1 warning (0.00 sec)

MariaDB [hospital]> SELECT @name_list;

+---------------------------------------------------------------------------------+
| @name_list                                                                                      |
+---------------------------------------------------------------------------------+
| Vishal;Aslam;Aslam;Renjini;Anshad;Anisha;Nisha;Jenilia;Jose;Suresh;Meenu;Neenu; |
+---------------------------------------------------------------------------------+
1 row in set (0.00 sec)






