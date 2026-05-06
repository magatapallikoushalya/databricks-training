-- 1. Select all columns from Employee
SELECT * FROM Employee;

-- 2. Select only name and salary
SELECT name, salary FROM Employee;

-- 3. Employees older than 30
SELECT * FROM Employee WHERE age > 30;

-- 4. Employees of all departments (same as all employees)
SELECT * FROM Employee;

-- 5. Employees in IT department
SELECT * FROM Employee WHERE department_id = 1;

-- 6. Names start with 'J'
SELECT * FROM Employee WHERE name LIKE 'J%';

-- 7. Names end with 'e'
SELECT * FROM Employee WHERE name LIKE '%e';

-- 8. Names contain 'a'
SELECT * FROM Employee WHERE name LIKE '%a%';

-- 9. Names exactly 6 characters
SELECT * FROM Employee WHERE LENGTH(name) = 6;

-- 10. Names with second character 'o'
SELECT * FROM Employee WHERE name LIKE '_o%';

-- 11. Employees hired in 2020
SELECT * FROM Employee 
WHERE YEAR(hire_date) = 2020;

-- 12. Employees hired in January
SELECT * FROM Employee 
WHERE MONTH(hire_date) = 1;

-- 13. Employees hired before 2019
SELECT * FROM Employee 
WHERE hire_date < '2019-01-01';

-- 14. Employees hired after March 1, 2021
SELECT * FROM Employee 
WHERE hire_date > '2021-03-01';

-- 15. Employees hired in last 2 years
SELECT * FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 16. Total salary
SELECT SUM(salary) FROM Employee;

-- 17. Average salary
SELECT AVG(salary) FROM Employee;

-- 18. Minimum salary
SELECT MIN(salary) FROM Employee;

-- 19. Count employees
SELECT COUNT(*) FROM Employee;

-- 20. Count employees per department
SELECT department_id, COUNT(*) 
FROM Employee 
GROUP BY department_id;

-- 21. Total salary per department
SELECT department_id, SUM(salary)
FROM Employee
GROUP BY department_id;

-- 22. Average salary per department
SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id;

-- 23. Number of employees per department
SELECT department_id, COUNT(*)
FROM Employee
GROUP BY department_id;

-- 24. Highest salary per department
SELECT department_id, MAX(salary)
FROM Employee
GROUP BY department_id;

-- 25. Department with highest average salary
SELECT department_id, AVG(salary) avg_sal
FROM Employee
GROUP BY department_id
ORDER BY avg_sal DESC
LIMIT 1;

-- 26. Departments with more than 2 employees
SELECT department_id, COUNT(*)
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 27. Departments with avg salary > 55000
SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 28. Departments with total salary > 100000
SELECT department_id, SUM(salary)
FROM Employee
GROUP BY department_id
HAVING SUM(salary) > 100000;

-- 29. Departments with minimum salary less than 50000
SELECT department_id, MIN(salary) AS min_salary
FROM Employee
GROUP BY department_id
HAVING MIN(salary) < 50000;

-- 30. Departments with maximum salary greater than 70000
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 70000;

-- 31. Order by salary ascending
SELECT * FROM Employee ORDER BY salary ASC;

-- 32. Order by age descending
SELECT * FROM Employee ORDER BY age DESC;

-- 33. Order by hire date ascending
SELECT * FROM Employee ORDER BY hire_date;

-- 34. Order by department then salary
SELECT * FROM Employee 
ORDER BY department_id, salary;

-- 36. Employee with department name
SELECT e.name, d.name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id;

-- 37. Project with department name
SELECT p.name, d.name
FROM Project p
JOIN Department d
ON p.department_id = d.department_id;

-- 38. Employee with project (via department)
SELECT e.name, p.name
FROM Employee e
JOIN Project p
ON e.department_id = p.department_id;

-- 39. Employees without department
SELECT * FROM Employee
WHERE department_id IS NULL;

-- 40. Departments without employees
SELECT d.*
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 40. Departments without employees
SELECT d.*
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 41. Employees along with their department and project names
SELECT e.name AS employee, d.name AS department, p.name AS project
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id
LEFT JOIN Project p
ON d.department_id = p.department_id;

-- 42. Count number of projects per department
SELECT department_id, COUNT(*) AS total_projects
FROM Project
GROUP BY department_id;

-- 43. Departments having more than 1 project
SELECT department_id, COUNT(*) AS total_projects
FROM Project
GROUP BY department_id
HAVING COUNT(*) > 1;

-- 44. Employees who work in departments with more than 2 projects
SELECT *
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) > 2
);

-- 45. Employees and their department names sorted by department
SELECT e.name, d.name AS department
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id
ORDER BY d.name;

-- 46. Employee with highest salary
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);

-- 47. Employees earning above average
SELECT * FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 48. Second highest salary
SELECT MAX(salary) 
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

-- 49. Department with most employees
SELECT department_id, COUNT(*) c
FROM Employee
GROUP BY department_id
ORDER BY c DESC
LIMIT 1;

-- 50. Employees working in departments that have projects
SELECT DISTINCT e.*
FROM Employee e
WHERE e.department_id IN (
    SELECT department_id FROM Project
    WHERE department_id IS NOT NULL
);

-- 51. Employees not assigned to any project (via department)
SELECT *
FROM Employee
WHERE department_id NOT IN (
    SELECT DISTINCT department_id FROM Project
    WHERE department_id IS NOT NULL
);

-- 52. Departments that have no projects
SELECT *
FROM Department
WHERE department_id NOT IN (
    SELECT DISTINCT department_id FROM Project
    WHERE department_id IS NOT NULL
);

-- 53. Employees earning more than the average salary of their department
SELECT e.*
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 54. Employees with same salary as someone else
SELECT *
FROM Employee
WHERE salary IN (
    SELECT salary
    FROM Employee
    GROUP BY salary
    HAVING COUNT(*) > 1
);

-- 55. Employees who are the highest paid in their department
SELECT *
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 56. Departments with at least one employee earning > 70000
SELECT DISTINCT department_id
FROM Employee
WHERE salary > 70000;

-- 57. Employees whose salary is greater than all employees in HR (dept_id = 2)
SELECT *
FROM Employee
WHERE salary > ALL (
    SELECT salary FROM Employee WHERE department_id = 2
);

-- 58. Employees whose salary is less than any employee in IT (dept_id = 1)
SELECT *
FROM Employee
WHERE salary < ANY (
    SELECT salary FROM Employee WHERE department_id = 1
);

-- 59. List employees along with number of projects in their department
SELECT e.name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
GROUP BY e.emp_id, e.name;

-- 60. Department-wise highest and lowest salary
SELECT department_id, 
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary
FROM Employee
GROUP BY department_id;

-- 61. Employees hired earliest in each department
SELECT *
FROM Employee e
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 62. Employees with salary between 50000 and 70000
SELECT *
FROM Employee
WHERE salary BETWEEN 50000 AND 70000;

-- 63. Count of employees without department
SELECT COUNT(*)
FROM Employee
WHERE department_id IS NULL;

-- 64. Departments having more projects than employees
SELECT d.department_id
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.department_id
HAVING COUNT(DISTINCT p.project_id) > COUNT(DISTINCT e.emp_id);

-- 65. List all employees and their department names (including NULLs)
SELECT e.name, d.name AS department_name
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id;
