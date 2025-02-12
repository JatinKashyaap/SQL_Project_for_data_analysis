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
✅ Top Companies: NielsenIQ, Avaloq, Bosch, Freshworks, Spotify, DoorDash, etc.
✅ Locations: Major cities like Pune, Bengaluru, Chennai, Gurugram, Mumbai.
✅ Salary: Most roles offer ₹111,175 per year.

![Screenshot 2025-02-12 174559](https://github.com/user-attachments/assets/c274e918-4746-4e8e-a200-5c307c67ca65)

### 2.What are the top 10 skills that are having the highest average salary in India?


![Screenshot 2025-02-12 180018](https://github.com/user-attachments/assets/d0e1d6ea-f6ea-4277-a9e5-017cbf8377f0)

