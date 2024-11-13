select skills, 
count(job_postings_fact.job_id) as no_demand_skills,
salary_year_avg
from job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and job_work_from_home = TRUE
GROUP BY skills, salary_year_avg
ORDER BY no_demand_skills DESC
LIMIT 10;