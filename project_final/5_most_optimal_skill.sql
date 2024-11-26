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
LIMIT 25;


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

[
  {
    "skill_id": 98,
    "skills": "kafka",
    "mention_count": "40",
    "avg_year_salary_gbp": "163799"
  },
  {
    "skill_id": 101,
    "skills": "pytorch",
    "mention_count": "20",
    "avg_year_salary_gbp": "157785"
  },
  {
    "skill_id": 31,
    "skills": "perl",
    "mention_count": "20",
    "avg_year_salary_gbp": "157104"
  },
  {
    "skill_id": 99,
    "skills": "tensorflow",
    "mention_count": "24",
    "avg_year_salary_gbp": "152015"
  },
  {
    "skill_id": 63,
    "skills": "cassandra",
    "mention_count": "11",
    "avg_year_salary_gbp": "149192"
  },
  {
    "skill_id": 219,
    "skills": "atlassian",
    "mention_count": "15",
    "avg_year_salary_gbp": "148637"
  },
  {
    "skill_id": 96,
    "skills": "airflow",
    "mention_count": "71",
    "avg_year_salary_gbp": "146648"
  },
  {
    "skill_id": 3,
    "skills": "scala",
    "mention_count": "59",
    "avg_year_salary_gbp": "145504"
  },
  {
    "skill_id": 169,
    "skills": "linux",
    "mention_count": "58",
    "avg_year_salary_gbp": "144753"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "mention_count": "62",
    "avg_year_salary_gbp": "143833"
  },
  {
    "skill_id": 95,
    "skills": "pyspark",
    "mention_count": "49",
    "avg_year_salary_gbp": "143713"
  },
  {
    "skill_id": 18,
    "skills": "mongodb",
    "mention_count": "26",
    "avg_year_salary_gbp": "143146"
  },
  {
    "skill_id": 62,
    "skills": "mongodb",
    "mention_count": "26",
    "avg_year_salary_gbp": "143146"
  },
  {
    "skill_id": 81,
    "skills": "gcp",
    "mention_count": "78",
    "avg_year_salary_gbp": "142463"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "mention_count": "187",
    "avg_year_salary_gbp": "142382"
  },
  {
    "skill_id": 193,
    "skills": "splunk",
    "mention_count": "15",
    "avg_year_salary_gbp": "142289"
  },
  {
    "skill_id": 75,
    "skills": "databricks",
    "mention_count": "102",
    "avg_year_salary_gbp": "142230"
  },
  {
    "skill_id": 210,
    "skills": "git",
    "mention_count": "74",
    "avg_year_salary_gbp": "141435"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "mention_count": "241",
    "avg_year_salary_gbp": "140588"
  },
  {
    "skill_id": 6,
    "skills": "shell",
    "mention_count": "44",
    "avg_year_salary_gbp": "140486"
  },
  {
    "skill_id": 168,
    "skills": "unix",
    "mention_count": "37",
    "avg_year_salary_gbp": "140015"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "mention_count": "140",
    "avg_year_salary_gbp": "139719"
  },
  {
    "skill_id": 93,
    "skills": "pandas",
    "mention_count": "90",
    "avg_year_salary_gbp": "139567"
  },
  {
    "skill_id": 137,
    "skills": "phoenix",
    "mention_count": "23",
    "avg_year_salary_gbp": "137666"
  },
  {
    "skill_id": 25,
    "skills": "php",
    "mention_count": "29",
    "avg_year_salary_gbp": "137405"
  }
]