SELECT 
    job_title_short as jobs,
    count(job_title_short) as job_count,
    ROUND(AVG(salary_year_avg),0) as salary_avg,
    MIN(salary_year_avg) as salary_min,
    MAX(salary_year_avg) as salary_max
FROM
    job_postings_fact
WHERE
    job_country='India' AND salary_year_avg IS NOT NULL
GROUP BY job_title_short
order BY salary_avg DESC;