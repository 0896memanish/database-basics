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


#AGGREGATE
select count(DISTINCT dept_no)
from dept_emp;

select sum(salary)
from salaries
where from_date > '1997-01-01';

select min(emp_no) from employees;
select max(emp_no) from employees;

select avg(salary) 
from salaries
where from_date > '1997-01-01';

select round(avg(salary),2)
from salaries
where from_date > '1997-01-01';

select * from departments_dup;

alter table departments_dup
change dept_name dept_name VARCHAR(20) NULL;

insert into departments_dup (dept_no) values ('d010'), ('d011');

alter table departments_dup
add column dept_manager varchar(200) NULL after dept_name;

select dept_no, dept_name, ifnull(dept_no, dept_name) as dept_info
from departments_dup
order by dept_no asc;

select 
 ifnull(dept_no, 'N/A') as dept_no,
 ifnull(dept_name, 'department name is not provided') as dept_name,
 coalesce(dept_no, dept_name) as dept_info
from departments_dup
order by dept_no asc;

#JOINS Begins
#setup 
alter table departments_dup
drop column dept_manager;

alter table departments_dup
change column dept_no dept_no CHAR(4) NULL;

alter table departments_dup
change column dept_name dept_name VARCHAR(40) NULL;

truncate table departments_dup;
select * from departments_dup;

insert into departments_dup
select * from departments;

insert into departments_dup (dept_name)
values ('Public Relations');

insert into departments_dup (dept_no) values ('d010'), ('d011');

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES(999904, '2017-01-01'),(999905, '2017-01-01'),(999906, '2017-01-01'),(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
dept_no = 'd001';

select e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
from employees e
join
dept_manager dm
on e.emp_no=dm.emp_no
where e.last_name = 'Markovitch'
order by dm.dept_no desc, e.emp_no;

select e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
from employees e, dept_manager d
where e.emp_no = d.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
from employees e
join titles t
on e.emp_no = t.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch';

select dm.emp_no, d.dept_no
from dept_manager dm cross join departments d
where d.dept_no = 'd009';

select e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
from dept_manager dm join employees e on dm.emp_no=e.emp_no
join titles t on e.emp_no = t.emp_no
join departments d on d.dept_no = dm.dept_no
where t.title = 'Manager';

select e.gender, count(d.emp_no)
from dept_manager d 
join employees e
on d.emp_no = e.emp_no
group by e.gender;

#UNION
SELECT
    *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis'
	UNION SELECT
			NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;

#SUBQUERIES

select * from dept_manager dm
where dm.emp_no in 
(
	select e.emp_no from employees e
    where e.hire_date between '1990-01-01' and '1995-01-01'
);

#CORELATED SUBQUERIES

select * from employees e
where exists (select * from titles t where title = 'Assistant Engineer' and e.emp_no = t.emp_no);

#NESTED Subqueries
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
   emp_no INT(11) NOT NULL,
   dept_no CHAR(4) NULL,
   manager_no INT(11) NOT NULL
);

insert into emp_manager
select u.*

from
(select a.* from
	(select e.emp_no as employee_ID, min(de.dept_no) as department_ID, 
		(select emp_no from dept_manager where emp_no=110022) as manager_ID
	from employees e
	join dept_emp de
	on e.emp_no = de.emp_no
	where e.emp_no <= 10020
	group by e.emp_no
	order by e.emp_no) as a

union

select b.* from 
(select e.emp_no as employee_ID, min(de.dept_no) as department_ID, 
	(select emp_no from dept_manager where emp_no=110039) as manager_ID
from employees e
join dept_emp de
on e.emp_no = de.emp_no
where e.emp_no > 10020
group by e.emp_no
order by e.emp_no
limit 20) as b

union

select c.* from 
(select e.emp_no as employee_ID, min(de.dept_no) as department_ID, 
	(select emp_no from dept_manager where emp_no=110022) as manager_ID
from employees e
join dept_emp de
on e.emp_no = de.emp_no
where e.emp_no = 110039
group by e.emp_no
order by e.emp_no) as c

union

select d.* from 
(select e.emp_no as employee_ID, min(de.dept_no) as department_ID, 
	(select emp_no from dept_manager where emp_no=110039) as manager_ID
from employees e
join dept_emp de
on e.emp_no = de.emp_no
where e.emp_no = 110022
group by e.emp_no
order by e.emp_no) as d 
) as u;

select * from emp_manager;

select t.emp_no, t.title, round(avg(
(select s.salary from salaries s where t.emp_no = s.emp_no)
),2) as avg_salary
from 
( select emp_no, title from titles where title in ('Staff', 'Engineer')) as t
group by t.emp_no;

#Views

create view v_avg_salary_of_managers as
select em.emp_no, round(avg(s.salary),2)
from emp_manager em
join salaries s
on em.emp_no = s.emp_no
group by em.emp_no;

CREATE OR REPLACE VIEW v_avg_salary_of_managers AS
    SELECT
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
        
        
#PROCEDURES

delimiter $$
create procedure avg_salary()
begin
	select avg(salary)
    from salaries;
end$$
delimiter ;

call avg_salary;

drop procedure if exists emp_info;

delimiter $$
create procedure emp_info(in p_first_name VARCHAR(20), in p_last_name VARCHAR(20), out p_output INT)
begin
	select emp_no into p_output from employees where
    first_name = p_first_name and last_name = p_last_name;
end$$
delimiter ;

set @v_emp_no = 0;
call emp_info('Parto', 'Bamford', @v_emp_no);
select @v_emp_no;

delimiter $$
create function emp_new_salary(p_first_name VARCHAR(20), p_last_name VARCHAR(20))
returns decimal(10,2) deterministic
begin 
declare v_salary decimal(10,2);
declare v_max_from_date date;

select max(s.from_date) into v_max_from_date 
from employees e 
join salaries s
on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name;

select s.salary into v_salary 
from employees e 
join salaries s
on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name and s.from_date = v_max_from_date;

return v_salary;
end $$
delimiter ;

select emp_new_salary('Parto','Bamford');

#Triggers
delimiter $$
create trigger emp_hire_trigger
before insert on employees
for each row
begin 
	if new.hire_date > date_format(sysdate, '%Y-%m-%d')
    then
		set new.hire_date = date_format(sysdate, '%Y-%m-%d');
	end if;
end $$
delimiter ;

#INDEXES

select * from salaries where salary > 89000;

create index i_salary_composite on salaries (salary);

#CASE

select e.emp_no, e.first_name, e.last_name, 
case
	when d.emp_no IS NOT NULL then 'Manager'
    else 'Employee'
end as is_manager
from employees e
left join dept_manager d
on e.emp_no = d.emp_no
where e.emp_no > 109990;


select e.emp_no, e.first_name, e.last_name, (max(s.salary) - min(s.salary)) as salary_hike,
case
	when max(s.salary) - min(s.salary) > 30000 then 'Hike is more than 30K'
    else 'Minimal hike'
end as is_hike_good_enough
from employees e 
join dept_manager d
on e.emp_no = d.emp_no
join salaries s 
on d.emp_no = s.emp_no
group by d.emp_no;

select e.emp_no, e.first_name, e.last_name, 
case 
	when max(de.to_date) > sysdate() then 'Contract Active'
    else 'Contract Inactive'
end as current_employee
from employees e 
join dept_emp de
on e.emp_no = de.emp_no
group by e.emp_no
limit 100;

#WINDOW Functions
#Type RANKING WINDOW functions NON Aggregate

select e.*, row_number() over (order by e.emp_no) as rankings
from employees e
join dept_manager d
on e.emp_no = d.emp_no
group by e.emp_no;

select e.*, row_number() over (partition by e.first_name order by e.last_name asc) as sequence
from employees e;

#window function alternative syntax
select e.*, row_number() over w as sequence
from employees e
window w as (partition by e.first_name order by e.last_name asc);

#rank and dense_rank functions

select emp_no, salary, rank() over (partition by emp_no order by salary) as rank_num
from salaries
where emp_no=10560;

select emp_no, salary, dense_rank() over (partition by emp_no order by salary) as rank_num
from salaries
where emp_no=10560;

#type NON RANKING Non Aggregate

SELECT
emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
salaries
    WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);


SELECT
emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
LAG(salary, 2) OVER w AS 1_before_previous_salary,
LEAD(salary) OVER w AS next_salary,
    LEAD(salary, 2) OVER w AS 1_after_next_salary
FROM
salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 1000;








        






















