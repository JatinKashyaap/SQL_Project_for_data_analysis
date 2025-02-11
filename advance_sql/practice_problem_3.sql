/*Job Skills Mapping: Identifying Required Skills for Various Roles */


SELECT 
    job_postings.job_id,
    job_postings.job_title_short AS title,
    skills_to_job.skill_id,
    skills.skills
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim as skills_to_job ON
job_postings.job_id =skills_to_job.job_id
INNER JOIN skills_dim as skills ON skills_to_job.skill_id=skills.skill_id;

SELECT 
    job_postings.job_id,
    job_postings.job_title_short as title,
    company_details.name
from job_postings_fact as job_postings
INNER JOIN company_dim as company_details ON
job_postings.company_id=company_details.company_id
WHERE job_title_short='Data Scientist';


SELECT 
    skills.skills as skill_name,
    count(skills_to_job.job_id) as number_of_job_postings,
    AVG (job_postings.salary_year_avg) as average_salary_for_skill
FROM skills_dim as skills
LEFT JOIN skills_job_dim as skills_to_job on skills.skill_id=skills_to_job.skill_id
LEFT JOIN job_postings_fact as job_postings on skills_to_job.job_id=job_postings.job_id
GROUP BY skills.skills
ORDER BY average_salary_for_skill DESC;
