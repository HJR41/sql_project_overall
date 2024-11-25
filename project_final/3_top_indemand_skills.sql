/* 
What are the most in-demand skills for Data Analyst roles?
- Join job_postings & skills to identify the most in-demand skills.
- focus on all job postings.
-Create a count of each skills mentioned in all job postings.
-Show top 5 skills based on mentions in job posts.

Allows further analyse for job seekers on skills to refine.
*/

SELECT
    skills,
    COUNT(skills_job_dim) AS mention_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    mention_count DESC
LIMIT 5


/* 
Further Analysis of the data set shows the
most in-demand skills (mentioned the most times in all job-postings) for 'Data Analysts' are as follows:
1. SQL
2. Excel
3. Python
4. Tableau
5. Power BI
*/

-- Add additional Filter to show only jobs posted in the UK to see how skills vary

SELECT
    skills,
    COUNT(skills_job_dim) AS mention_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_country = 'United Kingdom'
GROUP BY
    skills
ORDER BY
    mention_count DESC
LIMIT 5


/*
 Interestingly, the most in demand skills are the same. 
However the ordering is slightly different:
1. SQL
2. Excel
3. Power BI
4. Python
5. Tableau

This highlights that SQL & Excel are very prominant skills for Data Analysis world-wide.
Python is  very slightly less valuable in the UK, while Power BI is slightly more 
valuable in the UK comparing both to postings from around the world.
*/
