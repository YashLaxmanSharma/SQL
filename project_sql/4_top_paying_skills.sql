/*
 Question: What are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Analyst positions.
 - Focus on roles with specified salaries, regardless of location.
 */
SELECT skills,
    round(avg(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg is not null
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;