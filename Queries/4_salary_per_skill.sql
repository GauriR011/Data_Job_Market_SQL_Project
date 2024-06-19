-- What is the average salary associated per skill in general

-- In demand skills in general for Data Analysts

SELECT skills, AVG(job_postings_fact.salary_year_avg) as avg_salary
FROM job_postings_fact  
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE (job_title_short = 'Data Analyst') AND (salary_year_avg IS NOT NULL)
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 5;