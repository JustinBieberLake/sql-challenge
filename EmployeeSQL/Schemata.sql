-- Create departments table
CREATE TABLE departments(
dept_no VARCHAR PRIMARY KEY,
dept_name VARCHAR);

SELECT * FROM departments;


-- Create titles table
CREATE TABLE titles(
title_id VARCHAR PRIMARY KEY,
title VARCHAR);

SELECT * FROM titles;


--Create employees table
CREATE TABLE employees(
emp_no INT PRIMARY KEY,
emp_title_id VARCHAR,
birth_date DATE,
first_name VARCHAR,
last_name VARCHAR,
sex VARCHAR,
hire_date DATE,
FOREIGN KEY (emp_title_id) REFERENCES titles(title_id));

SELECT * FROM employees;


-- Create salaries table
CREATE TABLE salaries(
emp_no INT PRIMARY KEY,
salary INT);

--Check to make sure imported correctly
SELECT * FROM salaries;


-- Create dept_man table
CREATE TABLE dept_manager(
dept_no VARCHAR,
emp_no INT,
PRIMARY KEY (emp_no, dept_no));

--Add in Foreign Key
ALTER TABLE dept_manager
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_manager
ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

SELECT * FROM dept_manager;


-- Create dept_emp table
CREATE TABLE dept_emp(
	emp_no INT,dept_no VARCHAR,
    PRIMARY KEY (emp_no, dept_no));
	
--Add in Foreign Key
ALTER TABLE dept_emp
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE dept_emp
ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);

SELECT * FROM dept_emp;


-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name,  hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


-- 3. List the manager of each department along with their department number, department name, employee number, 
--    last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no


-- 4. List the department number for each employee along with that employee’s employee number, last name,   
--    first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins 
--    with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


-- 7. List each employee in the Sales and Development departments, including their employee number, last name, 
--    first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';


-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees 
--    share each last name).
SELECT last_name, COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;