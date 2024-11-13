select 
    count(job_postings_fact.company_id) as total_jobs, 
    company_dim.name,
    case
        when count(job_postings_fact.company_id) > 50 then 'High'
        when count(job_postings_fact.company_id) between 10 and 50 then 'Medium'
        when count(job_postings_fact.company_id) < 10 then 'Low'
        Else 'Nulll'
        End as category
FROM 
    job_postings_fact
left join company_dim on company_dim.company_id = job_postings_fact.company_id
group by company_dim.name
ORDER BY total_jobs desc

select * from job_postings_fact
LIMIT 5000;

with total_jobs_wfh as (
    select skill_id, 
    count(*) as total_skill
    from skills_job_dim
    inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
    where job_postings_fact.job_work_from_home = TRUE and job_title_short = 'Data Analyst'
    group by skill_id
    )
select 
    skills_dim.skill_id,
    skills_dim.skills,
    total_skill
from total_jobs_wfh
inner join skills_dim on total_jobs_wfh.skill_id = skills_dim.skill_id
ORDER by total_skill desc
limit 5


select skills, type as skill_type, job_postings_fact.job_posted_date
from skills_dim
inner join skills_job_dim on skills_job_dim.skill_id = skills_dim.skill_id
left join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_postings_fact.job_posted_date :: date  between '2023-01-01' and '2023-03-31'

UNION all

select skills, type as skill_type, job_postings_fact.job_posted_date, job_title_short
from skills_dim
left join skills_job_dim on skills_job_dim.skill_id = skills_dim.skill_id
left join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_postings_fact.job_posted_date :: date  between '2023-01-01' and '2023-03-31' 
AND job_postings_fact.salary_year_avg > 70000 AND job_postings_fact.job_title_short = 'Data Analyst'
order by job_posted_date desc