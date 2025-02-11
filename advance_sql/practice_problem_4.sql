/*
Look at companies that don’t require a degree 
- Degree requirements are in the job_posting_fact table
- Use subquery to filter this in the company_dim table for company_names
- Order by the company name alphabetically
*/

select 
    company_id,
    name as company_name
from company_dim

WHERE company_id IN (
select 
    company_id
from job_postings_fact
where job_no_degree_mention= TRUE
ORDER BY company_id
)

ORDER BY name asc;

/*
Find the companies that have the most job openings. 
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/


with max_job_postings as (
select 
  company_id,
  count(*) as total_jobs
from job_postings_fact
GROUP by company_id
)

SELECT company_dim.name as company_name,
max_job_postings.total_jobs
from company_dim

left JOIN max_job_postings on max_job_postings.company_id=company_dim.company_id
ORDER BY total_jobs DESC;
