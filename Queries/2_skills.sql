-- Question : What are the skills required for top paying data analyst jobs?

WITH top_jobs AS (
SELECT
    job_id,
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
LIMIT 10
)

SELECT top_jobs.* , skills_dim.skills
FROM top_jobs  
JOIN skills_job_dim ON top_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

