/*
 Question: What are teh top_paying Data Analyst roels that are available remotely?
 - Idnetify the top 10 higheset_paying Data Analyst roles that are available remotely.
 - Focuses on job positings with specified salaries (remove nulls).
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;