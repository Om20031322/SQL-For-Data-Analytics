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

select count(job_postings_fact.job_id) as job_count, 
skills_job_dim.skill_id, 
skills_dim.skills
from job_postings_fact
left join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id  
left join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
where job_postings_fact.job_work_from_home = TRUE
group by skills_job_dim.skill_id , skills_dim.skills
order by skills_dim.skills desc;
