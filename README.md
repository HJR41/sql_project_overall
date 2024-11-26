# Introduction 🌍📊
A deep-dive into 2023 job market data. With a main focus on 'Data Analyst' roles within the UK, but with in-sites into the overall market for comparison. The analysis uncovers **Top-Paying-Skills** & the most **in Demand tools** for job-seekers and recruiters for data-driven decision making.  🚀

Check out my SQL queries here: [project_final](/project_final/)

# Background

**The questions I wanted to answer through my queries were:**
1. What are the top paying jobs for UK based Data Anlyst roles (top 10).
2. What skills are required for these roles.
3. What skills are most in-demand for Data Analysts.
4. Which skills are associated with higher salaries?
5. Considering both Salary & Job-Security, which skills are optimal to learn?

# Tools Used

For my project I used the following tools to complete my analysis:

- **SQL:** The backbone of my queries, allowing me to get insights from the data.
- **PostgreSQL:** My Chosen Dtabase managment system.
- ** Visual Studio Code:** The go-to scripting editor.
- **Git & GitHub:** Essential for version control and error tracking. Allowing me to share my insights and how i achieved them.

# Analysis 
**1. Top paying Data-Analyst Jobs within the UK**

```SQL
SELECT
    job_id,
    job_title,
    job_location,
    company_dim.name AS company_name,
    job_country,
    job_schedule_type,
    salary_year_avg * 1.26 AS salary_year_gbp, --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
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
```



1. **Market Data Lead Analyst** - Deutsche Bank, United Kingdom, £226,800

2. **Research Engineer, Science** - DeepMind, London, UK, £223,376.58

3. **Data Architect** - Darktrace, Cambridge, UK, £207,900

4. **Data Analyst** - Plexus Resource Solutions, Anywhere, UK, £207,900

5. **Data Architect** - AND Digital, Bristol, UK, £207,900

6. **Data Architect** - Logispin, London, UK, £206,365.32

7. **Data Architect** - Trading and Supply - Shell, United Kingdom, £197,190

8. **Research Scientist, Science** - DeepMind, London, UK, £188,562.78

9. **Analytics Engineer** - ENA London, Warsaw- (F/M) - AccorCorpo, London, UK, £175,412.16

10. **Finance Data Analytics Manager** - AJ Bell, Manchester, UK, £166,950





**2. Skills in the Top-Paying jobs from First Query:**

To understand what skills are required at the top 10 paying jobs i joined the jobs table with the Skills table. The below query gave me all the skills mentioned in the top 10 tops.

``` SQL
WITH data_analyst_roles AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg * 1.26 AS salary_year_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
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
)

SELECT 
    data_analyst_roles.job_id,
    job_title,
    company_name,
    skills_dim.skills AS skill_name,
    salary_year_gbp
FROM
    data_analyst_roles
INNER JOIN skills_job_dim ON data_analyst_roles.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
        salary_year_gbp DESC,
        company_name,
        skill_name;
LIMIT 10
```

This chart is a breakdown of the most mentioned skills, with number of occurences on the Y axis & skill name on the X axis:

![Top Paying Roles](Charts\Query2.0.PNG)



**3. In-demand skills for Data Analysts:**

This query helped identify the most in demand skills for Data Analysis.
```SQL
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
```
Results from the overall data set found the following skills were the most in demand.

1. SQL
2. Excel
3. Python
4. Tableau
5. Power BI

Rerunning the Query to filtering for job posted in the UK provided slightly different results:

1. SQL
2. Excel
3. Power BI
4. Python
5. Tableau

Highlighting that SQL & Excel are very prominant skills for Data Analysis world-wide.
Python is  very slightly less valuable in the UK, while Power BI is slightly more valuable in the UK.




**4. Skills with highest Salaries:**

Delving into average salaries & their associated skills revealed which skills demand the highest salaries.
```SQL
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
   5
```
The top 5 highest paying skills from the whole data set are:

1. Debian                                   
2. Ringcentral                              
3. Mongo                                   
4. Lua                                      
5. DPLYR  

The top 5 paying skills in the UK are:
1.scikit-learn                           
2. Keras
3. C++
4. Javascript
5. Neo4j



**5. Optimal Skills for both high-Salary & Job-Security:**

COmbining insights from salary data & skills demand, my 5th query was used to try to tackle both demand & high salary, offering a more strategic focus on skill development.

```SQL
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
LIMIT 5;
```
1. Kafka - £163,799 (40 mentions)
2. Airflow - £146,648 (71 mentions)
3. GCP - £142,463 (78 mentions)
4. Spark - £142,382 (187 mentions)
5. Databricks - £142,230 (102 mentions)

A further breakdown of the data finds:
 - **High-Demand Programming Languages:** Python and R are highly sought after, with demand counts of 236 and 148, respectively. Despite their popularity, the average salaries are £101,397 for Python and £100,499 for R, reflecting their strong value in the market but also their widespread availability.
- **Cloud Tools and Technologies:** Expertise in tools like Snowflake, Azure, AWS, and BigQuery is in high demand, accompanied by competitive average salaries. This highlights the rising significance of cloud platforms and big data technologies in the field of data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 and average salaries of £99,288 and £103,795 respectively, underscore the essential role of data visualization and business intelligence in transforming data into actionable insights.


# Lessons Learned 🧩

- **Complex Query Crafting:** Proficient in the art of advanced SQL querying, using complex table merges & data aggregation with CTEs and subqueries to get valuable insights into Data.
- **Advanced Analytics:** Used SQL to turn real-world questions into actionablke Data-Driven answers.




# Conclusions


**1. Top-Paying Data Analysts Job** in the UK is a Market Data Lead Analyst, posted by Deutsche Bank. Offereing £226,800.00.

**2. Skills for Top-Paying Jobs:** Python, SQL & Excel are very relevant to top-paying Data Analyst roles in the UK.

**3. Most In-Demand Skills:** SQL, Excel & python are extremely sort after skills in the Data Analyst Job market, Power Bi is also valued highly, especially in the UK.

**4. Specialised Skills with High Salaries:** Debian, Ringcentral & mongo are specialised skills that demand high salaries.

**5. Optimal Skills for Job-Market Value:** SQL is high in demand and offers high salaries, as-well as Python & R.


**Closing Thoughts**

This project as enhanced valuable skills in Data-Analytics with various tools such as SQL, VS code & git/Github. My findings serve as a useful guide to proitising skills development and Job Search efforts. Aspiring Data Analysts can use my findings to better position themselves within the Job-Market.

The Data hails from an online course in SQL queries. Please feel free to reach out to me for more information.
