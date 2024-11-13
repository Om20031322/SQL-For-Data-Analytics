select job_id,
    job_title,
    company_dim.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
from job_postings_fact
left JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
where job_location = 'Anywhere' and salary_year_avg is not NULL and job_title_short = 'Data Analyst'
order by salary_year_avg DESC
LIMIT 10;
    