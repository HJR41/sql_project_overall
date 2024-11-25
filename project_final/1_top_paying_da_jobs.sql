/* 
What are the top paying jobs for Data-Analyst roles?
- ID highest paying (top 10) Data Analyst roles availble within the UK.
- remove null values for unspecified salaries.
Why?
To offer insight into employment opportunities  within 'Data Analyst' industry
*/

SELECT
    job_id,
    job_title,
    job_location,
    company_dim.name AS company_name,
    job_country,
    job_schedule_type,
    salary_year_avg AS salary_year_USD,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'United Kingdom' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

