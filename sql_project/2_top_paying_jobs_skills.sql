with top_jobs_skills as (
    select job_id,
        job_postings_fact.job_title,
        company_dim.name as company_name,
        job_postings_fact.salary_year_avg
    from job_postings_fact
    left JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    where job_location = 'Anywhere' and 
    salary_year_avg is not NULL and 
    job_title_short = 'Data Analyst'
    order by salary_year_avg DESC
    )
SELECT top_jobs_skills.*, skills
from top_jobs_skills
inner join skills_job_dim ON top_jobs_skills.job_id = skills_job_dim.job_id
inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
order by top_jobs_skills.salary_year_avg DESC
