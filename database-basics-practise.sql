USE employees;

#select practise

select dept_no from departments;
select * from departments;

#where clause

select * from employees
where first_name = "Elvis";

select * from employees
where gender = 'F' AND first_name = 'Kellie';

select * from employees
where first_name = 'Aruna' OR first_name ='Kellie';

select * from employees
where (first_name = 'Aruna' OR first_name = 'Kellie') AND gender = 'F';

#IN / NOT IN

select * from employees
where first_name IN ('Denis', 'Elvis');

select * from employees
where first_name NOT IN ('John', 'Mark', 'Jacob');

#LIKE / NOT LIKE
select * from employees 
where first_name LIKE('Mark%');

select * from employees 
where hire_date LIKE('2000%');

select * from employees
where emp_no LIKE ('1000_');

select * from employees
where first_name LIKE('%jack%');

select * from employees
where first_name NOT LIKE('%jack%');

#BETWEEN ... AND ... / NOT BETWEEN ... AND ...
select * from salaries
where salary between 66000 and 70000;

select * from employees
where emp_no not between 10004 and 10012;

select * from departments
where dept_no between 'd003' and 'd006';

#IS NULL / IS NOT NULL
select dept_name from departments where dept_no is not null;

# other comaprision operators <>, <, >, <=, >=, !=, =
select * from employees 
where gender = 'F' AND hire_date >= '2000-01-01';

select * from salaries 
where salary > 150000;

#DISTICT specifier
select DISTINCT hire_date from employees;

#Aggregate: Count()
select count(*) from salaries where salary >= 100000;
select count(*) from dept_manager;

#Order by Clause
select * from employees
order by hire_date;

#Group by and AS keyword
select salary, count(salary) AS emps_with_same_salary
from salaries
where salary > 80000
group by salary
order by salary;

#Having
select avg(salary)
from salaries 
group by emp_no
having avg(salary) > 120000
order by avg(salary) asc;


select emp_no
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date) > 1;

#LIMIT
select * from dept_emp limit 100;


#INSERT commands
INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

select * from titles limit 10;
insert into titles (emp_no, title, from_date)
values (999903, 'Senior Engineer', '1997-10-01');

select * from titles order by emp_no desc limit 10;

insert into dept_emp values (999903,'d005', '1997-10-01', '9999-01-01');
select * from dept_emp order by emp_no desc limit 10;

#INSERT INTO TABLE using existing table
create table departments_dup (
	dept_no varchar(4) NOT NULL,
    dept_name varchar(200) NOT NULL
);

insert into departments_dup (dept_no, dept_name)
select * from departments;

select * from departments_dup;

INSERT INTO departments VALUES ('d010', 'Business Analysis');

#UPDATE table_name command
update departments
set dept_name='Data Analysis'
where dept_name='Business Analysis';

select * from departments;

#DELETE command
delete from departments where dept_no='d010';
select * from departments;









