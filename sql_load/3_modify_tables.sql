SELECT AVG(salary_year_avg) as avg_yearly_salary ,
AVG(salary_hour_avg) as avg_hourly_salary,
job_schedule_type
from job_postings_fact
where job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

SELECT *
FROM job_postings_fact
LIMIT 100;

select count('job_id') as jobs,
EXTRACT (MONTH from job_posted_date) as month
from job_postings_fact
where EXTRACT (YEAR from job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') = 2023
GROUP BY MONTH
ORDER BY MONTH;


select count(job_postings_fact.job_id) as job_count, 
company_dim.name,
EXTRACT(QUARTER from job_posted_date) as quarter
from job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
where job_postings_fact.job_health_insurance = TRUE
and EXTRACT(QUARTER from job_posted_date) > 1
GROUP BY company_dim.name, quarter;

select job_country
from january
LIMIT 10;

select job_location
from february
LIMIT 10;



select 
    job_id , salary_year_avg, job_title_short,
    case
        when salary_year_avg > 100000 then 'High'
        when salary_year_avg between 50000 and 100000 then 'Standard'
        when salary_year_avg < 50000 then 'low'
        else 'NULL'
    End as job_category

from job_postings_fact
where job_title_short = 'Data Analyst'
ORDER BY 
    CASE 
        WHEN salary_year_avg > 100000 THEN 1
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 2
        WHEN salary_year_avg < 50000 THEN 3
        ELSE 4
    END;

with top_skills_table as (
    select 
        skills_job_dim.skill_id, 
        count(*) as total_skills 
    from 
        skills_job_dim
    GROUP BY 
        skill_id
)
select
    skills_dim.skill_id,
    top_skills_table.total_skills,
    skills_dim.skills as skills_name
from 
    skills_dim
left join top_skills_table on top_skills_table. skill_id = skills_dim.skill_id
ORDER BY top_skills_table.total_skills desc;




