--deletions to initialize
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE job_title;
DROP TABLE dept_employees;
DROP TABLE dept_managers;

-- data base for departments
CREATE TABLE departments (
	dept_num VARCHAR(4),
	dept_name VARCHAR
);

-- create employee database
CREATE TABLE employees (
	emp_num int,
	title CHAR(5),
	birthdate DATE,
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	sex CHAR(1),
	hire_date DATE
);

-- job-title database
CREATE TABLE job_title (
	title_id CHAR(5),
	title VARCHAR(15)
);

-- Salaries database
CREATE TABLE salaries (
	emp_num int,
	salary int
);

-- create dept employees database
CREATE TABLE dept_employees (
	emp_num int,
	dept_num CHAR(4)
);

-- create dept managers database
CREATE TABLE dept_managers (
	dept_num VARCHAR(4),
	emp_num int
);

-- 1. List the following details of each employee: employee number, last name,first name, sex,
--    and salary.
-- INNER JOIN
SELECT employees.emp_num, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.emp_num=employees.emp_num;

-- 2. Employees hired in 1986
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name.
-- Join 'employees', 'dept_manager', 'departments'
SELECT employees.first_name, employees.last_name, departments.dept_name, dept_managers.dept_num, 
dept_managers.emp_num
FROM employees JOIN dept_managers ON dept_managers.emp_num=employees.emp_num
JOIN departments ON departments.dept_num=dept_managers.dept_num;

-- 4. List the department of each employee with the following information: employee number, last name, 
--    first name, and department name.
-- Join 'employees' and 'departments' (and 'dept_emp')
SELECT employees.emp_num, employees.first_name, employees.last_name, departments.dept_name
FROM employees JOIN dept_employees ON employees.emp_num=dept_employees.emp_num
JOIN departments ON dept_employees.dept_num=departments.dept_num;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names 
--    begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name,
--    first name, and department name.
SELECT employees.emp_num, employees.first_name, employees.last_name, departments.dept_name
FROM employees JOIN dept_employees ON employees.emp_num=dept_employees.emp_num
JOIN departments ON dept_employees.dept_num=departments.dept_num
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee 
--    number, last name, first name, and department name.
SELECT employees.emp_num, employees.first_name, employees.last_name, departments.dept_name
FROM employees JOIN dept_employees ON employees.emp_num=dept_employees.emp_num
JOIN departments ON dept_employees.dept_num=departments.dept_num
WHERE dept_name = 'Sales';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees 
--    share each last name.
SELECT employees.last_name, 
COUNT(last_name)AS Frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT (last_name) DESC;

