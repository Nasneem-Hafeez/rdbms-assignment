# rdbms-assignment
Assignment for RDBMS session
Database is created with the name hospital
Created 11 tables with appropriate constraints.

VIEWS

A virtual table is created with the name salary_less_than_or_equal_to_10000 from the table finance which only contains the values of salary_per_month less than or equal to 10000
 
TRIGGER

Trigger is created with the name display_current_available_salary which adds a value 10 with the newly added rows.Trigger is made active when INSERT command is carried out.
We can check the trigger by checking the value in sum.

SP AND CURSOR

First of delimiter is changed to $$ for avoid pre-execution
A procedure named build_name_listnew is created with argument as name_listof type varchar
v_finished is declared as an integer with default zero value
v_name is set as also null value
A cursor is declared with the name name_cursor
Cursor iterates the table employee_details in the coloumn employee_name.
continue handler is declared
If the appropriate table is not found the value of v_finished is set to 1
OPEN the cursor step is done
The loop is iterated and all the names are placed in placed in a name_list
cursor is closed
To view the name_list 
First set the name_list as null
call the procedure named build_name_listnew
Using select statement the name_list can be viewed.




