/* 
Using query 3 & 4 as CTEs.
What are the most optimal skills to learn ie. high demand & high paying skills.

This represents jobs that have high security & offer high financial benefits.
*/

-- Jobs posted Anywhere:

WITH skills_demand AS ( -- from query 3
    SELECT
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS mention_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL 
    GROUP BY
        skills_dim.skill_id
), average_salary AS ( -- from query 4
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg*1.26), 0) AS avg_year_salary_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    mention_count,
    avg_year_salary_gbp
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    mention_count > 10
ORDER BY
    avg_year_salary_gbp DESC,
    mention_count DESC
LIMIT 25


-- More concise version of the above query:

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS mention_count,
    ROUND(AVG(job_postings_fact.salary_year_avg*1.26), 0) AS avg_year_salary_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
FROM 
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    --AND job_location = 'United Kingdom'   -- Add in additional filter for jobs only posted in the UK
GROUP BY   
    skills_dim.skill_id
Having
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_year_salary_gbp DESC,
    mention_count DESC
LIMIT 25;