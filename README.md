# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying jobs in India where the job title consist of Data Analyst and Business Analyst?
2. What are the top 10 skills that are having the highest average salary in India?
3. What are the top-paying data analyst jobs?
4. What skills are required for these top-paying jobs?
5. What skills are most in demand for data analysts?
6. Which skills are associated with higher salaries?
7. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. What are the top-paying jobs in India where the job title consist of Data Analyst and Business Analyst?


This SQL query retrieves the top 10 highest-paying job postings for Data Analyst or Business Analyst roles in India, excluding senior positions.
```sql
SELECT 
    job_title,
    name as company_name,
    job_location,
    salary_year_avg
FROM
    job_postings_fact as job_postings
INNER JOIN company_dim as comapanies ON
job_postings.company_id=comapanies.company_id
WHERE job_location LIKE '%India' AND
(job_title LIKE '%Data Analyst' or job_title LIKE'%Business Analyst') AND
job_title NOT LIKE '%Senior%' AND
job_title NOT LIKE '%Sr.%' AND
salary_year_avg is  NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Here is the breakdown of the top-paying jobs in India where the job title consist of Data Analyst and Business Analyst

✅ **Top Companies**: NielsenIQ, Avaloq, Bosch, Freshworks, Spotify, DoorDash, etc.
✅ **Locations**: Major cities like Pune, Bengaluru, Chennai, Gurugram, Mumbai.
✅ **Salary**: Most roles offer ₹111,175 per year.

![Screenshot 2025-02-12 174559](https://github.com/user-attachments/assets/c274e918-4746-4e8e-a200-5c307c67ca65)

### 2.What are the top 10 skills that are having the highest average salary in India?

This SQL query retrieves the top 10 in-demand skills in India based on job postings. It calculates the number of job postings for each skill and the average annual salary for jobs requiring that skill. The results are filtered to include only skills with non-null salary values and are sorted in descending order of average salary, followed by the number of job postings.
```sql
SELECT 
    skills.skills AS skill_name,
    COUNT(skills_to_job.job_id) AS number_of_job_postings,
    ROUND(AVG(job_postings.salary_year_avg), 2) AS avg_salary_for_skill
FROM skills_dim AS skills
LEFT JOIN skills_job_dim AS skills_to_job 
    ON skills.skill_id = skills_to_job.skill_id
LEFT JOIN job_postings_fact AS job_postings
    ON skills_to_job.job_id = job_postings.job_id
WHERE job_postings.job_country = 'India'  -- Corrected WHERE placement
GROUP BY skills.skills
HAVING AVG(job_postings.salary_year_avg) IS NOT NULL  -- Used the original function
ORDER BY avg_salary_for_skill DESC,
number_of_job_postings
LIMIT 10;

```
Here is the breakdown of the top 10 skills that are having the highest average salary in India?

- **GDPR** has the highest average salary ($163,782) with **336 job openings**.
- **Haskell, Watson, and Cognos** share the second-highest average salary ($157,500), but **Haskell has significantly fewer job openings (8)**.
- **MicroStrategy** has the most job openings (338) but a lower average salary ($150,166).
- **PHP, Rust, Couchbase, and Drupal** have the lowest average salaries in this list ($147,500).

This data indicates that while some skills offer high salaries, they may have fewer job opportunities, and vice versa.

![Screenshot 2025-02-12 180018](https://github.com/user-attachments/assets/d0e1d6ea-f6ea-4277-a9e5-017cbf8377f0)

### 3. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
select 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM
   job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short='Data Analyst' AND 
    job_location='Anywhere' AND
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
limit 10;

```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.


### 4. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

### 5. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*



