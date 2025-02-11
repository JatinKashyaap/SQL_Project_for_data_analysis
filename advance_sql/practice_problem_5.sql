/* High-Paying Skills in India: Job Demand and Average Salary Analysis */

SELECT skills.skills AS skill_name,
COUNT(skills_to_job.job_id) AS number_of_job_postings,
ROUND(AVG(job_postings.salary_year_avg), 2) AS avg_salary_for_skill
FROM skills_dim AS skills
LEFT JOIN skills_job_dim AS skills_to_job 
ON skills.skill_id = skills_to_job.skill_id
LEFT JOIN job_postings_fact AS job_postings
ON skills_to_job.job_id = job_postings.job_id
GROUP BY skills.skills
HAVING AVG(job_postings.salary_year_avg) IS NOT NULL AND job_country='India'
ORDER BY avg_salary_for_skill DESC;
