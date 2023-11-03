CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY ("title_id")
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY ("emp_no")
);

CREATE TABLE "Dept_Emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "Dept_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");



-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
JOIN "Salaries"
ON "Employees".emp_no = "Salaries".emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT "Employees".first_name, "Employees".last_name, "Employees".hire_date
FROM "Employees"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department along with their 
--department number, department name, employee number, last name, and first name.
SELECT "Departments".dept_no, "Departments".dept_name, "Dept_Manager".emp_no, "Employees".last_name, "Employees".first_name
FROM "Departments"
JOIN "Dept_Manager"
ON "Departments".dept_no = "Dept_Manager".dept_no
JOIN "Employees"
ON "Employees".emp_no = "Dept_Manager".emp_no;

--4. List the department number for each employee along with that 
--employee’s employee number, last name, first name, and department name.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Dept_Emp".dept_no, "Departments".dept_name 
FROM "Employees"
JOIN "Dept_Emp"
ON "Employees".emp_no = "Dept_Emp".emp_no
JOIN "Departments"
ON "Departments".dept_no = "Dept_Emp".dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.
SELECT "Employees".first_name, "Employees".last_name, "Employees".sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
--Get Sales Dept Number (d007)
SELECT * FROM "Departments";

SELECT "Dept_Emp".dept_no, "Dept_Emp".emp_no, "Employees".last_name, "Employees".first_name
FROM "Dept_Emp"
JOIN "Employees"
ON "Employees".emp_no = "Dept_Emp".emp_no
WHERE dept_no = 'd007';

-- 7. List each employee in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
SELECT "Dept_Emp".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Dept_Emp"
JOIN "Employees"
ON "Employees".emp_no = "Dept_Emp".emp_no
JOIN "Departments"
ON "Dept_Emp".dept_no = "Departments".dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS Frequency
FROM "Employees"
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
