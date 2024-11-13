select skills_dim.skill_id, 
    skills,
    count(job_postings_fact.job_id) as demand_count,
    ROUND(avg(salary_year_avg), 2) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'and
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
group by skills_dim.skill_id
having count(job_postings_fact.job_id) > 10
ORDER BY avg_salary desc, demand_count desc
limit 50;