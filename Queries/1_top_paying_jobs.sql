-- Question : What are the top paying data analyst jobs?
-- Conditions: top 10 jobs, remote working, specified salaries

SELECT
    name AS company_name,
    job_title,
    job_location, 
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE   (job_title_short = 'Data Analyst')
    AND (salary_year_avg IS NOT NULL)
    AND ((job_work_from_home = 'TRUE') OR (job_location = 'Anywhere'))
ORDER BY salary_year_avg DESC
LIMIT 10;
