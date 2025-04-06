/*
 Questions: What are the most in-demand skills for data analysts?
 - Join job posings to inner join table similar to query 2
 - Identify the top 5 in-demand skills fot a data analyst.
 - Focus on all jobs postings.
 */
SELECT skills,
    count(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;