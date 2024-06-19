-- What are the most optimal skills to learn (i.e. high in demand and high salary)

-- METHOD 1
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id, 
        skills_dim.skills, 
        count(skills_job_dim.job_id) as COUNT
    FROM job_postings_fact  
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE (job_postings_fact.job_title_short = 'Data Analyst') AND (job_postings_fact.salary_year_avg IS NOT NULL)
    GROUP BY skills_dim.skill_id
),

skill_salary AS (
    SELECT 
        skills_dim.skill_id, 
        skills_dim.skills, 
        AVG(job_postings_fact.salary_year_avg) as avg_salary
    FROM job_postings_fact  
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE (job_postings_fact.job_title_short = 'Data Analyst') 
    AND (job_postings_fact.salary_year_avg IS NOT NULL)
    GROUP BY skills_dim.skill_id

)

SELECT 
    skills_demand.skill_id, 
    skills_demand.skills, 
    skills_demand.COUNT, 
    ROUND(skill_salary.avg_salary, 0)
FROM skills_demand JOIN skill_salary
ON skills_demand.skill_id = skill_salary.skill_id;



-- METHOD 2
SELECT 
    skills_dim.skill_id, 
    skills_dim.skills, 
    COUNT(skills_job_dim.job_id) as job_count, 
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) as average_salary

FROM job_postings_fact  
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 

WHERE (job_postings_fact.job_title_short = 'Data Analyst') 
    AND (job_postings_fact.salary_year_avg IS NOT NULL)
    
GROUP BY skills_dim.skill_id;