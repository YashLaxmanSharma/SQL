/*
 Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skils)?
 - Identify skills in high demand and associated with high average salaries for Data Analyst roles
 - Concentrates on remote positions with specified salaries.
 */
WITH skills_demand AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
        JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),
average_salary AS(
    SELECT skills_job_dim.skill_id,
        round(avg(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
        JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg is not null
        AND job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
    join average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 100
ORDER BY demand_count DESC,
    avg_salary DESC
LIMIT 25;

SELECT skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) AS demand_count,
    round(avg(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg is not NULL
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING count(skills_job_dim.job_id) > 10
ORDER BY demand_count DESC,
    avg_salary DESC
LIMIT 25;