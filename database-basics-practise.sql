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










