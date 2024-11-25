/*
What are the high paying skills.
- Find the average salary for each skill.
- Show the skills with the highest paying average salary (top 5)
- This will focus on jobs regardless of location & only postings that have a value for salary (exclude Null)
This shows job-seekers how obtaining different skills could affect their salary expectations.
*/
-- Based on Average Year Salary
SELECT
    skills,
    ROUND(AVG(salary_year_avg*1.26), 0) AS avg_year_salary_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_year_salary_gbp DESC
LIMIT
   25

--Based on Average Hourly rate
SELECT
    skills,
    ROUND(AVG(salary_hour_avg*1.26),0) AS avg_hour_rate_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_hour_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_hour_rate_gbp DESC
LIMIT
    5


-- Repeated Average Year Salary for United Kingdom

SELECT
    skills,
    ROUND(AVG(salary_year_avg*1.26), 0) AS avg_year_salary_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_location ='United Kingdom'
GROUP BY
    skills
ORDER BY
    avg_year_salary_gbp DESC
LIMIT
    5

-- Repeated Average hourly rate for United Kingdom
SELECT
    skills,
    ROUND(AVG(salary_hour_avg*1.26),0) AS avg_hour_rate_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_hour_avg IS NOT NULL AND
    job_location ='United Kingdom'
GROUP BY
    skills
ORDER BY
    avg_hour_rate_gbp DESC
LIMIT 5


/*
Top 5 highest paying skills from jobs posted anywhere:
Year Salary:                                Hourly Salary:
1. Debian                                    1.Puppet
2. Ringcentral                               2. Lua
3. Mongo                                     3. Digital Ocean
4. Lua                                       4. Chef
5. DPLYR                                     5. Unreal

Top 5 highest paying skills from jobs posted within the UK:
Year Salary:
1.scikit-learn                              No hourly posted skills in the UK
2. Keras
3. C++
4. Javascript
5. Neo4j

*/


