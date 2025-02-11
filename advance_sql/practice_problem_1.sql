/*Top 10 Data & Business Analyst Job Postings in India with Salary Insights */

SELECT 
    job_title,
    name as company_name,
    job_via,
    job_location,
    job_country,
    salary_year_avg
FROM
    job_postings_fact as job_postings
INNER JOIN company_dim as comapanies ON
job_postings.company_id=comapanies.company_id
WHERE job_location LIKE '%India' AND
(job_title LIKE '%Data Analyst' or job_title LIKE'%Business Analyst') AND
job_title NOT LIKE '%Senior%' AND
salary_year_avg is  NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
