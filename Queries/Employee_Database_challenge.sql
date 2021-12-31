-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- titles table
SELECT  e.emp_no, e.first_name, e.last_name, t.title,
t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

--unique titles table creation
SELECT DISTINCT ON (emp_no)
emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

---memployees who are about to retire counts by title table
SELECT COUNT (title)
count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


--mentorship table
SELECT  DISTINCT ON (e.emp_no)
		e.emp_no, e.first_name, e.last_name,
	    e.birth_date,
        de.from_date, de.to_date,
        t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
INNER JOIN titles as t ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND 
    (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;